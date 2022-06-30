---
title: Field Definitions - Glossary
layout: cm_layout
description: A comprehensive list of the field definitions you encounter while working in the RightScale Cloud Management Dashboard.
---

The following are field definitions for the RightScale Dashboard. Field definitions fall into one of two categories:

1. A column displayed in the Dashboard, usually on a Index or Show page.
2. A field in a dialog box that the user fills out.

### A

#### Actions

Lists legal actions that can be performed against a specific row in the display. Actions are usually indicated by an action icon, and may or may not display a checkbox that works in conjunction with action links (e.g. select/clear all) and an action button that triggers the action when clicked.

#### Address

IP Address. In the context of a private cloud, the addresses in the Address column refer to specific Attachable IP Addresses taken from a pool and can be assigned to an instance.

#### Age

Length of time since the entity was created. Usually reported in the number of days, or a monthly approximation. (For example, the age of a Volume: "5 days", or "about 1 month", or the Age of a running instance: "about 1 hour".)

#### Alert Spec

Short for Alert Specification, also known simply as an Alert. Defines the conditions under which an alert is raised based on monitoring data.

**Attach Volume/Snapshot on Boot**

Attach a Volume or a Volume from a Volume Snapshot during the boot process. You will be prompted for the following information: Storage type (Volume or Volume from Snapshot); Volume to attach; Server to attach the Volume to; a device name for the attached Volume (e.g. /dev/sdj).

#### Attachable IP

Static, public IP address which can be assigned to an instance. Attachable IP addresses typically come from a pool offered by the cloud infrastructure, hence assigning or reassigning to a different instance does not have severe lag times normally associated with DNS propagation.

#### Attachment Status

Status of the Volume. Legal values are "attached" or "not attached". Although a Volume must be attached to a running instance to be used, you can take a Snapshot of a Volume that is not attached.

#### Attached at

The time and date stamp that a Volume was attached to a Server.

### B

#### Baseline

Select which report should be used as a baseline for comparison when performing a Diff.

### C

#### CIDR Block

Using CIDR notation, the IP address block allocation of the network.

#### Condition

The criteria portion of an Alert. The condition and threshold define the trigger for the alert. If the condition and threshold are met, the alert will be raised. For example, if the Server's cpu-idle time is greater than 85% for at least 3 mintues, then trigger an Alert. (Whereby that Alert may vote to grow a Server Array.)

#### CPU Architecture

The architecture the CPU of the Instance Type has. For example, x86 or 64 bit architectures.

#### CPU Count

The number of CPUs the Instance Type has. For example, 1 or 2 cores.

#### CPU Speed

The clock speed the CPU the Instance Type has (in Mhz). Example: 784 Mhz.

#### Created at

Time and date stamp that the entity was created at. (e.g. 2010-12-08 20:35:53 PST)

#### Created by

RightScale user that created the entity. For example, [john.doe@example.com](mailto:john.doe@example.com) or "-- unknown --" if the user could not be determined.

#### Created from

The Volume Snapshot that a Volume was created from or "-" if it was not created from a snapshot.

#### Credential Status

Status of your cloud credentials.

- Cloud Controller - Cloud's API server. A green sphere means it is responding to requests. Otherwise its state is "unknown".
- Cloud Account - A green sphere means that we can make an authenticated request to the Cloud Controller and get a response. (Otherwise "unknown".)

### D

#### Datacenter / Zone

A regional datacenter in the cloud. (Datacenter and zone are synonymous.) A cloud will often have multiple Datacenters which can help when architecting a highly available Deployment.

#### Deleted at

Time and date stamp that the entity was deleted at. For example, when an IP Address was deleted. (e.g. 2011-01-15 22:35:43 PST)

#### Description

User defined description of the RightScale component or entity.

#### Device

If a Volume is attached to an instance, the system identifier of the block device as it is manifested on the running Server is displayed. (If known and reported by the cloud.) If the Device of the Volume is not known it is labeled as such along with a unique/random number. Example: unknown_1438:1235.

