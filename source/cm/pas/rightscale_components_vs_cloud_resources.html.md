---
title: RightScale Components vs. Cloud Resources
layout: cm_layout
description: Discussion of the differences between RightScale Components and Cloud Resources in the context of the RightScale Cloud Management Platform.
---
## Overview

The RightScale Dashboard is designed to give you a multi-cloud platform for managing all of your cloud-specific resources and RightScale-specific components. It's important to understand the distinction between the two types because it affects their functionality and how they are treated within the RightScale platform.

## What are the differences?

### Cloud-specific vs. Cloud-agnostic

The key difference is that cloud resources are specific to particular cloud infrastructures whereas RightScale components are cloud-agnostic. RightScale components don't care which cloud provider you are using or if you are using your own private cloud. For example, AMIs and EBS Snapshots are cloud resources that are specific to Amazon EC2. Cloud resources can only be used within the context of their respective cloud infrastructures. Although you can use cloud resources independently of RightScale, you can also use the RightScale Dashboard or API to act on these cloud resources.

RightScale components can only be used inside the RightScale Dashboard or API. However, since they are designed to be cloud-agnostic, you can use them across multiple clouds. For example, you can use the same ServerTemplate to launch servers on Amazon EC2 and Azure.

RightScale provides a cloud management platform that sits on top of the various cloud infrastructures. You can use both the RightScale Dashboard or API to perform actions on both RightScale components and cloud resources. In many cases you will use cloud resources interchangeably within RightScale components. For example, multiple servers in a deployment can use the same SSH key and security group.

### Sharing Processes

Both RightScale components and cloud resources can be shared with other users, however there is a slight difference in how they are shared. Since RightScale components exist within the RightScale platform, we've created the notion of Account Groups where you can add RightScale components such as ServerTemplates, RightScripts, and MultiCloud Images to a particular Account Group and then invite users so that they can use those components within their own account. It's a useful way of encouraging collaborative efforts across multiple groups within your organization for development and testing purposes. It also helps ensure consistency by making sure that the same ServerTemplates are used across multiple RightScale accounts.

See [Sharing RightScale Components](/cm/pas/sharing_rightscale_components.html) for details.

Since cloud resources are specific to their respective cloud and can exist independently from RightScale, you cannot share them using Account Groups. Instead, you must use the sharing feature that is supported by each cloud.

For example, to share cloud resources inside AWS, you must specify a specific AWS Account Number with whom you would like to share the resource. However, it's mportant to remember that in RightScale, multiple users might have access to the same RightScale account. (Each RightScale account is tied to a specific AWS Account Number.) Therefore if you share a resource with AWS Account # 1234-1234-1234, multiple users might have access to that resource.  

![cm-share-ami.png](/img/cm-share-ami.png)

## What is a RightScale Component?

A RightScale component is a concept that is specific to the RightScale Management Platform. RightScale components only have meaning and purpose within the RightScale system. Each component is essentially a meta-data description or map of a particular configuration. RightScale components can only be created/modified/deleted within the RightScale Dashboard GUI or API. Each component is designed to be cloud-agnostic. For example, you can configure a ServerTemplate to launch a PHP server in a public cloud (e.g. any Amazon EC2 region, SoftLayer, etc.) or private cloud (e.g. OpenStack).

### Cloning RightScale Components

The following RightScale components can be cloned inside the Dashboard in order to create an editable copy within your account. Once you import ServerTemplates from the MultiCloud Marketplace, you must clone them in order to create a private version that you can modify.

* ServerTemplates
* RightScripts
* MultiCloud Images
* Deployments

!!info*Note:* Although you cannot clone alerts, you can import them to other ServerTemplates or Servers. When you import an alert, it becomes an editable version, just like a cloned RightScale component.

### Sharing RightScale Components

You can also share certain RightScale components with other users by using Account Groups. See [Sharing RightScale Components](/cm/pas/sharing_rightscale_components.html) for details. The following RightScale components can be shared.

* ServerTemplates (When a ServerTemplate is shared, its underlying RightScripts, MultiCloud Images, and RepoPaths are also shared)
* RightScripts
* MultiCloud Images

If your RightScale Account's plan supports Account Groups (see [Plans & Pricing](http://www.rightscale.com/products-and-services/products/pricing)), you can create private Account Groups where you can privately share components with other specific RightScale accounts via Account Group Invitations. In addition to using private Account Groups, RightScale partners also have the ability to share components with RightScale accounts with a paid subscription.

If you are interested in learning more about our partnership program, please send us an email at [bizdev@rightscale.com](mailto:bizdev@rightscale.com). You can also visit our [Partners](http://www.rightscale.com/partners/) page on our corporate website.

### Version Control

You also have a level of version control and history for certain RightScale components where you can commit revisions and maintain version history of all changes to ensure configuration consistency at all times. The following RightScale components support this type of version control.

* ServerTemplates
* RightScripts
* MultiCloud Images

!!info*Note:* You can also use the clone and lock features to preserve a component's configuration. For deployments, you can clone and archive it for future use.

## What is a Cloud Resource?

A cloud resource is a real entity that is specific to a particular cloud infrastructure. It can only be used within a particular cloud infrastructure/service. For example, you cannot use an Amazon Machine Image (AMI) to launch an instance on Windows Azure. Cloud resources exist independently of RightScale. However, as long as you've provided RightScale with valid cloud credentials, you can use the RightScale Dashboard and API to perform actions on these resources.

!!warning*Important!* Cloud resources can be created/modified/deleted outside of RightScale via cloud-specific tools (e.g. AWS Console or a cloud infrastructure's API). Therefore, it's important that you establish structured processes with all members of your team to ensure that the same tool is used to manage your cloud resources in order to prevent against accidental or "mysterious" modifications. RightScale makes a best effort to reflect the current state of all your cloud resources inside the Dashboard.

### Sharing Cloud Resources

If the ability to share cloud resources is supported by a cloud infrastructure, you can also use the RightScale Dashboard to share such resources. Currently, you can only share EBS Snapshots on Amazon EC2.
