---
title: Monitoring User-Defined Processes
layout: cm_layout
description: In addition to using the standard set of RightScale monitoring metrics, you can set up monitoring for your own (user-defined) processes. You can accomplish this using either imported RightScale ServerTemplates (easiest) or custom ServerTemplates.
---

## Overview

In addition to using the standard set of RightScale monitoring metrics, you can set up monitoring for your own (user-defined) processes. You can accomplish this using either imported RightScale ServerTemplates (easiest) or custom ServerTemplates.

## Setting up Monitoring using a RightScale ServerTemplate

Monitoring your user-defined processes by importing a RightScale ServerTemplate and configuring the correct inputs is the recommended method. You can also use a custom ServerTemplate but it is a more complex process and should only be used if you cannot use an imported RightScale ServerTemplate for whatever reason.

### Steps

1. Import any officially supported Rightscale server template from the Multicloud Marketplace by going to the MultiCloud Marketplace (**Design** > **MultiCloud Marketplace** > **ServerTemplates**) and importing the most recently published revision of the desired ServerTemplate into your RightScale account.
2. After importing the ServerTemplate, create your server (click **Add Server**).
3. Go to your server's Inputs tab (*your server* > **Inputs** ) and click **Edit**.
4. Enter a text value for either the 'Process List' or 'Process Match List' input for the process that you want to monitor.
  * The Process List input is a space-separated list of processes that you want to monitor in the RightScale Dashboard (for example, sshd crond).
  * The Process Match List input is a space-separated list of pairs used to match the names of additional processes to monitor in the RightScale Dashboard. Paired arguments are passed in using the following syntax: '<name>/<regex>' (for example, ssh/ssh\* cron/cron\*).
<br>**Note:** The <name> portion of this input refers to the monitoring graph's name, and the <regex> portion should be the regular expression used to match the process name(s). For example, if the value 'secure_shell/ssh\*' is used instead, then the collectd monitoring graph would be named 'processes-secure_shell' accordingly.
5. Click **Save**. Monitoring of these processes is now enabled on your server when it is launched.
6. After launching your server, go to the **Monitoring** tab (*your server* > **Monitoring** ) and select **processes-<your_process>** to display the process monitoring charts and view the monitoring data.

![cm-process-monitoring.png](/img/cm-process-monitoring.png)

## Setting up Monitoring using a Custom ServerTemplate

Although using an imported RightScale ServerTemplate for setting up your process monitoring is recommended, you can also use a custom ServerTemplate for this purpose, if your situation requires it. The following two sections provide instructions for setting up monitoring for both Chef-based and RightScript based custom ServerTemplates.

## Setting up monitoring for a Chef-based Custom ServerTemplate

1. Determine what version of RightLink (preinstalled on every RightImage) or the version of the image that your custom ServerTemplate or MultiCloud image is using by opening the ServerTemplate and clicking on the **Images** tab.
2. Add the necessary Chef cookbook(s) to your custom ServerTemplate based on the Rightlink/image version your custom template is using:
  <br>a. Import the ' [Base ServerTemplate for Linux](http://www.rightscale.com/library/server_templates/Base-ServerTemplate-for-Linux-/lineage/46939)' ServerTemplate that includes the same image and/or Rightlink version that your custom ServerTemplate is using. The ServerTemplate *must* use the same MultiCloud image and/or Rightlink version as your custom ServerTemplate for compatibility reasons.
    * For example, if your custom ServerTemplate is using the most recent version of 'RightImage_CentOS_6.4_x64_v13.5, import the 13.5 version of the 'Base ServerTemplate for Linux' ServerTemplate, which includes this particular version of the image.
    * You can always verify and compare exactly which RightLink version and/or image is used by importing a ServerTemplate and then navigating to the template's **Images** tab
  <br>b. Once imported, navigate to the *your ServerTemplate* **> Scripts** tab.
  <br>c. Click the **Modify** action button, then click the **Attach Cookbooks** action button.
  <br>d. Within the 'Attach Cookbooks' popup box, select the "Rightscale" cookbook from the 'Cookbooks' column.
  <br>e. The available cookbook versions will show in the right side pane of the popup. Ensure that the appropriate version matching your image/Rightlink version is selected, then click **Attach Selected**.
  <br>f. If there are any Dependent Cookbooks listed on the Scripts tab (right pane), ensure that they are also attached to the ServerTemplate. This can be done by using the small magnifying glass icon to the right of the dependent cookbook, which will search for a matching cookbook with that name.
3. Add the necessary monitoring recipe to your custom ServerTemplate:
  <br>a. On the **Scripts** tab of your ServerTemplate, click the arrow icon next to the "Rightscale" cookbook to expand the list of available recipes within this cookbook
  <br>b. Locate the **rightscale::default** recipe and click and drag the recipe over to the "Boot Sequence" section of the scripts tab. Recipe or script additions are saved immediately, so you can now move on to configuring the monitoring inputs in the next section.
4. Proceed by creating a new Server from your ServerTemplate.

### Configure User Defined Process Monitoring Inputs

