---
title: About Instance Types
description: RightScale uses Instance Types to help normalize the offerings from the various cloud providers. Instance Types are coded into the RightScale Dashboard.
---

## Overview

Every cloud infrastructure provides compute resources and the ability to provision these resources. The most important characteristics of compute resources are CPU, memory and local storage. They tend to factor most heavily into the decision making process of which compute resource you should use to meet your specific requirements. Each cloud provider has varying resources and levels of granularity that they provide. RightScale uses **Instance Types** to help normalize the offerings. Instance Types are coded into the RightScale Dashboard; you cannot just create, delete, and maintain your own Instance Types arbitrarily.

!!info*Note:* The fields defined below are set up in the database ahead of time in accord with the cloud's offerings, and are not fetched and displayed dynamically via the cloud infrastructure API (this is the case whether or not they can be retrieved via the cloud's API).

**Default Fields**

* **Name** - Name of the Instance Type. Clicking the Name hyperlink takes you to that Instance Type's show page, revealing additional information.
* **Estimated Pricing** - Used to calculate usage for specific Instance Types. The hourly cost estimate for a private cloud is typically $0.00/hour, whereas public cloud rates will vary depending on the specific resources defined by the Instance Type (for example, larger Instance Types tend to cost more than smaller ones). Estimated Pricing is editable by users with 'admin' role and can be used to represent costs similar to how public clouds have per hour instance fees.
* **RightScale Compute Unit** (RCU) - A standard measure of computing capacity across cloud infrastructures that factors in processor and memory resources.

**Other Fields**

* **Resource UID** - Resource Unique IDentifier for the Instance Type. Each resource (or entity) in the Dashboard has a unique ID tied to it. Whether the ID is numeric or alphanumeric varies depending on the cloud infrastructure. The Resource UID is generated and persistent in the Cloud. The value is initially retrieved from the Cloud, set in the database, and retrieved/displayed in many areas of the Dashboard (tied to the specific cloud resource).
* **Memory** - Amount of memory an Instance Type has (in megabytes). Example: 512 MB.
* **CPU Speed** - The architecture the CPU Instance Type has. Example: 784 Mhz.
* **CPU Count** - The number of CPUs the Instance Type has. For example, 1 or 2 CPUs.
* **Local Disk Spindles** - The number of disk spindles on the local disk drives.
* **Local Disk Size** - The size of the local disk in gigabytes (GB).
* **CPU Architecture** - The architecture the CPU Instance Type has. For example, x86 or 64 bit architectures.

**Actions**

* **Launch** - Launch an instance with the compute resources specified by the Instance Type. You will be prompted for the following before the instance is launched in the cloud: Name, Image to use, Instance Type, Security Group(s) and the Datacenter/Zone to run in. Note: If the RCU is not set, then you will not be able to launch an Instance (that is, the action is not made available from the Dashboard).

## Actions

Other than launching an instance based on specific Instance type (see **launch** above), there are currently no actions you can perform with respect to Instance Types. Think of them as containing read-only information after the initial setup and configuration is performed.

* [Set Instance Type Prices](/cm/dashboard/clouds/generic/instance_types_actions.html)

## Further Reading

* [EC2 t2.x instance type requirement](/faq/EC2_t2.x_Instance_Type_Requirement.html)
