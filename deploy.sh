#!/bin/sh

# Get the current directory where the script is located
project_dir="$(dirname "$(realpath "$0")")"

# Navigate to the project directory
cd "$project_dir" || { echo "Failed to navigate to project directory"; exit 1; }

# Check if Python is installed: Debian uses `python3` to differentiate from older versions
if command -v python3 >/dev/null 2>&1; then
    python="python3"
elif command -v python >/dev/null 2>&1; then
    python="python"
else
    echo "Python is not installed. Please install Python first."
    exit 1
fi

# Create a virtual environment
venv_dir="$project_dir/venv"
if [ ! -d "$venv_dir" ]; then
    $python -m venv "$venv_dir"
fi

# Activate the virtual environment
. "$venv_dir/bin/activate"

# Install dependencies
if [ -f "$project_dir/requirements.txt" ]; then
    pip install -r "$project_dir/requirements.txt"
else
    echo "requirements.txt not found in $project_dir"
    exit 1
fi


