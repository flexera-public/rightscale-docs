---
title: How do I enable system user account logins for SSH on my instance?
category: general
description: This article describes the recommended method to add SSH authentication for system users (other than root) with public/private keypairs.
---

## Public Key Authentication

This is the recommended method to add SSH authentication for system users (other than root) with public/private keypairs.

1. Create a new user (it not already existing), e.g.  
    `adduser tester`  
    \<enter user details>

2. Assign a default shell to the new user (if it's not already set), e.g.  
    `chsh tester`

3. Generate a new ssh keypair for this user (or copy existing keypair to ~/.ssh)  
    `su tester ssh-keygen`

4. Ensure the keys are locally secure  
    `chmod -v 700 ~/.ssh/id_rsa*`

5. Add public keys to `authorized_keys` for user. Add the public key generated plus any other public keys intended for use with SSH clients  
    `cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys`

6. Ensure the keypair is installed in the client's SSH configuration (~/.ssh and ~/.ssh/ssh\_config if required)

7. Clients can now ssh to the server, e.g.  
    `ssh -i ~/.ssh/id_rsa_myserver tester@<public_ip> `

You can debug issues buy using the -v flag with the ssh command and checking the secure/auth log on the server.

## Tunelled clear text passwords

**Important!** This is not a recommended best practice and should not be used on production servers or any instances that contain sensitive information. Plain user authentication with PAM is insecure compared to public key authentication (the default).  
Consider using an identity server such as an LDAP server to scale users if required.  

Tested with RightImage Ubuntu 10.04 i386 v5.5.9.

1. Launch a new server or instance (if required)

2. Log into the instance with SSH from the Dashboard

3. Enable tunnelled clear text passwords for sshd  
    `sed -e "s/#PasswordAuthentication yes/PasswordAuthentication yes/g" -i /etc/ssh/sshd_config`

4. Install DenyHosts (optional)  
    `apt-get update && apt-get -y install denyhosts`

5. Restart sshd to apply new configuration  
    `/etc/init.d/ssh restart`

6. Add new users as required (if not already added), e.g.  
    `adduser tester`  
    \<enter user details>

You can now log into the instance with system user accounts, while preserving public key authentication for the root user.
