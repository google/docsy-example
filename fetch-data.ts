import * as dotenv from 'dotenv';
dotenv.config();
// Ensure TypeScript recognizes Node.js types
// If you see type errors, run: npm install --save-dev @types/node

import * as https from 'https';
import { promises as fs } from 'fs';
import { fileURLToPath } from 'url';
import * as path from 'path';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

// Read API URL from environment variable, fallback to default
const url = process.env.API_URL;

const postData = JSON.stringify({
  usernames: ["baruchiro", "UrielOfir"]
});

async function fetchJson() {
  return new Promise((resolve, reject) => {
    const req = https.request(
      url,
      {
        method: 'POST',
        headers: {
          'accept': '*/*',
          'Content-Type': 'application/json',
          'Content-Length': Buffer.byteLength(postData)
        }
      },
      (res: any) => {
        let data = '';
        res.on('data', (chunk: any) => { data += chunk; });
        res.on('end', () => {
          try {
            const json = JSON.parse(data);
            resolve(json);
          } catch (e) {
            reject(new Error('Failed to parse JSON: ' + e));
          }
        });
      }
    );
    req.on('error', (err: any) => {
      reject(new Error('Error fetching data: ' + err));
    });
    req.write(postData);
    req.end();
  });
}

async function main() {
  const dataDir = path.join(__dirname, 'data');
  const outFile = path.join(dataDir, 'remote.json');
  try {
    await fs.mkdir(dataDir, { recursive: true });
    const json = await fetchJson();
    await fs.writeFile(outFile, JSON.stringify(json, null, 2));
    console.log(`Fetched data saved to ${outFile}`);
  } catch (err) {
    console.error(err);
    process.exit(1);
  }
}

main(); 