---
title: Server Login Control
layout: cm_layout
description: Server Login Control is a unique feature of the RightScale management platform that allows you to use a private SSH Key Pair instead of using a cloud SSH key for shell access.
---

## What is Server Login Control?

Server Login Control is a unique feature of the RightScale management platform that allows you to use a private SSH Key Pair instead of using a cloud SSH key for shell access. Previously, a cloud's SSH key pair (e.g. EC2 SSH Key) was used for authentication purposes if you opened up an SSH console session into a cloud instance. However, since SSH keys are cloud-specific and the same key can be used by multiple users, it can become quite difficult to control user-level access to your servers.

By default, RightScale generates a unique SSH key for each user for Server Login Control. You can view your Server Login Control settings and SSH key in the Dashboard (**Settings** > **User Settings** > **SSH**; see [User Settings - SSH](/cm/dashboard/settings/user/index.html#user-settings---ssh) for more information). RightScale also manages your login credentials for you unless you choose to manage them yourself. The SSH key is user-specific and is used for SSH authentication purposes across all the RightScale accounts that you have access to. Also, it will be used to SSH into any instance from the RightScale Dashboard, regardless of the cloud.

## Who Manages Server Login Control?

If you decide to have RightScale manage your SSH key for you, we will display your public SSH key in the Dashboard, but the matching private key is stored in our database.

If you want to manage your SSH key yourself, you can edit your Server Login Control settings and use your own keypair. If you decide to manage it yourself, you need to upload the public key to RightScale (via the Dashboard) and store the matching private key on your local machine. The private key must be stored locally, relative to your home directory (e.g. .ssh/id_rsa). This option ensures that only a logged in user from a machine that has the matching private key stored locally can SSH into an instance. If you try to SSH into an instance from the RightScale Dashboard, RightScale retrieves your private key from your local machine and uses it to authenticate SSH access. If the private key file cannot be found, you cannot SSH into an instance. If you are using multiple computers to manage your account, you must put the private key in the same location on all computers. For information on how to use this, see [Manage an SSH Key Pair](/cm/dashboard/settings/user/index.html#actions-and-procedures-managing-your-own-ssh-key-pair).

When an instance is launched from the RightScale management platform, the public keys for all users who are allowed to SSH into an instance (i.e. users with 'server_login' user role privileges) are stored locally on the instance itself. If a user's SSH access privileges are ever revoked, all instances are dynamically updated so that the person's public key is removed from each of the affected instances.

## Controlling How Server Login is Managed

Additionally, for stronger security, you can require an account to have all users manage their own key pair.This would remove RightScale from managing a user's SSH Key Pair by default. To enable this, see [Enable Mandatory Server Login Control](/cm/dashboard/settings/account/enable_mandatory_server_login_control.html).

## What Types of Instances Use Server Login Control?

Server Login Control is only supported on instances launched with RightImages v5.1.1 or newer that have RightLink installed. Instances launched with older RightImages use the cloud's SSH key (e.g. EC2 SSH Key) for authenticating SSH console sessions.

## Controlling User Access with Server Login Control

An 'admin' user can use the Server Login Control feature and user roles to control who has shell access to SSH into server instances. For example, a system administrator can grant some users the ability to launch/terminate a server ('actor'), but not SSH into it. Conversely, other users might only have 'server_login' privileges so they can SSH into a server for auditing and troubleshooting purposes even though they can't actually launch/terminate one.

You should also use a cloud's security or firewall services to control SSH access. For example, if you are launching servers into one of the AWS EC2 regions, you can set strict port level permissions that only allow SSH access to a specific IP address or range of IP addresses. Remember, firewall permissions are often cloud-specific rules that must be set at the cloud level using the appropriate cloud resources and services.
