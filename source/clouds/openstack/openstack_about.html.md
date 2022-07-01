---
title: About OpenStack
layout: openstack_layout_page
description: OpenStack is an open-source cloud computing platform for public and private clouds. RightScale currently supports the OpenStack Juno, Kilo, and Liberty versions.
---

## Overview

OpenStack ([http://www.openstack.org](http://www.openstack.org)) is an open-source cloud computing platform for public and private clouds. The technology consists of a series of interrelated projects delivering various components—including compute resources, a distributed object store, and image management—for a cloud infrastructure solution. RightScale currently supports the OpenStack Juno, Kilo, and Liberty versions.

## Features

Here is an overview of the various features available through OpenStack.

### Instances

Virtual machine instance in the cloud.

### Images

The name of the machine image that was used to build the instance. A virtual image (or virtual appliance, in hypervisor terminology) represents a collection of software: generally an operating system and accompanying applications or utilities. Administrators use machine images installed in virtual environments (such as a public or private cloud) to define and run virtual machines on a hypervisor.

### Instance Types

Every cloud infrastructure provides compute resources and the ability to provision these resources. The most important characteristics of compute resources are CPU, memory and local storage. They tend to factor most heavily into the decision making process of which compute resource you should use to meet your specific requirements. Each cloud provider has varying resources and levels of granularity that they provide. RightScale uses Instance Types to help normalize the offerings.  (Note that your cloud provider may not refer to compute resources by the same name.)  Instance Types are coded into the RightScale Dashboard; you cannot just create, delete, and maintain your own Instance Types arbitrarily.

### Datacenter/Zones

A regional datacenter in the cloud. (Datacenter and zone are synonymous.) A cloud will often have multiple Datacenters which can help when architecting a highly available Deployment.

### Security Groups

The name of the instance's Security Group.  Security Groups serve as firewalls for instances that restrict ingress (incoming traffic) communication based on protocol type (TCP, UDP, ICMP), IP address, and ports.  Each instance that is launched must be assigned a Security Group.  Security Groups essentially control who can communicate with instances that have been assigned that Security Group.   By default, all ingress (incoming) network traffic to an instance is rejected unless the instance belongs to one or more Security Groups whose rules specifically allow that traffic.

## Contact Information

* **OpenStack**
    Corporate website:  http://www.openstack.org

* **RightScale**
    Sales - For information about your account specifics, contact your account manager or email [sales@rightscale.com](mailto:sales@rightscale.com)
    Support - Report any bugs related to RightScale, please raise a support ticket from the Dashboard or email [support@rightscale.com](mailto:support@rightscale.com).

## See Also

* [Setup Guide - Let's Get Started](/clouds/openstack/openstack_setup_guide.html)
* [OpenStack Liberty Documentation](http://docs.openstack.org/liberty/) - This is already [EOL](/faq/end_of_life_end_of_service.html), no longer supported
* [OpenStack Juno Documentation](http://docs.openstack.org/juno/) - This is already [EOL](/faq/end_of_life_end_of_service.html), no longer supported
* [OpenStack Kilo Documentation](http://docs.openstack.org/kilo/) - This is already [EOL](/faq/end_of_life_end_of_service.html), no longer supported