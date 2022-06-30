---
title: Server States
layout: cm_layout
description: Provides an overview of the RightScale Server States including a flow diagram and descriptions of each state.
---

## Overview

When you launch an instance in the Cloud, a server will progress through various states. Each cloud defines and describes server states in different ways. To be consistent, RightScale has defined our own class of server states that's generic across all clouds.

The time that is required to complete the launch/terminate process varies across clouds. When launching instances, RightScale can only control the actual configuration process, but not the instantiation times for each cloud. Typically, we've observed launch times on EC2 to be around 5-10 minutes.

## RightScale Server States

The RightScale Server States only apply to server instances that were defined using ServerTemplates. Bare instances that are launching directly from machine images will not be subject to various RightScale-specific states (e.g. 'booting' and 'decommissioning'). If you are using ServerTemplates to launch RightScale server instances via the RightScale Dashboard or API, a server instance will transition between the various RightScale Server States that are defined below.

The diagram below applies to servers using v5 and above RightImages.

**Note:** If you are using v4 or earlier RightImages, the flowchart is slightly different.

**Server State Diagram for v5 RightImages**

![cm-server-state-flowchart-v5ri.png](/img/cm-server-state-flowchart-v5ri.png)

**Note:** If you are using v4 or earlier RightImages, the flowchart is slightly different.

### Bidding

The 'bidding' state is specific to Amazon EC2.

When you launch a Spot instance, RightScale will submit the request to Amazon on your behalf. The launched server will remain in the 'bidding' state until your request has been accepted by Amazon. Once a server is in the 'bidding' state you can no longer edit its configuration or change your maximum bid price. You must terminate the server in order to make any such modifications. A Spot instance will only be provisioned to you when excess EC2 capacity is available and the current Spot Price drops below your maximum bid price.

**Note:** If a running Spot instance is terminated by Amazon because your bid is no longer above the Spot price, the server will transition back to the 'bidding' state because RightScale assumes that you would like to run the same type of Spot instance again if one becomes available in the future. In this way, the request for a Spot instance will persist. If you do not want the request to persist, you must terminate the server.

