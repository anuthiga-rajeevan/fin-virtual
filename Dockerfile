# Base image
FROM node:18-alpine

WORKDIR /app

# Install backend dependencies
COPY backend/package*.json ./backend/
RUN cd backend && npm install

# Install frontend dependencies and build it
COPY frontend/package*.json ./frontend/
RUN cd frontend && npm install

# Copy full source
COPY . .

# Build frontend (static export)
RUN cd frontend && npm run build

# Build backend (transpile TypeScript)
RUN cd backend && npm run build

# Expose port and start backend (which serves FE)
EXPOSE 4000
CMD ["node", "backend/dist/index.js"]
