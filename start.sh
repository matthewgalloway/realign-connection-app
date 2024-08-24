#!/bin/ash
nginx -g "daemon off;" &
. /opt/venv/bin/activate && cd /app/backend && /opt/venv/bin/flask run --host=0.0.0.0