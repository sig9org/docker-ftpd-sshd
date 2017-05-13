#!/bin/sh

if [ -z ${USERNAME} ]; then
  USERNAME=admin
fi

if [ -z ${PASSWORD} ]; then
  PASSWORD=password
fi

ssh-keygen -A > /dev/null
adduser -h /home/${USERNAME} -D ${USERNAME}
/bin/sh -c "echo \"${USERNAME}:${PASSWORD}\" |/usr/sbin/chpasswd" > /dev/null 2>&1
chown ${USERNAME}:${USERNAME} /home/${USERNAME}/ -R
echo "Generated password for '${USERNAME}': ${PASSWORD}"

# Start sshd.
/usr/sbin/sshd -f /etc/ssh/sshd_config

# Start vsftpd.
if [ -z $1 ]; then
  /usr/sbin/vsftpd /etc/vsftpd/vsftpd.conf
else
  $@
fi
