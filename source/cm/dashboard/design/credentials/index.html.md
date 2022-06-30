---
title: Credentials
layout: cm_layout
alias: cm/dashboard/design/credentials/credentials.html
description: Credentials in the RightScale Cloud Management Dashboard provide an efficient way of passing sensitive information (logins, passwords, etc.) to multiple servers.
---

## Overview

**Credentials** provide an efficient way of passing sensitive information (logins, passwords, etc.) to multiple servers. Once a credential is created, it can be used to define input values. In order to create a new Credential you will need 'designer' user role privileges. Only users with 'admin' or 'credential_viewer' privileges will be able to view the stored value of a Credential.

Servers are often launched with software that requires credentials in order to access certain resources, such as your code repositories (GIT/SVN). Any type of sensitive information should be stored as a credential because the stored information will be encrypted and will not be retrievable through the web interface. Access Credentials by going to **Design** > **Credentials**

![cm-credentials-index.gif](/img/cm-credentials-index.gif)

!!info*Note:* The Credentials Store is separate from your individual cloud credentials and RightScale account information (Settings > Account).

## Create a New Credential

Credentials are a great way to protect sensitive information such as login and passwords. They also are very easy to use when setting up your Server Deployments later. If named descriptively, you no longer need to remember every login and password, you simply select them from a drop down menu when setting your Input parameters. Use the following procedure to create a new credential in the RightScale credential store.

### Steps

1. Go to **Design** > **Credentials**
2. Click **New Credential**

Provide the following information for each credential.

- **Name** - A short nickname that helps you recognize the credential.
- **Value** - Copy and paste the value that you would like to save for this credential.
- **Description** - A short description about the credential (for internal use only).

## Further Reading

* [RightScale Credentials Best Practices](http://blog.rightscale.com/2012/09/20/rightscale-credentials-best-practices/)

## Related FAQs

* [How do I use Amazon IAM with RightScale?](/faq/How_do_I_use_Amazon_IAM_with_RightScale.html)
* [How does RightScale store my credentials?](/faq/clouds/vmware/How_does_RightScale_store_my_credentials.html)
