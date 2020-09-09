#!/bin/bash

USERID=$(id -u)

# Ensure $HOME exists when starting
if [ ! -d "${HOME}" ]; then
  # echo "Creating ${HOME}"
  mkdir -p "${HOME}"
fi

# Setup $PS1 for a consistent and reasonable prompt
if [ -w "${HOME}" ] && [ ! -f "${HOME}"/.bashrc ]; then
  echo "PS1='\s-\v \w \$ '" > "${HOME}"/.bashrc
fi

# Add current (arbitrary) user to /etc/passwd and /etc/group
if ! whoami &> /dev/null; then
  if [ -w /etc/passwd ]; then
    # echo "Patching /etc/passwd and /etc/group"
    echo "${USER_NAME:-user}:x:${USERID}:0:${USER_NAME:-user} user:${HOME}:/bin/bash" >> /etc/passwd
    echo "${USER_NAME:-user}:x:${USERID}:" >> /etc/group
  fi
fi

# echo ${USERID} > ${HOME}/.userid
# echo "whoami = $(whoami)"
# echo "USERID = ${USERID}"
# echo "ls -al ~ = $(ls -al ${HOME})"

exec "$@"