---
title: How can I find which process on an instance is using too much CPU?
category: general
description: The RightScale monitoring system shows that there are high CPU events but it is not being caused by one of the processes that is actually being monitored such as httpd or mysqld.
---

## Background Information

The RightScale monitoring system shows that there are high CPU events but it is not being caused by one of the processes that is actually being monitored such as httpd or mysqld. How can I identify which process is causing the problem? This is easy enough to do if the instance is still running by running top, but what if the instance terminates because it is part of an autoscaling array or it is not accessible for some other reason? I need something like this for debugging purposes.

* * *

## Answer

One way of doing this is to install a program on the instance itself that sends information on high process use to `/var/log/messages`. Since this is available from the Dashboard, even after the instance terminates, you can look to see what high cpu procesess were running. The following script is very simple and can be expanded. It wakes up every minute and checks the process list and any process that is using over 40% CPU will be logged in `/var/log/messages`. You can modify the sleep time and cpu threshold by modifying the script.

You will want to install this as a boot script on your instances. If you want to test it (you probably should) then use the included C program at the end. You can compile and run it and it will stress the CPU. This will allow you to run it on an instance and see that messages are getting logged. You will also be able to see the monitoring graphs at work.

Install the following script as an attachment to your boot script. You can create a text file and upload it. You can edit the attachment directly in the Dashboard as well if you need to modify the script:

### ATTACHMENT TO SCRIPT (procwarn.txt):

~~~
  #! /bin/bash
  while true
  do
   STRING=`ps -e -o pcpu= -o comm= | sort -k1 -n -r | more | head -1`
   CPU=`ps -e -o pcpu= -o comm= | sort -k1 -n -r | more | head -1 | awk '{ print $1 }'`
   CPU=${CPU%%.*}
   if [$CPU -gt 40]
   then
          logger -t ProcessWarning $STRING
   fi
   sleep 60
  done
~~~

### BOOT SCRIPT:

~~~
  #! /bin/bash
  cp $RS_ATTACH_DIR/procwarn.txt /root/procwarn

  chmod 700 /root/procwarn
  /root/procwarn &
~~~

When this script runs, it installs the attachment script (procwarn.txt) as `/root/procwarn` and runs it. This will create a process that wakes up every minute and checks for any processes consuming more than 40% CPU and then logs it to `/var/log/messages`. It only prints the "top" process. Not all of them. It is used for identifying the single process consuming the most CPU.

To test, you can SSH into your instance and install and compile the following C program on your instance:

~~~
  vi test.c


  int main(){while (1);}


  gcc test.c


  ./a.out &
~~~

You will now have an a.out process running that consumes enough CPU to trigger the warning. You can check your server instance in the Dashboard "logs" tab to see the process getting thrown.