If you are currently in the bidding state you can change your bid price (under the Server's Info tab), but it will only apply to the "current" server. The changed price will not be inherited by the "next" server.

### Pending

RightScale makes a request to the cloud infrastructure of your choice for a new instance on your behalf (using your cloud credentials). The cloud provider will provision an instance for you and perform a basic configuration of your machine which often includes a base OS installation. By the end of the 'pending' phase, the instance will have a public and private IP address, DNS Name, SSH access, etc.

**AWS** - Amazon will consider it a 'running' (billable) instance at the end of this phase. However, you will not be charged instance usage charges during the pending phase itself.

### Booting

At then end of the 'pending' state you will have a functional machine, however it's not completely configured from a RightScale perspective. During the 'booting' state, RightScale will begin to execute the specified boot scripts in succession. If you are using ServerTemplates, the instance will be configured appropriately so that upon completion of the installation and configuration process, it will be able to assume its designed server role. For example, an instance can be configured to be a MySQL database server, FrontEnd PHP server, Rails application server, etc. During the booting phase, boot scripts (RightScripts/Chef Recipes) are executed in succession, Elastic IPs are assigned, and EBS volumes are created (if necessary) and attached to the instance. Although you can run a script during the booting phase of an instance, it is not recommended. Server alerts and monitoring features are enabled during the booting phase.

**AWS** - Amazon will charge you instance usage costs during the 'booting' state.

* **Stranded in Booting** - When a server is stranded in the 'booting' state, the server's alert and monitoring features are not functional. A server will persist in the stranded in booting state until it is either manually terminated or forced into the operational state.

### Configuring

The 'configuring' state is a state that a server instance might quickly transition into if it's waiting for certain environment variables to exist in order to complete the execution of a script. For example, an input might be defined to use an environment variable for another instance in the deployment that was just launched and is still in the 'pending' state. In such cases, the instance must wait for that variable to exist before the associated script can be executed.

**Note:** The 'configuring' state only exists for v4 RightImages. In v5 RightImages, the server will transition directly from the 'booting' state to either 'operational' or 'stranded in booting'. The 'booting' phase includes all configuration processes.

**AWS** - Amazon will charge you instance usage costs during the 'configuring' state.

* **Stranded in Configuring** - If the script fails after it receives the missing environment variable, the instance will become stuck in the "stranded in configuring" state.

### Operational

If the server was successfully configured, the server will become operational. It is now safe to run scripts on the server instance. Typically, you will only want to execute operational scripts, however, you can also run boot and decommission scripts.

**AWS** - Amazon will charge you instance usage costs during the 'operational' state.

* **Terminate** - Shutdown the instance. When an instance is terminated, it will be shutdown and returned to Amazon's pool of EC2 resources.
* **Stop** - You can only 'stop' an EC2 instance that was launched with an EBS-based AMI. Any data that's stored in RAM will not be preserved when an instance is stopped. When you stop an instance you will no longer be billed for hourly instance usage. The root partition Amazon EBS volume that was attached to the instance will not be deleted and will persist, so you will continue to be charged for Amazon EBS volume usage.

**Note:** You cannot stop a Spot instance.

* **Reboot** - When you reboot a running instance it will complete the standard shutdown steps and then transition directly to the 'booting' state without ever being completely shutdown. When you reboot a server instance, the same machine is rebooted so you'll keep the same AWS-id, DNS names, IP addresses, etc.
* **Bundle** - Create an AMI of the instance.
* **Relaunch** - When a server instance is relaunched, you can either launch a new server and terminate the current server at the same or wait for the current server to be completely terminated before launching a new server. When you relaunch a server instance, a completely new instance is provisioned to you. It will have a new AWS-id, DNS names, and IP addresses.

### Shutting-Down

During the 'shutting-down' phase, a request is made to RightScale to terminate an existing RightScale server instance.

**v4 RightImages** - The cloud provider has been notified that you no longer want to keep the server running. The cloud provider begins the process of shutting down your instance and returning provisioned cloud resources.

### Decommissioning

Since each cloud infrastructure handles the shutdown process differently, RightScale added an intermediary phase before a cloud instance is permanently terminated. The purpose of the 'decommissioning' state is to provide you with a brief window to gracefully terminate your machine. The 'decommissioning' state is a RightScale-specific concept that is only supported when you terminate servers that you've defined using ServerTemplates. Each RightScale server instance that is terminated via the RightScale Dashboard or API will go through the 'decommissioning' state.

Be sure to use discretion when defining which scripts should be run during the decommissioning phase since some scripts may not be fully executed if time does not permit. Although you can run other scripts during the decommissioning phase of a server, it is not recommended. Important tasks such as database backups that cannot be completed in the allotted time must be manually run during the operational phase. If there are few or no decommission scripts to be executed, the server instance will be shut down faster. See [Decommission Scripts](/cm/dashboard/design/rightscripts/index.html#decommission-rightscripts) for more information.

**v4 RightImages** - In v4 RightImages, when a server instance is terminated, RightScale makes a request to the cloud infrastructure to terminate the instance and then executes the decommission scripts during the cloud's shutdown phase.

**v5 RightImages** - In v5 RightImages, when a server instance is terminated, RightScale will explicitly run the decommission scripts (up to 180 seconds) before it makes a request to the cloud infrastructure to terminate the instance. As a result, you may still incur cloud instance usage costs when a server is in the decommissioning state.

**AWS** - When you make a request to Amazon to terminate your instance, AWS shuts down your instance normally within minutes of issuing the terminate command. EC2 instances that are launched directly from AMIs and not through RightScale ServerTemplates will _not_ go through the 'decommissioning' state.

* **Stranded in Decommissioning** - If a script fails to run during the 'decommissioning' state or there is a network issue, a server may become stranded in decommissioning. Typically, a server will still be terminated in 2-3 minutes.  RightScale will attempt to force a terminate or stop on servers stuck in 'decommissioning' after 50 minutes.  This can be extended using the `rs_decommissioning:delay` tag, for more details see [Instance tags](/cm/ref/list_of_rightscale_tags.html).

### Terminated

When an instance has been successfully terminated, the instance that was provisioned to you has been returned to the pool of cloud resources and you will never have access to that same virtual machine ever again. Any RAM data will be lost. Public/Private DNS Names and IP addresses will be removed, Elastic IPs (if applicable) will be disassociated from the instance, EBS volumes will be unmounted and deleted (default), etc. You are no longer being charged for instance usage.

### Stopping

The 'stopping' state is specific to Amazon EC2.

When an instance is in the 'stopping' state, the root EBS volume will be detached but not deleted. It will remain in a billable state. Related AWS activity (EBS usage) will be charged at the normal rate. However, the instance will be terminated and any data stored in RAM will be lost. You are no longer being charged for instance usage.

**Note:** The Stop/Start function is not available for Spot instances.

### Stopped and Provisioned

Once an instance transitions into the 'stopped' state you will no longer have access to the instance. Any EBS volumes or block devices will remain and will be charged at normal billing rates. A stopped instance can be started again at a later time. You will be charged an instance hour each time that a stopped instance is started again. If you change the instance type while it is in the 'stopped' state, you will be charged at the new rate once you start the instance.

**Note:** When stopping an instance, keep in mind that it must be started again through RightScale in order to operate correctly.

### Stranded

If a server does not successfully complete one of the transitional phases, the server will enter a "stranded" state. A server will strand whenever the execution of one of the scripts fails during the boot/configuring/decommissioning phase. There are several reasons why a server can become stranded. For troubleshooting purposes, check the server's Audit Entries tab to see which script failed. An incorrectly set input is often the cause for a stranded in booting server. Check your inputs to make sure that the correct input parameter is being set. Remember, inputs can be overwritten depending on where they're defined. See [Inheritance of Inputs](/cm/rs101/inheritance_of_inputs.html) for more information.

If you are aware of the script failure and you still want to make the server operational, you have the option of forcing a "stranded" server to become operational. Under the server's Info tab, click the "<u>operational</u>" action link to force the server into the operational state.

![cm-force-operational-state.png](/img/cm-force-operational-state.png)

**Note:** Amazon will still charge you the standard rate per hour even if a server is stuck in the stranded state, because the machine is technically in the 'running' (billable) state.

### Error

If for some reason an instance experiences an error with the cloud provider, the state of the VM in RightScale will be reported as `Error`. Check audit entires for further details. Note that it may be necessary to investigate further by way of the cloud provider's portal.


## Amazon Instance States

The following states are specific to instances on Amazon EC2. It's important to understand that although RightScale uses the same names in the Dashboard to describe various server states (e.g. pending), the actual actions that take place during each state may differ depending on the context in which they are used. For example, RightScale's 'booting' and 'configuring' states actually take place during Amazon's 'running' state. You will only be charged for instance usage when an instance is in the 'running' state.

![cm-server-state-flowchart-aws.png](/img/cm-server-state-flowchart-aws.png)

### Pending

During the 'pending' phase, Amazon will provision an instance to you based on the specified instance type, AWS region, and availability zone, assign it an AWS-id and load the specified AMI. Once the image is loaded, you will have an instance with a functional operating system. Next an SSH Key and Security Group will be applied. By the end of the 'pending' state your instance will have public and private DNS names, public and private IP Addresses, and if there were any EBS snapshots that were configured to be 'attached at boot', EBS volumes will be created and attached to the instance. You cannot associate an Elastic IP to an instance or attach an existing EBS volume during the 'pending' state.

The following items will be installed, associated, and configured on the instance:

* AWS ID
* SSH Key
* Security Group
* Public/Private DNS Names
* Public/Private IP Addresses (Elastic IP association, if applicable)
* machine/kernel/ramdisk image
* EBS Snapshots ('attach at boot')

### Running

In the 'running' state, an instance is fully configured based upon the specified launch parameters. Once an instance is running you can perform one of the following actions:

* **Terminate** - Shutdown the instance. When an instance is terminated, it will be shutdown and returned to Amazon's pool of EC2 resources.
* **Stop** - You can only 'stop' an EC2 instance that was launched with an EBS-based AMI. Any data that's stored in RAM will not be preserved when an instance is stopped. When you stop an instance you will no longer be billed for hourly instance usage. The root partition Amazon EBS volume that was attached to the instance will not be deleted and will persist, so you will continue to be charged for Amazon EBS volume usage.
* **Reboot** - When you reboot a running instance it will transition directly from the 'shutting down' state to the 'running' state without ever being completely shutdown. Amazon reserved the right to occasionally reboot your instance for maintenance purposes. You can also reboot an instance manually.
* **Bundle** - Create an AMI of the instance.

### Shutting Down

In the 'shutting down' state, Amazon is preparing your instance to be either stopped or terminated.

### Stopped

Once an instance transitions into the 'stopped' state you will no longer be charged for instance usage. However, all of its Amazon EBS volumes will remain attached. Related AWS activity (EBS usage) will be charged at the normal rate. When an instance is stopped, it is shutdown, and any data stored in RAM will be lost (Spot instances do not have the start/stop functionality).

* **Terminate** - If you terminate a 'stopped' instance, any attached EBS volumes will be deleted (default).
* **Start** - You can start a stopped instance at anytime. You will be charged an instance hour each time that a stopped instance is started again. If you change the instance type while it is in the 'stopped' state, you will be charged at the new rate once you start the instance.

**Note:** When stopping an instance, keep in mind that it must be started again through RightScale in order to operate correctly.

### Terminated

When an instance has been successfully terminated, the instance that was provisioned to you has been returned to the pool of cloud resources and you will never have access to that same physical machine ever again. Any RAM data will be lost. Public/Private DNS Names and IP addresses will be removed, Elastic IPs (if applicable) will be disassociated from the instance, EBS volumes will be unmounted and deleted (default), etc.
