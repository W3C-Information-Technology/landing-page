# Docker — Local testing and Dokploy notes

This file documents the small Docker workflow for the TechVision landing page.

Files
- `Dockerfile` — builds an nginx image that serves the static site. Entrypoint renders an nginx template from `docker/nginx/default.conf.template` using `PORT`.
- `docker-compose.yml` — local compose for testing. Uses `docker/.env` by default to set `PORT` and `HOST_PORT`.
- `docker/.env` — example env file (contains `PORT` and `HOST_PORT`).
- `docker/.env` — example env file (contains `PORT`, `IWAN` and `HOST_PORT`).

Environment variables
- `PORT` — the container port nginx will listen on (default `80`).
- `HOST_PORT` — local host port to map to the container when using `docker-compose` (default `8080`).
 - `IWAN` — optional alternate variable name for the container port. If set, the entrypoint prefers `IWAN` over `PORT` (this supports environments where you prefer a different variable name).

Local testing (PowerShell)

Build + run with docker-compose (recommended):

```powershell
# From repository root
docker compose -f docker/docker-compose.yml up --build
# Follow logs
docker compose -f docker/docker-compose.yml logs -f web
```

Build + run with docker (example mapping host 9009 -> container 9009):

```powershell
# Build the image using the Dockerfile in ./docker
docker build -t landing-page:latest ./docker
# Run the container and set PORT to 9009 so nginx listens on 9009 inside container
docker run -d -p 9009:9009 -e PORT=9009 --name landing-page landing-page:latest
# Check logs
docker logs -f landing-page
```

What to look for in logs

On startup the entrypoint prints timestamped info, you should see lines like:

```
[2025-11-28T12:34:56Z] => Container starting: configuring nginx to listen on port 80
[2025-11-28T12:34:56Z] => nginx config test passed
[2025-11-28T12:34:56Z] => Starting nginx (foreground). Container listens on port 80
```

Dokploy / Platform notes

- Dokploy will show container stdout/stderr as logs — the entrypoint writes the container PORT and nginx test output to stdout/stderr so you'll see them in the Dokploy app logs during startup.
- Dokploy often requires you to set environment variables (like `PORT`) in the app settings — set `PORT` to the port you want the container to listen on (commonly `80`).
- For Dokploy, configure the app to use the Dockerfile build flow, or push a pre-built image to a registry and deploy from the image.
- Dokploy health checks will use the container's exposed port. A Docker HEALTHCHECK is included in the image which uses curl to probe `http://127.0.0.1:${PORT}`; hosting platforms may use their own probe endpoints — configure those in the web UI to match the container port.

Troubleshooting
- If you see 502/503 or the app is unhealthy in Dokploy, open the container logs for startup errors. If nginx fails `nginx -t`, the entrypoint will print the error and the container will exit.
- If static assets are missing, verify the build context and that `assets/` exist in the image by running an interactive shell on the image locally.

Next steps
- If your site is a SPA, consider adding a custom `nginx.conf` to rewrite unknown routes to `/index.html`. I can add this file for you if needed.
