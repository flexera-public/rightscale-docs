---
title: Why does SoftLayer return an invalid hostname or 'Connection to the gateway failed' error?
category: softlayer
description: SoftLayer returns an invalid hostname or 'Connection to the gateway failed' error because it follows a naming convention for its instances and servers.
---

## Background

SoftLayer returns an invalid hostname or 'Connection to the gateway failed' error because it follows a naming convention for its instances and servers.

## Answer

The correct naming convention is as follows:

* The hostname and domain must be alphanumeric strings that may be separated by periods '.'. The only other allowable special character is the dash '-'. However the special characters '.' and '-' may not be consecutive.
* Each alphanumeric string separated by a period is considered a label.
* Labels must begin and end with an alphanumeric character. Each label cannot be soley comprised of digits and must be between 1-63 characters in length. The last label, the TLD (top level domain) must be between 2-6 alphabetic characters.
* The domain portion must consist of least one label followed by a period '.' then ending with the TLD label. Combining the hostname, followed by a period '.', followed by the domain gives the FQDN (fully qualified domain name), which may not exceed 253 characters in total length.
