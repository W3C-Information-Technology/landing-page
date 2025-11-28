#!/bin/sh
set -e

# default port if not provided
: "${PORT:=80}"

# If IWAN env var is provided (per your request), prefer it as the listen port
if [ -n "${IWAN:-}" ]; then
  SOURCE_VAR="IWAN"
  PORT="${IWAN}"
else
  SOURCE_VAR="PORT"
fi

# Timestamp helper
timestamp() { date -u +"%Y-%m-%dT%H:%M:%SZ"; }

TS=$(timestamp)
echo "[$TS] => Container starting: configuring nginx to listen on port ${PORT} (from ${SOURCE_VAR})"
echo "[$TS] => Container info: HOSTNAME=$(hostname)"

# Render nginx config from template by substituting ${PORT}
if [ -f /etc/nginx/conf.d/default.conf.template ]; then
  envsubst '$PORT' < /etc/nginx/conf.d/default.conf.template > /etc/nginx/conf.d/default.conf
  echo "[$(timestamp)] => Rendered /etc/nginx/conf.d/default.conf from template"
else
  echo "[$(timestamp)] ! Warning: template /etc/nginx/conf.d/default.conf.template not found" >&2
fi

# Validate nginx configuration before start
NGINX_TEST_LOG="/tmp/nginx-test.log"
if nginx -t 2>"${NGINX_TEST_LOG}"; then
  cat "${NGINX_TEST_LOG}"
  echo "[$(timestamp)] => nginx config test passed"
else
  echo "[$(timestamp)] ERROR: nginx config test failed" >&2
  cat "${NGINX_TEST_LOG}" >&2
  exit 1
fi

echo "[$(timestamp)] => Starting nginx (foreground). Container listens on port ${PORT}"
exec nginx -g 'daemon off;'
