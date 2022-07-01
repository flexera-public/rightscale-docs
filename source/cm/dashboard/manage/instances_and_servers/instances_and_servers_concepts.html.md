---
title: Instances and Servers - Concepts
layout: cm_layout
description: Basic concepts of Instances and Servers in the RightScale Cloud Management Dashboard including the Anatomy of a Server, differences between Servers and Instances, and the history timeline of a Server.
---
## Anatomy of a Server

Let's take a closer look at a Server. It's helpful to understand where a Server gets all of its cloud resources, software installation packages, inputs, etc. A Server's configuration leverages multiple services from RightScale, the cloud infrastructure, and other web resources to properly configure an instance in the cloud for its intended purpose (MySQL database server, application server, etc.)

For this discussion, a Server is a "RightScale" Server that you've defined using ServerTemplates. Below is a diagram that describes a Server that's designed to launch an EC2 Instance.

![cm-location-instance-resources.png](/img/cm-location-instance-resources.png)

## Is there a difference between launching a Server and launching an Instance?

When you launch a Server, an Instance will be launched in the specified cloud infrastructure. You cannot launch a Server without subsequently launching an Instance. However, you can launch an Instance directly from a machine image. For example, in Amazon EC2, you can launch an Instance using one of Amazon's AMIs, a RightImage published by RightScale, or a custom image of your own that you created by bundling a running Instance. In such cases, you can still manage the Instance in the RightScale Management Platform, however since it's technically not a RightScale Server, you cannot run RightScripts or Chef Recipes. Monitoring and alerts are also disabled. To properly take advantage of all the benefits of the RightScale Management Platform, you should use Servers to launch Instances in the cloud.

Instances that are launched directly from an image are not considered RightScale Servers, so they will not be listed under Manage -> Servers. However, they will appear under the Cloud or AWS Region in which they were launched. (e.g. Clouds -> AWS Region -> EC2 Instances) Typically, you will only want to launch an instance directly from an image for testing purposes only. Perhaps you've built a customized RightImage, but you need to first test and verify that a bare instance can successfully be launched before you reference that image in a MultiCloud Image and leverage it in your ServerTemplates.

![cm-servers-instances.png](/img/cm-servers-instances.png)

## Servers vs. Instances

### Overview

Is there a difference between a Server and an Instance?

Often times the words 'Server' and 'Instance' are used interchangeably in many cloud-related discussions. Although, the technical differences between these two terms will typically not lead to incorrect statements in most cases, they can cause some confusion. In order to prevent misinterpretations during collaborative efforts with your team or interacting with RightScale Technical Services, it's important to have an accurate, baseline understanding of each term.

### Definitions

#### Instance

A virtual machine running in the cloud.  

#### Server

The collection of properties and attributes that define a virtual machine that has run, will run, or is running in the cloud.

Since instances in the cloud can be launched and terminated several times throughout the lifetime of your web application, it's important that you can easily manage these different iterations of what are essentially different incarnations of the "same" Server that typically serve the same purpose over time. (e.g. PHP Application Server)

ServerTemplates are the "templates" that are used to create Servers. The only way to create a Server in the RightScale platform is to start with a ServerTemplate, which serves as the base configuration template for a Server. A Server will inherit a majority of its configuration from its ServerTemplate, however configurations can be overwritten at the Deployment or Server levels. (See [Inheritance of Inputs](/cm/rs101/inheritance_of_inputs.html).) When you create a Server, it must be placed inside a particular Deployment. A Deployment is a collection of related Servers that help satisfy the requirements for a common project. A Server cannot exist outside of the context of a Deployment. When you create a Server using a ServerTemplate, you must specify into which Deployment the Server will be placed.

## Server History Timeline

The History timeline for a server shows the most recent server sessions. As a system administrator, you're typically only concerned about the most recent servers that were launched, the current server, as well as the next server launch. The timeframe of the launched server will be displayed. If a server was launched and terminated the same day, the time period will be displayed, otherwise the launch and termination date will be displayed. More detailed information about the time periods can be found under the server's **Info** tab under the **Timestamps** section.

![cm-history-timeline-default.png](/img/cm-history-timeline-default.png)

By default, the timeline will only show up to the three most recent server launches. If you want to view an older server launch, click the **History** button, which will take you to the template's **History** tab.

Changes made to the "Next" server launch will carry forward to future server launches.

![cm-history-timeline-old.png](/img/cm-history-timeline-old.png)

If you select a launch that's older than the three most recent server launches, the History timeline will display [...] to denote a larger gap in the server's history.

