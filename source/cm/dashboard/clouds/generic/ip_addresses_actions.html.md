---
title: IP Addresses - Actions
description: Steps for creating a new Public IP Address in the RightScale Cloud Management Dashboard.
---

## Create a New Public IP Address

The use of public IP addresses is strongly recommended for public facing servers that should be accessible over TCP 80 (HTTP access). For example, if you are using dedicated HAProxy load balancer servers, you should create an IP address for each load balancer server and associate a remappable IP address to each one. This way, you can create a DNS record that points to the same public IP address, but you have the flexibility to change the underlying instance that it's actually pointing to at any given time, which is useful for failover and lifecycle management scenarios.

Use the following procedure to create a new public IP address.

### Steps

* Navigate to **Clouds** > **CloudName** > **IP Addresses**.
* Click the **New** action button.
* You are prompted for the **Name** of the IP Address.
* Click the **Create** action button when ready. A message from the cloud provider should confirm creation or display an error.

!!info*Note:* The Name is typically the same as the actual IP address that was pulled from a pool of addresses supplied by the cloud provider. (That is, reflects the address in standard dot notation.) If the Name is not explicitly set it will be set it to the IP Address automatically.

## Assign a Public IP Address

Once you create a public IP address, you can assign it to a server at launch time or remap it to a running server.

#### Steps to assign at launch

* In the [Add Server Assistant](/cm/dashboard/manage/deployments/deployments_actions.html#add-a-server-to-a-deployment) on the Server Details step, under Networking, select the Elastic IP address you want to assign to the new instance. The name of the EIP is followed by the actual IP Address. **NOTE:** It is possible to steal an EIP that's currently being used by another instance. Instances that are currently assigned to running instances are denoted with *in use* for precautionary reasons. 
* Click **Confirm** when finished assigning options to the new server, and then **Finish** after verifying all information is correct.
* Select the **Launch** button to launch your server when ready. The IP you assigned will be applied to the new server.

#### Steps to assign to a running server

* [Change a Server's Public IP](/cm/dashboard/manage/deployments/deployments_actions.html#change-a-server-s-public-ip)
