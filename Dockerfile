# Stage 1: Build
FROM node:18-slim AS builder
WORKDIR /app

# Copy package files and install ALL dependencies
COPY package*.json ./
RUN npm install

# Copy the rest of the code
COPY . .

# Stage 2: Production
FROM node:18-slim
WORKDIR /app

# Copy only the necessary files from the builder
# This avoids the "not found" error by ensuring /app exists
COPY --from=builder /app /app

EXPOSE 3000
CMD ["npm", "start"]
