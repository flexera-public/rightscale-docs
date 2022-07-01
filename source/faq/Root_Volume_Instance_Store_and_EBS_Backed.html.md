---
title: Root Volume - Instance Store and EBS Backed
category: general
description: There are 2 Types of Volumes that can be used as Root Device, the Instance Store and EBS Backed volumes. The original AWS Instances came with the Instance Store volume and later with the EBS Backed volume.
---

## Overview

There are 2 Types of Volumes that can be used as Root Device, the Instance Store and EBS Backed volumes. The original AWS Instances came with the Instance Store volume and later with the EBS Backed volume. The 2 can be distinguished as below.

* **Instance Store** - Volume size is limited to 10GB
* **EBS Backed** - Volume size can go as much as 1TB

Many have asked about this specific topic and it's good to understand what options are available when dealing with the Root Device volume on the Server, specially if there's a need to expand the Root Volume on the Server which currently can be done only on EBS Backed volume.

* **Expanding Root EBS Backed Volume** - [Click HERE](http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ebs-expand-volume.html)

**NOTE**: Must carefully test and follow the instruction from AWS. Result may not be the same as outlined in the instruction, hence it's good to perform a thorough testing of this option before touching any Production Servers.

An example below showing a Root Volume not reflecting the new volume size after it was resized. The new volume had to be extended so its actual size is reflected properly.

~~~
**root@TestNode~]# df -h**  
 Filesystem                    Size  Used Avail Use% Mounted on  
 /dev/xvda1                    9.9G  2.2G  7.2G  24% /  
 none                          1.9G     0  1.9G   0% /dev/shm  
 /dev/mapper/vg--data-lvol0    400G  545M  400G   1% /mnt/ephemeral
~~~

~~~
**[root@TestNode ~]# file -s /dev/xvda1**  
 /dev/xvda1: Linux rev 1.0 ext3 filesystem data (needs journal recovery) (large files)
~~~

~~~
**[root@TestNode ~]# resize2fs /dev/xvda1**  
 resize2fs 1.41.12 (17-May-2010)  
 Filesystem at /dev/xvda1 is mounted on /; on-line resizing required  
 old desc\_blocks = 1, new\_desc\_blocks = 2  
 Performing an on-line resize of /dev/xvda1 to 6553600 (4k) blocks.  
 The filesystem on /dev/xvda1 is now 6553600 blocks long.
~~~

~~~
**[root@TestNode ~]# df -h**  
 Filesystem                    Size  Used Avail Use% Mounted on  
 /dev/xvda1                    25G  2.2G   22G  10% /  
 none                         1.9G     0  1.9G   0% /dev/shm  
 /dev/mapper/vg--data-lvol0   400G  545M  400G   1% /mnt/ephemeral  
 [root@ip-10-91-156-71 ~]#
~~~

More references can be followed as needed.

* [Creating your own AMI](http://support.rightscale.com/06-FAQs/Does_UCP_support_bundling%3F/index.html)
* [More about these 2 Types of Root Volume] (http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ComponentsAMIs.html#storage-for-the-root-device)
