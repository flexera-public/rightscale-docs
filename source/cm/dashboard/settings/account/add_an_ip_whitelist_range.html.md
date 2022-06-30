---
title: Add an IP Whitelist Range
layout: cm_layout
description: The IP Whitelists section lets you specify the range of IP addresses that can log into RightScale or from which users or programs can access RightScale API endpoints.
---

## Objective

The IP Whitelists section lets you specify the range of IP addresses that can log into RightScale or from which users or programs can access RightScale API endpoints. This feature can be used by account administrators to enable access to RightScale through a company's IP address.

## Prerequisites

* Requires `admin` user role privileges and Enterprise Edition to configure this feature. Contact your account manager or [sales@rightscale.com](mailto:sales@rightscale.com) for more details.

## Overview

By default, users are allowed to log into the RightScale Dashboard from any public IP address (i.e. IP Whitelist Access Control is disabled). To enable the IP Whitelist access control feature, create a rule.

## Steps

* Navigate to **Settings** > **Account Settings** > **Access Controls**. Enable IP Whitelist access controls by creating a rule.

![cm-account-settings-access-controls.png](/img/cm-account-settings-access-controls.png)

* Specify the **IP Range** and **Description** and select **Add**. You must specify IP addresses in CIDR format. (e.g. 192.23.167.0/24)  

!!info*Note:* As a safety precaution you cannot create a rule where your own IP address is denied access, otherwise you could accidentally lock yourself out of your own account.

Your list of active IP whitelist ranges are displayed below. If you would like to remove an IP restriction, simply delete the rule.

## See also

- [About Organization](/cm/dashboard/settings/enterprise/index.html)
