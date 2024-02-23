#!/bin/bash

url=$1 # Get the URL from the first command-line argument

while true; do
    response_code=$(curl -s -o /dev/null -w "%{http_code}" $url)
    echo "Response code for $url: $response_code"
    sleep 1
done

#chmod +x url_availability_check.sh
#./url_availability_check.sh https://google.com/
