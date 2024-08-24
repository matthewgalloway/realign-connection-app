#!/bin/bash

echo "Current user: $(whoami)"
echo "Current directory: $(pwd)"
echo "Contents of /app:"
ls -la /app
echo "Permissions of start.sh:"
ls -l /app/start.sh

# Check if nginx is installed
if command -v nginx &> /dev/null
then
    echo "nginx is installed"
    nginx -g "daemon off;" &
else
    echo "nginx is not installed"
fi

# Check if flask is installed
if command -v flask &> /dev/null
then
    echo "flask is installed"
    cd /app
    flask run --host=0.0.0.0
else
    echo "flask is not installed"
    pip list
fi