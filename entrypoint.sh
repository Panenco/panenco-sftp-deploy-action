#!/bin/sh -l
set -eu

TEMP_SSH_PRIVATE_KEY_FILE='../private_key.pem'
TEMP_SFTP_FILE='../sftp'

# Save private key to a file
printf "%s" "$5" >$TEMP_SSH_PRIVATE_KEY_FILE
chmod 600 $TEMP_SSH_PRIVATE_KEY_FILE

# SFTP file transfer
echo 'sftp start'
printf "%s" "put -r $6 $7" >$TEMP_SFTP_FILE
sshpass -p $2 sftp -oBatchMode=no -b $TEMP_SFTP_FILE -P $4 $8 -o StrictHostKeyChecking=no -i $TEMP_SSH_PRIVATE_KEY_FILE $1@$3

# Create body and signature
body="{}"
signature="$(echo -n "$body" | openssl sha1 -hmac "$10" -binary | xxd -p)"
signature=$(echo -n "$signature")

# Debugging information
echo "$9"
echo "$body"
echo "$signature"

# Send curl request and capture result
if [ ! -z "$9" ]; then
    response=$(curl --location --request POST "$9" \
        --data-raw "$body" \
        --header 'Content-Type: application/json' \
        --header "X-Hub-Signature:sha1=$signature" \
        --write-out '%{http_code}')
    
    # Check if the HTTP response code indicates a failure
    if [ "$response" -ne 200 ]; then
        echo "Deployment failed. Server responded with HTTP code $response"
        exit 1
    fi
fi

echo 'deploy successful'
exit 0
