---
title: Managing Active (Current) Servers
layout: cm_layout
description: A RightScale "Server" is a definition of how a cloud instance will be configured when it is launched from either the RightScale Cloud Management Dashboard or API.
---
## Overview

A server is a definition of how a cloud instance will be configured when it is launched from either the RightScale Dashboard or API. It's important to understand that an "active" server is not always an "operational" server in the sense that it has an equivalent physical piece of hardware that's been incarnated at the cloud level. Although you can still make several modifications to an "active" server, it is important to understand what you can/cannot change once a server has been launched.

## Unsupported Modifications for Active Servers

Once a server is active, you cannot make any of the following system level changes.

* Machine Images - Cloud (e.g. AMI, RightImage<sup>TM </sup>), Kernel, Ramdisk
* Instance Type (e.g. small, large, etc.)
* Platform/OS
* Availability Zone (EC2 only)
* SSH Key
* Public/Private IP Addresses and DNS Names
* Security Groups\*

\* Although you cannot add/remove the security group(s) of a running server, you can still make modifications by making changes directly to the security group itself. Any changes to the actual security group will take effect immediately, so always use discretion.

## Supported Modifications for Active Servers that are in the operational state

You can perform any of these modifications/actions on an active server that's in the "operational" state. See details below.

### Assign/Switch Elastic IPs (AWS only)

There are two ways that you can assign an Elastic IP (EIP) to a server. You can either assign an EIP to a server at launch time or to a running instance. Be careful! You can accidentally steal an EIP from one of your frontend servers and reroute incoming traffic.

* [Elastic IP (EIP)](/clouds/aws/amazon-ec2/aws_elastic_ip.html)

