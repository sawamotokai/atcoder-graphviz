#!/bin/bash

# Path to the compiled C++ binary
CLI_PATH="./atcoder-graphviz-cli"

# Check if the compiled binary exists
if [[ ! -f $CLI_PATH ]]; then
    echo "Error: $CLI_PATH not found!"
    exit 1
fi

# Check if xdot is installed
if ! command -v xdot &> /dev/null; then
    echo "Error: xdot is not installed!"
    exit 1
fi

# Run the C++ program with provided arguments and capture its output
output=$("$CLI_PATH" "$@" 2>&1)
exit_code=$?

# If the exit code is zero and it's not a help command, pipe to xdot
if [[ $exit_code -eq 0 && "$@" != *"-h"* && "$@" != *"--help"* ]]; then
    echo "$output" | xdot -
else
    # Display the CLI's output (which might be an error message or help message)
    echo "$output"
fi
