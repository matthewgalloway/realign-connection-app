#!/bin/bash
echo "Start script is running"
echo "Current directory: $(pwd)"
echo "Contents of current directory:"
ls -la
# Keep the container running
tail -f /dev/null