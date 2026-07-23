# Stage 1: Install dependencies
FROM node:22-slim AS deps
WORKDIR /app

RUN npm install -g npm@latest

COPY package*.json ./
RUN npm ci --only=production

# Stage 2: Production image
FROM node:22-slim
WORKDIR /app

RUN npm install -g npm@latest

# Copy only production dependencies
COPY --from=deps /app/node_modules ./node_modules

# Copy application code
COPY . .

EXPOSE 3000

CMD ["npm", "start"]