### E

#### Enabled

Enabled/disabled status of the Alert. For example, if an Alert is enabled (yes) or disabled (no). Disabled Alerts won't trigger an action even if an associated condition is met.

#### Escalation

Name of the Alert Escalation that should be called if all conditions are met and an alert is raised. An Alert Escalation can be one action or a list of several actions.

### F

#### Fingerprint

The SSH Key's unique identifier.

### G

### H

#### High-Availability Enabled

High availability enabled is an example of Cloud specific data that may or may not be supported and passed through from the cloud infrastructure. An example setting is "true" or "false" (boolean).

### I

#### Image

The name of the machine image that was used to build the instance. A virtual image (or _virtual appliance_, in hypervisor terminology) represents a collection of software: generally an operating system and accompanying applications or utilities. Administrators use machine images installed in virtual environments (such as a public or private cloud) to define and run virtual machines on a hypervisor.

#### Instance Tenancy

Used for VPC security purposes. "Dedicated" Instance tenancy means your instances will use dedicated hardware, and no other accounts will share the same hardware for their instances.

#### IP Address

External IP address for the instance to forward traffic to when configuring Port Forwarding Rules. The instance _may have_ only one IP address, but it could be more than one. Hence, you must specify the IP too, not just the instance itself.

#### IP Addresses

Static, public IP Address which can be assigned to an instance. Attachable IP addresses typically come from a pool offered by the cloud infrastructure, hence assigning or reassigning to a different instance does not have severe lag times normally associated with DNS propagation.

#### Instance

Virtual machine instance in the cloud.

#### Instance states

The state of an instance in the cloud. Although not differentiated in the Dashboard, there are two different types of states displayed. The two types help normalize instance states between all cloud offerings. They have a subtle distinction that is clarified below for informational purposes.

1. **agent state** - Images that are RightLink enabled report an agent state. The agent state is more specific than the cloud state, and hence is always used (when known) in the Dashboard. Legal values are: _booting, operational, decommissioning_.
2. **cloud state** - State with respect to the VMI. A generic reporting from the cloud infrastructure. Legal values are: _pending, running, stopping, stopped, terminating, terminated_.

#### Instance Types

Every cloud infrastructure provides compute resources and the ability to provision these resources. The most important characteristics of compute resources are CPU, memory and local storage. They tend to factor most heavily into the decision making process of which compute resource you should use to meet your specific requirements. Each cloud provider has varying resources and levels of granularity that they provide. RightScale uses _Instance Types_ to help normalize the offerings. (Note that your cloud provider may not refer to compute resources by the same name.) Instance Types are coded into the RightScale Dashboard; you cannot just create, delete, and maintain your own Instance Types arbitrarily.

### J

### K

#### Key Material

Refers to the public/private key pair used for SSH Keys. Set to either "yes" or "no". "Yes" means that RightScale possesses the private key material for that SSH key, and can SSH into any running instance that trusts that key. This is normally the case if the SSH Key was either created from the Dashboard, or manually added to it. "No" means that the RightScale database does not contain the private key; although you can launch instances that trust that key, you cannot SSH into those instances directly from the Dashboard. _Important!_ Even if RightScale knows the private key material, it is _only_ displayed in the Dashboard's Private Key field for the user who created it, or accounts with 'admin' privileges.

### L

#### Last age

Last time the Volume had a Volume Snapshot taken. The number of days since the last snapshot or approximate number of months is displayed. If no Snapshots have been taken, a "-" is displayed.

#### Local Disk Size

The size of the local disk in gigabytes (GB).

#### Local Disk Spindles

The number of physical disks on your instance.

#### Launched by

The RightScale user that launched the Server or instance. For example, [johndoe@example.com](mailto:johndoe@example.com).

#### Lock

Lock an object so it cannot be edited and/or deleted.

### M

#### Memory

Amount of memory a Instance Type has (in megabytes). For example, 512 MB.

### N

#### Name

