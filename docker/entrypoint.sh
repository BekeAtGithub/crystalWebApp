#!/bin/bash
set -e

# If a NODE_NUMBER is not set, default to "01"
NODE_NUMBER=${NODE_NUMBER:-"01"}

# If a PORT is not set, default to 8080
PORT=${PORT:-8080}

# Run the main application
exec ./main
