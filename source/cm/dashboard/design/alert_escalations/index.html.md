---
title: Alert Escalations
layout: cm_layout
alias: cm/dashboard/design/alert_escalations/alert_escalations.html
description: In the RightScale Cloud Management Dashboard, an alert escalation defines the action or set of actions to be taken when specified alert conditions are met.
---
### Overview

An **alert escalation** defines the action or set of actions to be taken when specified alert conditions are met. Unlike alerts which are specific to a Server, ServerTemplate, or Server Array, Alert Escalations can be designated to a specific Deployment or made available for use across all Deployments.

An alert must be enabled on a server in order for the server to monitor for a condition and call an Alert Escalation. Alert conditions are evaluated every minute. When an alert that is tied to an Alert Escalation is triggered, the actions of the associated escalation will be executed until the alert condition no longer exists or it's disabled. If an alert's conditions no longer exist, an option Resolution Action can be specified to be run.

You can also override an Alert Escalation by creating one with the same name in order to override the account-wide escalation with one that is deployment-specific.

Several of the most common alert escalations have already been predefined for your convenience. You can also create your own custom alert escalations.

To view or create Alert Escalations, navigate to **Design** > **Alert Escalations**. The **New** button is provided to create Alert Escalations.

Visit the [Alert Escalations - Actions and Procedures](/cm/dashboard/design/alert_escalations/alert_escalations_actions.html)

Here is a list of supported actions inside an Alert Escalation. These actions are summarized in the sections below.

