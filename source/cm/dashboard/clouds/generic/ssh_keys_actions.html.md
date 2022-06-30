---
title: SSH Keys - Actions
description: Steps for creating a new SSH Key using the RightScale Cloud Management Dashboard.
---

## Create a New SSH Key

Use the following procedure to create an SSH Key that you can use to gain access to running Servers.

### Prerequisites

* 'actor' user role privileges in the RightScale account
* SSH is required to run RightScripts (prior to RightLink enabled images, which are RightImages prior to v5), so setting up your SSH key can be very important.

### Steps

* Go to **Clouds** > *CloudName* > **SSH Keys**
* Click the **New** action button
* Provide a Name for your SSH Key
* Click the **Create** action button when ready

The SSH Key is created and stored in the database.

![cm-SSHkeys-material.png](/img/cm-SSHkeys-material.png)

!!info*Note:* You can edit the SSH Key and copy in "new" private key data in the future. For example, you can generate your own SSH Keys and manually copy the private key into the SSH Key you created from within the Dashboard above.

### Further Reading

* [How do I configure my native SSH client to work with RightScale?](/faq/How_Do_I_Configure_My_Native_SSH_Client_to_Work_with_RightScale.html)
* [Create a New SSH Key by Importing an RSA Key Pair](/cm/dashboard/clouds/aws/actions/ec2_ssh_keys_actions.html#create-a-new-ssh-key-by-importing-an-rsa-key-pair)