Name of the RightScale component or entity. Clicking the Name hyperlink takes you to that component or entity's show page.

### O

#### OS Platform

The instance's operating system. (For example, Linux/Unix or Windows.)

#### Owner

The cloud account user. For AWS, the 'owner' is defined by the AWS account number (e.g. 1234-1234-1234). 

#### Ownership

Cloud account ownership. An image is a good use case example. An image gets associated with the Cloud account ID that created the image. Note that this determines whether you even see the image from the Dashboard or not. This differs depending on the actual cloud infrastructure. For example, for one cloud the Ownership could be based on an alphanumeric account ID, for another a numeric account ID, etc.

### P

#### Password Enabled

Password Enabled is an example of Cloud specific data that may or may not be passed through from the cloud infrastructure. An example value is "true" or "false" (boolean).

#### Port Forwarding Rules

Port forwarding is used to enable communications between external hosts and services offered within a VLAN (virtual local area network) in a private cloud. As a common use case, you could use port forwarding rules to enable external hosts to access SSH or HTTP services on a specific instance and port in your VLAN. Port forwarding is often known as port mapping, because a request on a public port gets _mapped_ to a private port number. The port can be the same on both sides, or mapped from any open external port to any open internal port. Unlike port forwarding in traditional computing, in virtual environments (such as cloud infrastructures that support port forwarding capabilities) you can have multi-tenant IP addressing. That is, a virtual instance in the cloud could support more than one IP address. This offers a lot of flexibility on how to forward network traffic for a given IP:Port combination, and is also why both an IP address _and_ Instance name are required when configuring port forwarding rules.

#### Private DNS Name

The private URI that's used to privately access the running cloud instance over its private IP address. For EC2 instances, the Private DNS Name is constructed based upon its assigned Private IP Address. For example, http://ip-10-114-91-178.ec2.internal/

#### Private Key

The actual RSA private key data. _Important!_ Private key data is _only seen by the user who created the key and by account administrators_.

#### Private Port

Incoming network traffic will get forwarded to this port number on the specified Instance.

#### Protocol

Type of network traffic that gets forwarded. Specify UDP or TCP traffic.

#### Public DNS Name

The publicly facing URI that can be used to publicly access the running cloud instance. To make the instance publicly accessible over TCP/IP, the instance's security group must have port 80 open to 'any' IP. For EC2 instances, the Public DNS Name is constructed based upon its assigned Public IP Address. For example, http://ec2-72-44-38-100.compute-1.amazonaws.com/

#### Public Port

Incoming network traffic on this public port will get forwarded (to the IP:Private Port of the specified Instance).

### Q

### R

#### Resource UID

Resource Unique IDentifier. Each resource (or entity) in the Dashboard has a unique ID tied to it. Whether the ID is numeric or alphanumeric varies depending on the cloud infrastructure. The Resource UID is generated and persistent in the Cloud. The value is initially retrieved from the Cloud, set in the database, and retrieved/displayed in many areas of the Dashboard (tied to the specific cloud resource).

#### Revoke

Revoke previously granted permissions. For example, revoking a Security Group allow permission removes the ingress rules from that Security Group, while leaving all other configured aspects of the group. (Only the individual rule is removed from the group.)

#### RightScale Compute Unit

A RightScale Compute Unit (RCU) is a standard measure of computing capacity across cloud infrastructures that factors in processor and memory resources.

#### RS ID

A unique and randomly generated RightScale ID. In most instances the RS ID is not customer facing, and is used strictly as an internal tracking mechanism by RightScale. In some instances (such as SSH Keys and Security Groups) it is required to allow users to correctly identify the resource from the Dashboard.

#### Runnable

The Server or Server Array to which a Volume attachment is scheduled.

#### Runnable Type

Either Server or Server Array, depending on how Runnable is scheduled.

### S

#### Security Group

