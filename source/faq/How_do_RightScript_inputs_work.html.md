---
title: How do RightScript inputs work?
category: general
description: There are several Input tabs in the RightScale Cloud Management Dashboard where you can define various input parameters.
---

## Background Information

There are several Input tabs in the Dashboard where you can define various input parameters. You can find Input tabs on ServerTemplates, deployments, and individual servers. So, what is the difference between these different input tabs and how do I use them?

* * *

## Answer

There are many places to enter inputs:

1. **Template**: Entering inputs here sets the "default" value of an input for a specific ServerTemplate. When an instance is launched, it will inherit its inputs from the template's inputs.
2. **Launch**: When you launch a new instance, the inputs will be displayed. Here you can override whatever inputs that have been set from the ServerTemplate.  But, these inputs will only take effect on that particular launch. If you want to use that input on future launches with that ServerTemplate, you will need to modify that input at the template or deployment level.
3. **Server**: Each server in your deployment can have its own inputs specific to that server. So you can have two servers from the same template that have different values for the same input. Any changes to the Inputs tab of a running server will only affect the current running server.  Changes made to the Inputs tab of the "next" server are persistent and affect all future launches of that server.  Inputs that are defined under the Inputs tab at the server level overwrite inputs defined at either the template or deployment level.
4. **Deployment**: Entering inputs at the deployment level is the most convenient location to define common input parameters because they will apply to all servers in the deployment. However, if you have multiple servers that require different values for the same input, you should define them on each specific server.
5. **On a Running Instance**: Once an instance is running, it is too late to change the inputs because the scripts have already been used at boot time. However, you can re-run any boot script (and of course you can also run operational scripts). When you run a script on a running instance it gets its input from the "Inputs" tab.

### Input Hierarchy

There is also an input hierarchy. Depending on where you define inputs, you can overwrite inputs that are set at a different level.

* ServerTemplate level - A server will inherit it's inputs from the ServerTemplate.
* Deployment level - Inputs defined at the deployment level will overwrite input values set at the ServerTemplate level.
* Server level - Inputs defined at the server level under the "Inputs" tab will overwrite input values that are set at either the deployment or template level.
