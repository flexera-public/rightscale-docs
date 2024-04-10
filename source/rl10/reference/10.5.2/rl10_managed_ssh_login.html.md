---
title: Managed SSH Login
description: Enabling and understanding the Managed Login feature to enable users to SSH into instances.
version_number: 10.5.2
versions:
  - name: 10.6.4
    link: /rl10/reference/10.6.4/rl10_managed_ssh_login.html
  - name: 10.6.3
    link: /rl10/reference/10.6.3/rl10_managed_ssh_login.html
  - name: 10.6.2
    link: /rl10/reference/10.6.2/rl10_managed_ssh_login.html
  - name: 10.6.1
    link: /rl10/reference/10.6.1/rl10_managed_ssh_login.html
  - name: 10.6.0
    link: /rl10/reference/10.6.0/rl10_managed_ssh_login.html
  - name: 10.5.3
    link: /rl10/reference/10.5.3/rl10_managed_ssh_login.html
  - name: 10.5.2
    link: /rl10/reference/10.5.2/rl10_managed_ssh_login.html
  - name: 10.5.1
    link: /rl10/reference/10.5.1/rl10_managed_ssh_login.html
---
## Overview

With RightLink v10.5.0 and above, Managed Login for Linux based systems has been completely revamped. Users with the [*server_login*](/cm/ref/user_roles.html#-server_login) role can log into running servers with key-based SSH connections. Users who also have the [*server_superuser*](cm/ref/user_roles.html#-server_superuser) role can run sudo. The two login names available to users are the [*RightScale generated default login name*](#login-names-rightscale-generated-default-login-name) and a [*user definable custom login name*](#login-names-user-definable-custom-login-name).

## Enabling Managed Login

Enabling the 'Managed Login' feature is done by running the RL10 Linux Enable Managed Login RightScript ([Github](https://github.com/rightscale/rightlink_scripts/blob/master/rll/enable-managed-login.sh), [MultiCloud Marketplace](http://www.rightscale.com/library/right_scripts/RL10-Linux-Enable-Managed-Logi/lineage/59044)).

## Installed and Configuration files

Managed Login uses these commonly used standard Linux components: PAM, NSS, sudo, and OpenSSH.

Configuration of these components entails the following files:

Files | Format | Purpose |
----- | ------ | ------- |
/etc/ssh/sshd_config | SSHD config file | Configuration file updated to use /usr/local/bin/rs-ssh-keys.sh to obtain a user's ssh public key for key-based authentication. |
/usr/local/bin/rs-ssh-keys.sh | bash script | Custom open-source script that obtains a user's public key set in the RightScale Dashboard. This script is used in /etc/ssh/sshd_config. The script can be found in the [rightscale/rightlink_scripts repository](https://github.com/rightscale/rightlink_scripts) as [rs-ssh-keys.sh](https://github.com/rightscale/rightlink_scripts/blob/master/rll/attachments/rs-ssh-keys.sh). |
/etc/sudoers.d/90-rightscale-sudo-users | Sudo config | Configuration file enabling users with *server_superuser* role the ability to run sudo. |
/etc/pam.d/sshd | PAM config | Configuration file updated to use the pam_mkhomedir PAM module to create user's home directory at successful login. |
/etc/nsswitch.conf | NSS config | Name Service Switch configuration file updated to use RightScale's custom NSS module providing user and group information to the OS. |
/usr/local/lib/libnss_rightscale.so.2.0.0<br>*/usr/local/lib/libnss_rightscale.so.2*<br>*/usr/local/lib/libnss_rightscale.so* | NSS binary module | RightScale's custom NSS module to provide RightScale user and group information to the OS. This module is used in /etc/nsswitch.conf. The source code is available in the [rightscale/libnss-rightscale repository](https://github.com/rightscale/libnss-rightscale). |
/var/lib/rightlink/login_policy | Login Policy File | Generated file read by the custom NSS module, rs-ssh-keys.sh, and sshd_config. |
/var/lib/rightlink_keys | SSH Keys Directory | Ubuntu 12.04 has a version of OpenSSH that does not support the feature to use rs-ssh-keys.sh. In this case, this directory is created and used by sshd_config. A file is created in this directory for every user with the 'server_login' role, containing their public key. |

## Login Names

RightScale users with the [*server_login*](/cm/ref/user_roles.html#-server_login) role can log into an instance using either the *RightScale generated default login name* or their *user definable custom login name*. Both of these login names are mapped to the same Linux user ID (UID). Login names are defined under SSH settings, found in the RightScale UI: Settings\User Settings\SSH.

!!info*Note:* In order to allow users to manage their own SSH key pairs [Mandatory Server Login Control](/cm/dashboard/settings/account/enable_mandatory_server_login_control.html) must be enabled for the account.

### RightScale generated default login name
The default login name is generated for each user using the following pattern: `rightscale{RightScale_ID_Num}`. For example, your RightScale ID might be 123456 so you would have the login name `rightscale123456`.

### User definable custom login name

Optionally, you can set a custom login name using the edit button with the following requirements:
* must be globally unique to the RightScale platform
* must be made up of only lower case letters, numbers, dashes, and underscores with the first character being a lowercase letter
* must be a minimum length of 3 characters and a maximum length of 32 characters
* must not be in the [list of disallowed login names](rl10_disallowed_login_names.html)

If any of these restrictions are not met, an error message will present the issue. You can remove the custom login name by removing all characters from the "Custom Login Name" field and hitting save.

!!info*Note:* If a custom login name conflicts with an already existing username on the operating system, this conflict will be logged into Audit Entries and stating that the existing username may take authentication priority. The solution would be to use the default login name or change the custom login name that is in conflict.

!!info*Note:* Changing of custom login names, updating of public keys, and role updates are not immediatly available to every server in a RightScale account.  Please allow 5-10 minutes for updates to propagate across all servers.  Audit entries can be reviewed to check for updates on specific servers.

## Home Directories

User home directories are created at SSH login if they do not exist. The location of a user's home directory is `/home/rightscale{RightScale_ID_Num}`, matching the default login name.  Regardless of what login name is used, this will always be the user's home directory.

## 'sudo' permission

RightScale users with both [*server_login*](/cm/ref/user_roles.html#-server_login) and [*server_superuser*](cm/ref/user_roles.html#-server_superuser) roles are given the ability to run `sudo` commands on the instance. By default configuration, ALL commands are available via 'sudo' to users with *server_superuser* role.

## Managing User Roles

Managing user roles is done in the RightScale UI. For more information on managing user roles, please see [RightScale Account and User Role Management](/cm/rs101/rightScale_account_and_user_role_management.html).

## Known Limitations

Currently the Managed Login feature is not supported on CoreOS. This is due to an issue with PAM in the "stable" releases.

