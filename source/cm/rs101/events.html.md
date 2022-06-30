---
title: Events
layout: cm_layout
description: Events or event notifications display in the RightScale Cloud Management Dashboard to inform users about recent activity within a RightScale account.
---

## What is an Event?

Events or event notifications display in the RightScale Dashboard to inform users about recent activity within a RightScale account. Events are specific to a RightScale account. The Events pane is located on the left-hand side of the Dashboard and displays text hyperlinks to the related audit entries for each action. Click on one of the text links to view more detailed information. Only events that have occurred in the last ten minutes will be displayed.

![cm-events-pane.png](/img/cm-events-pane.png)

## Event Icons

Event notifications are categorized into one of the following event types. A different icon represents each event type. By default, all icons are active and all events are shown. However, you can turn the events on/off for a particular event type by clicking the related icon.

![cm-lifecycle-icon.png](/img/cm-lifecycle-icon.png) **Lifecycle Management**  

Displays the various states of a server as they transition from pending, booting, operational, shutting-down, or terminated. User performed actions are also listed such as execution of scripts. Ex: completed: Email action

![cm-wiki-icon.gif](/img/cm-wiki-icon.gif) **Information**

Displays actions that are specific to scaling. Ex: Resize array by (+2) Scripts that are automatically executed by the platform on your behalf are also displayed. For example, Chef recipes that are periodically executed to maintain the state of the machine as part of the Reconvergence List. Ex: completed: lb::do\_attach\_all

![cm-security-icon.png](/img/cm-security-icon.png) **Security**

Denotes when a server is being accessed via SSH. Ex: SSH console launch Events are also displayed when there is a change in the Server Login Policy. For example, if a user is granted or denied SSH access, any effected running servers will be updated accordingly.

![cm-error-icon.png](/img/cm-error-icon.png) **Error**

Displays failure messages.

## Feed (RSS)

Click the Feed icon ![cm-rss-icon.gif](/img/cm-rss-icon.gif) to subscribe to an RSS feed based on the current event settings. Event settings are RightScale account-specific.

## Tools

Click the Tools menu to view a list of all the RightScale accounts to which you have access. Remember, you can have access to more than one RightScale account. By default, events are only shown for the current RightScale account. Click the Tools link to view a list of additional options related to your Events settings.

* Select multiple RightScale accounts
* Change the maximum number of events that are displayed for a given Event type. (Range: 1, 3, 10 or All) (Default = 3)
* Mark all events as read - Click this text link to clear the Events pane.

![cm-events-tools.png](/img/cm-events-tools.png)

**Note**: Events has taken the place of the limited features surrounding Recent Activity. (Deprecated Dec 2009)
