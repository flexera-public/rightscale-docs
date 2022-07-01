---
title: Can the public or private IP addresses change on an EC2 instance?
category: aws
description: A common topic of confusion is understanding when and why an instance's public and/or private IP addresses can change.
---

## Background Information

A common topic of confusion is understanding when and why an instance's public and/or private IP addresses can change. For example, what happens to an instance's public IP address when an instance is rebooted, stopped and restarted, or an Elastic IP is associated or disassociated with it?

* * *

## Answer

Once an EC2 instance is launched, it's assigned a private IP address at boot time. An instance's private IP address will never change during the lifetime of that instance. As per [AWS](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-instance-addressing.html#concepts-public-addresses), when an instance is launched in EC2-Classic, it is automatically assigned a public IP address to the instance from the EC2-Classic public IPv4 address pool. This behavior cannot be modified.  When an instance is launched in a VPC, you control whether it receives a public IP or not. The public IP address can change under certain [circumstances](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-instance-addressing.html#concepts-public-addresses).

**Note**: Public and private DNS names are constructed based upon an instance's public and private IP addresses. So, if an instance's public IP address changes, the public DNS name will also change accordingly.

### What happens when you perform the following actions in RightScale?

* **Reboot** - When you perform a reboot, the same virtual machine instance is rebooted. The original virtual machine instance that was provisioned to you is never returned back to Amazon.  The public IP address will not change.
* **Assign, reassign, remove an Elastic IP address** - An instance (in EC2-Classic) can only have one public IP address at any given time. An instance (in a VPC) can have [multiple](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/MultipleIP.html) public ip addresses. When an instance is assigned an Elastic IP, the EIP becomes its new public IP address and its previous public IP address (if one has already been assigned to it) will be released. For example, if you launch an instance and later assign an Elastic IP to it, the original public IP address of the instance will be replaced by the Elastic IP address. Later, if you disassociate the Elastic IP from the instance, a new public IP address will be assigned to the instance. The original public IP address will not be reassigned to the instance again.
* **Relaunch** - When you [relaunch](/cm/management_guide/server_states.html#rightscale-server-states-booting) a server, the running instance is terminated and a new instance is launched in its place. The new instance will have new and different public and private IP addresses than its predecessor because it's a different virtual machine that's been allocated to you.
* **Stop and Restart** - When you stop a server in RightScale, the associated instance is actually [terminated](/cm/management_guide/server_states.html#rightscale-server-states-terminated). Therefore, when you [restart](/cm/management_guide/server_states.html#rightscale-server-states-booting) the server, another virtual machine instance will be provisioned to you,so it will have new and different public(unless it was allocated an elastic ip) and private IP addresses.

### Things to consider

Once you understand how IP addresses and DNS names are affected when different actions are performed, you start to realize the importance of using remappable IP addresses such as Elastic IPs for front end servers in the cloud.  Elastic IPs provide a way of maintaining the same public facing IP address even when the associated virtual machine instance is changed.

### See also

* [RightScale Server States](/cm/management_guide/server_states.html#overview)
* [AWS Instance States](/cm/management_guide/server_states.html#amazon-instance-states)
* [What is the difference between terminating and stopping an EC2 instance?](/faq/clouds/aws/Whats_the_difference_between_Terminating_and_Stopping_an_EC2_Instance.html)
* [Elastic IP (EIP)](http://support.rightscale.com/09-Clouds/AWS/02-Amazon_EC2/Elastic_IP_(EIP))

Manage AWS more efficiently with RightScale. [Try it free](https://www.rightscale.com/free-trial?sd=Free&t=supportal).
