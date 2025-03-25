#!/bin/bash

# Define the MAC address of the Bluetooth headset
HEADSET_MAC="9C:0C:35:76:C2:60" # Replace with your headset's MAC address
# Max retries and delay between attempts
MAX_RETRIES=5
RETRY_DELAY=2 # Seconds

# Function to connect to the Bluetooth headset
connect_headset() {
	echo "Connecting to Bluetooth headset with MAC address: $HEADSET_MAC"

	# Use bluetoothctl to connect
	echo -e "connect $HEADSET_MAC\nexit" | bluetoothctl >/dev/null 2>&1

	# Check the connection status
	# Retry logic
	local retries=0
	while [ $retries -lt $MAX_RETRIES ]; do
		# Check the connection status
		if bluetoothctl info "$HEADSET_MAC" | grep -q "Connected: yes"; then
			echo "Bluetooth headset connected successfully."
			return 0
		fi
		retries=$((retries + 1))
		echo "Connection attempt $retries failed. Retrying in $RETRY_DELAY seconds..."
		sleep $RETRY_DELAY
	done

	echo "Failed to connect to the Bluetooth headset after $MAX_RETRIES attempts."
	return 1
}

# Function to disconnect the Bluetooth headset
disconnect_headset() {
	echo "Disconnecting Bluetooth headset with MAC address: $HEADSET_MAC"

	# Use bluetoothctl to disconnect
	echo -e "disconnect $HEADSET_MAC\nexit" | bluetoothctl >/dev/null 2>&1

	sleep 1
	# Verify disconnection
	if bluetoothctl info "$HEADSET_MAC" | grep -q "Connected: yes"; then
		echo "Failed to disconnect the Bluetooth headset."
		return 1
	else
		echo "Bluetooth headset disconnected successfully."
		return 0
	fi
}

# Ensure bluetoothctl is available
if ! command -v bluetoothctl &>/dev/null; then
	echo "bluetoothctl command not found. Please install bluez package."
	exit 1
fi

# Parse command-line arguments
case "$1" in
-d | --disconnect)
	disconnect_headset
	;;
*)
	connect_headset
	;;
esac
