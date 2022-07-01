---
title: EC2 Instances
layout: cm_layout
description: A cloud instance refers to a Virtual Machine Instance (VMI) that runs within a cloud infrastructure.
---
## Overview

A cloud *instance* refers to a Virtual Machine Instance (VMI) that runs within a cloud infrastructure. Conceptually, an instance is simply a dedicated machine in your desired cloud infrastructure that you can configure for your own purposes. Two of the more important concepts with respect to instances in the cloud are instance type and state. Both of which can differ from cloud to cloud. An instance type is basically the size of the instance. That is, the amount of compute resources when provisioned such as the amount of CPU, memory, and ephemeral storage. RightScale maps these back to generic terms which are easier to understand across all cloud infrastructures. It's the cloud provider's responsibility to make sure that an instance is provisioned which meets the requirements you specify from the RightScale Dashboard (or API).

Navigating to **Clouds** > *AWS Region* > **Instances** displays a list of all active and inactive (terminated) server instances of Amazon's EC2. It's an exhaustive list of all instances that were launched/terminated within the selected cloud/region. Click the **Active** or **Terminated** tabs to toggle the view.

!!info*Note:* The **Manage** > **Instances and Servers** page lists unmanaged instances in addition to servers that were launched from Deployments using ServerTemplates.

![cm-EC2-Instances.png](/img/cm-ec2-instances.png)

**Action Buttons**

The following action buttons are available from the Instances page:

* **Launch** - Launch an EC2 Instance using an Amazon Machine Image (AMI) and not a ServerTemplate.

## Actions

* [View EC2 Instance Details](/cm/dashboard/clouds/aws/actions/ec2_instances_actions.html#view-ec2-instance-details)
* [Terminate an Instance](/cm/dashboard/clouds/aws/actions/ec2_instances_actions.html#terminate-an-instance)

## Further Reading

* [EC2 Instance Types](/clouds/aws/aws_instance_types.html)
* [What is auto-scaling?](/faq/What_is_auto-scaling.html)
