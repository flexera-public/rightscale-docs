---
title: Port Forwarding Rules - Actions
description: Steps for creating a new Port Forwarding Rule in the RightScale Cloud Management Dashboard.
---

## Create a New Port Forwarding Rule

* **Linux** - If you are creating a port forwarding rule to allow SSH access on a Linux instance, specify port 22 for both the public and private port fields and select 'TCP' for the protocol.
* **Windows** - If you are creating a port forwarding rule to allow Remote Desktop Connections using RDP on a Windows instance, specify port 3389 for both the public and private port fields and select 'TCP' for the protocol.

### Prerequisites

* Cloud infrastructure must support a virtual networking mode. (Not just the more standard Security Group networking model.)
* A running instance

### Steps

* Navigate to **Clouds** > *Private Cloud Name* > **Port Forwarding Rules**
* Click the **New** action button
* To create a new port forwarding rule you must fill out the following fields:
  * **Instance** - The running instance to forward the network traffic to. Because the instance and IP address are rather loosely coupled (e.g. not always 1:1) for clouds with port forwarding capabilities, you must specify both the instance and IP Address to forward traffic to. Note that at this point the instance must already be launched in order to open up a port.
  * **IP Address** - Specify the IP address for the instance to forward traffic to. The instance may have only one IP address, but it could be more than one. Hence, you must specify the IP too.
  * **Public Port** - Incoming network traffic on this public port will get forwarded (to the IP:Private Port of the specified Instance).
  * **Private Port** - Incoming network traffic will get forwarded to this port number on the specified Instance.
  * **Protocol** - Type of network traffic that gets forwarded. Specify UDP or TCP traffic.
* Once filled out, click the **Create** action button. The Port Forwarding Rule will be created and a unique Resource UID issued. If the rule is not created, an error message should be passed through from the cloud to the Dashboard. For example:

~~~
Cloud Exception: Unable to create port forwarding rule (TCP:8088->8089) for virtual machine
[User|i-7-11-rightscale-untagged], bad network type (DirectSingle)
~~~
