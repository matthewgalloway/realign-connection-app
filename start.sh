#!/bin/bash
echo "Current user: $(whoami)"
echo "Current directory: $(pwd)"
echo "Contents of /app:"
ls -la /app
echo "Permissions of start.sh:"
ls -l /app/start.sh

# Start Nginx
sudo nginx -g "daemon off;" &

# Activate virtual environment and start Flask app
source /opt/venv/bin/activate
cd /app/backend
flask run --host=0.0.0.0