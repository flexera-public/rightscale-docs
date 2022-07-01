---
title: How come I receive an error when attempting to launch my Softlayer server or instance?
category: softlayer
description: When launching a SoftLayer instance or server, you may notice a generic "gateway" related error or another flash error on the screen.
---

## Background

When launching a SoftLayer instance or server, you may notice a generic "gateway" related error or another flash error on the screen.

This may be due to the server or instance's nickname, which must fall under requirements of a naming convention set by SoftLayer. This article explains the naming requirements for SoftLayer instances or servers.

## Answer

The naming requirements are as follows for SoftLayer instances/servers:

* The nickname must be alphanumeric strings that may be separated by periods '.'
* The only other allowable special character is the dash '-'. However the special characters '.' and '-' may not be consecutive.
* Each alphanumeric string separated by a period is considered a label. Labels must begin and end with an alphanumeric character.
* Each label cannot be solely comprised of digits and must be between 1-63 characters in length.
* The last label, the TLD (top level domain) must be between 2-6 alphabetic characters (if applicable).
* The domain portion must consist of at least one label followed by a period '.' then ending with the TLD label (if applicable).
* Combining the hostname, followed by a period '.', followed by the domain gives the FQDN (fully qualified domain name), which may not exceed 253 characters in total length.


In short, you may see errors trying to launch a SoftLayer instance or server if there are special characters in the server/instance's nickname (parentheses, etc.)

If you still see problems beyond the scope of this article, please feel free to open a ticket from the dashboard or call/email us at **(866) 787-2253** or [support@rightscale.com](mailto:support@rightscale.com)
