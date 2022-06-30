---
title: Register a Private Cloud with RightScale
layout: cm_layout
description: Steps for registering an existing private cloud with RightScale.
---

## Objective

To register an existing private cloud with RightScale.

## Prerequisites

* A private cloud infrastructure that has already been configured from a hardware and network POV.
* 'admin' and 'actor' user role privileges in the RightScale account in which you will register the private cloud.

## Overview

Once you've configured your private cloud infrastructure you can register it with RightScale so that the compute resources of your private cloud can be managed through the RightScale Dashboard. You will only have to register the private cloud with RightScale once. The RightScale account where you will register the private cloud will become the "Administrative RightScale Account" for that private cloud. Once a private cloud has been registered with RightScale, you can grant access to other RightScale accounts so that they will be able to access your private cloud's resources. (See [Add a Cloud Account to a RightScale Account](/cm/dashboard/settings/account/add_a_cloud_account_to_a_rightscale_account.html).) You will be able to grant access to other RightScale accounts by giving them a cloud token that they can use for authentication purposes to add the private cloud to their own RightScale account. (Only a user with 'admin' user role privileges in a RightScale account will be able to add a cloud to the account.)

!!info*Note:* You will only be able to deregister or delete the cloud from RightScale (using this particular RightScale account) if you ever need to delete/deregister the private cloud from RightScale in order to prevent access to your private cloud by users through the RightScale platform.

## Steps

Follow the appropriate procedure below to register a private cloud with RightScale.

* [Register an OpenStack Cloud with RightScale](/clouds/openstack/openstack_register_an_openstack_private_cloud_with_rightscale.html)
