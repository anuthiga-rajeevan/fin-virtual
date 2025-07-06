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

# Debug: list contents of frontend and out directory
RUN echo "=== Contents of /app/frontend ===" && ls -al ./frontend
RUN echo "=== Contents of /app/frontend/out ===" && ls -al ./frontend/out || echo "frontend/out does not exist"
RUN echo "=== Searching for index.html ===" && find ./frontend -name index.html || echo "index.html not found"

# Move frontend static files to a common directory (e.g., ./public)
RUN mkdir -p ./public && cp -r ./frontend/out/* ./public/

# Debug: list contents of public directory
RUN echo "=== Contents of /app/public ===" && ls -al ./public

# Build backend (transpile TypeScript)
RUN cd backend && npm run build

# Expose port and start backend (which serves FE)
EXPOSE 4000
CMD ["node", "backend/dist/index.js"]
