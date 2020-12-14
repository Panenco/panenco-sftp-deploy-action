#!/bin/sh -l
set -eu

TEMP_SSH_PRIVATE_KEY_FILE='../private_key.pem'
TEMP_SFTP_FILE='../sftp'

printf "%s" "$4" >$TEMP_SSH_PRIVATE_KEY_FILE
chmod 600 $TEMP_SSH_PRIVATE_KEY_FILE
echo 'ssh start'
ssh -o StrictHostKeyChecking=no -p $3 -i $TEMP_SSH_PRIVATE_KEY_FILE $1@$2 mkdir -p $5
echo 'sftp start'
printf "%s" "put -r $5 $6" >$TEMP_SFTP_FILE
sftp -b $TEMP_SFTP_FILE -P $3 $7 -o StrictHostKeyChecking=no -i $TEMP_SSH_PRIVATE_KEY_FILE $1@$2

echo 'deploy successful'
exit 0