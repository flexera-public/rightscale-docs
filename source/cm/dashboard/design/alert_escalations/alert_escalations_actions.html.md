---
title: Alert Escalations Actions
layout: cm_layout
description: Common procedures for working with Alert Escalations in the RightScale Cloud Management Dashboard.
---

## Clone an Alert Escalation

Use this procedure to clone an Alert Escalation so that it becomes your own (Private) object that you can customize to suit your needs. You cannot edit a committed revision of an Alert Escalation. You must clone it in order to create an editable version under **Design** > **Alert Escalations**.

* Go to **Design** > **Alert Escalations**. Select one of the available Alert Escalations that you would like to clone.
* When you click the **Clone** action button, an editable copy of that Alert Escalation will be created.
* You may notice a warning message that the cloned object will have its usage reported to RightScale. This message is meant to convey the fact that RightScale is able to track the lineage of an object even if it's cloned.

By default, the version of a Alert Escalation will be incremented. For example, if you clone "Alert Escalation" the new cloned version will be named "Alert Escalation v1". Therefore, we recommend changing the name of the object to help better distinguish the cloned one from its ancestor. Under the Info tab, notice that we always show where an Alert Escalation was cloned from.

## Create a New Alert Escalation

Use this procedure to create an example Alert Escalation for scaling down a Server Array.

### Create the New Alert

* Go to **Design** > **Alert Escalations** and click **New**.

![cm-new-alert-escalation.png](/img/cm-new-alert-escalation.png)

Provide the following information for each alert escalation.

* **Name** – A short nickname that helps you recognize the alert escalation.
* **Description** – A short description of the alert escalation (for internal use only).
* **Deployment** - Select a specific deployment where you will be able to select the alert escalation. By default the escalation will be available to "all deployments."

### Define Alert Actions

The next step is to define what actions should be taken when an alert escalation is called. The most common actions are already configured for your convenience. Under the Actions tab, select which action you would like to add. See [Valid Actions for Alert Escalations](/cm/dashboard/design/alert_escalations/alert_escalations.html) for a detailed breakdown of each supported action. Add as many actions to an escalation as necessary. For example, you can create a series of actions to define an escalation process for a persistent problem.