* [**send_email**](#valid-actions-for-alert-escalations-send-email) - Send email to one or multiple recipients.
* [**reboot_server**](#valid-actions-for-alert-escalations-reboot-server) - Reboot the server instance generating the alert.
* [**relaunch_server**](#valid-actions-for-alert-escalations-relaunch-server) - Relaunch the server generating the alert (this terminates the current instance and launches a fresh instance).
* [**run_right_script**](#valid-actions-for-alert-escalations-run-rightscript) - Run a RightScript on the server instance generating the alert.
* [**run_cloud_workflow**](#valid-actions-for-alert-escalations-run-cloud-workflow) - Run a [Cloud Workflow](/ss/reference/rcl/v2/index.html) to react to the alert.
* **vote_grow_array** - Vote to grow a server array attached to the deployment in which the alerting server is running. (This option will soon be deprecated. Use Voting Tags instead.)
* **vote_shrink_array** - Vote to shrink a server array attached to the deployment in which the alerting server is running. (This option will soon be deprecated. Use Voting Tags instead.)

!!info*Note:* The "vote to grow/shrink array" options will soon be deprecated. Autoscaling is now performed using [voter tags](/cm/dashboard/manage/arrays/arrays_actions.html#set-up-autoscaling-using-voting-tags).

The following is a list of supported actions to be run as part of a Resolution Action. These actions are summarized in the sections below.

* [**send_email**](#valid-actions-for-alert-escalations-send-email) - Send email to one or multiple recipients.
* [**run_cloud_workflow**](#valid-actions-for-alert-escalations-run-cloud-workflow) - Run a [Cloud Workflow](/ss/reference/rcl/v2/index.html) to react to the alert.

## Valid Actions for Alert Escalations

The following actions are supported when creating a sequence of actions for an alert escalation.

### Send Email

Action name: `send_email`

You can send an email to one or multiple recipients. Email field supports space-, comma- or semicolon-separated list of email addresses.

There are three different types of email formats.

* **detailed email message** - Standard email format with Subject and Message.  

* **short TXT message** - Designed for sending short SMS/MMS text messages to cell phones. Enter the phone number in a valid SMS string into the Email field. (e.g., [18052224444@vtext.com](mailto:18052224444@vtext.com) (Verizon) See [FAQ 105 - How do I text message an alert?](/faq/How_do_I_send_an_alert_as_a_text_message.html)  

* **parsable message** - Designed for auto responders. A server will receive the email message and 'parse' a response. (See example below)

**Example of Parsable Message**

~~~
    subject: alert: 'My cool server' My sweet alert spec
~~~

~~~
    message: Server Name: My super server,
    Server Href: http://my.rightscale.com/api/acct/0/servers/0,
    Deployment Name : My awesome deployment,
    Deployment Href: http://my.rightscale.com/api/acct/0/deployments/0,
    Account Name: My account name,
    Cloud: 1,
    Alert Name: My sweet alert spec,
    Alert Time: 2009-11-21 00:00:42,
    Alert Spec Input: cpu-0/cpu-idle,
    Alert Spec Metric: value,
    Alert Spec Condition: >,
    Alert Spec Target Value: 60,
    Alert Spec Duration: 5
~~~

### Reboot Server

Action name: `reboot_server`

Reboot the server generating the alert. Equivalent to rebooting the same physical machine. (i.e., The Server will maintain its Instance ID.)

### Relaunch Server

Action name: `relaunch_server`

Relaunch the server generating the alert (this terminates the current running instance and launches a fresh instance). i.e. The Server will receive a new Instance ID.

### Run RightScript

Action name: `run_right_script`

Run a RightScript on a server.

* **Repeat every** - Enter a positive integer greater than zero (valid range: 1 - 10,000,000) to repeat this action every *n* minutes. Leave the field blank to run the script once.
* **Prior actions** - This value is only applicable if a prior action already exists.
  * **add** - Add the current action to any previously running actions. (i.e. Continue executing any previous actions and run this action too.)
  * **replace** - Replace any previously running actions with this action. (i.e. Stop performing any previous actions and run this action.)
* **Escalate after** - Defines how many minutes must pass before executing the next action in the list. Enter a positive integer greater than zero (valid range: 1 - 10,000,000)
* **Execute on server** - If the Alert Escalation is available across all deployments in the RightScale account, you can only execute the script on the server that raised the alert. However, if you were explicit when you created the Alert Escalation and only made it available for use inside of a specific deployment, you will also have the option to execute the script on another server in the deployment.
 ![cm-select-server.png](/img/cm-select-server.png)  
You can only run the script on a single server. To run the script on another server you must create another action. Only servers that currently exist in the deployment will be listed. You cannot execute the script on any instances in an associated array.
* **RightScript** - Select the RightScript to be executed on the server. All RightScripts available within the RightScale account will be listed. All committed revisions as well as the HEAD version of the script will be listed.

### Run Cloud Workflow

Action name: `run_cloud_workflow`

Run a [Cloud Workflow](/ss/reference/rcl/v2/index.html). The workflow is run using the permissions of the user that creates the alert escalation at time of creation.

* **Repeat every** - Enter a positive integer greater than zero (valid range: 1 - 10,000,000) to repeat this action every *n* minutes. Leave the field blank to run the script once.
* **Prior actions** - This value is only applicable if a prior action already exists.
  * **add** - Add the current action to any previously running actions. (i.e. Continue executing any previous actions and run this action too.)
  * **replace** - Replace any previously running actions with this action. (i.e. Stop performing any previous actions and run this action.)
* **Escalate after** - Defines how many minutes must pass before executing the next action in the list. Enter a positive integer greater than zero (valid range: 1 - 10,000,000)
* **Cloud Workflow source** - Enter the [RCL source code](/ss/reference/rcl/v2/index.html) to run. The RCL must implement a definition named `alert` that takes no parameters, which is the entry point when the alert is triggered. The global variables `@@alert` and `@@instance` are are available to the definition, representing the alert and instance that was triggered, respectively.

The following limits exist for Cloud Workflow processes running as part of an alert escalation:

* A hard limit of **10 minutes** is defined for the runtime of a Cloud Workflow associated with an alert escalation. If a Cloud Workflow is still running past this time, it will be canceled. 
* Only one Cloud Workflow process may be running at any time for a given server alert
* Cloud Workflow processes running as part of an alert escalation do not support plugins
* When an alert is "resolved", any running Cloud Workflow processes continue to run to completion (they are not canceled/aborted)

### Vote to Grow the Server Array (scale-up)

Action name: `vote_grow_array`

!!warning*Warning!* This action will soon be deprecated. Please see [Set up Autoscaling using Voting Tags](/cm/dashboard/manage/arrays/arrays_actions.html#set-up-autoscaling-using-voting-tags).

The server is voting to grow or 'scale-up' by launching additional servers into the server array that's attached to the deployment. It is only a vote; not a trigger to launch servers. Additional servers will not be launched unless enough servers are voting for the 'vote_grow_array' action. The server array's scaling parameters will ultimately determine when to scale (e.g. > 51% are voting) and how to scale (e.g. Launch '2' new servers into the array).

!!info*Note:* The array must be active (enabled) in order for any scaling to take place.

### Vote to Shrink the Server Array (scale-down)

Action name: `vote_shrink_array`

!!warning*Warning!* This action will soon be deprecated. Please see [Set up Autoscaling using Voting Tags](/cm/dashboard/manage/arrays/arrays_actions.html#set-up-autoscaling-using-voting-tags).

The server is voting to shrink or 'scale-down' by terminating underutilized servers from the array that's attached to the deployment. It is only a vote; not a trigger to terminate servers. Underutilized servers will not be terminated unless enough servers are voting for the 'vote_shrink_array' action. The server array's scaling parameters will ultimately determine when to scale (e.g. > 51% are voting) and how to scale (e.g. Terminate '1' server from the array).

!!info*Note:* The array must be active (enabled) in order for any scaling to take place.

## Further Reading

- [Alert Escalations - Actions and Procedures](/cm/dashboard/design/alert_escalations/alert_escalations_actions.html)
- [Alerts, Alert Escalations, and Server Arrays](/cm/rs101/alerts_alert_escalations_and_server_arrays.html)
- [Create an Alert Specification](/cm/rs101/create_a_new_alert_specification.html)
- [Create a Custom Alert Specification](/cm/rs101/create_a_custom_alert_specification.html)
- [Set up Autoscaling using Voting Tags](/cm/dashboard/manage/arrays/arrays_actions.html)
- [Cloud Workflow](/ss/reference/rcl/v2/index.html)
