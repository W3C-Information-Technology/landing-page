# Dockerfile for TechVision static landing page
# Uses nginx to serve static files
FROM nginx:stable-alpine

# Remove default nginx content
RUN rm -rf /usr/share/nginx/html/*

# Copy site contents to nginx html directory
COPY . /usr/share/nginx/html

# Set ownership (nginx user in image)
RUN chown -R nginx:nginx /usr/share/nginx/html

# Expose port 80 (Dokploy will map host port)
EXPOSE 9009

# Use the default nginx entrypoint/cmd from the base image
# (no CMD needed)
