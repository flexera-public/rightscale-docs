---
title: LDAP Group Sync
description: Details around the LDAP Group Sync tool
---
## Overview

The group sync tool is designed to sync groups from an LDAP provider, such as Active Directory, to RightScale Governance.

It runs on PowerShell and leverages ldapsearch(Part of [openldap](https://www.openldap.org/software/download/) tools) or the [Active Directory PowerShell Module](https://docs.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/ee617195(v=technet.10)).


## Prerequisites

1. Native PowerShell on Windows or [PowerShell core](https://github.com/PowerShell/PowerShell) on Linux
1. For a non-Active Directory LDAP Directory Service, openldap tools are required:
    -  Linux: [https://www.openldap.org/software/download/](https://www.openldap.org/software/download/)
    -  Windows: <a nocheck href="https://userbooster.de/en/download/openldap-for-windows.aspx">https://userbooster.de/en/download/openldap-for-windows.aspx</a>
        - Ensure you add the *ClientTools* directory to your `PATH`
1. For Active Directory, installation of the [Active Directory PowerShell Module](https://docs.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/ee617195(v=technet.10)) is recommended.


## Important Considerations

1. This tool will follow memberships for nested groups. All users of nested groups will be treated as members of the parent group.
1. Groups must already exist in RightScale with the proper roles assigned. This tool will not create groups.
1. Once a group is managed by this tool, you will no longer be able to manually make modifications to its members in RightScale Governance. Any changes you make to the group in RightScale Governance will be removed once the next group sync is run. Manage the group in your directory service.
1. The time it takes to do a full sync is directly related to the number of groups and users you are synchronizing. We recommend running it a few times manually to get a good baseline before scheduling it to run on a reoccurring basis. Remember to add a buffer to the schedule to account for latency and additional users and groups that may be added in the future.
1. We recommend creating a group in RightScale Governance to manage users with the enterprise_manager role. It is important that this group is not synchronized from your directory service. This will ensure you have a fail-safe for gaining access to RightScale.


## Active Directory(AD)

1. If your directory service is Active Directory, and you will be running this script on a Microsoft Windows Server, please install the Active Directory PowerShell module.
1. When the Active Directory PowerShell module is installed on the Microsoft Windows Server running this script, the values of some parameters will automatically be overridden.


## How It Works

1. The tool gathers groups from an LDAP directory service based on a comma separated list of groups. Wildcards are supported in the group names.
1. Once the groups are discovered, it collects the necessary details from each member of that group(Given name, Surname, Email Address, Phone Number and Principal UID).
1. A query is run against your Organization in RightScale to collect all users and determine what users need to be created and removed.
1. All new users are created based on the attributes collected from LDAP.
1. A query is run against your Organization in RightScale to collect the groups that match your LDAP groups and adjust their membership to match your LDAP groups membership.
1. (Optional) Users that are no longer members of your LDAP groups are removed from your RightScale Organization.


## Implementation

For further details on this solution, as well as instructions on configuring, executing, and scheduling, please visit the GitHub repository - [rs-services/ldap-group-sync](https://github.com/rs-services/ldap-group-sync)