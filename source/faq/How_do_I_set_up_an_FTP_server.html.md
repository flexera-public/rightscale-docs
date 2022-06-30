---
title: How do I set up an FTP server?
category: general
description: Setting up an FTP Server on a RightScale server or cloud instance can enable you to upload and download files to and from the instance.

## Background Information

Setting up an FTP Server on a RightScale server or cloud instance can enable you to upload and download files to and from the instance. This is not the preferred method of uploading files to your servers, but some may want to do it anyway (SSH/SCP via PKA/PKI is the recommended method).

* * *

## Answer

The following example sets up ftpd on EL/CentOS or Debian/Ubuntu systems (you may find that additional configuration is required depending on the distribution used).

~~~
#!/bin/bash -e

yum -y install xinetd || ( apt-get -y install xinetd ftpd )

useradd ftp

if [-e /usr/share/doc/ftpd/examples/ftpd.xinetd]; then
    cp -v /usr/share/doc/ftpd/examples/ftpd.xinetd /etc/xinetd.d/ftpd
    sed -i "s/flags = IPv6/#flags = IPv6/" /etc/xinetd.d/ftpd
    mkdir -p /home/ftp/ftp
    chown -R ftp:ftp /home/ftp
else
    cat > /etc/xinetd.d/gssftp << EOF
service ftp
{
    flags = REUSE
    socket_type = stream
    wait = no
    user = ftp
    server = /usr/kerberos/sbin/ftpd
    server_args = -l
    log_on_failure += USERID
    disable = no
}
EOF
fi

service xinetd restart
~~~

## Important Notes

* You need to open TCP port 21 in your Security Groups (as required) to allow insecure FTP access
* FTP is not secure and generally not recommended, but it is convenient. **Use at your own risk!** Consider the following FAQs:
  * With RightScale there are solutions using [serveral methods](http://support.rightscale.com/06-FAQs/FAQ_0054_-_How_can_I_copy_files_to_my_server_instances%3F).
  * Use any SFTP client with your (or the instance's) private SSH key. See the [SSH FAQ](/faq/How_Do_I_Access_Servers_Using_SSH.html).

## External Links

* [FTP Must Die](http://mywiki.wooledge.org/FtpMustDie)
* [ftp(1)](http://linux.die.net/man/1/ftp") - Linux man page
* [FtpServer](https://help.ubuntu.com/community/FtpServer) (Community Ubuntu Documentation)
