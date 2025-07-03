import express from 'express';
import dotenv from 'dotenv';
import path from 'path';

dotenv.config();

const app = express();
const port = process.env.PORT || 3000;

// Middleware
app.use(express.json());

app.use(express.static(path.join(__dirname, '../../frontend/.next')));

app.get('*', (req, res) => {
  res.sendFile(path.join(__dirname, '../../frontend/.next/server/pages/index.html'));
});

app.listen(port, () => {
  console.log(`Server running on http://localhost:${port}`);
});
