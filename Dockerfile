# Stage 1: Install dependencies
FROM node:22-alpine AS deps
WORKDIR /app

# Upgrade npm to the latest version securely
RUN npm install -g npm@latest

# Copy dependency manifests
COPY package*.json ./

# Install only production dependencies
RUN npm ci --only=production

# Stage 2: Production image
FROM node:22-alpine
WORKDIR /app

# Upgrade npm to the latest version
RUN npm install -g npm@latest

# Copy production dependencies with correct user ownership
COPY --from=deps --chown=node:node /app/node_modules ./node_modules

# Copy application code with correct user ownership
COPY --chown=node:node . .

# Switch to the built-in non-root user
USER node

# Expose the application port
EXPOSE 3000

# Start the application
CMD ["npm", "start"]