## What happens when a Server is launched with RightScale?

Before you start launching instances in the cloud using the RightScale platform, it's important to first understand how a server is defined, launched, and configured using RightScale's ServerTemplate model. A proper understanding of how instances are launched in the cloud will provide you with a useful perspective as you become more familiar with the RightScale platform and start launching your own custom servers.

When you launch a Server from the RightScale platform (Dashboard or API), the following actions take place to properly configure your instance in the cloud.

**Note**: The example below applies to how EC2 instances are defined, launched, and configured in AWS using RightScale's ServerTemplate model.

### Define a Server

Before you can launch a Server, you must first define how that Server will be configured. For example, you need to choose an operating system (CentOS 5.4, Ubuntu, 9.10, Windows 2008, etc.), the desired size or hardware specifications for the cloud instance, as well as into which cloud or AWS region the instance will be launched.

1. Go to the RightScale Component Library (**Design** > **MultiCloud Marketplace** > **ServerTemplates**) to find a ServerTemplate that best satisfies your server requirements. Import a copy of the ServerTemplate into your local collection (**Design** > **ServerTemplates**). You can either use the ServerTemplate as-is or clone it to create an editable version that you can customize yourself. You can also create your own ServerTemplate from scratch.
2. Use the ServerTemplate to add a Server to a Deployment or configure a Server Array. You will also need to provide any required cloud-specific information. Below is a list of the minimum requirements that must be specified in order to launch an EC2 instance.
  * AWS Region - Select into which AWS Region the instance will be launched. (e.g. AWS US-East)
  * EC2 instance type - Defines the hardware specifications of the provisioned instance. (e.g. m1.small, m1.large, etc.)
  * Amazon Machine Image (AMI) - The base machine image that will be loaded onto the instance by Amazon. The selection of the appropriate AMI (based upon the selected AWS Region) will be chosen by the ServerTemplate's MultiCloud Image (MCI). (e.g. RightImage_CentOS_5.4_i386_v5.6)
  * EC2 SSH Key - Key pair used to establish SSH access to the instance.
  * EC2 Security Group - Hardware firewall for controlling ingress communication to the instance.
  * EC2 Elastic IP (optional) - Remappable Public IP address for use in EC2. Instead of being randomly assigned a Public IP by Amazon, you can choose to use an EIP that you've reserved for use within your AWS account.

### Launch a Server

A Server can be launched from either the RightScale Dashboard (GUI) or API. You can either launch a Server manually or set up a scalable Server Array for autoscaling purposes that will grow/shrink (i.e. launch/terminate instances) depending on the various scaling parameters that you've defined.

1. A Server is either manually or automatically launched.
2. RightScale makes an API request to the cloud provider on your behalf (using your cloud credentials) to launch a new instance. An instance will be provisioned to you based upon how you defined the Server above. For example:
  * AWS Region: AWS US-East
  * EC2 Instance Type: m1.small
3. The cloud provider will use the following user-specified cloud resources to properly configure the bare instance. Each of these resources are AWS region-specific. The appropriate machine image will be chosen by the selected MultiCloud Image (MCI). (Note: A ServerTemplate can have more than one MCI.)
  * Amazon Machine Image (AMI): (e.g. RightImage_CentOS_5.4_i386_v5.6)
  * Kernel Image
  * Ramdisk Image
  * EC2 User Data
  * EC2 SSH Key
  * EC2 Security Group
4. The cloud provider assigns the instance the following configurations. At the end of this phase, AWS declares the configured instance both active and billable.
  * UID (unique identifier) (e.g. i-a97984c3)
  * Private DNS Name
  * Public DNS Name
  * Private IP Address
  * Public IP Address / Elastic IP (optional)
5. RightScale associates the following RightScale-specific configurations with the instance:
  * Tags
  * Sketchy host - Each instance will be assigned to one of RightScale's Sketchy servers, which monitors all server activity, alerts, and server status. The Sketchy servers collect Server data and draw the real-time monitoring graphs in the Dashboard.
6. RightScale executes the list of enabled Boot Scripts that are defined by the Server's ServerTemplate in sequential order.
7. If all scripts were executed successfully, RightScale will label it as an "operational" server.

## Where does a Server inherit its configurations?

### Introduction

When you launch a Server, there are several places where different inheritance rules apply to ensure that a Server will properly be configured. It's important to understand where a Server will ultimately inherit certain configurations in order to properly configure your Deployments, as well as for troubleshooting purposes.

