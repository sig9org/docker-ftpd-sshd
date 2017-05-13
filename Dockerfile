#vim: set ft=dockerfile:
FROM alpine:3.5

RUN apk update \
 && apk add openssh openssh-sftp-server vsftpd \
 && echo "local_enable=YES" >> /etc/vsftpd/vsftpd.conf \
 && echo "chroot_local_user=YES" >> /etc/vsftpd/vsftpd.conf \
 && echo "allow_writeable_chroot=YES" >> /etc/vsftpd/vsftpd.conf \
 && echo "write_enable=YES" >> /etc/vsftpd/vsftpd.conf \
 && echo "local_umask=022" >> /etc/vsftpd/vsftpd.conf \
 && echo "passwd_chroot_enable=yes" >> /etc/vsftpd/vsftpd.conf \
 && echo 'seccomp_sandbox=NO' >> /etc/vsftpd/vsftpd.conf \
 && echo 'pasv_enable=Yes' >> /etc/vsftpd/vsftpd.conf \
 && echo 'pasv_max_port=10100' >> /etc/vsftpd/vsftpd.conf \
 && echo 'pasv_min_port=10090' >> /etc/vsftpd/vsftpd.conf \
 && rm -rf /var/cache/apk/*

ADD docker-entrypoint.sh /

EXPOSE 20 21 22 10090-10100

CMD /docker-entrypoint.sh
