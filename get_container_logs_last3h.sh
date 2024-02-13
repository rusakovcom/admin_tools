#!/bin/bash

# Specify the time
start_time=$(date -d "3 hours ago" "+%Y-%m-%d %H:%M")  # Start time is 3 hours ago

# A new directory is created with the name of the instance and the date
output_directory="$(pwd)/$(hostname -s)_$(date +%Y-%m-%d)_logs"
mkdir -p "$output_directory"

# Collect logs of each container
containers=$(docker ps -a --format "{{.Names}}")
for container in $containers
do
    log_file="$output_directory/$container.log"

    docker logs --since "$(date -d "$start_time" +%s)" $container > $log_file

    echo "Logs for $container saved"
done

# chmod +x get_container_logs.sh
# ./get_container_logs.sh
