#!/bin/bash

echo "Current user: $(whoami)"
echo "Current directory: $(pwd)"
echo "Contents of current directory:"
ls -la

echo "Python version:"
python3 --version

echo "Pip version:"
pip3 --version

echo "Installed packages:"
pip3 list

echo "Starting Flask app..."
cd /workspace/backend
python3 app.py