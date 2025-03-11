#!/bin/bash
set -e  # Exit immediately if a command fails

# Function to handle termination signals
cleanup() {
    echo "Caught termination signal. Cleaning up..."
    exit 0
}

# Trap SIGINT (Ctrl+C) and SIGTERM (graceful shutdown)
trap cleanup SIGINT SIGTERM

# Debugging: Print environment variables if DEBUG=true
if [[ "$DEBUG" == "true" ]]; then
    echo "DEBUG MODE ENABLED"
    env
fi

# If the first argument starts with '-', prepend 'python'
if [[ "${1:0:1}" = '-' ]]; then
    source venv/bin/activate
    set -- python "$@"
fi

# If no arguments are provided, run a default Python script (optional)
if [[ -z "$1" ]]; then
    echo "No command provided. Running default script..."
    
    set -- Xvfb :1 -screen 0 1600x1200x16 && python3 simulator/main.py
fi

# Execute the command (default or overridden)
echo "Running command: $@"
exec "$@"