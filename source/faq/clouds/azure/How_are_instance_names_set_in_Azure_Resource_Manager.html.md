---
title: How are instance names set in Azure Resource Manager?
category: azure
description: The name of the Server/Array in RightScale is used as the instance name in those clouds, after it's been sanitized per cloud limitations.

---

## Overview

Azure Resource Manager (ARM) uses a server's name to uniquely identify it. Users need to provide unique names for servers. 

## What is the default behavior?
 **Generate Unique Instance Names** is Enabled by default in CM. This will check the CM Server Name against the Server names in the cloud, and if it is not unique, RightScale will append a unique identifier to the server name to satisfy the uniqueness requirement.

## Can this setting be disabled/enabled?

Yes.  This can be changed using an account setting in CM by going to Account -> Preferences.  

To turn off **Generate Unique Instance Names** `Disabled`.  

![faq-generate-unique-instance-names-disabled.png](/img/faq-generate-unique-instance-names-disabled.png)

To turn on **Generate Unique Instance Names**
`Enabled`. 
![faq-generate-unique-instance-names-enabled.png](/img/faq-generate-unique-instance-names-enabled.png)

##What User Role do you need to toggle Generate Unique Instance Names?
 Users with the [admin](/cm/ref/user_roles.html#-admin) User Role can change options in Account Preferences, including **Generate Unique Instance Names**.

##If Generate Unique Instance Names is disabled, what does the default name become?
* ARM will use the name in a server that was assigned in CM. For Example:
* RightScale: `mylinux-server.johndoe.rightscale-services.com`
* ARM: &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; `mylinux-server.johndoe.rightscale-services.com`

##If Generate Unique Instance Names is Enabled, what does the default name become?
 * RightScale:  `mylinux-server.johndoe.rightscale-services.com`   
 * ARM: &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; `mylinux-server.johndoe.rightscale-services.com-5ax423b7e`
 
##What will happen if my name is not unique in GCE and Generate Unique Instance Names is disabled?
 * `GatewayExceptions::InvalidParameter - The instance 'mylinux-server.johndoe.rightscale-services.com' already exists'` already exists
 * This error tells us that RightScale tried to create a server in the cloud, but was unable to as the server name was not unique.

###Resolution
 * To fix this you will need to assign a unique name to the server, either manually or by enabling **Generate Unique Instance Names**.
