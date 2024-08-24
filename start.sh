#!/bin/bash

echo "Current user: $(whoami)"
echo "Current directory: $(pwd)"
echo "Contents of current directory:"
ls -la

echo "Python version:"
python3 --version

echo "Pip version:"
python3 -m pip --version

echo "Installed packages:"
python3 -m pip list

echo "Python path:"
echo $PYTHONPATH

echo "Starting Flask app..."
cd /workspace/backend
python3 -m flask run --host=0.0.0.0 --port=5000