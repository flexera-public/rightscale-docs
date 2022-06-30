---
title: Guide for Evaluating Microsoft Azure
layout: azure_layout_page
description: The purpose of this evaluation guide is to show the power of combining the IaaS features and functionality of the Microsoft Azure cloud with RightScale Cloud Management to manage all of your cloud infrastructure with a single, integrated solution.
---

## Purpose of the Evaluation Guide

The purpose of this evaluation guide is to show the power of combining the IaaS features and functionality of the Microsoft Azure cloud with RightScale Cloud Management to manage all of your cloud infrastructure with a single, integrated solution.

## Audience

In general, readers of this evaluation guide fall into one of the following two groups:

* **New Microsoft Azure users and New RightScale users** - if you are new to Microsoft Azure and new to RightScale, we recommend that you read the entire evaluation guide to gain a more complete understanding of the Microsoft Azure + RightScale solution.
* **New Microsoft Azure users but experienced RightScale users** - If you are new to Microsoft Azure but have some experience with RightScale, feel free to skip the Introduction to RightScale and Register for a RightScale Account sections.

## Overview

Microsoft Azure is Microsoft's application platform for the public cloud - it is the development, service hosting, and service management environment for the Microsoft Azure platform. It provides developers with on-demand compute, storage, bandwidth, content delivery, middleware, and marketplace capabilities to build, host, and scale web applications through Microsoft data centers.

Understanding the various components of Microsoft Azure is helpful when making decisions about how to build and manage your cloud and for seeing the value of using RightScale + Microsoft Azure for this purpose. The three main components of Microsoft Azure are Web Sites, Cloud Services, and Virtual Machines.

## Introduction to Microsoft Azure

Microsoft Azure is an open and flexible cloud platform that enables you to quickly build, deploy and manage applications across a global network of Microsoft-managed datacenters. Microsoft Azure is built to support open technologies with any OS, language, database, or tool. Comprehensive networking capabilities connect on-premise infrastructure to Azure as well as integrated IaaS and PaaS on a shared network. Microsoft offers rock solid service with a 99.95% monthly SLA and global footprint of 6 data centers.

## Introduction to RightScale

RightScale is the leading cloud management platform, supporting Microsoft Azure and a range of public and private clouds. RightScale has more than 50,000 users and has launched over 4 million servers including many of the largest production deployments and scaling events in public and private clouds.

RightScale provides complete lifecycle management for public and private cloud-based applications including provisioning, monitoring, configuration, automation, auditing, and governance. This enables efficient administration with a single view of multiple cloud accounts’ usage, resources, and role-based access controls. RightScale is a multi-cloud solution, making it easy to migrate workloads into and out of public and private clouds, with consistent governance, monitoring, and automation, and to construct hybrid and multi-data center environments for large organizations, distributed applications, and high availability. In addition, RightScale offers services including consultative support, business critical SLAs, onboarding services, and end-to-end engineering that has advised the cloud’s cutting edge deployments.

## Key RightScale Concepts

RightScale Cloud Management is the bridge between your applications and your cloud infrastructure. The MultiCloud Platform provides a universal remote to conveniently access your public, private, and hybrid cloud resource pools from one Dashboard and API. The Configuration Framework provides intelligent cloud blueprints to configure and operate your servers in a dynamic and completely customizable fashion. The MultiCloud Marketplace™ provides a one-stop shop of cloud-ready components. The Automation Engine gives you the power to provision, monitor, scale, and manage entire server deployments efficiently and reliably. Governance Controls allow you to keep watch over access, security, auditing, reporting, and budgeting through a “single pane of glass” view.

## Use Cases

### Windows-based

Microsoft Azure provides extensive support for .Net, IIS, SQL Server, Active Directory, and other Windows-based applications.

### Highly available

Microsoft Azure offers a global footprint of data centers that the offer geographic coverage, redundancy, and capacity to host mission critical, highly available applications.

### Highly scalable

From big data analytics to gaming, SaaS, and websites, Microsoft Azure is well suited to run highly scalable applications.

## MultiCloud Platform

RightScale Cloud Management enable management of all of your clouds — Microsoft Azure, other public clouds, and private clouds — and all of your resources — compute, storage, and networking. Cloud-specific differences are abstracted so you can focus on running your applications. All of your resources are in one place and are organized for ease with logical groups of servers called deployments. Provision, configure, and automate individual servers or entire deployments in minutes. All of your resources are accessible from the RightScale Dashboard and API.

## Configuration Framework

