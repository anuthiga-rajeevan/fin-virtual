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

# Move frontend static files to a common directory (e.g., ./public)
RUN mkdir -p ./public && cp -r ./frontend/out/* ./public/

# Build backend (transpile TypeScript)
RUN cd backend && npm run build

# Expose port and start backend (which serves FE)
EXPOSE 4000
CMD ["sh", "-c", "npx prisma migrate deploy --schema=./backend/prisma/schema.prisma && node backend/dist/main.js"]
