# Top-level Dockerfile for TechVision landing page
# This mirrors the docker/Dockerfile but uses paths relative to the repository root
FROM nginx:stable-alpine

# Install gettext for envsubst (used to render nginx template at container startup)
# and curl for healthchecks
RUN apk add --no-cache gettext curl

# Remove default nginx content
RUN rm -rf /usr/share/nginx/html/*

# Copy site contents (repository root) to nginx html directory
COPY . /usr/share/nginx/html

# Copy entrypoint and nginx template (paths relative to repo root)
COPY docker/docker-entrypoint.sh /docker-entrypoint.sh
COPY docker/nginx/default.conf.template /etc/nginx/conf.d/default.conf.template

# Set ownership and make entrypoint executable
RUN chown -R nginx:nginx /usr/share/nginx/html \
    && chmod +x /docker-entrypoint.sh

# Default container listen port
ENV PORT=80

# Expose the container port
EXPOSE 80

# Healthcheck probes the container's PORT
HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
  CMD sh -c "curl -fsS --max-time 3 http://127.0.0.1:${PORT:-80}/ >/dev/null || exit 1"

CMD ["/docker-entrypoint.sh"]
