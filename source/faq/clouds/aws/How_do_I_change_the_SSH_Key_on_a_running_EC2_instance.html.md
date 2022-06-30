---
title: How do I change the SSH Key on a running EC2 instance?
category: aws
description: If you need to switch to a new SSH Key, RightScale recommends that you terminate the instance, change the associated SSH Key and launch the instance again.
---

## Background Information

Is it possible to change the SSH Key on a running EC2 instance? If so, how?

* * *

## Answer

If you need to switch to a new SSH Key, RightScale recommends that you terminate the instance, change the associated SSH Key and launch the instance again. Before terminating the instance or taking any corrective action, make sure you've saved any critical data that needs to be preserved. So, if the instance has any attached EBS volumes, be sure to take snapshots of the volumes so that you can use them to restore your volume data on future instances. However, any data saved on the instance's local ephemeral drive will be lost once the instance is terminated.

If terminating and relaunching the instance is not feasible then the following instructions will allow you to change the authorized keys on the instance and update the Dashboard with the new key information.

1. Generate a new Key Pair. When you do this, copy the SSH key information to your text editor; you will need this to update the old key in the Dashboard and the Authorized Keys file on the instance(s).
2. Use the command-line to generate your public key.
3. Create a new Credential named, "your key name here" Public Key. For the value, use ONLY the key information (not the begin/end rsa tags)
4. Create a script that alters the Authorized Keys file to only allow the new SSH Key Pair. In the following example, the value of $PUBLIC_SSH_KEY is set to the Credential just created, and the value of $KEY_NAME is the name of the newly created key pair:

    ~~~
    #!/bin/bash -e
    echo "ssh-rsa $PUBLIC_SSH_KEY $KEY_NAME" > ~root/.ssh/authorized_keys
    exit 0 # Leave with a smile...
    ~~~

5. Now that the Public Key has been replaced, the Private Key information for the old SSH Key Pair associated with the old instances must be updated so that you can still SSH into the machines. Find the old key under Clouds > AWS (US/EU) > SSH Keys, open it and click Edit. Overwrite the old private key information by copying and pasting the newly created key's private key information, and click Save.
6. If any of your instances use the "MISC ssh priv key install" script, you will need to rerun this script with the new key.
7. This will work indefinitely, but we recommend that you relaunch with the new SSH Key as soon as it's possible. This will prevent confusion and allow you to fully deprecate the old SSH key name from active instances.
