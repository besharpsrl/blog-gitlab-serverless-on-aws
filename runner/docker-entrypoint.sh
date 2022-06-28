#!/bin/sh 
 
# Create a folder to store the user's SSH keys if it does not exist. 
USER_SSH_KEYS_FOLDER=~/.ssh 
[ ! -d ${USER_SSH_KEYS_FOLDER} ] && mkdir -p ${USER_SSH_KEYS_FOLDER} 
 
# Copy contents from the `SSH_PUBLIC_KEY` environment variable 
# to the `$USER_SSH_KEYS_FOLDER/authorized_keys` file. 
# The environment variable must be set when the container starts. 
echo "${SSH_PUBLIC_KEY}" > ${USER_SSH_KEYS_FOLDER}/authorized_keys 
 
# Clear the `SSH_PUBLIC_KEY` environment variable. 
unset SSH_PUBLIC_KEY 
 
echo "Starting SSH"
# Start the SSH daemon 
/usr/sbin/sshd -D 
 