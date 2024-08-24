#!/bin/bash

echo "Current user: $(whoami)"
echo "Current directory: $(pwd)"
echo "Contents of /app:"
ls -la /app
echo "Permissions of start.sh:"
ls -l /app/start.sh

# Start Nginx
nginx -g "daemon off;" &

# Start Flask app
cd /app
flask run --host=0.0.0.0