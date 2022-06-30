---
title: About Port Forwarding Rules
description: The Port Forwarding Index page in the RightScale Cloud Management Dashboard displays the current port forwarding rules in effect. 
---

## Overview

!!warning*Important!* This feature is only supported by the Dashboard and not the API.

The Port Forwarding Index page displays the current port forwarding rules in effect. Port forwarding is used to enable communications between external hosts and services offered within a VLAN (virtual local area network) in a private cloud. As a common use case, you could use port forwarding rules to enable external hosts to access SSH or HTTP services on a specific instance and port in your VLAN. Port forwarding is often known as port mapping, because a request on a public port gets *mapped* to a private port number. The port can be the same on both sides, or mapped from any open external port to any open internal port. Unlike port forwarding in traditional computing, in virtual environments (such as cloud infrastructures that support port forwarding capabilities) you can have multi-tenant IP addressing. That is, a virtual instance in the cloud could support more than one IP address. This offers a lot of flexibility on how to forward network traffic for a given IP:Port combination, and is also why both an IP address *and* Instance name are required when configuring port forwarding rules.

**Default Fields**

* **Resource UID**

* **Instance** - The running instance to forward the network traffic to. Because the instance and IP address are rather loosely coupled (e.g. not always 1:1) for clouds with port forwarding capabilities, you must specify both the instance and IP Address to forward traffic to.
* **IP Address** - Specify the public IP address for the instance to forward traffic to. The instance might have only one IP address, but it could be more than one. Hence, you must specify the IP too.
* **Public Port** - Incoming network traffic on this public port will get forwarded (to the IP:Private Port of the specified Instance).
* **Private Port** - Incoming network traffic will get forwarded to this port number on the specified Instance.
* **Protocol** - Type of network traffic that gets forwarded. Specify UDP or TCP traffic.

**Actions**

* **New** - Create a new port forwarding rule.
* **Delete** - Delete the port forwarding rule.

!!info*Note:* Think of port forwarding as another networking "mode". Instead of the standard Security Group model, port forwarding is how some cloud infrastructures implement a virtual networking mode. Depending on the cloud's implementation, both modes may co-exist. That is, the cloud may support one mode or the other, both modes, or some hybrid of both. (For example, the cloud supports both networking modes as a whole, but within a given Datacenter / Zone only one mode can be configured.) A summary view of port forwarding looks like this:

`public_IP:public_port -> instance:private_port`

## Actions

* [Create New Port Forwarding Rules](/cm/dashboard/clouds/generic/port_forwarding_rules_actions.html)

## Further Reading

* [Port Forwarding](http://en.wikipedia.org/wiki/Port_forwarding) (Wikipedia)
