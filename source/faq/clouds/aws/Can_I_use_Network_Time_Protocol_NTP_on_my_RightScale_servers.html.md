---
title: Can I use Network Time Protocol (NTP) on my RightScale EC2 servers?
category: aws
description: Network Time Protocol (NTP) is a protocol used for synchronizing the time clocks of computers over a network. NTP is used by utilities such as "ntpdate" to accomplish time synchronization across multiple computers. 
---

## Background

Network Time Protocol (NTP) is a protocol used for synchronizing the time clocks of computers over a network. NTP is used by utilities such as "ntpdate" to accomplish time synchronization across multiple computers.

* * *

## Answer

By default, Amazon has Xen setup on EC2 so that it forces the hardware clock to sync to UTC. However, there may be a (fairly rare) condition that causes the time on your instance to drift. You can fix this on Linux instances by disabling the hypervisor's independent wallclock then employing the use of an NTP client.

**Note**: RightScale RightScripts will set the time zone on your server for you. You have control over that as an Input variable.

### Enabling the Independent Wallclock

Issue the following command:

~~~
# echo 1 > /proc/sys/xen/independent_wallclock
~~~

Overriding the value in `/proc/sys/xen/independent_wallclock` disables sync with the clock on the physical machine (default).

**Important!** The drift time will remain after running ntpdate or ntpd until the binary value in independent\_wallclock is set to 1.

### Installing NTP

If you don't have NTP installed on your instance you must install it first:

~~~
# apt-get -y install ntp || yum -y install ntp
~~~

### Using ntpdate

For a once off sync with a remote NTP server, you can use ntpdate, e.g.:

~~~
root@sandbox:~# ntpdate ntp.nasa.gov time-b.nist.gov
30 Jun 04:05:58 ntpdate[19740]: adjust time server 198.123.30.132 offset -0.001006 sec
~~~

Notice the time adjustment. If a large drift remains after running ntpdate twice, the independent wallclock has not been enabled.

### Using ntpd

For regular sync with remote NTP servers, use ntpd.

~~~
#!/bin/bash -ex
if grep 'server ntp.ubuntu.com' /etc/ntp.conf > /dev/null 2>&1; then
   sed -i 's/server ntp.ubuntu.com/#server ntp.ubuntu.com/g' /etc/ntp.conf
fi
cat <<EOF>> /etc/ntp.conf
server time.rightscale.com
server pool.ntp.org
EOF
~~~

~~~
service ntp restart || service ntpd restart
~~~

Example service restart showing the initialization of ntpd then a subsequent sync according to the frequency in the configuration:

~~~
root@sandbox:~# service ntp restart; tail -f /var/log/messages
* Stopping NTP server ntpd [OK]
* Starting NTP server ntpd [OK]
Jun 30 04:11:16 sandbox ntpd[20173]: ntpd 4.2.4p8@1.1612-o Tue Apr 19 07:08:18 UTC 2011 (1)
Jun 30 04:11:16 sandbox ntpd[20174]: precision = 1.000 usec
Jun 30 04:11:16 sandbox ntpd[20174]: Listening on interface #0 wildcard, 0.0.0.0#123 Disabled
Jun 30 04:11:16 sandbox ntpd[20174]: Listening on interface #1 wildcard, ::#123 Disabled
Jun 30 04:11:16 sandbox ntpd[20174]: Listening on interface #2 lo, 127.0.0.1#123 Enabled
Jun 30 04:11:16 sandbox ntpd[20174]: Listening on interface #3 eth0, 10.161.110.239#123 Enabled
Jun 30 04:11:16 sandbox ntpd[20174]: Listening on interface #4 lo, ::1#123 Enabled
Jun 30 04:11:16 sandbox ntpd[20174]: Listening on interface #5 eth0, fe80::1031:3fff:fe01:6d01#123 Enabled
Jun 30 04:11:16 sandbox ntpd[20174]: kernel time sync status 2040
Jun 30 04:11:16 sandbox ntpd[20174]: frequency initialized 17.284 PPM from /var/lib/ntp/ntp.drift
Jun 30 04:15:34 sandbox ntpd[20174]: synchronized to 174.129.253.100, stratum 2
Jun 30 04:15:34 sandbox ntpd[20174]: kernel time sync status change 2001
~~~

### See also

* <a nocheck href='https://forums.aws.amazon.com/thread.jspa?messageID=53658'>NTP server (AWS forum post)</a>
* <a nocheck href='https://forums.aws.amazon.com/thread.jspa?messageID=278626'>How to get reliable clock time in EC2 (AWS forum post)</a>
* [UbuntuTime](https://help.ubuntu.com/community/UbuntuTime)
* [System and hardware time](https://www.debian.org/doc/manuals/debian-reference/ch09.en.html#_system_and_hardware_time) (Debian Documentation)
* <a nocheck href="http://www.tldp.org/HOWTO/TimePrecision-HOWTO/index.html">Managing Accurate Date and Time</a> (HOWTO)
