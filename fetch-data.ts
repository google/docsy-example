import { promises as fs } from 'fs';
import { fileURLToPath } from 'url';
import * as path from 'path';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

// Configuration interface
interface Config {
  apiUrl: string;
  usernames: string[];
  outputDir: string;
  outputFile: string;
  requestTimeout: number;
  maxRetries: number;
  retryDelay: number;
  logLevel: 'debug' | 'info' | 'warn' | 'error';
}

// API Response type
interface ApiResponse {
  [key: string]: unknown;
}

/**
 * Logger utility that respects the LOG_LEVEL setting
 */
class Logger {
  private levels = { debug: 0, info: 1, warn: 2, error: 3 };
  constructor(private logLevel: Config['logLevel']) {}

  debug(message: string, ...args: unknown[]) {
    if (this.levels[this.logLevel] <= this.levels.debug) console.log(`🐛 ${message}`, ...args);
  }
  info(message: string, ...args: unknown[]) {
    if (this.levels[this.logLevel] <= this.levels.info) console.log(`ℹ️  ${message}`, ...args);
  }
  warn(message: string, ...args: unknown[]) {
    if (this.levels[this.logLevel] <= this.levels.warn) console.warn(`⚠️  ${message}`, ...args);
  }
  error(message: string, ...args: unknown[]) {
    if (this.levels[this.logLevel] <= this.levels.error) console.error(`❌ ${message}`, ...args);
  }
  success(message: string, ...args: unknown[]) {
    if (this.levels[this.logLevel] <= this.levels.info) console.log(`✅ ${message}`, ...args);
  }
}

/**
 * Get configuration strictly from config.json
 */
async function getConfig(): Promise<Config> {
  const configPath = path.join(__dirname, 'config.json');
  try {
    const configFile = await fs.readFile(configPath, 'utf-8');
    const jsonConfig = JSON.parse(configFile);

    if (!jsonConfig.apiUrl) throw new Error('apiUrl is required in config.json');
    if (!Array.isArray(jsonConfig.usernames) || jsonConfig.usernames.length === 0)
      throw new Error('usernames array is required and must not be empty in config.json');

    return {
      apiUrl: jsonConfig.apiUrl,
      usernames: jsonConfig.usernames,
      outputDir: jsonConfig.outputDir || 'data',
      outputFile: jsonConfig.outputFile || 'github_data.json',
      requestTimeout: parseInt(jsonConfig.requestTimeout, 10) || 60000,
      maxRetries: parseInt(jsonConfig.maxRetries, 10) || 3,
      retryDelay: parseInt(jsonConfig.retryDelay, 10) || 2000,
      logLevel: jsonConfig.logLevel || 'info'
    };
  } catch (error) {
    throw new Error(
      `Failed to load or parse config.json at ${configPath}: ${(error as Error).message}`
    );
  }
}

function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms));
}

function isRetryableError(error: Error): boolean {
  if (error.name === 'AbortError' || error.name === 'TypeError') return true;
  if (error.message.includes('HTTP error!')) {
    const statusMatch = error.message.match(/status: (\d+)/);
    if (statusMatch) {
      const status = parseInt(statusMatch[1]);
      return status >= 500 || status === 429;
    }
  }
  return false;
}

async function fetchUserData(config: Config, logger: Logger): Promise<ApiResponse> {
  const postData = JSON.stringify({ usernames: config.usernames });
  let lastError: Error | null = null;

  for (let attempt = 1; attempt <= config.maxRetries + 1; attempt++) {
    const isRetry = attempt > 1;
    if (isRetry) {
      logger.warn(`Attempt ${attempt}/${config.maxRetries + 1} - Retrying after ${config.retryDelay}ms delay...`);
      await sleep(config.retryDelay);
    }

    const controller = new AbortController();
    const timeoutId = setTimeout(() => controller.abort(), config.requestTimeout);

    try {
      if (!isRetry) logger.info(`Fetching data for users: ${config.usernames.join(', ')}`);

      const response = await fetch(config.apiUrl, {
        method: 'POST',
        headers: { 'Accept': 'application/json', 'Content-Type': 'application/json', 'User-Agent': 'Maakaf-Home-Data-Fetcher/1.0' },
        body: postData,
        signal: controller.signal
      });

      clearTimeout(timeoutId);

      if (!response.ok) {
        const error = new Error(`HTTP error! status: ${response.status} - ${response.statusText}`);
        if (isRetryableError(error) && attempt <= config.maxRetries) {
          lastError = error;
          logger.warn(`Retryable error: ${error.message}`);
          continue;
        }
        throw error;
      }

      const contentType = response.headers.get('content-type');
      if (!contentType || !contentType.includes('application/json'))
        throw new Error(`Expected JSON response, got: ${contentType}`);

      const json = await response.json() as ApiResponse;
      logger.success(isRetry ? `Successfully fetched data on attempt ${attempt}` : `Successfully fetched data`);
      return json;

    } catch (error) {
      clearTimeout(timeoutId);
      if (error instanceof Error) {
        if (error.name === 'AbortError') {
          const timeoutError = new Error(`Request timed out after ${config.requestTimeout}ms`);
          if (isRetryableError(timeoutError) && attempt <= config.maxRetries) {
            lastError = timeoutError;
            logger.warn(`Request timeout, will retry...`);
            continue;
          }
          throw timeoutError;
        }
        if (isRetryableError(error) && attempt <= config.maxRetries) {
          lastError = error;
          logger.warn(`Retryable error: ${error.message}`);
          continue;
        }
        throw new Error(`Failed to fetch data: ${error.message}`);
      }
      throw error;
    }
  }
  throw new Error(`Failed to fetch data after ${config.maxRetries + 1} attempts. Last error: ${lastError?.message}`);
}

async function main(): Promise<void> {
  try {
    const config = await getConfig();
    const logger = new Logger(config.logLevel);
    const outFile = path.join(config.outputDir, config.outputFile);

    logger.info(`Starting data fetch process`);

    await fs.mkdir(config.outputDir, { recursive: true });
    const data = await fetchUserData(config, logger);

    // Check for missing users
    const returnedUsernames = (data as any).users.map((u: any) => u.user.username);
    const missingUsers = config.usernames.filter(u => !returnedUsernames.includes(u));
    if (missingUsers.length > 0) {
      logger.warn(`No data returned for the following usernames: ${missingUsers.join(', ')}`);
    }

    await fs.writeFile(outFile, JSON.stringify(data, null, 2), 'utf8');
    logger.success(`Data successfully saved to ${outFile}`);
    logger.info(`Data contains ${Object.keys(data).length} properties`);

    const stats = await fs.stat(outFile);
    logger.info(`File size: ${(stats.size / 1024).toFixed(2)} KB`);
  } catch (error) {
    if (error instanceof Error) console.error(`❌ Error: ${error.message}`);
    else console.error('❌ An unknown error occurred:', error);
    process.exit(1);
  }
}

main().catch((error) => {
  console.error('❌ Unhandled error in main:', error);
  process.exit(1);
});
