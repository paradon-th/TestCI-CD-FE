# Stage 0: "builder", based on Node.js, to build and compile the Angular app
FROM node:12.22-alpine AS builder

WORKDIR /usr/src/app

# Copy package.json and package-lock.json to install dependencies
COPY package.json package-lock.json ./

RUN npm install

# Copy the entire project and build the Angular app
COPY . .

RUN npm run build

# Stage 1: Nginx, to serve the compiled Angular app
FROM nginx:stable-alpine

# Copy custom Nginx configuration
COPY src/nginx.conf /etc/nginx/nginx.conf

# Set the working directory to Nginx's default public directory
WORKDIR /usr/share/nginx/html

# Copy the built app from the "builder" stage
COPY --from=builder /usr/src/app/dist/iCubeServe-Frontend/ .

# Expose port 80 for external access
EXPOSE 80

# Start Nginx server
CMD ["nginx", "-g", "daemon off;"]
