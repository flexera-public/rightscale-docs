---
title: Monitoring Error Messages
layout: cm_layout
description: Here are some common error messages that are specific to the RightScale monitoring feature are explained below.
---

Some common error messages that are specific to the monitoring feature are explained below.

**"Sorry, monitoring is not permitted for this server?"**

If you receive this message it means that the monitoring feature is not enabled on your account. The monitoring feature is only available for our pay editions. To upgrade, please contact [sales@rightscale.com](mailto:sales@rightscale.com). You could also receive this message if the administrator of the account did not give you permission to view the graphs.

**"Restoring monitoring data, please wait..." "Monitoring data is still being restored for this server, please wait..."?**

RightScale keeps a user's instance data in our main repository for 30 days after its termination for quick retrieval. After 30 days, the data is still preserved, but it's archived and stored elsewhere for future reference. If you try to access older graphical data, the data is retrieved from our archives, which may take some time. The monitoring system automatically sends a re-query for the archive data every 20 seconds until all of the graphs are retrieved.

**"The server is not sending any monitoring data. Verify that it is running collectd." "No monitoring data available?"**

If you receive this message, you probably have not set up collectd to send data to our servers for generating the monitoring graphs. See [Setting up collectd](/cm/rs101/setting_up_collectd.html).& You could also receive this error message if you are trying to retrieve graphical data, while there is no such data to be restored.
