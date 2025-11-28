# Dockerfile for TechVision static landing page
# Uses nginx to serve static files
FROM nginx:stable-alpine

# Install gettext for envsubst (used to render nginx template at container startup)
# and curl for healthchecks
RUN apk add --no-cache gettext curl

# Remove default nginx content
RUN rm -rf /usr/share/nginx/html/*

# Copy site contents to nginx html directory
COPY . /usr/share/nginx/html

# Copy a small entrypoint and nginx template so PORT can be configured at runtime
COPY docker/docker-entrypoint.sh /docker-entrypoint.sh
COPY docker/nginx/default.conf.template /etc/nginx/conf.d/default.conf.template

# Set ownership (nginx user in image)
RUN chown -R nginx:nginx /usr/share/nginx/html \
	&& chmod +x /docker-entrypoint.sh

# Allow configuring the container listen port via the PORT env var
ENV PORT=80

# Expose the container port (matches the default PORT)
EXPOSE 80

# Start with our entrypoint which will log the port and render nginx config
# Add a lightweight HTTP healthcheck so hosting platforms (Dokploy) can probe the container
# This checks the container's listen port (PORT) at localhost
HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
	CMD sh -c "curl -fsS --max-time 3 http://127.0.0.1:${PORT:-80}/ >/dev/null || exit 1"

CMD ["/docker-entrypoint.sh"]
