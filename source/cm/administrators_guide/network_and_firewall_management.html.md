---
title: Network and Firewall Management
layout: cm_layout
description: Overview of the RightScale Firewall and Network Management capabilities including best practices and utilizing Private Clouds in RightScale.
---

## Network Firewall Settings

### Who should be given the 'security_manager' user permission?

Make sure only trusted users are granted the 'security_manager' user role permission.

* **'security_manager'**  

Ability to manage network and firewall permissions that are used by instances in the cloud. You will need this permission in order to create security groups and define individual firewall rules within those security groups. You will also need this permission in order to create Virtual Private Clouds (VPCs) and subnets. Only trusted users should be granted this permission. You will also be able to view and generate Infrastructure Audit Reports.

**Warning!** A user with this permission can affect firewall permissions of running instances. For example, any changes to an EC2 security group will instantly take effect on any running instances that are using that particular security group. For security reasons, you may want to create all of the required security groups and related firewall port permissions for each RightScale account beforehand so that the users who are configuring and launching servers in the account will already have the necessary network settings pre-configured and available for use. You may also find it useful to use Server Defaults to pre-select the desired security groups on a per cloud basis. See [Should I set default configurations for servers?](user_and_account_management.html)

Remember, you can also grant temporary access (by day) to a user and give them the 'security_manager' role if it is required for an initial setup but not for perpetuity.

### Should I create security groups that are specific for SSH/RDP access?

Before you can properly answer this question you must first determine how you want to grant SSH (Linux) or RDP (Windows) access within a RightScale account. There are several factors to take into consideration before you determine how the security groups should be configured across your account.

* Which users within a RightScale account should be allowed to create and manage security groups? Perhaps the leader of each team or maybe only the Operations team should have that ability. Remember, if a user has the 'security\_manager' user role, he/she can create firewall rules at anytime to allow/deny remote access.
* Should security groups be defined on a per project/deployment basis or account-wide? For example, if you are deploying multiple applications within the same RightScale account, you may want to empower each engineering team to manage their own security group and set up their own SSH/RDP firewall rules. Or maybe you want to create a global 'SSH/RDP' security group that everyone has to use instead.
* How many clouds will be used in the account? Remember, security groups are cloud-specific resources. Therefore, you'll need to duplicate your security group settings across all clouds into which you're going to deploy applications.
* One of the key benefits of using an account-wide security group is that it will be easier for you to manage SSH access across all deployments in your account. Since you'll only have to manage a single SSH/RDP security group in each cloud that you're using, it will be relatively easy to change your firewall rules at anytime to either allow/deny remote access.
* If you do not want your users to create and/or modify their own security groups and related firewall permissions, someone will need to create the appropriate security groups for their use in advance.
* To encourage users to always use the correct security group for granting remote SSH/RDP access, you can use [Server Defaults](/cm/rs101/server_defaults.html) at either the deployment or account level to make sure that the appropriate SSH/RDP security groups are automatically pre-selected for users when they either add a new server or server array to a deployment.
* Use tier-specific security groups for more granular control of remote access. For example, you may have more strict SSH/RDP firewall rules for the database tier than at the load balancer tier.

Several different examples of how you can set up security groups in your account for granting remote SSH/RDP access are shown below. Each configuration has its own advantages and disadvantages, and requires varying degrees of maintenance depending on who has the ability to manage security groups within an account. If you're using multiple RightScale accounts for your organization it's also important to remember that each account is unique so you might not want to use the same security group configurations across all accounts. Determine what's the right balance between control and security for each account and set up your security group access controls accordingly.

![cm-security-group-scenarios.png](/img/cm-security-group-scenarios.png)

### How can I check and manage security groups across an account for auditing purposes?

#### Infrastructure Audit Reports

*(For Amazon EC2 only)*

Any user with either 'admin' or 'security_manager' user role permissions can generate an infrastructure audit report to get a current snapshot of all firewall related permissions across all security groups\* within a RightScale account.

\* Currently, only EC2 security groups are evaluated at this time.

1. Go to **Reports > Infrastructure Audit**.
2. Click **Perform New Audit**. You can either generate a report that shows only publicly open ports or all ports.
3. Review the results and make sure there aren't any firewall rules that do not comply with your network access policies.

#### Network Maps

*(For Amazon EC2 only)*

Another great resource to getting a more visual representation of open ports across all security groups of a given cloud\* is the Network Maps feature.

\* Currently, only EC2 security groups are evaluated at this time.

1. Go to **Manage > Networks**.
2. Select a specific cloud/region.
3. Click the **Map** tab.
4. Review the results and make sure there aren't any firewall rules that do not comply with your network access policies.

![cm-network-map-example.png](/img/cm-network-map-example.png)

## Remote 'Root' Access

### How do I control who can SSH or RDP into running servers?

Please refer back to the [User and Account Management](user_and_account_management.html) section.

## Using Private Clouds with RightScale

### How do I connect my private cloud to RightScale?

​If you are setting up your own private cloud infrastructure (e.g. VMware vSphere or OpenStack) and want to manage it through RightScale's Cloud Management Platform, you will need to set up your network to allow the necessary communication between RightScale and your private cloud.

See [Firewall Configuration Ruleset](/faq/Firewall_Configuration_Ruleset.html).

## Next Steps

See [Monitoring and Alert Management](monitoring_and_alerts_management.html).