Remember, a Server is either "inactive" (yet to be launched) or "active" (a running instance in a cloud). This document specifically addresses inactive or "Next" servers which defines how the next instance of that Server will be configured when it's launched.

### Diagram

The diagram below highlights where a Server will initially inherit most of its configurations. Some configurations can be overwritten at the Deployment and Server levels. See tables below for more details.

![cm-server-resource-inheritance.png](/img/cm-server-resource-inheritance.png)

### Cloud-assigned

The following configurations are assigned by the individual cloud providers and are not user-defined. These configurations only apply to active (running) Servers and are assigned to instances at launch time.

| Configuration | Cloud Provider |
| ------------- | -------------- |
| UID (e.g. AWS id) | X |
| Private DNS name | X |
| Public DNS name | X |
| Private IP Address | X |
| (Public) IP Address | X |

### User-defined

The following configurations are defined by the user. You have the flexibility to choose which cloud resources and RightScale components should be used to configure the instance.

You'll notice that a Server inherits a majority of its configurations from higher levels (e.g. ServerTemplate or Deployment). As a best practice, you should rarely configure any settings at the Server level. You'll find that it's much easier to manage all Servers in your Deployment if you configure your Servers to inherit their configurations from either the ServerTemplate or Deployment levels. By effectively using the various inheritance rules to your advantage, you'll have a better way of ensuring overall consistency and repeatability across all Servers in your Deployment.

The table below shows where a Server will ultimately inherit its configuration. Configurations that are defined at the right of the table (MultiCloud Image) take the least precendence, whereas any configurations that are defined at the Server level will automatically take the most precedence. For example, a Server will initially inherit its machine image from the ServerTemplate's MultiCloud Image. But, you can overwrite the seletion and choose a different machine image at the Server level. See [Understanding Inputs](/cm/rs101/understanding_inputs.html).

| Configuration | "Next" Server | Deployment | ServerTemplate | MultiCloud Image |
| ------------- | ------------- | ---------- | -------------- | ---------------- |
| Nickname<sup>RS</sup> | X | &nbsp; | X | &nbsp; |
| ServerTemplate | X<sup>1</sup> | &nbsp; | &nbsp; | &nbsp; |
| SSH Key | X | &nbsp; | &nbsp; | &nbsp; |
| Security Group(s) | X | &nbsp; | &nbsp; | &nbsp; |
| Cloud | X | &nbsp; | &nbsp; | &nbsp; |
| MultiCloud Image<sup>RS</sup> | &nbsp; | &nbsp; | X | &nbsp; |
| Machine Image | X | &nbsp; | &nbsp; | X |
| Kernel Image | X | &nbsp; | &nbsp; | X |
| Ramdisk Image | X | &nbsp; | &nbsp; | X |
| Instance Type | X | &nbsp; | &nbsp; | X |
| Availability Zone\* | X | X | &nbsp; | &nbsp; |
| Elastic IP\* | &nbsp;X<sup>2</sup> | &nbsp; | &nbsp; | &nbsp; |
| User Data\* | X | &nbsp; | &nbsp; | &nbsp; |
| Pricing Type\* | X | &nbsp; | &nbsp; | &nbsp; |
| Tag(s)<sup>RS</sup> | &nbsp;X<sup>3</sup> | &nbsp; | X | &nbsp; |
| Scripts<sup>RS</sup> | &nbsp;X<sup>4</sup> | &nbsp; | X | &nbsp; |
| Inputs<sup>RS</sup> | X | X | X | &nbsp; |
| Alerts<sup>RS</sup> | X | &nbsp; | X | &nbsp; |
| EBS Volumes\* | X | &nbsp; | &nbsp; | &nbsp; |
| EBS Snapshots\* | X | &nbsp; | &nbsp; | &nbsp; |
| OS Distribution Repositories | X | &nbsp; | X | &nbsp; |
| Cookbooks Repositories Path | &nbsp; | &nbsp; | X | &nbsp; |

 \* AWS only  
<sup>RS</sup> RightScale-specific term

**Notes**

1. Change a Server's ServerTemplate. You can either select a different committed revision or HEAD version (if available). You cannot select a completely different ServerTemplate.
2. Disassociate or associate an Elastic IP
3. Edit Tags (Add or Delete)
4. At the Server level you can define which Scripts (RightScripts and/or Chef Recipes) are enabled. For example, If you disable a boot script, that script will not be executed during the booting phase the next time that the server is launched.

Once a Server is launched and an instance is running in the cloud, you can still edit some of its configurations, however, those changes only apply to the Current (Running) Server and are not preserved in future launches of that Server.
