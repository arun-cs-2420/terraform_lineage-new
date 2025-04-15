# Stage 1: Build the Angular project
FROM node:18 AS build

# Set working directory inside the lineage-ui project
WORKDIR /app/lineage-ui

# Copy only necessary files to avoid cache busting
COPY lineage-ui/package.json lineage-ui/package-lock.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application source code
COPY lineage-ui ./

# Build the Angular project for production
RUN npm run build -- --configuration production --project lineage-ui

# Stage 2: Serve the Angular project using a lightweight web server
FROM nginx:alpine

# Copy the build artifacts from the build stage
COPY --from=build /app/lineage-ui/dist/lineage-ui/browser/ /usr/share/nginx/html


# Ensure correct permissions
RUN chmod -R 755 /usr/share/nginx/html

# Expose port 10000
EXPOSE 10000

# Copy the custom nginx configuration file
COPY lineage-ui/nginx.conf /etc/nginx/nginx.conf

# Start NGINX server
CMD ["nginx", "-g", "daemon off;"]