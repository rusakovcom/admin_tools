#!/bin/bash

# Specify the time
start_time="2024-02-13 09:00"
end_time=$(date "+%Y-%m-%d %H:%M") # Up to the current point in time, set other end_time if necessary

# A new directory is created with the name of the instance and the date
output_directory="$(pwd)/$(hostname -s)_$(date +%Y-%m-%d)_logs"
mkdir "$output_directory"

# Collect logs of each container
containers=$(docker ps -a --format "{{.Names}}")
for container in $containers
do
    log_file="$output_directory/$container.log"
    
    docker logs --since "$(date -d "$start_time" +%s)" --until "$(date -d "$end_time" +%s)" $container > $log_file
    
    echo "Logs for $container saved"
done

# chmod +x get_all_docker_containers_logs.sh
# ./get_all_docker_containers_logs.sh
