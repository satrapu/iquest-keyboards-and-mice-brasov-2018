#!/bin/sh
### Ensure when editing this file on Windows, its line-endings are set to "LF" instead of "CRLF"!
set -eu

main() {
    sleepingTime="$PORT_CHECKING_SLEEP"
    totalAttempts=$PORT_CHECKING_ATTEMPTS
    currentAttempt=1

    echo "Start checking whether PostgreSQL database \"$DB_NAME\" is up & running" \
         "(able to process incoming connections) each $sleepingTime for a total amount of $totalAttempts times"

    while [ $currentAttempt -le $totalAttempts ]; do
        sleep $sleepingTime

        pg_isready --host=$DB_HOST --port=$DB_PORT --dbname=$DB_NAME --username=$DB_USERNAME

        if [ $? -eq 0 ]; then
            echo "OK: [$currentAttempt/$totalAttempts] PostgreSQL database \"$DB_NAME\" is up & running."
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