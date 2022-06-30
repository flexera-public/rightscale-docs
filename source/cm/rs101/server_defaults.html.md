---
title: Server Defaults
layout: cm_layout
description: Server defaults in RightScale let users set certain values that will be used as defaults for new servers. These defaults can be set at the cloud, account, and deployment level.
---

## Overview

Server defaults let users set certain values that will be used as defaults for new servers. These defaults can be set at the cloud, account, and deployment level. If no deployment defaults are found, account defaults will be used, then cloud defaults. Server defaults are used to pre-fill fields when creating new servers and server arrays. Server defaults are scoped by cloud and (with the exception of cloud-level defaults) by account. Cloud-level defaults are global objects, while defaults at the deployment and account level are not.

## Account Server Defaults

Account Server Defaults are set at the account level for servers launched within that account. Setting these defaults allows users within that account to inherit them when launching a server. You mix and match with defaults that can be set at the deployment level. Navigate to Account Settings > Server Defaults to view the available settings to serve as defaults. You have the option of creating different default settings for each available cloud from the dropdown menu in the Cloud field.

![cm-account-server-defaults.png](/img/cm-account-server-defaults.png)

## Deployment Server Defaults

You can set Server Defaults from the Confirm tab of the add server flow. Checking the box at the bottom of the Confirm Details section will store these settings so they can be used for future servers launched within that deployment. These settings can be edited by navigating to the Server Defaults tab of the deployment.

![cm-server-defaults-checkbox.png](/img/cm-server-defaults-checkbox.png)

The server default settings are specific to each deployment. Within the deployment's Server Defaults tab, you can set up different server defaults for each supported cloud in the RightScale account. Navigate to your deployment's Server Defaults tab to view these settings. Within the deployment's Server Defaults settings, you have the ability to inherit your choice of settings from your Account Defaults. You also have the option of choosing a particular cloud as the default choice for that deployment.

![cm-deployment-server-defaults.png](/img/cm-deployment-server-defaults.png)

## See Also

- [Add Server Assistant](/cm/dashboard/design/server_templates/servertemplates_actions.html#add-server-assistant)
