# Use a slim version of Node.js for a smaller image
FROM node:20-slim AS builder

# Set the working directory inside the container
WORKDIR /app

# Copy package files first to leverage Docker's build cache
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Optional: Build the app (if using TypeScript or React)
# RUN npm run build

# --- Production Stage ---
FROM node:20-slim

WORKDIR /app

# Only copy the necessary production files from the builder stage
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app .

# Expose the port your app runs on
EXPOSE 3000

# Start the application
CMD ["npm", "start"]
