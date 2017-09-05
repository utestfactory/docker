#!/bin/bash

# post-apply script that properly manages ssh authentication keys
# Install in /var/radmind/postapply

SSHKEYGEN=/usr/bin/ssh-keygen

if [ ! -f /etc/ssh/ssh_host_rsa_key ]; then
    $SSHKEYGEN -q -t rsa  -f /etc/ssh/ssh_host_rsa_key -N "" \
        -C "" < /dev/null > /dev/null 2> /dev/null
    echo "Created /etc/ssh_host_rsa_key"
fi

if [ ! -f /etc/ssh/ssh_host_dsa_key ]; then
    $SSHKEYGEN -q -t dsa  -f /etc/ssh/ssh_host_dsa_key -N "" \
        -C "" < /dev/null > /dev/null 2> /dev/null
    echo "Created /etc/ssh_host_dsa_key"
fi

# Install SSH keys
mkdir -p ~/.ssh
echo $JENKINS_PUBLIC_KEY | sed 's/\\\\n/\n/g' > ~/.ssh/authorized_keys
echo $GITLAB_SSH_PRIVATE_KEY | sed 's/\\\\n/\n/g' > ~/.ssh/id_rsa
chmod 600 ~/.ssh/id_rsa

echo -e "Host u-test-factory.org\n\tStrictHostKeyChecking no\n\n" >> ~/.ssh/config
echo -e "Host gitlab.u-test-factory.org\n\tStrictHostKeyChecking no\n" >> ~/.ssh/config

# Run sshd
/usr/sbin/sshd -D