The name of the instance's Security Group. Security Groups serve as firewalls for instances that restrict ingress (incoming traffic) communication based on protocol type (TCP, UDP, ICMP), IP address, and ports. Each instance that is launched must be assigned a Security Group. Security Groups essentially control who can communicate with instances that have been assigned that Security Group. By default, all ingress (incoming) network traffic to an instance is rejected unless the instance belongs to one or more Security Groups whose rules specifically allow that traffic.

#### Server

An operational instance in the Cloud. RightScale Server's are added to Deployments to address specific application needs.

#### Size

Size of a Volume in gigabytes (GB).

#### Sketchy Host / Id

The name and IP address of the RightScale sketchy server that will be used to draw the real-time graphs for this instance.

#### Snapshots

Displays the number of Snapshots that have been taken of a specific Volume. If no snapshots have been taken of the Volume, a "-" is displayed.

#### Started at

Time and date stamp the entity was started at. For example, when a Volume Snapshot or Volume creation was started at.

#### State

Current state of the entity. Note that the state transitions are different depending on the entity. We define and track several state entities, most notably are the instance states, Volume states, Volume Snapshot states, and Alert States (green sphere indicates alerts are triggering, red is not.)

#### Status

The current status of the Volume. Valid statuses are 'available' and 'in-use'.

#### Storage Type

The type of storage. This needs to be specified, for example, when scheduling a recurring Volume attachment. In this case either a Volume or Volume from Snapshot.

#### Summary

Basic text that summarizes an Audit Entry. A short Summary is displayed, if you click on the short Summary a longer Summary is displayed. This could be tied to several things, such as a state transition (an instance goes _operational_, a volume is _attached_, etc.) or the execution of a RightScript or Chef Recipe (completed, or an error message, etc.)

### T

#### Tags

Descriptive metadata that is defined by RightScale or a user and associated with RightScale-managed objects such as servers, storage volumes, and MultiCloud Images. RightScale users can use tags for filtering objects in the RightScale Dashboard or API, while RightLink and other RightScale functions use them to facilitate server communications (for example, to register an application server with associated load balancers on startup).

### U

#### Updated at

Time and date stamp when the entity was last updated.

### V

**Visibility**

The visibility of an entity in the cloud. For example, the visibility of a Datacenter / Zone, or Image. Examples: private, public.

#### Volume

Permanent storage device in the cloud. The data on a Volume attached to an instance persists, even if the instance is terminated. (That is, the data on the Volume is not transient.)

#### Volume Snapshots

A Cloud storage volume at a particular point in time. Don't confuse this with a database snapshot, this is a snapshot of the entire volume, regardless of whether it contains a database or not. You can create a snapshot regardless of whether or not a volume is attached to an Instance. When a snapshot is created, various meta data is retained such as a Created At timestamp, a unique Resource UID (e.g. vol-52EF05A9 or GEDtestVolume), the Volume Owner and Visibility (e.g. private or public). Snapshots consist of a series of data blocks that are incrementally saved.

#### Volume Status

Current status of a Volume in the cloud. Legal values are: _in-use, available_. If a Volume is in-use, the Server it is attached to is displayed on the Volumes index page. If its available, the status is left blank. _(Note_: Also referred to as Volume state. Displayed in context in the Dashboard as simply "status".)

#### Volume Type

The types of permanent storage Volumes the cloud offers. A Name, Resource UID and Size is associated with a Volume Type.

#### VPC Subnet

If applicable, specify a subnet of your Virtual Private Cloud (VPC)

### W

#### Widget

Widgets are objects that display in the Dashboard's Overview tab. You can use RightScale Widgets to create your own custom landing page within the Dashboard. When using Widgets you can select from several Built-in Widget Definitions or create your own custom Widget Definition and then add an instance of those Widget Definitions to the Dashboard.

### X

### Y

### Z

#### Zone

A Zone is a regional datacenter in the cloud. (Datacenter and zone are synonymous, hence the name "Datacenter / Zone" inside of the Dashboard UI.) A cloud will often have multiple Datacenters which can help when architecting a highly available Deployment.
