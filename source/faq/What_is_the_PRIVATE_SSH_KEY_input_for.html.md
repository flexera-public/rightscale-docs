---
title:  What is the PRIVATE_SSH_KEY input for?
category: general
description: The PRIVATE_SSH_KEY input allows you to specify which private SSH key will be used by default for the root user.
---

## Background Information

You're unsure how to use the PRIVATE_SSH_KEY input.

* * *

## Answer

This input allows you to specify which private SSH key will be used by default for the root user. It must be the SSH key that is used on the instance itself, which should match the key used by other servers in the same deployment.

Many ServerTemplates feature the script, **MISC ssh priv key install** , which installs the private key for the root user in `~root/.ssh/id_rsa`. This allows the instance to access other instances that use the associated SSH public key. For example, the **LB app to HA proxy connect** script will use this key when it attempts to ssh into the Front End servers. It must ssh in to add the proper information to the HAProxy configuration files. If the key pair does not match, it will fail. You will see the following/similar error in the Audit Entries:

~~~
********************************************************************************
*RS> Running RightScript <db v2="" backup=""> ****
*RS> script starting at: Thu Mar 12 20:33:05 -0500 2009
Warning: Permanently added 'localhost' (RSA) to the list of known hosts.

Permission denied (publickey,gssapi-with-mic).

/opt/rightscale/db/ec2_s3/../common/d_b_utils.rb:149:in
`accept_ssh_key': Host:localhost Error:65280
(RightScale::RemoteExecException)
     from /opt/rightscale/db/ec2_s3/backupDB.rb:96
No host argument given...assuming localhost
Using C interface for mysql, client version 5.0.45
*RS> script duration: 0.593617 seconds

!!!!! ERROR PROCESSING RIGHTSCRIPTS:
!!!!! error running script (code 1)
/opt/rightscale/bin/runrightscripts.rb:529:in
`run'/opt/rightscale/bin/runrightscripts.rb:798:in
`process_state'/opt/rightscale/bin/runrightscripts.rb:785:in
`each'/opt/rightscale/bin/runrightscripts.rb:785:in
`process_state'/opt/rightscale/bin/runrightscripts.rb:459:in
`execute'/opt/rightscale/bin/runrightscripts.rb:873

RUN RIGHTSCRIPTS ending at Thu Mar 12 20:33:09 -0500 2009
~~~

In this example, the machine is unable to access itself by ssh (which some scripts must do) because the wrong key is set in the input.

Fixing this problem on a running instance is a simple process. First, open up the instance that has the wrong key in the Dashboard. Go to the **Inputs** tab, and click **Edit**. Change the input, PRIVATE_SSH_KEY to the correct key, and click Save at the top of the page. Now, open the Scripts tab and run the boot script, **MISC ssh priv key install** to install the correct key over top of the wrong key. The other scripts should now function as expected.
