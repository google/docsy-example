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
 * Get configuration from config.json file with minimal environment variable fallback
 */
async function getConfig(): Promise<Config> {
  const configPath = path.join(__dirname, 'config.json');
  
  try {
    // Try to load from config.json
    const configFile = await fs.readFile(configPath, 'utf-8');
    const jsonConfig = JSON.parse(configFile);
    
    // Validate required fields
    if (!jsonConfig.apiUrl) {
      throw new Error('apiUrl is required in config.json');
    }
    
    if (!Array.isArray(jsonConfig.usernames) || jsonConfig.usernames.length === 0) {
      throw new Error('usernames array is required and must not be empty in config.json');
    }
    
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
    // Minimal fallback to environment variables for deployment scenarios
    console.log('Could not load config.json, trying environment variables...');
    
    const apiUrl = process.env.GITHUB_DATA_URL;
    if (!apiUrl) {
      throw new Error('config.json not found and GITHUB_DATA_URL environment variable not set. Please create a config.json file or set environment variables.');
    }

    const usernames = process.env.USERNAMES 
      ? process.env.USERNAMES.split(',').map(u => u.trim()).filter(u => u.length > 0)
      : ["baruchiro", "UrielOfir"];

    return {
      apiUrl,
      usernames,
      outputDir: process.env.OUTPUT_DIR || 'data',
      outputFile: process.env.OUTPUT_FILE || 'github_data.json',
      requestTimeout: parseInt(process.env.REQUEST_TIMEOUT || '60000', 10),
      maxRetries: parseInt(process.env.MAX_RETRIES || '3', 10),
      retryDelay: parseInt(process.env.RETRY_DELAY || '2000', 10),
      logLevel: (process.env.LOG_LEVEL || 'info') as Config['logLevel']
    };
  }
}

/**
 * Logger utility that respects the LOG_LEVEL setting
 */
class Logger {
  private levels = { debug: 0, info: 1, warn: 2, error: 3 };
  
  constructor(private logLevel: Config['logLevel']) {}

  debug(message: string, ...args: unknown[]) {
    if (this.levels[this.logLevel] <= this.levels.debug) {
      console.log(`🐛 ${message}`, ...args);
    }
  }

  info(message: string, ...args: unknown[]) {
    if (this.levels[this.logLevel] <= this.levels.info) {
      console.log(`ℹ️  ${message}`, ...args);
    }
  }

  warn(message: string, ...args: unknown[]) {
    if (this.levels[this.logLevel] <= this.levels.warn) {
      console.warn(`⚠️  ${message}`, ...args);
    }
  }

  error(message: string, ...args: unknown[]) {
    if (this.levels[this.logLevel] <= this.levels.error) {
      console.error(`❌ ${message}`, ...args);
    }
  }

  success(message: string, ...args: unknown[]) {
    if (this.levels[this.logLevel] <= this.levels.info) {
      console.log(`✅ ${message}`, ...args);
    }
  }
}

/**
 * Sleep utility for retry delays
 */
function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms));
}

/**
 * Determine if an error is retryable (server errors, timeouts, network issues)
 */
function isRetryableError(error: Error): boolean {
  // Network errors
  if (error.name === 'AbortError' || error.name === 'TypeError') {
    return true;
  }
  
  // HTTP errors - retry on 5xx (server errors) and some 4xx codes
  if (error.message.includes('HTTP error!')) {
    const statusMatch = error.message.match(/status: (\d+)/);
    if (statusMatch) {
      const status = parseInt(statusMatch[1]);
      // Retry on server errors (5xx) and rate limiting (429)
      return status >= 500 || status === 429;
    }
  }
  
  return false;
}

/**
 * Fetch user data from the API using modern fetch API with retry logic
 */
async function fetchUserData(config: Config, logger: Logger): Promise<ApiResponse> {
  const postData = JSON.stringify({
    usernames: config.usernames
  });

  let lastError: Error | null = null;

  for (let attempt = 1; attempt <= config.maxRetries + 1; attempt++) {
    const isRetry = attempt > 1;
    
    if (isRetry) {
      logger.warn(`Attempt ${attempt}/${config.maxRetries + 1} - Retrying after ${config.retryDelay}ms delay...`);
      await sleep(config.retryDelay);
    }

    // Create AbortController for timeout handling
    const controller = new AbortController();
    const timeoutId = setTimeout(() => controller.abort(), config.requestTimeout);

    try {
      if (!isRetry) {
        logger.info(`Fetching data for users: ${config.usernames.join(', ')}`);
      }
      logger.debug(`API URL: ${config.apiUrl}`);
      logger.debug(`Request timeout: ${config.requestTimeout}ms`);
      logger.debug(`Request payload:`, JSON.parse(postData));

      const response = await fetch(config.apiUrl, {
        method: 'POST',
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'User-Agent': 'Maakaf-Home-Data-Fetcher/1.0'
        },
        body: postData,
        signal: controller.signal
      });

      clearTimeout(timeoutId);

      logger.debug(`Response status: ${response.status} ${response.statusText}`);

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
      if (!contentType || !contentType.includes('application/json')) {
        throw new Error(`Expected JSON response, got: ${contentType}`);
      }

      const json = await response.json() as ApiResponse;
      
      if (isRetry) {
        logger.success(`Successfully fetched data on attempt ${attempt}`);
      } else {
        logger.success(`Successfully fetched data`);
      }
      
      logger.debug(`Response data keys:`, Object.keys(json));
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
        
        logger.debug(`Fetch error details:`, error);
        throw new Error(`Failed to fetch data: ${error.message}`);
      }
      throw error;
    }
  }

  // If we get here, all retries failed
  throw new Error(`Failed to fetch data after ${config.maxRetries + 1} attempts. Last error: ${lastError?.message}`);
}

/**
 * Main function to orchestrate the data fetching process
 */
async function main(): Promise<void> {
  try {
    // Get and validate configuration
    const config = await getConfig();
    const logger = new Logger(config.logLevel);
    const outFile = path.join(config.outputDir, config.outputFile);
    
    logger.info(`Starting data fetch process`);
    logger.debug(`Configuration loaded:`, {
      githubDataUrl: config.apiUrl,
      usernames: config.usernames,
      outputDir: config.outputDir,
      outputFile: config.outputFile,
      requestTimeout: config.requestTimeout,
      maxRetries: config.maxRetries,
      retryDelay: config.retryDelay,
      logLevel: config.logLevel
    });
    
    logger.info(`Output directory: ${config.outputDir}`);
    logger.info(`Output file: ${outFile}`);
    
    // Create output directory
    await fs.mkdir(config.outputDir, { recursive: true });
    logger.debug(`Created/verified directory: ${config.outputDir}`);
    
    // Fetch data from API
    const data = await fetchUserData(config, logger);
    
    // Save to file with pretty formatting
    await fs.writeFile(outFile, JSON.stringify(data, null, 2), 'utf8');
    
    logger.success(`Data successfully saved to ${outFile}`);
    logger.info(`Data contains ${Object.keys(data).length} properties`);

    // Show file size
    const stats = await fs.stat(outFile);
    logger.info(`File size: ${(stats.size / 1024).toFixed(2)} KB`);

  } catch (error) {
    if (error instanceof Error) {
      console.error(`❌ Error: ${error.message}`);
    } else {
      console.error('❌ An unknown error occurred:', error);
    }
    process.exit(1);
  }
}

/**
 * Execute the script with proper error handling
 */
if (import.meta.url === `file://${process.argv[1]}`) {
  main().catch((error) => {
    console.error('❌ Unhandled error in main:', error);
    process.exit(1);
  });
} 