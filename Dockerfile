FROM debian
RUN apt update \
   && apt install -y samba proftpd apache2 \
   && mkdir -p /var/srv/webdav /var/srv/smb /var/srv/ftp
COPY webdav.conf /etc/apache2/sites-available/
RUN a2dissite 000-default \
  && a2dissite default-ssl \
  && a2ensite webdav \
  && a2enmod auth_digest \
  && a2enmod dav \
  && a2enmod dav_fs \
  && mkdir -p /var/run/apache2 \
  && . /etc/apache2/envvars \
  && htpasswd -b -c /etc/apache2/users.password test test \
  && chown -R www-data:www-data /etc/apache2/users.password /var/srv/webdav /var/www
COPY proftpd.conf /etc/proftpd/proftpd.conf
RUN addgroup ftp \
  && chown ftp:ftp /var/srv/ftp \
  && chmod a+rwx /var/srv/ftp \
  && mkdir -p /var/run/vsftpd/empty 
COPY smb.conf /etc/samba/smb.conf
RUN useradd -ms /bin/bash test \
  && echo "test:test" | chpasswd \
  && smbpasswd -a -n test \
  && (echo test; echo test) | smbpasswd -s test \
  && smbpasswd -e test \
  && chown test:test /var/srv/smb
COPY start.sh .
STOPSIGNAL SIGWINCH
EXPOSE 80 21 20 139 445 30000-40000
CMD ["bash", "start.sh"]
