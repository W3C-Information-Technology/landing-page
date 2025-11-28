# Deploying the TechVision Landing Page to Dokploy (Web UI)

This guide shows step-by-step how to deploy the static landing page in this repository to Dokploy using the Dokploy web UI (you said you only have web UI access). The repo already contains a `Dockerfile` that serves the site with Nginx and a `docker-compose.yml` for local testing.

---

Prerequisites
- You have a Dokploy account and access to the Dokploy Dashboard (web UI)
- This repository is reachable (GitHub, GitLab, Bitbucket) or you can upload a zip of the repo via Dokploy UI
- A domain name (optional) pointed to the Dokploy-managed endpoint if you want a custom domain

Files included
- `Dockerfile` — serves the static site with nginx
- `docker-compose.yml` — local testing helper (maps 8080 -> 80)
 - `docker-compose.yml` — local testing helper (uses `docker/.env` for PORT/HOST_PORT)
- `.dockerignore` — avoids sending unnecessary files to Docker build context

Quick overview of the approach
- Dokploy's web UI typically supports one of the following deployment flows:
  - Connect to a Git repository and build from a `Dockerfile` in the repo
  - Upload a repository archive (zip) via the UI and build using the included `Dockerfile`
  - Point Dokploy to a pre-built Docker image in a registry (Docker Hub, etc.) and deploy

This guide explains each flow; use the one that matches how your Dokploy account is set up.

---

Flow A — Deploy by connecting your Git repository
1. Push this repository to your Git provider (GitHub/GitLab/Bitbucket) if not already there.
2. Log in to Dokploy web UI and create a new project/app.
3. Choose "Deploy from Git" (or similar option).
4. Connect your Git provider and select the repository and branch (e.g., `main` or `master`).
5. Set the build mode to "Dockerfile" or "Docker build". Point Dokploy to `docker/Dockerfile` (recommended) and use repository root `/` as the build context. If your Dokploy setup requires a root-level Dockerfile, you can also use `./Dockerfile`.
6. Optionally set the build context to `/` (root). Dokploy will run `docker build` using your Dockerfile.
7. Set the container port mapping in the UI to the container port you're using (default `80`) — Dokploy will provide a public endpoint.
8. Add environment variables in the web UI to configure runtime behavior. Important variables:
    - `PORT` — container listen port (default `80`).
    - `IWAN` — alternate variable name supported by the image; if set, the entrypoint will prefer `IWAN` over `PORT`.
    - Note: `docker/.env` is provided for local testing (compose). Dokploy typically requires you to set runtime env vars in the app settings — platform-managed env vars override repo .env files.
9. Trigger the first deploy. Dokploy will build the Docker image and start the container.
10. Check build logs in the UI. When the build finishes, open the provided public URL to verify the site.

Notes:
- If Dokploy fails to detect the Dockerfile, ensure the Dockerfile is in the repository root and named exactly `Dockerfile`.
- If your static site uses client-side routing (SPA), you may need a custom `nginx.conf` to rewrite 404s to `/index.html`. If required, I can add an `nginx.conf` to this repo.


Flow B — Upload ZIP via Dokploy web UI
1. Create a zip of this repository (exclude large assets if not needed).
2. In the Dokploy dashboard, create a new app and choose "Upload" or "Deploy from archive".
3. Upload the zip and point the build to use the `Dockerfile` in the archive root.
4. Continue with steps 6-10 from Flow A.

Flow C — Deploy a pre-built image (Docker Hub or other registry)
1. Build the image locally and push to your Docker Hub (or another registry):

```powershell
# Build locally
docker build -t yourhubusername/landing-page:latest .

# Login and push
docker login
docker push yourhubusername/landing-page:latest
```

2. In the Dokploy web UI create a new app and choose "Deploy from image" (or set image name in app settings).
3. Enter the registry image `yourhubusername/landing-page:latest` and provide registry credentials if private.
4. Set exposed/published port to container `80`.
5. Deploy.

---

Domain, SSL, and DNS (Web UI steps)
- In Dokploy UI add your custom domain to the app (often an option in the app's settings: "Domains" or "Custom Domains").
- Create an A record with your domain registrar that points your domain (e.g., `example.com`) or subdomain to the Dokploy-managed IP or CNAME the platform gives you.
- Dokploy may offer automatic Let's Encrypt provisioning; use the UI button to enable HTTPS for your domain, or follow the platform prompts.

---

Health checks & logs
- Use the Dokploy UI to view real-time build logs and container logs.
- If the app is not healthy, inspect the logs for Nginx startup errors or missing files.
- Typical nginx issues: wrong file paths, missing `index.html`, permission errors.

Troubleshooting tips
- If you see a 404 for every route, and your site is an SPA, add an `nginx.conf` to rewrite fallback to `/index.html`.
- Ensure the `Dockerfile` is in the root and the build context includes all files (no `.dockerignore` blocking necessary files).
- If static assets aren't loading, check that `assets/` folder is present in the built image (logs: `docker image ls` and `docker run -it --rm image sh` to inspect locally).

Local testing (recommended before web UI deploy)
1. Start locally with docker-compose (Windows PowerShell):

```powershell
# From repo root
docker compose -f docker/docker-compose.yml up --build
# By default this maps host 8080 -> container PORT (from docker/.env). Open http://localhost:8080
```

2. Or use direct docker commands:

```powershell
docker build -t landing-page:local .
docker run --rm -p 8080:80 landing-page:local
```

---

Advanced: SPA routing `nginx.conf` example
If your site is a SPA (client-side routing), add `nginx.conf` to repo and update Dockerfile to copy it to `/etc/nginx/conf.d/default.conf`.

Example `nginx.conf`:

```
server {
    listen 80;
    server_name _;

    root /usr/share/nginx/html;
    index index.html;

    location / {
        try_files $uri $uri/ /index.html;
    }

    location ~* \.(?:manifest|appcache|xml|json)$ {
        add_header Cache-Control "no-cache, must-revalidate";
    }

    location ~* \.(?:css|js|jpg|jpeg|gif|png|svg|ico|woff2?)$ {
        expires 30d;
        add_header Cache-Control "public";
    }
}
```

To use it, create the file `nginx.conf` in the repo and update Dockerfile to copy it:

```dockerfile
COPY nginx.conf /etc/nginx/conf.d/default.conf
```

---

What I added to the repo for you
- `Dockerfile` — serves the static site with nginx
- `docker-compose.yml` — local testing
- `.dockerignore` — keep builds small
- `DOCKPLOY.md` — this Dokploy-specific guide

Next steps I can take for you
1. Add `nginx.conf` (SPA routing) if you need client-side routing.
2. Build and test the Docker image locally and share results.
3. If you give me the Dokploy UI screenshots or exact web form labels, I can tailor the `DOCKPLOY.md` steps to match the UI word-for-word.

If you're ready, follow the steps in `DOCKPLOY.md`. If you want me to add the `nginx.conf` and update the Dockerfile to include it, reply "add nginx.conf" and I'll create it.