* [Transfer an Elastic IP to a running instance](/cm/dashboard/clouds/aws/actions/ec2_elastic_ips_actions.html#transfer-an-elastic-ip-to-a-running-instance)

### Run a RightScript

Once a server is operational, there are several different ways that you can manually execute/run RightScripts on the live server. You can execute scripts either the Deployment or Server levels. Typically, you will run scripts at the Deployment level if you are running a script on multiple/all servers in a deployment. However, it is useful to run a RightScript at the individual server level if you only want to modify a single server.

* [Run a RightScript on Multiple Servers](/cm/dashboard/design/rightscripts/rightscripts_actions.html#run-a-rightscript-on-multiple-servers)
* [Run a RightScript on a Server](/cm/dashboard/design/rightscripts/rightscripts_actions.html#run-a-rightscript-on-a-server)

### Change the ServerTemplate Revision

As a best practice, you should always launch servers in a production environment with committed ServerTemplate revisions. However, you can change the ServerTemplate revision of an operational (not stranded) server. This functionality should only be used for development and testing purposes. For example, if you are aware of the minor changes between two revisions, you may find it useful to "roll-forward" a running server instead of launching a new server and terminating the old one. However, this feature can get you into trouble. Changing the ServerTemplate revision of an operational server to a different committed revision or HEAD version should only be used by advanced users who are clearly aware of the changes between the two revisions. You should also have a clear understanding of the implications of such a change.

![cm-change-server-template-revision.png](/img/cm-change-server-template-revision.png)

When you change the revision of a ServerTemplate (ex: rev1 to rev2), the running server will display the inputs and scripts from the new ServerTemplate revision, but no changes will be made to the server itself. (i.e. A server's Scripts and Inputs tabs will always reflect what is defined by the selected ServerTemplate revision.) Therefore, the information that's displayed under a server's Inputs tab may become inconsistent and inaccurate with the values that the server is actually using.

**Note**: System level changes such as specifying a different machine image (AMI/RightImage) or instance type cannot be updated once a server has been launched.

If you want to change the ServerTemplate revision and you do not want to terminate the current server and launch a new one, you should specify a different ServerTemplate revision under the "Next" iteration of a server and click the Relaunch button. This is a better way to change a server's ServerTemplate revision because you will create a clear audit entry of the change, the displayed inputs and scripts will be consistent with the running server, and you will be able to perform various system level changes such as specifying a different machine image.

### Move a Server

You can move a server from one deployment to another, but you should realize the consequences of making such a move. When you move a running server to a different deployment, it will be subject to the new deployment's alert escalations. So, if you move a server to a different deployment, the server's alerts might call an alert escalation that has different actions associated with it than expected. The ability to move a server across deployments is a useful feature for organizational and upgrade purposes. Although it is possible to have servers in multiple deployments communicate with one another, this practice is not recommended.

### Relaunch a Server

When a server is relaunched, the current server is terminated and a new server is launched in its place. The new server will receive a new aws-id, private DNS name, and public DNS name because it is a completely different virtual machine. Relaunching a server is equivalent to terminating the existing running server and launching a fresh new server in its place, whereas a reboot will restart the same physical machine.

You have two options when relaunching a server. You will also have the ability to make any modifications to the server's inputs before the new server is launched.

* **Launch new server immediately** - Equivalent to terminating the current server and launching a new server at the same time.
* **Launch new server when the current server terminates** - Equivalent to terminating current server, waiting for it to finish termination, and then launching a new server.

**Important!** When a server is relaunched, input hierarchy rules apply. If you are relaunching a server that's currently operational, any inputs that have been defined under the "Next" server definition (history timeline) will overwrite values that are normally inherited at the ServerTemplate or Deployment levels. See [Server History Timeline](/cm/management_guide/server_history_timeline.html)

### Reboot a Server

When you reboot a server, it is like shutting down the physical machine and turning it on again. If possible, a server will attempt to run its decommission scripts. Any saved data on the server's disk drive will be preserved. The aws-id, private DNS name, and public DNS name will be the same after a reboot. Preferably, if you are experiencing problems with a server, you should perform a relaunch and launch a fresh new server instead rebooting the bad machine. Remember, you should always roll-forward. If you insist on rebooting a server, you might want to first clone and launch a new server as a replacement before attempting a reboot. Basically, you should not rely on a reboot as a means of fixing a problematic server. See [Response to a Server Failure](/cm/management_guide/response_to_a_server_failure.html) for more information.

**Note**: If you are launching servers on EC2, Amazon reserves the right the right to reboot your instances for maintenance purposes. Therefore, make sure any RightScripts are reboot-safe. RightScale RightScripts are all reboot safe.

### Modify and Copy Inputs

As a best practice you should always define and modify inputs for your production setup at the deployment level in order to ensure consistency across all of your servers. See [Understanding Inputs](/cm/rs101/understanding_inputs.html). However, you may find it useful to modify the inputs of a single server for testing purposes. To make changes to the inputs of a running server, make sure that you're editing the Inputs tab of the "Current" server. See [Server History Timeline](/cm/management_guide/server_history_timeline.html). If you make changes to the current running server that you want to persist after the current server is either terminated or relaunched, you will need to define the inputs under the "Next" server. Use the **Copy Inputs** button to copy input parameters between the "Current" and "Next" servers (vice-versa). This feature is useful for making sure that a server's current and next input parameters always match.

For example, if you changed some inputs on the "Current" server and you want those changes to persist to future iterations of that server, you will need to copy those inputs over to the "Next" server. Select the "Next" server in the Server History Timeline and click the Inputs tab. Click the **Copy Inputs** button to copy input parameters from the "Current" server. Any input discrepencies will be highlighted in red. Simply select which inputs you want to copy from the "Current" server. Conversely, you can copy inputs from the "Next" server.

![cm-copy-inputs-highlight.png](/img/cm-copy-inputs-highlight.png)

### Warning: Next server is missing boot script inputs

When viewing your deployment's Servers tab, you may see a warning icon denoting that the currently running server has missing boot script inputs.

![cm-missing-next-boot-script-input.png](/img/cm-missing-next-boot-script-input.png)

The reason you are seeing this warning message is because there is at least one missing/undefined input for one of the server's boot scripts (as defined by its ServerTemplate). It's important that you resolve this error by defining a value for the missing input so that the server can be safely rebooted and/or relaunched. If you are seeing this warning message it's probably because you launched the current server with inputs that you defined at the input confirmation page (server level) prior to launching the server and clicked the **Launch** instead of **Save and Launch** button. As a result, the provided value was used for the current server, but the next server (i.e. the "next" time that the server is relaunched/launched there will be a missing input that must be defined before successfully launching the server.) To resolve this warning message you must define a value for the missing input(s). If you do not want to define the value at either the deployment or ServerTemplate levels for inheritance purposes, you can define it by going to the "Next" server in the Server History bar and edit the input(s) accordingly.

## Supported Modifications for Active Servers that are in the "bidding" state (AWS only)

You can perform any of these modifications/actions on an active server that's in the "bidding" state. Only applies to spot (not on-demand) instance types.

### Change Your Max Price for a Spot Instance Type (Rebid)

If you've launched a server that's a spot instance type and the server is still in the 'bidding' state because your max bid price is below the current spot price, you can change your max bid price by using the 'Rebid' option under the server's Info tab. The change only applies to the "current" server and is not inherited by the "next" server.
