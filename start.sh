#!/bin/bash
echo "Current user: $(whoami)"
echo "Current directory: $(pwd)"
echo "Contents of /app:"
ls -la /app
echo "Permissions of start.sh:"
ls -l /app/start.sh

nginx -g "daemon off;" &
. /opt/venv/bin/activate && cd /app/backend && /opt/venv/bin/flask run --host=0.0.0.0