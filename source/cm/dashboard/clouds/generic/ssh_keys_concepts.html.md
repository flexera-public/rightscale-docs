---
title: About SSH Keys
description: SSH Keys are used to establish secure client-server connections via SSH (secure shell) to running instances in the cloud. An SSH Key pair consists of both public and private key material.
---

## Overview

**SSH Keys** are used to establish secure client-server connections via SSH (secure shell) to running instances in the cloud. An SSH Key pair consists of both public and private key material. (For older RightImages (e.g. v4) they were also used to execute RightScripts on the running instance.) The SSH key is passed directly into an instance in order to provide root login access to the machine via SSH. Once an instance is launched, you can typically find it inserted into the **/root/.ssh/authorized_keys** file.

SSH Keys that are generated inside the Dashboard or from the RightScale API will have key material, whereas SSH Keys generated outside of RightScale will not have any key material. (The **Key Material** is basically the encrypted portion of the private key.) However, you can manually add the key material for one of your SSH keys inside the Dashboard. (*Note*: Not all cloud software supports SSH key generation. See the next section for more information.) The Dashboard will always display all SSH Keys associated with an account, regardless of whether or not they have key material. You can still launch an instance inside the Dashboard using an SSH key that does not have any key material, but you will not be able to SSH into the instance or use any of RightScale's convenient features such as bundling, backups, automation, etc. Without knowing the contents of the SSH Keys, RightScale will not be able to access your instance to perform such tasks.

!!info*Note:* When you launch an instance, be sure to select an SSH Key that contains key material. (Key material = yes)

### Cloud Support for SSH Keys

Some Cloud software may not support the generation of SSH Keys directly, in which case from within the RightScale Dashboard you will not see an entry for SSH Keys. That is, you cannot navigate to **Clouds** > *CloudName* > **SSH Keys**... it is not an option. This is not to say your cloud infrastructure cannot make use of SSH keys to access running instances, etc. The first time you log into the Dashboard, we create an SSH key pair for you. It's saved in our database, and we send it to every Server booted within your account (or accounts). When you click SSH icon or button for the Server, we give you the private key so you can gain SSH access to the Server.

As a best practice, we suggest that users generate their own keys and give us just the public key, keeping their private key private (known only to them). This can be accomplished at any time and all of the instances will be updated in real time.

### RightImage Compatibility differences

It is important to recognize that v4 and v5 RightImages behave differently with respect to SSH Keys. v5 RightImages are said to be "RightLink enabled". v4 RightImages (pre-RightLink) rely heavier on SSH Keys. If you are launching instances using v4 RightImages, RightScale will use the SSH Key in order to run RightScripts on the instance. Therefore, it's important that you only use SSH Keys where the private key material is available and not missing. Otherwise RightScale will not be able to run any RightScripts on the instance to complete the boot process thereby resulting in a Server that "strands" in booting. If you are using v5 (or later) RightImages, RightScale's Managed SSH feature will be used to establish SSH access and RightLink will be used to run RightScripts on the instance. You can either use the unique SSH Key that RightScale generates for each user or upload your own SSH Key.

## SSH Keys Screen

The following fields are available on the SSH Keys screen

* **Name** - Name of the SSH Key. Clicking the Name hyperlink takes you to that SSH Key's show page. *Note*: Some entities don't have unique names in their respective clouds. In particular, SSH Keys are like this in some clouds (for example, in some private clouds). This is why RightScale created an RS_ID. The RS_ID is held unique within an account (within a timeframe). From a practical perspective, this means an SSH Key can be created and named "Test". You won't be able to create another one in the same account called "Test". You can, however, delete the SSH Key and create a new one called "Test". It will have different key material and will not SSH into already launched Servers that used the prior "Test" SSH Key.
* **Key Material** - Refers to the public/private key pair used for SSH Keys. Set to either "yes" or "no". "Yes" means that RightScale possesses the private key material for that SSH key, and can SSH into any running instance that trusts that key. This is normally the case if the SSH Key was either created from the Dashboard, or manually added to it. "No" means that the RightScale database does not contain the private key; although you can launch instances that trust that key, you cannot SSH into those instances directly from the Dashboard. *Important!* Even if RightScale knows the private key material, it is only displayed in the Dashboard's Private Key field for the user who created it, or accounts with 'admin' privileges.
* **Resource UID** - Resource Unique Identifier for the SSH Key. To tie this back into the "Name" discussion above, some clouds use the Name of SSH Key as the Resource UID. This is why the Name and Resource UID match. The RS_ID for non-sharable entities (such as SSH Keys) is unique and random. *Note*: This is a RightScale only concept that guarantees uniqueness while leaving no security loopholes with respect to implementation.

You can take the following actions from the SSH Keys screen.

* **New** - Create a new SSH Key pair whereby the cloud generates the key pair for you.
* **Delete** - Delete an existing SSH KEY pair.

See [Create a New SSH Key](/cm/dashboard/clouds/generic/ssh_keys_actions.html)

## Further Reading

* [How Do I Access Servers Using SSH?](/faq/How_Do_I_Access_Servers_Using_SSH.html)