1. Once you have created a server from your custom ServerTemplate, navigate to the *your Server* > **Inputs** tab.
2. Click **Edit** and enter a text value for either the 'Process List' or 'Process Match List' input for the process that you want to monitor.
  * The Process List input is a space-separated list of processes that you want to monitor in the RightScale Dashboard (for example, sshd crond).
  * The Process Match List input is a space-separated list of pairs used to match the names of additional processes to monitor in the RightScale Dashboard. Paired arguments are passed in using the following syntax '<name>/<regex>' (for example, ssh/ssh\* cron/cron\*).
  <br>**Note:** The <name> portion of this input refers to the monitoring graph's name, and the <regex> portion should be the regular expression used to match the process name(s). For example, if the value 'secure_shell/ssh\*' is used instead, then the collectd monitoring graph would be named 'processes-secure_shell' accordingly.
3. Click **Save**. Monitoring your own user defined processes is now enabled on your server when it is launched.
4. After launching your server, go to the **Monitoring** tab (*your server* > **Monitoring** ) and select **processes-<your_process>** to display the process monitoring charts and view the monitoring data.

## Setting up Monitoring for a RightScript-based Custom ServerTemplate

1. Determine what version of RightLink (RightLink is preinstalled on every RightImage) or the version of the image that your custom ServerTemplate or MultiCloud image is using by opening the ServerTemplate and clicking on the **Images** tab.
2. Go to the MultiCloud Marketplace ( **Design** > **MultiCloud Marketplace** > **RightScripts** ) and determine which version of the 'SYS Monitoring Install' RightScript is the correct one to use with your version of RightLink.
  * For example, if your custom ServerTemplate is using the image 'RightImage_CentOS_5.4_x64_v5.6 - 11H1', then you will want to import the 11H1 version 'SYS Monitoring Install' Rightscript.
  * You can always verify and compare exactly which RightLink version and/or image is used by importing a ServerTemplate and then navigating to the template's **Images** tab
  * See the following links for the latest corresponding RightScript versions:
    * [13.x](http://www.rightscale.com/library/right_scripts/SYS-Monitoring-install-v13-4/lineage/7299) (Infinity, v13.x and v5.8 RightLink images)
    * [12.11.x](http://www.rightscale.com/library/right_scripts/SYS-Monitoring-install-v12-11-/lineage/15496) (LTS, v12.11-LTS and some v5.8 RightLink images)
    * [11H1](http://www.rightscale.com/library/right_scripts/SYS-Monitoring-install-11H1/lineage/6337) (v5.0-v5.6 RightLink images)
    * [v8](http://www.rightscale.com/library/right_scripts/SYS-Monitoring-install-v8/lineage/2726) (for v4.x non-RightLink images
3. Click **Import** to import the desired version of the 'SYS Monitoring Install' RightScript.
4. Configure monitoring for your ServerTemplate using the 'SYS Monitoring Install' RightScript:
  * Go to *your ServerTemplate* > **Scripts** and click **Modify**.
  * In the right side pane, locate the 'SYS Monitoring Install' RightScript imported in the previous step.
  * Click and drag on the 'SYS Monitoring Install' RightScript and drag it to the 'Boot Sequence' section
5. Proceed by creating a new Server from your ServerTemplate.

### Configure User Defined Process Monitoring Inputs

1. Once you have created a server from your custom ServerTemplate, navigate to the *your Server* > **Inputs** tab.
2. Click **Edit** and enter a text value for either the 'MON_PROCESSES' or 'MON_PROCESSMATCH' input for the process that you want to monitor.
  * The MON_PROCESSES input is a space-separated list of processes that you want to monitor in the RightScale Dashboard (for example, sshd crond).
  * The MON_PROCESSMATCH input is a space-separated list of pairs used to match the names of additional processes to monitor in the RightScale Dashboard. Paired arguments are passed in using the following syntax 'name/regex' (for example, ssh/ssh\* cron/cron\*).
  <br>**Note:** The <name> portion of this input refers to the monitoring graph's name, and the <regex> portion should be the regular expression used to match the process name(s). For example, if the value 'secure_shell/ssh\*' is used instead, then the collectd monitoring graph would be named 'processes-secure_shell' accordingly.
3. Click **Save**. Monitoring custom defined processes is now enabled on your server when it is launched.
4. After launching your server, go to the **Monitoring** tab (*your server* > **Monitoring** ) and select **processes** to display the process monitoring charts and view the monitoring data.

## Configure an Optional Alert

If you wish to configure an optional alert for your user defined process, then view the [Create a Custom Alert Specification](/cm/rs101/create_a_custom_alert_specification.html) tutorial. The monitoring system tracks multiple metrics with regards to the monitored process, but most importantly you can monitor the number of processes running for the given process. The syntax for the custom alert specification to count the number of processes would be as such:

* processes-< **_your process_** >/ps_count.processes

**Important!** If you used the MON_PROCESSMATCH input (RightScript) or the 'Process Match List' input (Chef), then <_your process_> should be the value of the <name> portion of the input. For example, if I used the value " **secure_shell** /ssh\*" for the MON_PROCESSMATCH or Process Match List input, then my alert would look like this:
* processes- **secure_shell** /ps_count.processes
