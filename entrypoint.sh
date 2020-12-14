#!/bin/sh -l
set -eu

TEMP_SSH_PRIVATE_KEY_FILE='../private_key.pem'
TEMP_SFTP_FILE='../sftp'

printf "%s" "$5" >$TEMP_SSH_PRIVATE_KEY_FILE
chmod 600 $TEMP_SSH_PRIVATE_KEY_FILE
echo 'sftp start'
printf "%s" "put -r $6 $7" >$TEMP_SFTP_FILE
sshpass -p $2 sftp -oBatchMode=no -b $TEMP_SFTP_FILE -P $4 $8 -o StrictHostKeyChecking=no -i $TEMP_SSH_PRIVATE_KEY_FILE $1@$3

echo 'deploy successful'
exit 0