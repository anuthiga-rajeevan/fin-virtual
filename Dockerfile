# ---- Build Frontend ----
    FROM node:18-alpine AS frontend

    WORKDIR /app/frontend
    
    COPY frontend/package*.json ./
    RUN npm install
    
    COPY frontend/ .
    RUN npm run build
    
    # ---- Build Backend ----
    FROM node:18-alpine AS backend
    
    WORKDIR /app
    
    
    # Copy backend files
    COPY backend/package*.json ./backend/
    RUN cd backend && npm install
    
    # Copy backend and frontend build output
    COPY backend/ ./backend
    # Compile TS → JS
    RUN cd backend && npm run build

    COPY --from=frontend /app/frontend/.next ./frontend/.next
    COPY --from=frontend /app/frontend/public ./frontend/public
    COPY --from=frontend /app/frontend/next.config.ts ./frontend/next.config.ts
    COPY --from=frontend /app/frontend/package.json ./frontend/package.json
    
    # Set env
    ENV NODE_ENV=production
    ENV PORT=4000
    
    EXPOSE 4000
    
    CMD ["node", "backend/dist/index.js"]
    