# Generate root password
import random
import string
import time

# Copy authtoken from https://dashboard.ngrok.com/auth
authtoken = 'YOUR_NGROK_AUTH_TOKEN'

# password = ''.join(random.choice(string.ascii_letters + string.digits) for i in range(20))
password = 'WHATEVER_YOU_WANT'
public_key_path = 'LINK_TO_YOUR_PUBLIC_KEY'

# Download ngrok
! wget -q -c -nc https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip
! unzip -qq -n ngrok-stable-linux-amd64.zip

# Setup sshd
! apt-get install -qq -o=Dpkg::Use-Pty=0 openssh-server pwgen > /dev/null

# Setup authentication
! echo root:$password | chpasswd
! mkdir /root/.ssh/
! wget -P /root/.ssh/ $public_key_path
! chmod 700 /root/.ssh
! chmod 600 /root/.ssh/authorized_keys


# Config sshd server
! mkdir -p /var/run/sshd
! echo "Protocol 2" >> /etc/ssh/sshd_config
! echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
! echo "PasswordAuthentication no" >> /etc/ssh/sshd_config
! echo "TCPKeepAlive yes" >> /etc/ssh/sshd_config
! echo "X11Forwarding yes" >> /etc/ssh/sshd_config
! echo "X11DisplayOffset 10" >> /etc/ssh/sshd_config
! echo "AuthorizedKeysFile /root/.ssh/authorized_keys" >> /etc/ssh/sshd_config
! echo "PubkeyAuthentication yes" >> /etc/ssh/sshd_config
! echo "IgnoreRhosts yes" >> /etc/ssh/sshd_config
! echo "HostbasedAuthentication no" >> /etc/ssh/sshd_config
! echo "PrintLastLog yes" >> /etc/ssh/sshd_config
! echo "AcceptEnv LANG LC_*" >> /etc/ssh/sshd_config


! echo "LD_LIBRARY_PATH=/usr/lib64-nvidia" >> /root/.bashrc
! echo "export LD_LIBRARY_PATH" >> /root/.bashrc

# Run sshd
get_ipython().system_raw('/usr/sbin/sshd -D &')

# Create tunnel
get_ipython().system_raw('./ngrok authtoken $authtoken && ./ngrok tcp 22 &')

# Print root password
import os
os.system("echo 'Root password: {}'".format(password))

# Get public address
! curl -s http://localhost:4040/api/tunnels | python3 -c \
    "import sys, json; print(json.load(sys.stdin)['tunnels'][0]['public_url'])"

import requests, json
url = json.loads(requests.get('http://localhost:4040/api/tunnels').text)['tunnels'][0]['public_url']
os.system("echo '{}'".format(url))

# Now just keep the kernel alive
while True:
    time.sleep(10000)