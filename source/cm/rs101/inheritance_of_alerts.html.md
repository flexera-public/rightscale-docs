---
title: Inheritance of Alerts
layout: cm_layout
description: Alerts can be defined at two different levels in the RightScale Cloud Management Platform. It's important to understand how alerts are inherited so that you can properly use and configure them to help manage your servers across all your deployments.
---

## Overview

Alerts can be defined at two different levels. It's important to understand how alerts are inherited so that you can properly use and configure them to help manage your servers across all your deployments.

**Important!** Alert hierarchy rules are only evaluated and applied to a server at launch time. Once a server is operational, the alerts are set for the current instance. If you want to change the input on a running server, you need to add/modify the alert under the "current" server's Alerts tab.

![cm-alert-hierarchy-chart.png](/img/cm-alert-hierarchy-chart.png)

* **ServerTemplate** - Most ServerTemplates contain a list of predefined alert specifications that are tied to alert escalations.
* **Server / Server Array** - The highest level of precedence is at the Server or Server Array level.

## ServerTemplate Level

Typically, most servers inherit their alerts from their ServerTemplates. Many of the ServerTemplates published by RightScale already have a set of predefined alert specifications.

Each ServerTemplate contains a generic set of alert specifications that are considered best practices for servers in the cloud, as well as a set of application-specific alert specifications. For example, in RightScale's "Load Balancer with HAProxy" ServerTemplate, you'll find the common set of base alerts that are preconfigured for each ServerTemplate, along with the addition of a few alert specifications that are specific to the ServerTemplate's core functionality. As you can see in the screenshot below, it contains Since it's a load balancer ServerTemplate that uses Apache and HAProxy (highlighted below).

![cm-ha-proxy-alerts.png](/img/cm-ha-proxy-alerts.png)

You'll notice that each alert specification is using one of the three (Warning, Critical, Default) predefined alert escalations in each RightScale account.

![cm-default-alert-escalations.png](/img/cm-default-alert-escalations.png)

By default, the core set of alert escalations send emails to the email address of the 'owner' of the account. (i.e. To the person who created the RightScale account.) However, if you have changed the email address of the account's owner (Settings > Account Settings > Info) since the RightScale account was first created, the alert escalations will not be updated to send email to the new email address.

nly application-specific inputs should be left undefined since they are unique to each setup. To improve the usability of your ServerTemplate, keep the number of undefined inputs at the ServerTemplate to a minimum. Setting values for your Inputs is arguably the most difficult part of becoming proficient using the RightScale Dashboard to manage your cloud assets. Using our ServerTemplates as a starting point for what you build and manage in the cloud facilitates using sensible settings for your inputs. Although you can change or override the default inputs of a ServerTemplate, making unnecessary changes increases the risk of entering incorrect or invalid input settings.

## Best Practices for Alerts

### ServerTemplate Designer

If you are creating new ServerTemplates or modifying existing ones, follow the guidelines below.

![cm-alert-inheritance-clone.png](/img/cm-alert-inheritance-clone.png)

* Define generic alerts at the ServerTemplate level.
* Define application-specific alerts at the ServerTemplate level. For example, if you are creating a MySQL database ServerTemplate, you should add alert specifications that are relevant for monitoring MySQL databases on a server. For example, raise an alert if the MySQL thread count is too low or the mysqld process is not running.
* If you are creating a generic ServerTemplate that will either be used across different deployments within the same account or in other RightScale accounts (via publishing and sharing to the MultiCloud Marketplace), you should define any generic alert specifications at the ServerTemplate level.
* If you want to define deployment-specific alerts, clone the ServerTemplate to create a version of the ServerTemplate that's specific to a particular deployment or use-case. Add new alerts or modify the existing ones on the cloned ServerTemplate.
* Do not set any alerts for autoscaling at the ServerTemplate level.

### System Administrator

If you are managing operational servers in a deployment, follow the guidelines below.

![cm-alert-inheritance-server.png](/img/cm-alert-inheritance-server.png)

* If you modify an alert specification on a "current" running server, you must make the same modification under the "next" server if you want the same alert specification to be set the next time the server is launched/relaunched.
* Alerts for autoscaling should only be set at the Server or Server Array levels.
