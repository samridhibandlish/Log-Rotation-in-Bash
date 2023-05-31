#!/bin/bash

log_file="logs.txt"
max_logs=10

while true; 
do
	# Generating continuous logs
	timestamp=$(date "+%F_%H:%M:%S")
	echo "$timestamp" >> "$log_file"

	# Checking to see if max logs condition is reached
	log_count=$(grep -c "" "$log_file")
	if [ "$log_count" -gt "$max_logs" ];
	then
		# Rotating the oldest log generated to a new file
		rotated_log=$(grep -E ".*" "$log_file" | head -n 1)
		echo "$rotated_log" >> rotated_log.txt

		# Removing the rotated log from the original file
		tail -n +2 "$log_file" > temp.txt && mv temp.txt "$log_file"
	fi

	# Wait 1 second before generating a new log
	sleep 1
done