!!info*Note:* The 'vote_grow_array' and 'vote_shrink_array' actions will soon be deprecated. To set up autoscaling, please use tags instead. See [Set up Autoscaling using Voting Tags](/cm/dashboard/manage/arrays/arrays_actions.html#Set_up_Autoscaling_using_Voting_Tags).

![cm-select-action.png](/img/cm-select-action.png)

In the example below, an email will be sent every 15 minutes to the system administrator. If the condition continues to persist without change for 60 minutes, the next action will be triggered (Ex: An email to the CEO).

![cm-define-email-action.png](/img/cm-define-email-action.png)

* **Prior actions** - If there is more than one action for an alert escalation, you can define whether this action should be "added" to the prior action or "replace" the prior action. Currently, you cannot change the order of the listed actions. You must simply delete and create new actions.
  * **add** - This action will be "added" to the prior action. The previous action will continue to run.
  * **replace** - This action will "replace" any prior actions. The previous action(s) will stop running.

![cm-list-of-actions.png](/img/cm-list-of-actions.png)

### Define Alert Resolution Action (Labs)

When an alert goes from active to inactive, it is considered "resolved". You can specify one action to take when an alert escalation is resolved, either to send an email or run a Cloud Workflow. This action can be used to automate systems to auto-resolve issues when the alert clears, either from manual intervention or automated resolution actions.

![cm-select-resolution-action.png](/img/cm-select-resolution-action.png)


### Missing Inputs on Relaunch

In the examples above, the alert action was to send an email. Relaunching a server is among several other possible alert actions. The following discussion details how the Dashboard has embedded intelligence so that you don't try to relaunch a Server with missing Inputs.

When adding a "Relaunch Server" action to an Alert Escalation, there is a check to see if this escalation is connected to a server with missing Inputs. If so, a warning will be displayed to inform the user that in order to automate the relaunching of a server, its Input parameters must be fully specified. A warning message will appear when the input's check fails when clicking adding the 'relaunch_server' action.

Similarly, when adding an Alert Specification to a Server or ServerTemplate, there is a check to see if the Server (or a Server derived from a ServerTemplate) has missing Inputs. If so, a flash message is displayed to inform the user that in order to automate the relaunching of a server, its Input parameters must be fully specified. A flash warning message will appear when the Inputs check fails when clicking the "Attach" button from a selected Alert Specification (that includes a relaunch) from **Manage** > **Servers** > *ServerName* > **Alerts Tab**

## Override Alert Escalations

To override an account-wide Alert Escalation with one that is deployment-specific so that the behavior of the triggered Alert Escalation changes depending on the deployment, which is especially useful when you use the same ServerTemplate across multiple deployments such as production, staging, or development environments.

By default, a RightScale account is preconfigured with three Alert Escalations that are available for use across all deployments. (**Design** > **Alert**  **Escalations**)

* critical
* default
* warning

If you are using ServerTemplates published by RightScale to launch servers, you will notice that each ServerTemplate has a number of preconfigured alert specifications that leverage the *critical* and *warning* Alert Escalations. For this reason, it's not recommended to delete them otherwise the *default* escalation will be used instead.

In some use cases, you may not want to have all servers in your account using the same Alert Escalations. For example, you may be using the same ServerTemplate across multiple deployments in your account, but only one deployment is for production use whereas the other deployments are for staging, development, and/or testing. In such cases, the alerts that use the *critical* and *warning* Alert Escalations related to your production deployment should be treated differently than every other deployment. For instance, you may want any critical alerts to send an email notification directly to your system administrator or Operations team instead of to the owner of the RightScale account (default).

In the diagram below, the ServerTemplate contains an alert that uses the *critical* Alert Escalation. Notice that the 'Production' deployment uses a different *critical* Alert Escalation even though the ServerTemplate's alert configurations remain unchanged.

![cm-deployment-alert-esc.png](/img/cm-deployment-alert-esc.png)

Follow the instructions below to set up your RightScale account so that your production deployment can use a different set of Alert Escalations without having to create separate ServerTemplates for production use, which would be extremely difficult to maintain.

### Steps

1. Go to **Design** > **Alert**  **Escalations**.  
  ![cm-list-default-alert-escalations.png](/img/cm-list-default-alert-escalations.png)
2. Select the one that you want to copy for exclusive use by your production deployment. (e.g. critical)
3. Clone the Alert Escalation. (*Note*: Do not rename the Alert Escalation at this time.)
4. Click on the **Actions** tab and make any necessary modifications. For example, a common modification is to change the email address that receives emails when this Alert Escalation is executed by a triggered alert. (By default, the email address that is tied to each of the preconfigured Alert Specifications is the email address of the account owner. See **Settings** > **Account**  **Settings** > **Info** tab.)  
  ![cm-email-action-rename.png](/img/cm-email-action-rename.png)
5. Go to the Alert Escalations **Info** tab. Click **Edit** and change the scope of the Alert Escalation to a specific deployment. Select the production deployment. (e.g., My Production)  
  ![cm-select-production-deployment.png](/img/cm-select-production-deployment.png)
6. It is now safe to change the Alert Escalation's name to 'critical'. Remember, you do not want to give it a unique name because the ServerTemplates in your production account are probably already configured to use the 'critical' alert. By using the same name, you will not have to change the existing ServerTemplate. However, when that ServerTemplate is used in the context of the selected deployment (e.g. My Production), this new Alert Escalation that you just defined will be used, instead of the account-wide Alert Escalation with the same name.  
  ![cm-list-of-escalations.png](/img/cm-list-of-escalations.png)
7. Repeat the steps above to create additional deployment-specific Alert Escalations.

## Update Default Alert Escalations

To update the default Alert Escalations that are automatically preconfigured in each RightScale account to be more appropriately configured for a RightScale account. By default, a RightScale account is preconfigured with three Alert Escalations that are available for use across all deployments. (**Design** > **Alert Escalations**)

* critical
* default
* warning

![cm-list-default-alert-escalations.png](/img/cm-list-default-alert-escalations.png)

If you are using ServerTemplates published by RightScale to launch servers, you will notice that each ServerTemplate has a number of preconfigured alert specifications that leverage the *critical* and *warning* Alert Escalations. For this reason, it's not recommended to delete those two escalations otherwise the *default* escalation will be used instead.

However, it is recommended that the administrator of the RightScale account update/change these preconfigured alert escalations to be appropriately customized for your account. There are two different ways to customize your Alert Escalations. Both methods are described in the following sections.

* [Update Existing Alert Escalations](#update-default-alert-escalations-update-existing-alert-escalations)
* [Override Default Alert Escalations](#update-default-alert-escalations-override-default-alert-escalations)

### Update Existing Alert Escalations

1. Go to **Design** > **Alert**  **Escalations**.
2. Select the one that you want to modify.
3. Click the **Actions** tab and edit the predefined action. Typically, most users opt to change the email address that's associated with each of the default Alert Escalations. By default, the email address that's associated with the escalations is based upon the person (email) who created the RightScale account. Therefore, you might prefer to change the email address to an alias instead. (e.g. ops@example.com)  
![cm-change-email.png](/img/cm-change-email.png)  
4. (Optional) Add additional actions, as necessary. See the [Valid Actions for Alert Escalations](/cm/dashboard/design/alert_escalations/#valid-actions-for-alert-escalations) for more information.
5. Repeat the steps above to modify other Alert Escalations.

### Override Default Alert Escalations

If you are using the same ServerTemplates (that are using the same Alert Escalations), but want to define a different set of actions based upon the deployment in which those Alert Escalations are triggered, create deployment-specific ones using an override.
