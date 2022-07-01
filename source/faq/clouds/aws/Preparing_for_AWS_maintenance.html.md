---
title: Preparing for AWS maintenance
category: aws
description: This article details RightScale's recommended practices to prepare for and handle AWS EC2 maintenance requests.
---

## Background

This article details RightScale's recommended practices to prepare for and handle AWS EC2 maintenance requests. Occasionally Amazon needs to reboot host hardware and/or reboot instances for the purpose of installing security patches and updates.

As an example, you may receive a notification from Amazon for such events. Here is a perfect example:

[[Amazon Maintenance Letter Example

Dear Amazon EC2 Customer,


One or more of your Amazon EC2 instances have been scheduled for a reboot in order to receive some patch updates. Most reboots complete within minutes, depending on your instance configuration. The instance(s) that will be rebooted and your scheduled reboot time(s) are listed below.


**Region Instance ID Maintenance Window**

us-east-1 i-xxxxxxx 2011-12-11 04:00:00 UTC - 2011-12-11 10:00:00 UTC instance-reboot

No action is required on your part. Each reboot will occur during the corresponding scheduled maintenance window listed above. Note that when a reboot is done, all of your configuration settings are retained. You also have the option to manage these reboots yourself at any time prior to the scheduled maintenance window.

If you do want to manage your reboots for yourself, or simply want more information on the reboot process, please visit the Amazon EC2 Maintenance Help Page at: http://aws.amazon.com/maintenance-help/

All scheduled events for your Amazon EC2 instances can also be found on the Scheduled Events page in the AWS Management Console at:
https://console.aws.amazon.com/ec2/home?#s=ScheduledEvents

Additional details on how to see your scheduled events, as well as additional details on how to manage them yourself can be found in the Amazon EC2 User Guide at: http://docs.amazonwebservices.com/AWSEC2/latest/UserGuide/monitoring-instances-status-check.html

Should you have any questions or concerns, the AWS Support Team is available on the community forums and via AWS Premium Support at:
http://aws.amazon.com/support

Sincerely,
Amazon Web Services
]]

## Answer

**1. Ensure your scripts are reboot-safe**

This can't be stressed enough! Be sure that any and all of your RightScripts (or Chef recipes) are fully reboot-safe.

The majority of our default RightScripts are reboot-safe by default.&nbsp; However, your own custom scripts or 3rd party imported scripts may not be. We utilize an environment variable on our Linux RightScripts that checks for reboot conditions, and if it is met it will NOT re-run the RightScript.

An example of this is shown here:

~~~
#
# Test for a reboot, if this is a reboot just skip this script.
#
if test "$RS_REBOOT" = "true" ; then
  echo "Skip re-setting Timezone on reboot."
  exit 0 # Leave with a smile ...
fi
~~~

When you put this code in your bash script/RightScript, it will check for the $RS\_REBOOT variable's status, and if it is True it will skip the remainder of the script.

For more information on making RightScripts reboot-friendly, see [Create Reboot-safe RightScripts](http://support.rightscale.com/12-Guides/Dashboard_Users_Guide/Design/RightScripts/Actions/Create_Reboot-safe_RightScripts).

**2. Backups**

The next thing to check is that any custom configuration file changes, settings or anything of that nature are regularly and currently backed up OR scripted out in RightScripts.

We normally recommend scripting these changes into RightScripts or Chef Recipes if possible, as opposed to simply changing them on the instance once. The reason for this is because if it is scripted, an instance can simply reboot or re-launch and the configuration change or setting will automatically recreate itself, so there is no need to worry about having a file backed up or saved anywhere else.

As a quick example, instead of changing a Timezone on an instance manually, we have a script to accomplish it like the following:

~~~
if ["$SYS_TZINFO" = "localtime"]; then
  echo "SYS_TZINFO set to localtime. Not changing /etc/localtime..."
  exit 0
else
  tzset="$SYS_TZINFO"
fi


#
# Set the Timezone
#
ln -sf /usr/share/zoneinfo/$tzset /etc/localtime
echo "Timezone set to $tzset"
~~~

This may seem obvious, but now we can simply set an Input value to a timezone, and every time this script runs it will setup the timezone properly.

Another example for editing config files could be done using 'sed' or a similar tool. For example -

~~~
sed -i "s/127.0.0.1/&\t$HOSTNAME/" /etc/hosts
sed -i "s/^HOSTNAME.*/HOSTNAME=$HOSTNAME/" /etc/sysconfig/network
hostname $HOSTNAME
~~~

This simple script updates the hostname on an instance. Instead of manually connecting to the instance using SSH and changing the hostname one time by editing the /etc/hosts file, we change it dynamically using the sed command. This way, it is scripted, and we do not need to keep a backup of our `/etc/hosts` file from our instances anywhere.

**EBS Volumes**

Another good practice for backups is to ensure you have regular EBS snapshots of any/all EBS volumes attached to ANY of your running instances. You can take a manual snapshot or if you are using our EBS Tools, we have a "Continuous" snapshot script that runs a backup regularly throughout the day.

Our EBS Toolbox template can be used to create properly tagged volumes and backup/restore to/from snapshots easily. It is located in the library here:

[http://www.rightscale.com/library/server\_templates/EBS-Stripe-Toolbox-11H1/18194](http://www.rightscale.com/library/server_templates/EBS-Stripe-Toolbox-11H1/18194)

For more info on creating a manual snapshot, see [Create an EBS Snapshot](http://support.rightscale.com/12-Guides/Dashboard_Users_Guide/Clouds/AWS_Regions/EBS_Snapshots/Actions/Create_an_EBS_Snapshot).

For more info in general on EBS snapshots, see [EBS Snapshots](http://support.rightscale.com/12-Guides/Dashboard_Users_Guide/Clouds/AWS_Regions/EBS_Snapshots).

**3. Be proactive - reboot/re-launch yourself**

If everything above has been taken care of - that is to say, you have **ANY** changes scripted and **ALL** important data backed up/snapshotted, you are ready to reboot the instance yourself.

To do so, simply navigate to the server or instance within the RightScale Dashboard and use the "Reboot" button found towards the top of the page. This will be a user-initiated reboot.

Here is a screenshot of the Reboot button on a server:

![faq-reboot.png](/img/faq-reboot.png)

Alternatively, if you do not think a reboot will completely keep Amazon from rebooting your instance, you are welcome to also try a **Relaunch** of the server/instance as well.

A relaunch will give you an entirely new instance, which means you will be given new resources/hardware on the infrastructure side and a new Amazon EC2 Instance ID. This might be a better option (we normally recommend re-launch instead of a reboot 99% of the time) since it could possibly give you a new instance on hardware that does not need an AWS-scheduled reboot! If it is successful, you can circumvent the problem before AWS even needs to reboot the instance.

**NOTE**: Some people may think this is a better way to go, because you can control WHEN the instance is rebooted/relaunched! If AWS is planning on doing a scheduled reboot after hours and you run into problems with production servers, you may not get the help you need right away. However, if you perform this early, you have the opportunity to do it during business hours and get support from RightScale, AWS or other 3rd party resources as needed!!

**Still need help or have questions?**

Feel free to contact us at **[support@rightscale.com](mailto:support@rightscale.com)** or at **(866) 787-2253.** Alternatively, you may open a support ticket by going to the **Support -> Email** link from within the RightScale Dashboard (top right corner) and opening a support incident.
