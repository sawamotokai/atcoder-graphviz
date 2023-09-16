#!/bin/bash

# Define color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'  # No Color

# Check if the system is Unix-based
if [[ "$OSTYPE" != "linux-gnu"* && "$OSTYPE" != "darwin"* ]]; then
    echo -e "${RED}Error: This installation script is only for Unix-based systems.${NC}"
    exit 1
fi

# Define the path to the C++ source and binary
SOURCE_PATH="./atcoder-graphviz-cli.cpp"
BINARY_PATH="./atcoder-graphviz-cli"
CLI_DEST="/usr/local/bin/atcoder-graphviz-cli"

# Check if the source file exists
if [[ ! -f $SOURCE_PATH ]]; then
    echo -e "${RED}Error: Source file $SOURCE_PATH not found!${NC}"
    exit 1
fi

# Compile the C++ source
g++ $SOURCE_PATH -o $BINARY_PATH -std=c++11
if [[ $? -ne 0 ]]; then
    echo -e "${RED}Error: Compilation failed!${NC}"
    exit 1
fi
echo -e "${GREEN}Compilation successful!${NC}"

# Install the runner script
RUNNER_SOURCE="./run.sh"
RUNNER_DEST="/usr/local/bin/atcoder-graphviz"

if [[ ! -f $RUNNER_SOURCE ]]; then
    echo -e "${RED}Error: Runner script $RUNNER_SOURCE not found!${NC}"
    exit 1
fi

# Copying the runner script to a location in PATH
cp $RUNNER_SOURCE $RUNNER_DEST
cp $BINARY_PATH $CLI_DEST
chmod +x $RUNNER_DEST
chmod +x $CLI_DEST
if [[ $? -ne 0 ]]; then
    echo -e "${RED}Error: try 'sudo ./install.sh'${NC}"
    exit 1
fi

echo -e "Use 'atcoder-graphviz' to visualize graph problems.${NC}"
echo -e "Use 'atcoder-graphviz -h' to see available options.${NC}"

# Prompt user to install dependencies
echo "Please ensure you have 'xdot' and the necessary C++ libraries installed on your system."
echo -e "${GREEN}Installation successful!${NC}"
