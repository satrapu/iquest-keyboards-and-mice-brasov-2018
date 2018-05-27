#!/bin/sh
### Ensure when editing this file on Windows, its line-endings are set to "LF" instead of "CRLF"!
set -eu

main() {
    sleepingTime="$CHECK_DB_SLEEP"
    totalAttempts=$CHECK_DB_RETRIES
    currentAttempt=1

    echo "Start checking whether PostgreSQL database \"$DB_NAME\" is up & running" \
            "(able to process incoming connections) each $sleepingTime for a total amount of $totalAttempts times"

    while [ $currentAttempt -le $totalAttempts ]; do
        sleep $sleepingTime
        
        response=$(curl --silent --unix-socket /var/run/docker.sock http://v$DOCKER_API_VERSION/containers/json | \
                    jq '.[] | select(.Labels["com.docker.compose.service"] == "'$DB_SERVICE_NAME'") | select(.State == "running") | .Status | contains("healthy")')

        if [ "$response" = "true" ]; then
            echo "OK: [$currentAttempt/$totalAttempts] PostgreSQL database \"$DB_NAME\" is up & running."
            dotnet dotnet-core-with-docker.dll
            return 0
        else
            echo "WARN: [$currentAttempt/$totalAttempts] PostgreSQL database \"$DB_NAME\" is still NOT up & running ..."
            currentAttempt=`expr $currentAttempt + 1`
        fi
    done;

    echo "ERROR: Could not connect to PostgreSQL database \"$DB_NAME\" in due time."
    return 1
}

main
