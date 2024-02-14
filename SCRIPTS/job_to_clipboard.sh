#!/bin/bash

# check dependencies
if ! command -v scons &>/dev/null; then
	echo "scons could not be found, please install it 'pip install scons' does the trick" >&2
	exit 1
fi

if ! command -v xclip &>/dev/null; then
	echo "xclip could not be found, please install it 'apt install xclip' does the trick on linux" >&2
	exit 1
fi

# assert that there is one argument and that it's a file existing in the current directory
if [ "$#" -ne 1 ] || [ ! -f "$1" ]; then
	echo "Usage: $0 FILE" >&2
	echo "The file name should start with 'env_values_' and end with '.json'" >&2
	exit 1
fi

# check that the file starts with "env_values_" and ends with ".json" and extract the thing in between
if [[ "$1" =~ ^env_values_(.*)\.json$ ]]; then
	ENV_NAME="${BASH_REMATCH[1]}"
else
	echo "Usage: $0 FILE" >&2
	echo "The file name should start with 'env_values_' and end with '.json'" >&2
	exit 1
fi

# run scons, if it's successful then copy the content of the generate file to the clipboard
if scons --environment=$ENV_NAME; then
	xclip -sel clip <product-platform-${ENV_NAME}.nomad
	echo "Build successful and content of the file 'product-platform-${ENV_NAME}.nomad' copied to the clipboard"
else
	echo "Scons failed, see above messages" >&2
	exit 1
fi
