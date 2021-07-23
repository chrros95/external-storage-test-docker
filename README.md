# external-storage-test-docker

> :warning: **__Never ever use this image in production!!!__**

This image is for dev/test purposes only and is highly insecure.
So, please don't allow anyone to reach this container out of the internet as long as you know what you are doing.

This docker image provides
- an FTP server (ftp://1.2.3.4)
- a WebDAV server (http://1.2.3.4/webdav)
- an SMB server (smb://1.2.3.4/Public)

The credentials are always test:test
