#!/bin/bash

echo "Current user: $(whoami)"
echo "Current directory: $(pwd)"
echo "Contents of current directory:"
ls -la

echo "Python version:"
python --version

echo "Pip version:"
pip --version

echo "Installed packages:"
pip list

echo "Starting Flask app..."
python app.py