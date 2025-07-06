import express from 'express';
import dotenv from 'dotenv';
import path from 'path';

dotenv.config();

const app = express();
const port = process.env.PORT || 4000;

// Serve static files from exported Next.js frontend
app.use(express.static(path.join(__dirname, '../../frontend/out')));

// API health check
app.get('/api/health', (req, res) => {
  res.json({ status: 'ok' });
});

// All other routes => frontend app
app.get('*', (req, res) => {
  res.sendFile(path.join(__dirname, '../../frontend/out/index.html'));
});

app.listen(port, () => {
  console.log(`Server running on http://localhost:${port}`);
});
