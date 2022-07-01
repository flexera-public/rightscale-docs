---
title: Server History Timeline
layout: cm_layout
description: Describes the Server History Timeline accessible from the RightScale Cloud Management Dashboard user interface.
---
## Overview

The Server History Timeline Bar for each Server gives you the ability to view the Server level configurations of the past, current, and future launches of that Server. The tabs for a Server are specifically related to the selection in the timeline bar. Remember, any changes that you make at the Server level will overwrite settings that you've defined at the Deployment or ServerTemplate levels. See [Inheritance of Inputs](/cm/rs101/inheritance_of_inputs.html).

![cm-server-timeline.png](/img/cm-server-timeline.png)

Remember, each time a Server is launched a new instance is provisioned and configured accordingly. Each iteration or instance of that Server will be a unique virtual instance and be assigned a unique ID, IP addresses, etc. by the cloud provider. If you want a Server to always use the same public facing IP address for each instance, you need to use a remappable IP address (e.g. Elastic IP for EC2 instances).

All recent iterations of the Server will be displayed in the timeline bar. If a server was launched and terminated the same day, the time period will be displayed, otherwise the launch and termination date will be displayed. More detailed information about the time periods can be found under the server's **Info** tab under the **Timestamps** section.

![cm-server-history-timeline.png](/img/cm-server-history-timeline.png)

By default, the timeline will only show up to the three most recent launches of a Server. If you want to view an older iterations of a server, click the **History** button, which will take you to the Server's History tab. If you select a launch that's older than the three most recent server launches, the History timeline will display [...] to denote a larger gap in the server's history.

![cm-history-timeline-old.png](/img/cm-history-timeline-old.png)

## Current vs. Next

It's important to understand the differences between the "Current" and "Next" Server. When viewing the **Current** Server, you can view and make changes to the live, running Server.

The **Next** server in the timeline bar defines the configurations that will be used for future launches of that server. Unlike the Current Server, any changes you make to the Next Server will be persistent.

Changes that are made to the Current Server are not persistent. For example, you can change a Current Server's inputs, alerts, etc., but if you want that change to be persistent across future launches of that Server, you will also need to make the same modification to the Next Server or at either the Deployment or ServerTemplate levels. For this reason you should always try and configure a Server so that it inherits all of its settings from either the ServerTemplate or Deployments levels. You'll find that it's easier to manage Servers across all of your Deployments if you do not define a Server's configuration at the Server level. The ability to make changes to the Next Server should only be reserved for performing one-time operations.

It's also important to realize that the configurations of the Current Server can change over the lifetime of that instance. When reviewing previous iterations of that Server in the timeline bar, it's important to understand that the settings that are displayed reflect the Server when it was terminated (not launched).

*Note*: When you relaunch a server, the configurations that you've defined under the Next server will be used to boot the server.
