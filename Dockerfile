# Stage 1: Install dependencies
FROM node:18-slim AS deps
WORKDIR /app

COPY package*.json ./
RUN npm ci --only=production

# Stage 2: Production image
FROM node:18-slim
WORKDIR /app

# Copy only production dependencies
COPY --from=deps /app/node_modules ./node_modules

# Copy application code
COPY . .

EXPOSE 3000

CMD ["npm", "start"]