The RightScale configuration framework — the ServerTemplate™ — is the key to efficient, automated provisioning and operations on Microsoft Azure and other public and private clouds. ServerTemplates are built from modular images, scripts, and variable inputs. ServerTemplates are dynamic, provisioning your servers at boot time using your chosen configuration and variable inputs. Dynamic configuration ensures that your servers are provisioned in context — they automatically register with the correct load balancers and databases, begin backups with the proper frequencies and storage locations, and much more.

The modular and dynamic aspects of ServerTemplates enable them to be completely customizable, from the inputs all the way down to the images. Each element of a ServerTemplate is version controlled, providing reproducible behavior across time and infrastructure, so that you design once and then consistently deploy multiple times on multiple clouds. ServerTemplates abstract cloud-specific differences, ensuring consistent multi-cloud configuration across public, private, and hybrid cloud resource pools.

[![azure-config-framework-st.png](/img/azure-config-framework-st.png)

The RightScale MultiCloud Marketplace™ offers ServerTemplates™, scripts, and architectures published by RightScale, our partners, and our users. All of these pre-built configurations are fully customizable and provide a huge variety of solutions to get started. Swap scripts and recipes in or out and change default inputs and alerts. ServerTemplates and components published by RightScale are rigorously tested, version controlled, and backed by our support.

## Automation Engine

The RightScale automation engine provides powerful tools to make cloud resources efficient, elastic, and highly available. Keep tabs on your resources with granular Server and Application Monitoring. View entire systems of hundreds of servers with Cluster Monitoring. Link monitors to Alerts and Escalations that notify you of issues and automatically take action. Scale resources up and down according to your needs with Auto-Scaling Arrays. Stand up entire architectures using Deployment Orchestration. Perform Application and Database Automation with powerful tools such as tags and our customizable library of scripts.

## Governance Controls

Manage access and usage of cloud resources with a comprehensive set of RightScale governance controls. Control authentication, permissions, and credentials with the Access and Security Manager. Create secure environments for multiple teams with Enterprise Manager and Federated Identity. Resolve issues and trace events with Auditing.

## Services & Support

RightScale has been a provider of leading services and support for public and private clouds since 2006. RightScale offers a range of services to help you succeed, from do-it-yourself materials to white glove engineering. Onboarding services provide you with invaluable assistance getting cloud projects up and running on time. Round-the-clock support keeps your applications running. In-depth training offers insights into using RightScale, cloud-based applications, and adopting cloud best practices.

## Registration

### Create a Microsoft Azure Account

1. Log in to your Microsoft account. [https://login.live.com/](https://login.live.com/)
2. Sign-up for a Microsoft Azure account. [https://account.windowsazure.com/SignUp](https://account.windowsazure.com/SignUp)
3. Create a subscription for the required services. Click the **Sign up for a free trial** option and provide the required personal and billing information.
4. Click **add subscription**.

    [![azure-subscription.png](/img/azure-subscription.png)

5. At a minimum, please select the 'Pay-As-You-Go' option and purchase the subscription.
6. Click the **Portal** link. After going through the Microsoft Azure Tour, click on **Settings** in the left navigational pane. Later, when you add the cloud to a RightScale account, you will need to select the specific **Subscription ID** that you want to associate with your RightScale account.  

    [![azure-subscriptionID.png](/img/azure-subscriptionID.png)

7. In order for RightScale to control your Microsoft Azure subscription and assets, you must first create security credentials. Use the following link to download your subscription profile: [https://manage.windowsazure.com/publishsettings](https://manage.windowsazure.com/publishsettings).  
 _Note_: You must be logged in to the Azure console in order to download the publish profile.
8. Keep the file in a secure location as they serve as your credentials to administer on behalf of your subscriptions. You will need this file in order to add the cloud to a RightScale account.

### Add Microsoft Azure to your Account

#### Connect to a Cloud

1. After logging into the Dashboard, go to **Settings** > **Account Settings** > **Clouds.** Click **Connect to a Cloud.**

2. Next, click the (+) icon next to Microsoft Azure.

**NOTE**: Azure is a cloud with several regions which you can view by clicking the arrow next to its name in the "Connect to Public Clouds" box. For every region, you must register individually using the same Azure credentials. Only 5 regions can be added to a RightScale account. RightScale requires a virtual network for each region. By default Microsoft Azure subscriptions have a maximum of 5 virtual networks they can create. This means that only up to 5 regions can be added to RightScale by default. Please contact Microsoft to request more virtual networks in your subscription if needed.

![azure-connect-to-windows.png](/img/azure-connect-to-windows.png)

#### Upload Publish Profile

**NOTE** : Make sure you are signed up for [‘Virtual Machines & Virtual Networks’](http://support.rightscale.com/09-Clouds/Microsoft_Azure/Tutorials/Sign_up_for_Microsoft_Azure/index.html).

Next, upload your publish profile file.

#### Select a Subscription ID

1. Select a Subscription ID from the drop-down list. This lists all your Subscription IDs found at [https://account.windowsazure.com/Subscriptions](https://account.windowsazure.com/Subscriptions) when logged in.

2. Click on the ‘Subscriptions’ link at the top of your Microsoft Azure portal.

    **NOTE** : Azure does not currently support specifying the public IP space. They dynamically assign public IPs.

3. Click **Continue**.

**NOTE** : You are going to be registering a Microsoft Azure subscription where you will specify a virtual network and subnet where virtual machines launched via RightScale will be provisioned. If virtual networks already exist within this Microsoft Azure subscription you will be given the option to select a virtual network on the next page. If no virtual networks exist within this Microsoft Azure subscription, RightScale will create one on your behalf. When creating a subnet within that virtual network, we will use the private IP range specified in the Subnet Prefix field on the next page.

## Virtual Network

### No Existing Virtual Network

![azure-create-virtual-network.png](/img/azure-create-virtual-network.png)

**Subnet Prefix:** Specify a Private IP address range in CIDR format for the subnet that will be created on your behalf in Azure.

### Existing Virtual Network

If you have an existing virtual network, you must go back into the Azure portal and make sure there’s a subnet within the virtual network with same name as the virtual network itself.

- Navigate to Preview.
- Choose Networks on the left panel which will take you to Virtual Networks.
- Click on the name of your virtual network.
- Click Configure.

Add a subnet with the same name as the virtual network.

Once you have an existing virtual network and subnet, you will see the following screen:

![azure-select-network.png](/img/azure-select-network.png)

Select your virtual network and subnet and click **Continue**.

Once your cloud credentials have been verified, you will see that the Microsoft Azure cloud is enabled under the Clouds tab. You will now see all of your Microsoft Azure resources under the Clouds menu (Clouds _>_ Microsoft Azure). You may need to refresh the tab to view your newly added Azure cloud.

### Check the Cloud Status

On the same Clouds tab or on the Cloud Credentials widget in the Overview tab, you may check the status of your cloud. Both of these items must be valid and active (green) in order to successfully launch cloud servers:

![azure-cloud-credential-status.png](/img/azure-cloud-credential-status.png)

**NOTE** : RightScale could take several hours to discover the instance types before you can launch a server after initially adding a cloud.

## Introductory Lab

This introductory lab introduces some of the fundamental steps required for creating deployments and launching servers with RightScale + Microsoft Azure.

### Create a Deployment

Your deployment is the container for your servers. A deployment consists of a cluster or group of Servers that work together and share common Input variables and cloud configurations.

Before launching servers, you must create a deployment. To create a deployment:

1. Go to **Manage** > **Deployments**.
2. Click **New** and provide the following information:

- **Nickname** - User-defined name for the deployment.
- **Description** - A short, internal-only description of the deployment.

### Import a ServerTemplate

A ServerTemplate includes one or more MultiCloud Images that define an operating system and the supporting applications for the server. It is a collection of RightScripts or Chef recipes that install select applications and define configuration settings and other attributes. You can import ServerTemplates from the RightScale MultiCloud Marketplace.

To import a ServerTemplate:

1. Go to **Design** > **MultiCloud Marketplace** > **ServerTemplates**
2. Find and select the **Base ServerTemplate for Windows** ServerTemplate. Browse by categories, perform a keyword search, or use the filter options to find the correct ServerTemplate.
3. Click **Import**.

Once imported, the ServerTemplate and associated RightScripts are considered part of your "local" collection.

### Add a Server

Now that you have imported a ServerTemplate, you can add a server to your deployment using the imported ServerTemplate. To add a server to the deployment:

1. Go to your deployment ( **Manage** > **Deployments** > _your deployment_).
2. Click **Add Server** to add a server and select your cloud from the **Cloud** drop down menu
3. Select your imported ServerTemplate from **ServerTemplates in Your Account**.

Launch the server.

Check the events pane on the left for real time updates of your server's status.

## Server Management and Monitoring

The RightScale management platform offers options for managing and monitoring your servers after you launch them in Microsoft Azure. This section provides an overview of some of the available options.

### Inputs

Inputs are used to create easily customizable and reusable scripts. Inputs are variables within a script that allow you to substitute specific, user-defined values for the input when an associated script is run on a server. A ServerTemplate's **Inputs** tab shows all of the inputs declared in any of its scripts (RightScripts or Chef Recipes) located under its Scripts tab.

### RDP

You can use RDP to securely connect to servers in the cloud through the RightScale Dashboard. To connect to a server using RDP, go to _your deployment > server name >_ **RDP**

### Audit Entries

The **Audit Entries** tab shows a detailed, historical record for all server activity within a deployment. Audit entries are created for the vast majority of actions, such as launching and terminating instances, script execution, or performing database backups. These log files can be used for troubleshooting problems or tracking changes. To see an Audit Entry report, go to _your deployment_ > **Reports** > **Audit Entries.**

### Monitoring

The **Monitoring** tab ( **Manage** > **View Dashboard** > **Monitoring** ) displays real-time graphical data for all servers in your deployment. By default, the 'cpu-overview' and 'interface if_packets-eth0' graphs are displayed, which show you status of your server's resources and incoming/outgoing data (packet) traffic. You can view detailed graphs for individual servers as well, if those servers have monitoring enabled. Cluster Monitoring is also available and provides a simple and efficient means to browse through monitoring data for Deployments consisting of many Servers.

![azure-monitoring.gif](/img/azure-monitoring.gif)

### Deployment Budget Estimate Widget

The Deployment Budget Estimate Widget is s built-in widget that provides a budgetary breakdown of all deployments in the account. By default, the built-in widgets display on the **Overview** tab of the Dashboard ( **Manage** > **View Dashboard** > **Overview** ).

## Advanced Configuration

The advanced configuration options allow you to take full advantage of the management and monitoring capabilities of RightScale + Microsoft Azure. This section describes some of the advanced configuration options available in the RightScale Dashboard.

### Architecture Diagram

The following diagram shows the components that make up the 3-tier architecture for the RightScale + Microsoft Azure solution. The 3-tier architecture consists of your chosen DNS service, load balancers, application servers, database servers, and storage. Try building one yourself: [3 Tier Deployment with Microsoft Azure](http://support.rightscale.com/09-Clouds/Microsoft_Azure/Tutorials/3_Tier_Deployment_with_Microsoft_Azure/index.html).

![azure-3tier-diagram.png](/img/azure-3tier-diagram.png)

### Advanced Management Features

After your deployment is up and running, RightScale provides a set of advanced management features to help you monitor and manage your Microsoft Azure cloud. These advanced features are described here.

### User Management

RightScale user management features allow you to control access to your Microsoft Azure cloud and add or remove users as needed. RightScale has several types of users that are defined by their roles. RightScale administrators can assign the different roles to users, depending on each user's needs. This level of control adds flexibility and lets users collaborate on projects in RightScale and in your Microsoft Azure cloud.

### Governance and Control

Governance and control refers to the ability to view all cloud activities from a single dashboard with comprehensive audits and logs while controlling user access, server security, resource usage, and budgeting

You can decide how to control access to your cloud resources and how to govern changes, processes, and workflows. You can distribute control among deployments, accounts, or regions using a different administrator for each or centralize control and maintain it under one administrator, deployment, or account. Because you can structure your administration of RightScale and Microsoft Azure in whatever way best serves your business needs, we don't offer a step-by-step process for putting your governance and control systems in place. But for the purposes of this evaluation guide, the following example uses the enterprise account to demonstrate one method for using a centralized model.

#### Centralized Control Example (Enterprise Account)

Enterprise customers can create a 'master' enterprise account that acts as an umbrella account for all of its 'child' accounts. Use the master enterprise account to monitor the cloud related activity across all RightScale accounts in the enterprise. Each child account is essentially a separate RightScale account with its own credentials. Each enterprise can have up to four child accounts. If you require more than four child accounts, please contact [sales@rightscale.com](mailto:sales@rightscale.com).

The user who is given the 'enterprise_manager' user role will be responsible for managing all accounts of the enterprise.

![azure-enterprise.png](/img/azure-enterprise.png)

In the preceding diagram, Michael is the Enterprise Manager. He maintains that role across all accounts in his enterprise.He has access to both master and child accounts. Regardless of which account he is logged into and viewing, he has access to the Enterprise view under **Settings** > **Organization**.

The Enterprise view is where he can monitor and manage all activity within the Enterprise. He can track current run-rates, add/remove/modify user roles, and invite users across all accounts.

#### Enterprise User Roles

One additional role is available to the enterprise.

- **enterprise_manager** - Manages all accounts within the enterprise. Grants user role privileges across all accounts in the enterprise. Controls which child accounts have access to which sharing groups. The master enterprise account must have at least one 'enterprise_manager' user. An 'enterprise_manager' can also grant the same privileges to another user.

## Managing Permissions and Users

One of the core responsibilities of administrators is managing accounts, users, roles, and permissions. The terms 'accounts', 'user', and 'roles' are used in this evaluation guide and can cause some confusion. This section contains detailed descriptions of these terms and provides information about their appropriate usage/application.

### Accounts

Each user needs access to two types of accounts:

- **RightScale Account** - Create a RightScale Account to log in to the RightScale Dashboard and manage your Microsoft Azure cloud. Registration requires an email and password. To view information about your RightScale Account in the Dashboard, go to **Settings** > **Account**.  
 **Note** : Unless otherwise specified, the word 'account' in the documentation refers to your RightScale Account.
- **Microsoft Azure Account** - Before you can use the RightScale Dashboard to manage your server instances in Microsoft Azure, make sure you have valid Microsoft Azure credentials. You need to enter valid credentials into the Dashboard in order to launch and manage resources in your Microsoft Azure cloud through the RightScale Dashboard or API.

The following diagram shows three separate users. John set up the 'Site1.com' RightScale account and invited Ben (who has his own RightScale account) to be a user of the 'Site1.com' RightScale account. Ben set up his own RightScale account, which he's enabled to manage resources across multiple cloud providers. Greg is new to RightScale and has never set up his own RightScale account, however Ben invited him to be a user of his 'Site2.com' RightScale account.

![azure-account-model.png](/img/azure-account-model.png)

Keep in mind that a RightScale Account is separate from a Cloud Account. You can register multiple cloud accounts with a single RightScale account. However, you will be responsible for paying for all cloud and cloud-related cloud usage costs. If you are a paying customer of RightScale, your cloud usage costs are separate charges from your RightScale Edition subscription fee.

![azure-billing-model.png](/img/azure-billing-model.png)

### User

RightScale users are identified by their email address. Each user can have access to multiple RightScale Accounts. Create your own RightScale Account or accept invitations to be a user of other RightScale Accounts. To view information about your User settings across all of the RightScale accounts that you have access to, go to **Settings** > **User**.

In the diagram below, John Doe is identified as ['john@mysite.com](mailto:'john@mysite.com "mailto:'john@mysite.com")' in the RightScale platform. He currently has access to three RightScale Accounts and has different user role privileges in each of those accounts.

![azure-user.png](/img/azure-user.png)

In the RightScale system, your email address is used as your username or unique identifier and is also used in audit entries, changelogs, and histories to identify which user performed a particular action(s) within a RightScale Account. Therefore, it's important that login credentials (email/password) are never shared or used by multiple users because it will not be possible to track user actions in the Dashboard.

### Invite Users

Users with 'admin' user role privileges can send RightScale account invitations to other users. In order to invite a user to a RightScale account, you must send the invitation to the email address that the user will use to log into the RightScale Dashboard.

To send a RightScale account invitation, go to **Settings** > **Account Settings**. Under the **Invitations** tab, click the **Invite Users** button. Click the **Send Invitations** button to send an email invitation to each user. (A copy of the email invitation will also be sent to the owner of the RightScale account.) Invitations can be either temporary or permanent. Temporary invitations allow account admins to invite users to their account, but the invited user will be removed after a specified number of days.

**Note**: If you have a free RightScale account, you must grant each invited user 'admin' user role privileges.

The invitation link that users receive in email will expire in six days. If the user does not use the invitation to activate a RightScale account within that period, you must send a new invitation.

### Accept an Account Invitation

An invitation to a RightScale account sends an email from [root@rightscale.com](mailto:root@rightscale.com). If the email is not in the recipient's inbox, check the spam folder or perform a keyword search for 'rightscale' in your email.

To accept the account invitation, click on the validation link in the email. Once you are logged into the Dashboard, you'll need to click the **Accept Invitation** button.

## Managing your RightScale Account

If you are an 'admin'user of a RightScale account, you can use the various user roles to control the permissions of all invited users in order to manage their level of access and functionality. Only 'admin' users can send account invitations. If you are an 'admin' user, you must specify a user's roles before sending an account invitation. Later, you can change a user's roles under the **Settings** > **Account Settings** > **Users** tab.

**Note** : Only an 'admin' user can revoke another user's 'admin' privileges.

It's important that you never share the email/password that you use to log into the RightScale Dashboard. For example, if an account (e.g. 'Site1.com') has multiple users, each user should create a unique RightScale account. Later, the 'admin' user of the 'Site1.com' account can invite additional users to that account. This is the only way that you can have user accountability within an account. If you share the same email/password with multiple users, there is no way to determine who launched or terminated a server. It's important that each action can be attributed to a single user.

## User Roles

To view your own user role privileges across all of your accounts, go to **Settings** > **User** > **Info**. Remember, user roles are account-specific. The following is a list of available roles and a brief description of what each role can do in the RightScale Dashboard.

**admin:** Administrative control of the RightScale Account.

**actor:** Ability to manage all cloud related activity.

**observer:** Ability to view the RightScale account.

**designer:** Ability to create ServerTemplates, RightScripts, and Macros. Ability to view local object collections under the Design menu.

**library:** Ability to import objects from the MultiCloud Marketplace to your local view (collection). The ability to view the MultiCloud Marketplace requires the 'designer' role.

**security_manager:** Ability to create a cloud Security Group and modify an existing Security Group's port permissions. Ability to view and generate Infrastructure Audit Reports.

**server_login:** Ability to log into servers.

**publisher:** Ability to create sharing groups and share RightScale objects (ServerTemplates, RightScripts, and Macros) with other users.

**enterprise_manager:** (Enterprise only) Manages all accounts within the enterprise. Send account invitations and grant user role privileges across all accounts in the enterprise.

**ca_user:** Ability to view billing information.

## Server Roles

Sometimes the word 'role' refers to a server's role or configuration. For example, when you launch an instance on a cloud you are provisioning a "blank" piece of hardware that you can configure to fulfill a specific type of server role. Additionally, you can use different ServerTemplates to configure instances to fulfill certain roles such as dedicated load balancers, application servers, database servers, etc.

![azure-server-roles.png](/img/azure-server-roles.png)

## Collaboration

RightScale gives you a single pane of glass to manage your Microsoft Azure cloud which makes collaboration across teams and regions easy and effective. Instead of using multiple tools or systems to manage cloud assets, using the RightScale cloud management platform enables you to see everything in one place. You can manage public clouds, private clouds, and hybrid clouds across geographies and time zones under one platform.

## SAML

Security Assertion Markup Language (SAML) is an XML standard used to authenticate users from an Identity Provider (IdP) to a software provider. SAML allows a user to log on once to a site (an IdP) and have access granted to affiliated websites. In conjunction with our provisioning API, this functionality enables you to authenticate and synchronize with existing identity stores.

RightScale is enabling SAML 2.0-based Single Sign-On (SSO) functionality for Enterprise Plan customers who request this feature. This, combined with our provisioning API, allows for full identity federation including syncing with Active Directory. In addition, we have tested this functionality with our partners Okta and PingIdentity so that you can use their (and similar) SaaS-based Identity Provider.

## OAuth

OAuth-compatible authentication and authorization supports a password-less Dashboard user that can login to the API and make authenticated requests. This feature is currently in public beta. Please contact support with any issues. You can enable OAuth by going to **Settings** > **Account Settings** > **API Credentials**. Here you can obtain an API access token which allows you to make changes without logging in.

## Microsoft Active Directory Integration

RightScale supports Microsoft Active Directory (AD) integration by allowing you to launch Windows AD domain controllers in public or private clouds using the Microsoft Active Directory ServerTemplate.

## Conclusion

Using RightScale to manage your Microsoft Azure cloud gives you maximum control and flexibility by integrating all of your cloud management into one interface. Using Microsoft Azure with RightScale provides you with the following benefits:

- Manage your entire Microsoft Azure cloud infrastructure with a single, integrated solution using RightScale.
- Use RightScale abstraction with customization so you can focus on your applications running in Microsoft Azure rather than on administration.
- Automate deployment and management of cloud resources.
- Build and manage your cloud by leveraging the expertise of both the RightScale and Microsoft Azure teams.
- Provision and monitor your servers in the Internet-scale hosting environment provided by Microsoft Azure, using RightScale as a "single pane of glass" management interface.

## Support

Contact RightScale Support at [support@rightscale.com](mailto:support@rightscale.com).
