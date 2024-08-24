#!/bin/sh
nginx -g "daemon off;" &
. /opt/venv/bin/activate && cd /app/backend && flask run --host=0.0.0.0