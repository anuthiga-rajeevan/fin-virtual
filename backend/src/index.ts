import express from 'express';
import dotenv from 'dotenv';
import path from 'path';
import fs from 'fs';

dotenv.config();

console.log('Loaded ENV:', process.env);


const app = express();
const port = process.env.PORT || 4000;

console.log('__dirname is:', __dirname);

// ✅ Serve static files from the public directory
const publicDir = path.join(__dirname, '../../public');
app.use(express.static(publicDir));

// ✅ Log to confirm
console.log('Serving frontend from:', publicDir);

// ✅ Wildcard fallback for SPA routing (if needed)
const indexPath = path.join(publicDir, 'index.html');
console.log('Serving frontend from:::::::::::::::', indexPath);
if (fs.existsSync(indexPath)) {
  console.log('FILE EXISTS');
  app.get('*', (req, res) => {
    res.sendFile(indexPath);
  });
} else {
  console.warn('⚠️ index.html not found at:', indexPath);
}

app.listen(port, () => {
  console.log(`✅ Server running on http://localhost:${port}`);
});
