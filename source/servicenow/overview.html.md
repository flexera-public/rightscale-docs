---
title: RightScale Application for ServiceNow
description: RightScale provides a certified integration for ServiceNow that brings the cloud management capabilities of RightScale together with the ITSM features of ServiceNow.
alias: ss/guides/sn_integration_overview.html
---

## Overview

RightScale provides a certified integration for [ServiceNow](http://www.servicenow.com/) that brings the cloud management capabilities of RightScale together with the ITSM features of ServiceNow. The integration is available by [downloading from our releases page](/servicenow/releases.html). It provides features for maintaining the ServiceNow CMDB using cloud information from RightScale and provides various integration points that can be leveraged in ServiceNow to launch infrastructure in RightScale.

See [frequently asked questions here](faq.html).

## How It Works

### Prerequisites

The only prerequisite is to have at least one RightScale account connected to your cloud(s) of choice. No additional ServiceNow modules are required to leverage the functionality of this application.

### Features

#### CMDB Integration

This application helps populate your ServiceNow CMDB by querying the RightScale API for information about resources running in the cloud. The data is placed into Import Sets which you can then use to populate your CMDB. The information provided by this application is listed below.

Note that you can use the [ServiceNow Discovery](http://www.servicenow.com/products/discovery.html) tool in conjunction with this integration to provide additional information about your instances. There is no direct integration between this information and the Discovery information, but the IP Address of the instance can be used to correlate the information in your CMDB.

**Instances**

Instances represent any instance that is running in the cloud account, regardless of how it was launched. Note that not all fields will be available for all instances depending on how the instance is configured.

* account
* cloud_id
* cloud_name
* datacenter_name
* deployment (if the instance belongs to a RightScale deployment)
* description
* href (unique RightScale ID)
* image_name
* instance_type_name
* ip_addresses
* links (links to related RightScale resources)
* mci_name (if the instance was launched from a ServerTemplate)
* name
* network_names
* private_dns_names
* private_ip_addresses
* public_dns_names
* public_ip_addresses
* resource_uid
* security_group_names
* server_template_name (if the instance was launched from a ServerTemplate)
* server_template_version (if the instance was launched from a ServerTemplate)
* ssh_key
* state
* subnet_names
* tags
* uid (unique cloud ID)

**Servers**

Servers represent servers that are launched through RightScale or that are RightScale-enabled by installing the [RightLink](/rl) agent.

* account
* cloud_id
* cloud_name
* deployment_id
* description
* href
* id
* links
* name
* server_template_id
* server_template_name
* state
* tags

**ServerArrays**

* account
* cloud_id
* cloud_name
* deployment
* description
* href
* id
* instance_summary
* links
* name
* state
* tags

**Deployments**

* account_id
* account_name
* description
* href
* id
* links
* name
* tags

**Applications**

Applications represent items from a Self-Service Catalog.

* account_id
* href
* id
* name
* parameters
* required_parameters
* schedule_required
* schedules
* short_description

**Executions**

Executions represent a CloudApp instance in Self-Service.

* account_id
* application
* cost_unit
* cost_value
* created_by
* created_at
* deployment
* description
* href
* id
* launched_from_href
* launched_from_name
* launched_from_type
* links
* name
* status
* terminated_at

#### Self-Service Application Launching

The application also provides all of the necessary components to launch infrastructure through RightScale's [Self-Service](/ss) product and its associated CAT file language. This language provides a powerful tool to encapsulate application definitions that is portable across clouds. These "Applications" can be made available in the ServiceNow Service Catalog and launched through ServiceNow.

## Getting Started

Download and install the RightScale-provided Update Set from our [releases page](/servicenow/releases.html).

### Account Setup

The RightScale integration for ServiceNow connects to your RightScale accounts to gather information about what is running in your clouds and to provide an interface for you to launch new infrastructure. In ServiceNow, you will have to configure every RightScale account that you want integrated with ServiceNow.

1.  In ServiceNow, navigate to the RightScale application and select Accounts under the Configuration menu.
2.  Click the "New" button and fill out the form.
    1.  This information can be obtained by logging in to your RightScale account and navigating to Settings -> Account Settings
    2.  The account_id is the numeric part of the “href” field
    3.  The refresh_token can be obtained on the same page by clicking on “API Credentials” and enabling refresh tokens
    4.  The endpoint is the host name in the browser (either https://us-3.rightscale.com or https://us-4.rightscale.com)
    5.  The ss_endpoint is the same as the endpoint, with “us” replaced by “selfservice” (either https://selfservice-3.rightscale.com or https://selfservice-4.rightscale.com)
    6.  Confirm that the account name shows up in the Accounts table within about one minute by refreshing the list. If it doesn't, there is likely a problem with the information that you entered and you should verify all input values
    7.  Repeat steps 1-5 for all RightScale accounts you would like connected

### Configuring integration schedules

The RightScale integration uses Scheduled Jobs to periodically poll the RightScale API and gather information about running infrastructure. The following settings will ensure that this is configured as you want it.

1.  In ServiceNow, navigate to the RightScale application and select Settings under the Configuration menu.
2.  Set the interval for each type of resource that will be updated in your CMDB
3.  In ServiceNow, navigate to the RightScale application and select Scheduled Jobs under the Source Code menu.
4.  Make sure all Scheduled Jobs are active
    1.  If a Scheduled Job is not active, select the job to edit it and select the Active checkbox

### Configure permissions

The RightScale integration contains pre-built roles that you can use to give your ServiceNow users access to the resources in the integration. Use the roles as follows:

* x_snm_rightscale_c.user - Intended for end users and provides read access to application resources and accounts table
* x_snm_rightscale_c.admin - Intended for end users and provides full application permissions. Note that system admin role for ServiceNow will also be required to fully change all settings associated with the application, or any custom role that has the required privilege to modify system settings.
* x_ris_rightscale_c.app_role - An integration user that can setup account integrations with RightScale and import data into the import sets and tables, but does not have the full rights that are granted to the admin role described above. It is recommended to use this role with any integration accounts within ServiceNow that are used only to configure the integration with RightScale.

## Customizing the integration

### Create Transform Maps

The RightScale integration imports data from RightScale into Import Sets - from there, Transform Maps are used to transform the data into CMDB tables. While the integration provides some basic Transform Maps that places data in the tables inside the Application, you likely want to transform the data into your own system CMDB tables.

For more information on creating Transform Maps, reference the ServiceNow documentation: [http://wiki.servicenow.com/index.php...Transform_Maps](http://wiki.servicenow.com/index.php?title=Creating_New_Transform_Maps "http://wiki.servicenow.com/index.php?title=Creating_New_Transform_Maps")

For more information on the Import Set tables made available in the RightScale integration, [see below](#integration-components-web-services--import-sets-)

<!-- ### Creating custom Catalog Items

The RightScale integration provides all of the component pieces necessary to create Catalog Items that launch and manage Self-Service Cloud Applications. You can find more information about RightScale Self Service [on this docs site](/ss/guides).

One common use of Self-Service CloudApps is to display them as Catalog Items in your Service Catalog in Self-Service. Future versions of this application will include auto-generated Catalog Items from application definitions, but in the meantime you can choose which CloudApps are available in your Service Catalog by following these steps:

1. Copy the generic Service Catalog Item included with the integration and change the name of the item
2. Select which Category in the SN Service Catalog you would like this item to be shown in (if any)
 -->

## Troubleshooting the integration

The RightScale integration provides a link to the Application Logs under the Support menu. The information in these logs can usually help identify potential issues and resolutions. In the event that you experience issues that you can't resolve, please contact RightScale support through the usual channels (such as [support@rightscale.com](mailto:support@rightscale.com "mailto:support@rightscale.com")).

## Integration Components

This section describes each component of the RightScale integration. All components can be found in the RightScale CloudManagement category on the left-hand navigation bar in ServiceNow.

### Configuration

Contains configuration items for the application, accessible by an administrator to customize the behavior and control the access to the application.

#### Accounts

This table contains all of the RightScale accounts that you have configured to use the RightScale integration.For every RightScale account that you want to use with ServiceNow, you must create an entry in this table. Each entry contains the information required to connect and authenticat to the RightScale system.

#### Roles

Permissions on objects in the RightScale application are scoped to the roles defined in this table, which are scope to the RightScale application. The table here is similar to what you would see by filtering the system table 'sys_user_role' on this application.

#### Permissions

Provides a list of granted permissions in the scope of this application -- this is similar to filtering the system table 'sys_security_acl' by this application and provides an easy way to find permissions granted to app roles in the scope of this application.

#### Users

List of App users. Since all users in SN are 'system' and have been created in the system table 'sys_user' this list shows users whose 'User ID' starts from prefix 'rightscale_'. Since user is not belongs to the particular app it can't be published with it. So see 'Steps to create a dedicated integration user' to add a new user which could be used to push new resources to Import sets tables.

#### Settings

This is a System Property Category with four system properties inside. It could be managed through Support -> Settings Manager interface.

### Resources

The following CMDB tables are provided by default and are populated from the Import Sets listed in the Web Services section by a default transform map. Each table contains all of the information that is imported into ServiceNow by the integration.

#### Applications

Applications represent Cloud Applications that have been published the Service Catalog in RightScale Self-Service.

#### Deployments

Deployments are a basic RightScale construct to logically group together a set of cloud resources that make up an application running in the cloud.

#### Instances

Instances are discovered running across all clouds for all configured RightScale accounts. They can include instances from clouds, virtual infrastructure, or dedicated hardware. Some Instances are launched by RightScale, such as those launched by Servers, Arrays, or CloudApps. Others are launched outside of RightScale, but detected by the RightScale platform.

#### Servers

Servers represent  the RightScale construct for a cloud-based or virtual server. Servers contain configuration items, monitoring information, alerts, and more. When a Server is launched, an instance is created in the corresponding cloud.

#### Executions

Executions represent running Cloud Applications in RightScale Self-Service. Each Execution is linked to a single Deployment which contains all of the resources defined and in use by a Self-Service Cloud Application.

### Source Code

#### Business Rules

A list of Business Rules in scope of the RightScale Cloud Management application. Only one Business Rule is included which is used for populating account information during Account registration.

#### REST Messages

A set of REST messages that are in use by other components in the RightScale Cloud Management application. These messages can also be used in custom workflows to provide additional functionality on top of that provided by the application.

#### Scheduled Jobs

The Scheduled Jobs listed for this application are used to periodically poll the RightScale API and import information into the Import Sets. Each job should be marked "active" during installation and is configured to run once a minute. Every time the jobs run, they check the configured times in the Settings to determine if information should be updated.

#### Service Catalog Items

Contains a sample catalog item which can be used to launch a RightScale Self-Service Cloud Application. This item can be copied and configured for each Application in order to provide users the ability to launch CloudApps through Self-Service.

#### Scripts

Contains a set of library JavaScript classes that are used in other parts of the application. These libraries are used for tasks such as communicating with and parsing results from the RightScale API.

#### Workflows

A set of workflows that are both used in other parts of the application and that can be leveraged for custom behavior.

### Web Services (Import Sets)

The Import Sets listed in this category are populated by the Scheduled Jobs. Each Import Set includes a default Transform Map which maps elements to the included CMDB tables in the Resources section of the application.

#### Inbound Applications

The import set used to import all Applications from your RightScale Self-Service accounts. Note that this contains only Applications that have been published to the Catalog, not all CAT templates that are in Designer

#### Inbound Deployments

The import set used to populate all Deployments across your configured RightScale accounts.

#### Inbound Instances

The import set used to import all instances discovered in across all clouds that are connected to all of the RightScale accounts that you’ve configured

#### Inbound Servers

The import set which contains all of the RightScale Servers discovered across all of the RightScale accounts that you’ve connected

#### Inbound Executions

The import set which contains all of the running CloudApps in Self-Service across the RightScale accounts that you’ve configured

### Support

This category contains support-related information that can be used by both admins and end users to get help regarding this application.

#### Application Logs

This is a shortcut to view logs related to this application -- it is the same as System logs -> System Log -> Application logs but filtered by Source filed where Source is a application scope name 'x_snm_rightscale_c'. This log contains messages posted by application scripts. In other words contains messages explicitly added by typing "gs.info(message)". All other messages from Scheduled jobs, Transformation maps etc could be found in the system log (System logs -> System Log -> All).

#### Documentation

Links to this page on the RightScale support site.

#### RightScale Support

Links to a page containing RightScale Support information in case of issues.

#### Settings Manager

This is an admin interface for adding new or changing existing settings. The application includes four settings which are used for managing the scheduled jobs intervals.
