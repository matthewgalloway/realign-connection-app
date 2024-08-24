echo "Pip version:"
python3 -m pip --version

echo "Installed packages:"
python3 -m pip list

echo "Python path:"
echo $PYTHONPATH

echo "System PATH:"
echo $PATH

echo "Contents of /usr/local/bin:"
ls -la /usr/local/bin

echo "Contents of /usr/bin:"
ls -la /usr/bin | grep python

echo "Starting Flask app..."
cd /workspace/backend
python3 -m flask run --host=0.0.0.0 --port=5000