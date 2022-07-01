---
title: How do I configure log rotation on my instances?
category: general
description: For auditing or archival purposes, you may need to decrease or increase the log rotation configuration for one or more logs files. To do this, the relevant logrotate configuration file is manipulated or created.
---

## Background

You have need to modify the log rotation configuration for log files (e.g. `/var/log/maillog`) on an instance to keep a spool of more or less logs.

## Answer

For auditing or archival purposes, you may need to decrease or increase the log rotation configuration for one or more logs files.  
To do this, the relevant logrotate configuration file is manipulated or created.

In Linux, the logrotate configuration files are usually found in `/etc/logrotate.conf` and `/etc/logrotate.d`.

### Example RightScript

The RightScale frontend templates are designed to move the Apache and HAProxy logs to the ephemeral storage in `/mnt/log` via a symlink so that a very large archive of logs can be stored. These typically reside in either `/var/log/httpd` or `/var/log/apache2` depending on the Linux distribution.

In the below script, inputs are used to control the frequency of the rotation and the number of rotated log files to keep.  
With a daily rotation, rotating 31 files effectively keeps a one month spool of daily logs.

~~~
#!/bin/bash -e

# RightScript: Modify httpd+haproxy logrotate configuration

#
# Inputs:
# LOGROTATE_HTTPD_ROTATE_FREQ e.g. daily
# LOGROTATE_HTTPD_ROTATE_KEEP e.g. 31
#

if ["$RS_DISTRO" = 'centos']; then
cat <<EOF> /etc/logrotate.d/httpd
/var/log/httpd/*log {
    $LOGROTATE_HTTPD_ROTATE_FREQ
    rotate $LOGROTATE_HTTPD_ROTATE_KEEP
    missingok
    notifempty
    sharedscripts
    postrotate
        /sbin/service httpd reload > /dev/null 2>/dev/null || true
    endscript
}
EOF
fi

if ["$RS_DISTRO" = 'ubuntu']; then
cat <<EOF> /etc/logrotate.d/apache2
/var/log/apache2/*.log {
        $LOGROTATE_HTTPD_ROTATE_FREQ
        missingok
        rotate $LOGROTATE_HTTPD_ROTATE_KEEP
        compress
        delaycompress
        notifempty
        create 640 root adm
        sharedscripts
        postrotate
                if [-f "`. /etc/apache2/envvars ; echo ${APACHE_PID_FILE:-/var/run/apache2.pid}`"]; then
                            /etc/init.d/apache2 reload > /dev/null
                fi
        endscript
}
EOF
fi

echo 'Done.'
~~~

### Running logrotate manually

In situations such as being alerted to a filling filesystem, you can call logrotate manually to action a rotation early, ahead of cron. This can be done for the entire logrote configuration or a specific include. You can also use the force option which is handy for force-rotating the log file that has been growing and filling up the partition. The verbose (-v) option is used to see the results of the rotation.

**Rotating all**

~~~
# logrotate -v /etc/logrotate.conf
~~~

**Rotating maillog only w/ force**

~~~
# logrotate -v --force /etc/logrotate.d/maillog
~~~

This then allows you to move the rotated log(s) to a different volume or off the instance (or optionally delete).

## See also

- [LOGROTATE(8)](http://man7.org/linux/man-pages/man8/logrotate.8.html)
