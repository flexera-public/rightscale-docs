---
title: Scripts won't run even after RightLink restart and re-enrollment. What is wrong?
category: general
description: Further troubleshooting for a script that won't run after a Rightlink restart and re-enrollment.
---

## Background Information

Usually, this behavior is seen if NTP is not properly synced from the source.

## Answer

If you encounter this issue and you can still access the Server, try to do the following. 

	1. service ntpd status <br>
	2. ntpq -pn <br>

For item 2, please check the delay or jitter that is returned. If it is high, please re-sync your ntp.
 
 	3. ntpstat or service ntpd restart

Check again after a few seconds if ntp has synced properly. After that, you can test to run your script. If this does not work, attempt to reboot your Server.

