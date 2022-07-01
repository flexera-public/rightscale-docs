---
title: Policy Template Language Permissions
description: The Policy Template Language allows you to specify needed permissions to run a given policy.
version_number: "20180301"
comment: This file is auto-generated in the governance repo, please do not edit by hand.
alias: [policies/reference/v20180301/permissions.html]
versions:
  - name: "20180301"
    link: /policies/reference/v20180301/permissions.html
---

The following table lists all RightScale resources and actions that can be used in a policy template 
language [permissions](/policies/reference/policy_template_language.html#permissions) block.
The table also lists the least-privileged [RightScale role](/cm/ref/user_roles.html) that provides
the given [privilege](cm/ref/user_role_privs.html). Note that more powerful roles will generally grant 
privileges from less valuable roles. For example, actor will grant all observer privileges and admin 
will grant everything the actor and observer roles grant.


| Resource     | Action | Privilege | Role        |
|--------------+--------+-----------+-------------+
| rs_cm.account_groups | [rs_cm.index](http://reference.rightscale.com/api1.5/resources/ResourceAccountGroups.html#index) | cm:legacy:publisher | publisher|
| rs_cm.account_groups | [rs_cm.show](http://reference.rightscale.com/api1.5/resources/ResourceAccountGroups.html#show) | cm:legacy:publisher | publisher|
| rs_cm.accounts | [rs_cm.show](http://reference.rightscale.com/api1.5/resources/ResourceAccounts.html#show) | cm:legacy:observer | observer|
| rs_cm.alert_specs | [rs_cm.create](http://reference.rightscale.com/api1.5/resources/ResourceAlertSpecs.html#create) | cm:legacy:designer | designer|
| rs_cm.alert_specs | [rs_cm.destroy](http://reference.rightscale.com/api1.5/resources/ResourceAlertSpecs.html#destroy) | cm:legacy:designer | designer|
| rs_cm.alert_specs | [rs_cm.index](http://reference.rightscale.com/api1.5/resources/ResourceAlertSpecs.html#index) | cm:legacy:observer | observer|
| rs_cm.alert_specs | [rs_cm.show](http://reference.rightscale.com/api1.5/resources/ResourceAlertSpecs.html#show) | cm:legacy:observer | observer|
| rs_cm.alert_specs | [rs_cm.update](http://reference.rightscale.com/api1.5/resources/ResourceAlertSpecs.html#update) | cm:legacy:designer | designer|
| rs_cm.alerts | [rs_cm.destroy](http://reference.rightscale.com/api1.5/resources/ResourceAlerts.html#destroy) | cm:legacy:actor | actor|
| rs_cm.alerts | [rs_cm.disable](http://reference.rightscale.com/api1.5/resources/ResourceAlerts.html#disable) | cm:legacy:actor | actor|
| rs_cm.alerts | [rs_cm.enable](http://reference.rightscale.com/api1.5/resources/ResourceAlerts.html#enable) | cm:legacy:actor | actor|
| rs_cm.alerts | [rs_cm.index](http://reference.rightscale.com/api1.5/resources/ResourceAlerts.html#index) | cm:legacy:observer | observer|
| rs_cm.alerts | [rs_cm.quench](http://reference.rightscale.com/api1.5/resources/ResourceAlerts.html#quench) | cm:legacy:actor | actor|
| rs_cm.alerts | [rs_cm.show](http://reference.rightscale.com/api1.5/resources/ResourceAlerts.html#show) | cm:legacy:observer | observer|
| rs_cm.audit_entries | [rs_cm.append](http://reference.rightscale.com/api1.5/resources/ResourceAuditEntries.html#append) | cm:legacy:actor | actor|
| rs_cm.audit_entries | [rs_cm.create](http://reference.rightscale.com/api1.5/resources/ResourceAuditEntries.html#create) | cm:legacy:actor | actor|
| rs_cm.audit_entries | [rs_cm.detail](http://reference.rightscale.com/api1.5/resources/ResourceAuditEntries.html#detail) | cm:legacy:observer | observer|
| rs_cm.audit_entries | [rs_cm.index](http://reference.rightscale.com/api1.5/resources/ResourceAuditEntries.html#index) | cm:legacy:observer | observer|
| rs_cm.audit_entries | [rs_cm.show](http://reference.rightscale.com/api1.5/resources/ResourceAuditEntries.html#show) | cm:legacy:observer | observer|
| rs_cm.audit_entries | [rs_cm.update](http://reference.rightscale.com/api1.5/resources/ResourceAuditEntries.html#update) | cm:legacy:actor | actor|
| rs_cm.backups | [rs_cm.cleanup](http://reference.rightscale.com/api1.5/resources/ResourceBackups.html#cleanup) | cm:legacy:actor | actor|
| rs_cm.backups | [rs_cm.create](http://reference.rightscale.com/api1.5/resources/ResourceBackups.html#create) | cm:legacy:actor | actor|
| rs_cm.backups | [rs_cm.destroy](http://reference.rightscale.com/api1.5/resources/ResourceBackups.html#destroy) | cm:legacy:actor | actor|
| rs_cm.backups | [rs_cm.index](http://reference.rightscale.com/api1.5/resources/ResourceBackups.html#index) | cm:legacy:observer | observer|
| rs_cm.backups | [rs_cm.restore](http://reference.rightscale.com/api1.5/resources/ResourceBackups.html#restore) | cm:legacy:actor | actor|
| rs_cm.backups | [rs_cm.show](http://reference.rightscale.com/api1.5/resources/ResourceBackups.html#show) | cm:legacy:observer | observer|
| rs_cm.backups | [rs_cm.update](http://reference.rightscale.com/api1.5/resources/ResourceBackups.html#update) | cm:legacy:actor | actor|
| rs_cm.child_accounts | [rs_cm.create](http://reference.rightscale.com/api1.5/resources/ResourceChildAccounts.html#create) | cm:legacy:enterprise_manager | enterprise_manager|
| rs_cm.child_accounts | [rs_cm.index](http://reference.rightscale.com/api1.5/resources/ResourceChildAccounts.html#index) | cm:legacy:enterprise_manager | enterprise_manager|
| rs_cm.child_accounts | [rs_cm.update](http://reference.rightscale.com/api1.5/resources/ResourceChildAccounts.html#update) | cm:legacy:enterprise_manager | enterprise_manager|
| rs_cm.cloud_accounts | [rs_cm.create](http://reference.rightscale.com/api1.5/resources/ResourceCloudAccounts.html#create) | cm:legacy:admin | admin|
| rs_cm.cloud_accounts | [rs_cm.destroy](http://reference.rightscale.com/api1.5/resources/ResourceCloudAccounts.html#destroy) | cm:legacy:admin | admin|
| rs_cm.cloud_accounts | [rs_cm.index](http://reference.rightscale.com/api1.5/resources/ResourceCloudAccounts.html#index) | cm:legacy:observer | observer|
| rs_cm.cloud_accounts | [rs_cm.show](http://reference.rightscale.com/api1.5/resources/ResourceCloudAccounts.html#show) | cm:legacy:observer | observer|
| rs_cm.cloud_accounts | [rs_cm.update](http://reference.rightscale.com/api1.5/resources/ResourceCloudAccounts.html#update) | cm:legacy:admin | admin|
| rs_cm.clouds | [rs_cm.index](http://reference.rightscale.com/api1.5/resources/ResourceClouds.html#index) | cm:legacy:observer | observer|
| rs_cm.clouds | [rs_cm.show](http://reference.rightscale.com/api1.5/resources/ResourceClouds.html#show) | cm:legacy:observer | observer|
| rs_cm.cookbook_attachments | [rs_cm.create](http://reference.rightscale.com/api1.5/resources/ResourceCookbookAttachments.html#create) | cm:legacy:designer | designer|
| rs_cm.cookbook_attachments | [rs_cm.destroy](http://reference.rightscale.com/api1.5/resources/ResourceCookbookAttachments.html#destroy) | cm:legacy:designer | designer|
| rs_cm.cookbook_attachments | [rs_cm.index](http://reference.rightscale.com/api1.5/resources/ResourceCookbookAttachments.html#index) | cm:legacy:observer | observer|
| rs_cm.cookbook_attachments | [rs_cm.multi_attach](http://reference.rightscale.com/api1.5/resources/ResourceCookbookAttachments.html#multi_attach) | cm:legacy:designer | designer|
| rs_cm.cookbook_attachments | [rs_cm.multi_detach](http://reference.rightscale.com/api1.5/resources/ResourceCookbookAttachments.html#multi_detach) | cm:legacy:designer | designer|
| rs_cm.cookbook_attachments | [rs_cm.show](http://reference.rightscale.com/api1.5/resources/ResourceCookbookAttachments.html#show) | cm:legacy:observer | observer|
| rs_cm.cookbooks | [rs_cm.destroy](http://reference.rightscale.com/api1.5/resources/ResourceCookbooks.html#destroy) | cm:legacy:designer | designer|
| rs_cm.cookbooks | [rs_cm.follow](http://reference.rightscale.com/api1.5/resources/ResourceCookbooks.html#follow) | cm:legacy:designer | designer|
| rs_cm.cookbooks | [rs_cm.freeze](http://reference.rightscale.com/api1.5/resources/ResourceCookbooks.html#freeze) | cm:legacy:designer | designer|
| rs_cm.cookbooks | [rs_cm.index](http://reference.rightscale.com/api1.5/resources/ResourceCookbooks.html#index) | cm:legacy:observer | observer|
| rs_cm.cookbooks | [rs_cm.obsolete](http://reference.rightscale.com/api1.5/resources/ResourceCookbooks.html#obsolete) | cm:legacy:designer | designer|
| rs_cm.cookbooks | [rs_cm.show](http://reference.rightscale.com/api1.5/resources/ResourceCookbooks.html#show) | cm:legacy:observer | observer|
| rs_cm.credentials | [rs_cm.create](http://reference.rightscale.com/api1.5/resources/ResourceCredentials.html#create) | cm:legacy:actor | actor|
| rs_cm.credentials | [rs_cm.destroy](http://reference.rightscale.com/api1.5/resources/ResourceCredentials.html#destroy) | cm:legacy:actor | actor|
| rs_cm.credentials | [rs_cm.index](http://reference.rightscale.com/api1.5/resources/ResourceCredentials.html#index) | cm:legacy:observer | observer|
| rs_cm.credentials | [rs_cm.show](http://reference.rightscale.com/api1.5/resources/ResourceCredentials.html#show) | cm:legacy:observer | observer|
| rs_cm.credentials | [rs_cm.update](http://reference.rightscale.com/api1.5/resources/ResourceCredentials.html#update) | cm:legacy:actor | actor|
| rs_cm.credentials | [rs_cm.show_sensitive](http://reference.rightscale.com/api1.5/resources/ResourceCredentials.html#show) | cm:legacy:credential_viewer _OR_ cm:legacy:admin | credential_viewer|
| rs_cm.credentials | [rs_cm.index_sensitive](http://reference.rightscale.com/api1.5/resources/ResourceCredentials.html#index) | cm:legacy:credential_viewer _OR_ cm:legacy:admin | credential_viewer|
| rs_cm.datacenters | [rs_cm.index](http://reference.rightscale.com/api1.5/resources/ResourceDatacenters.html#index) | cm:legacy:observer | observer|
| rs_cm.datacenters | [rs_cm.show](http://reference.rightscale.com/api1.5/resources/ResourceDatacenters.html#show) | cm:legacy:observer | observer|
| rs_cm.deployments | [rs_cm.clone](http://reference.rightscale.com/api1.5/resources/ResourceDeployments.html#clone) | cm:legacy:actor | actor|
| rs_cm.deployments | [rs_cm.create](http://reference.rightscale.com/api1.5/resources/ResourceDeployments.html#create) | cm:legacy:actor | actor|
| rs_cm.deployments | [rs_cm.destroy](http://reference.rightscale.com/api1.5/resources/ResourceDeployments.html#destroy) | cm:legacy:actor | actor|
| rs_cm.deployments | [rs_cm.index](http://reference.rightscale.com/api1.5/resources/ResourceDeployments.html#index) | cm:legacy:observer | observer|
| rs_cm.deployments | [rs_cm.lock](http://reference.rightscale.com/api1.5/resources/ResourceDeployments.html#lock) | cm:legacy:actor | actor|
| rs_cm.deployments | [rs_cm.show](http://reference.rightscale.com/api1.5/resources/ResourceDeployments.html#show) | cm:legacy:observer | observer|
| rs_cm.deployments | [rs_cm.unlock](http://reference.rightscale.com/api1.5/resources/ResourceDeployments.html#unlock) | cm:legacy:actor | actor|
| rs_cm.deployments | [rs_cm.update](http://reference.rightscale.com/api1.5/resources/ResourceDeployments.html#update) | cm:legacy:actor | actor|
| rs_cm.deployments | [rs_cm.servers](http://reference.rightscale.com/api1.5/resources/ResourceDeployments.html#servers) | cm:legacy:observer | observer|
| rs_cm.identity_providers | [rs_cm.index](http://reference.rightscale.com/api1.5/resources/ResourceIdentityProviders.html#index) | cm:legacy:admin | admin|
| rs_cm.identity_providers | [rs_cm.show](http://reference.rightscale.com/api1.5/resources/ResourceIdentityProviders.html#show) | cm:legacy:admin | admin|
| rs_cm.images | [rs_cm.index](http://reference.rightscale.com/api1.5/resources/ResourceImages.html#index) | cm:legacy:observer | observer|
| rs_cm.images | [rs_cm.show](http://reference.rightscale.com/api1.5/resources/ResourceImages.html#show) | cm:legacy:observer | observer|
| rs_cm.inputs | [rs_cm.index](http://reference.rightscale.com/api1.5/resources/ResourceInputs.html#index) | cm:legacy:observer | observer|
| rs_cm.inputs | [rs_cm.multi_update](http://reference.rightscale.com/api1.5/resources/ResourceInputs.html#multi_update) | cm:legacy:actor | actor|
| rs_cm.instance_types | [rs_cm.index](http://reference.rightscale.com/api1.5/resources/ResourceInstanceTypes.html#index) | cm:legacy:observer | observer|
| rs_cm.instance_types | [rs_cm.show](http://reference.rightscale.com/api1.5/resources/ResourceInstanceTypes.html#show) | cm:legacy:observer | observer|
| rs_cm.instances | [rs_cm.create](http://reference.rightscale.com/api1.5/resources/ResourceInstances.html#create) | cm:legacy:actor | actor|
| rs_cm.instances | [rs_cm.index](http://reference.rightscale.com/api1.5/resources/ResourceInstances.html#index) | cm:legacy:observer | observer|
| rs_cm.instances | [rs_cm.launch](http://reference.rightscale.com/api1.5/resources/ResourceInstances.html#launch) | cm:legacy:actor | actor|
| rs_cm.instances | [rs_cm.lock](http://reference.rightscale.com/api1.5/resources/ResourceInstances.html#lock) | cm:legacy:actor | actor|
| rs_cm.instances | [rs_cm.multi_run_executable](http://reference.rightscale.com/api1.5/resources/ResourceInstances.html#multi_run_executable) | cm:legacy:actor | actor|
| rs_cm.instances | [rs_cm.multi_terminate](http://reference.rightscale.com/api1.5/resources/ResourceInstances.html#multi_terminate) | cm:legacy:actor | actor|
| rs_cm.instances | [rs_cm.reboot](http://reference.rightscale.com/api1.5/resources/ResourceInstances.html#reboot) | cm:legacy:actor | actor|
| rs_cm.instances | [rs_cm.run_executable](http://reference.rightscale.com/api1.5/resources/ResourceInstances.html#run_executable) | cm:legacy:actor | actor|
| rs_cm.instances | [rs_cm.show](http://reference.rightscale.com/api1.5/resources/ResourceInstances.html#show) | cm:legacy:observer | observer|
| rs_cm.instances | [rs_cm.start](http://reference.rightscale.com/api1.5/resources/ResourceInstances.html#start) | cm:legacy:actor | actor|
| rs_cm.instances | [rs_cm.stop](http://reference.rightscale.com/api1.5/resources/ResourceInstances.html#stop) | cm:legacy:actor | actor|
| rs_cm.instances | [rs_cm.terminate](http://reference.rightscale.com/api1.5/resources/ResourceInstances.html#terminate) | cm:legacy:actor | actor|
| rs_cm.instances | [rs_cm.unlock](http://reference.rightscale.com/api1.5/resources/ResourceInstances.html#unlock) | cm:legacy:actor | actor|
| rs_cm.instances | [rs_cm.update](http://reference.rightscale.com/api1.5/resources/ResourceInstances.html#update) | cm:legacy:actor | actor|
| rs_cm.ip_address_bindings | [rs_cm.create](http://reference.rightscale.com/api1.5/resources/ResourceIpAddressBindings.html#create) | cm:legacy:actor | actor|
| rs_cm.ip_address_bindings | [rs_cm.destroy](http://reference.rightscale.com/api1.5/resources/ResourceIpAddressBindings.html#destroy) | cm:legacy:actor | actor|
| rs_cm.ip_address_bindings | [rs_cm.index](http://reference.rightscale.com/api1.5/resources/ResourceIpAddressBindings.html#index) | cm:legacy:observer | observer|
| rs_cm.ip_address_bindings | [rs_cm.show](http://reference.rightscale.com/api1.5/resources/ResourceIpAddressBindings.html#show) | cm:legacy:observer | observer|
| rs_cm.ip_addresses | [rs_cm.create](http://reference.rightscale.com/api1.5/resources/ResourceIpAddresses.html#create) | cm:legacy:actor | actor|
| rs_cm.ip_addresses | [rs_cm.destroy](http://reference.rightscale.com/api1.5/resources/ResourceIpAddresses.html#destroy) | cm:legacy:actor | actor|
| rs_cm.ip_addresses | [rs_cm.index](http://reference.rightscale.com/api1.5/resources/ResourceIpAddresses.html#index) | cm:legacy:observer | observer|
| rs_cm.ip_addresses | [rs_cm.show](http://reference.rightscale.com/api1.5/resources/ResourceIpAddresses.html#show) | cm:legacy:observer | observer|
| rs_cm.ip_addresses | [rs_cm.update](http://reference.rightscale.com/api1.5/resources/ResourceIpAddresses.html#update) | cm:legacy:actor | actor|
| rs_cm.monitoring_metrics | [rs_cm.data](http://reference.rightscale.com/api1.5/resources/ResourceMonitoringMetrics.html#data) | cm:legacy:observer | observer|
| rs_cm.monitoring_metrics | [rs_cm.index](http://reference.rightscale.com/api1.5/resources/ResourceMonitoringMetrics.html#index) | cm:legacy:observer | observer|
| rs_cm.monitoring_metrics | [rs_cm.show](http://reference.rightscale.com/api1.5/resources/ResourceMonitoringMetrics.html#show) | cm:legacy:observer | observer|
| rs_cm.multi_cloud_image_matchers | [rs_cm.create](http://reference.rightscale.com/api1.5/resources/ResourceMultiCloudImageMatchers.html#create) | cm:legacy:designer | designer|
| rs_cm.multi_cloud_image_matchers | [rs_cm.destroy](http://reference.rightscale.com/api1.5/resources/ResourceMultiCloudImageMatchers.html#destroy) | cm:legacy:designer | designer|
| rs_cm.multi_cloud_image_matchers | [rs_cm.index](http://reference.rightscale.com/api1.5/resources/ResourceMultiCloudImageMatchers.html#index) | cm:legacy:observer | observer|
| rs_cm.multi_cloud_image_matchers | [rs_cm.rematch](http://reference.rightscale.com/api1.5/resources/ResourceMultiCloudImageMatchers.html#rematch) | cm:legacy:designer | designer|
| rs_cm.multi_cloud_image_matchers | [rs_cm.show](http://reference.rightscale.com/api1.5/resources/ResourceMultiCloudImageMatchers.html#show) | cm:legacy:observer | observer|
| rs_cm.multi_cloud_image_settings | [rs_cm.create](http://reference.rightscale.com/api1.5/resources/ResourceMultiCloudImageSettings.html#create) | cm:legacy:designer | designer|
| rs_cm.multi_cloud_image_settings | [rs_cm.destroy](http://reference.rightscale.com/api1.5/resources/ResourceMultiCloudImageSettings.html#destroy) | cm:legacy:designer | designer|
| rs_cm.multi_cloud_image_settings | [rs_cm.index](http://reference.rightscale.com/api1.5/resources/ResourceMultiCloudImageSettings.html#index) | cm:legacy:observer | observer|
| rs_cm.multi_cloud_image_settings | [rs_cm.show](http://reference.rightscale.com/api1.5/resources/ResourceMultiCloudImageSettings.html#show) | cm:legacy:observer | observer|
| rs_cm.multi_cloud_image_settings | [rs_cm.update](http://reference.rightscale.com/api1.5/resources/ResourceMultiCloudImageSettings.html#update) | cm:legacy:designer | designer|
| rs_cm.multi_cloud_images | [rs_cm.clone](http://reference.rightscale.com/api1.5/resources/ResourceMultiCloudImages.html#clone) | cm:legacy:designer | designer|
| rs_cm.multi_cloud_images | [rs_cm.commit](http://reference.rightscale.com/api1.5/resources/ResourceMultiCloudImages.html#commit) | cm:legacy:designer | designer|
| rs_cm.multi_cloud_images | [rs_cm.create](http://reference.rightscale.com/api1.5/resources/ResourceMultiCloudImages.html#create) | cm:legacy:designer | designer|
| rs_cm.multi_cloud_images | [rs_cm.destroy](http://reference.rightscale.com/api1.5/resources/ResourceMultiCloudImages.html#destroy) | cm:legacy:designer | designer|
| rs_cm.multi_cloud_images | [rs_cm.index](http://reference.rightscale.com/api1.5/resources/ResourceMultiCloudImages.html#index) | cm:legacy:observer | observer|
| rs_cm.multi_cloud_images | [rs_cm.show](http://reference.rightscale.com/api1.5/resources/ResourceMultiCloudImages.html#show) | cm:legacy:observer | observer|
| rs_cm.multi_cloud_images | [rs_cm.update](http://reference.rightscale.com/api1.5/resources/ResourceMultiCloudImages.html#update) | cm:legacy:designer | designer|
| rs_cm.network_gateways | [rs_cm.create](http://reference.rightscale.com/api1.5/resources/ResourceNetworkGateways.html#create) | cm:legacy:security_manager | security_manager|
| rs_cm.network_gateways | [rs_cm.destroy](http://reference.rightscale.com/api1.5/resources/ResourceNetworkGateways.html#destroy) | cm:legacy:security_manager | security_manager|
| rs_cm.network_gateways | [rs_cm.index](http://reference.rightscale.com/api1.5/resources/ResourceNetworkGateways.html#index) | cm:legacy:observer | observer|
| rs_cm.network_gateways | [rs_cm.show](http://reference.rightscale.com/api1.5/resources/ResourceNetworkGateways.html#show) | cm:legacy:observer | observer|
| rs_cm.network_gateways | [rs_cm.update](http://reference.rightscale.com/api1.5/resources/ResourceNetworkGateways.html#update) | cm:legacy:security_manager | security_manager|
| rs_cm.network_option_group_attachments | [rs_cm.create](http://reference.rightscale.com/api1.5/resources/ResourceNetworkOptionGroupAttachments.html#create) | cm:legacy:security_manager | security_manager|
| rs_cm.network_option_group_attachments | [rs_cm.destroy](http://reference.rightscale.com/api1.5/resources/ResourceNetworkOptionGroupAttachments.html#destroy) | cm:legacy:security_manager | security_manager|
| rs_cm.network_option_group_attachments | [rs_cm.index](http://reference.rightscale.com/api1.5/resources/ResourceNetworkOptionGroupAttachments.html#index) | cm:legacy:observer | observer|
| rs_cm.network_option_group_attachments | [rs_cm.show](http://reference.rightscale.com/api1.5/resources/ResourceNetworkOptionGroupAttachments.html#show) | cm:legacy:observer | observer|
| rs_cm.network_option_group_attachments | [rs_cm.update](http://reference.rightscale.com/api1.5/resources/ResourceNetworkOptionGroupAttachments.html#update) | cm:legacy:security_manager | security_manager|
| rs_cm.network_option_groups | [rs_cm.create](http://reference.rightscale.com/api1.5/resources/ResourceNetworkOptionGroups.html#create) | cm:legacy:security_manager | security_manager|
| rs_cm.network_option_groups | [rs_cm.destroy](http://reference.rightscale.com/api1.5/resources/ResourceNetworkOptionGroups.html#destroy) | cm:legacy:security_manager | security_manager|
| rs_cm.network_option_groups | [rs_cm.index](http://reference.rightscale.com/api1.5/resources/ResourceNetworkOptionGroups.html#index) | cm:legacy:observer | observer|
| rs_cm.network_option_groups | [rs_cm.show](http://reference.rightscale.com/api1.5/resources/ResourceNetworkOptionGroups.html#show) | cm:legacy:observer | observer|
| rs_cm.network_option_groups | [rs_cm.update](http://reference.rightscale.com/api1.5/resources/ResourceNetworkOptionGroups.html#update) | cm:legacy:security_manager | security_manager|
| rs_cm.networks | [rs_cm.create](http://reference.rightscale.com/api1.5/resources/ResourceNetworks.html#create) | cm:legacy:security_manager | security_manager|
| rs_cm.networks | [rs_cm.destroy](http://reference.rightscale.com/api1.5/resources/ResourceNetworks.html#destroy) | cm:legacy:security_manager | security_manager|
| rs_cm.networks | [rs_cm.index](http://reference.rightscale.com/api1.5/resources/ResourceNetworks.html#index) | cm:legacy:observer | observer|
| rs_cm.networks | [rs_cm.show](http://reference.rightscale.com/api1.5/resources/ResourceNetworks.html#show) | cm:legacy:observer | observer|
| rs_cm.networks | [rs_cm.update](http://reference.rightscale.com/api1.5/resources/ResourceNetworks.html#update) | cm:legacy:security_manager | security_manager|
| rs_cm.permissions | [rs_cm.create](http://reference.rightscale.com/api1.5/resources/ResourcePermissions.html#create) | cm:legacy:admin | admin|
| rs_cm.permissions | [rs_cm.destroy](http://reference.rightscale.com/api1.5/resources/ResourcePermissions.html#destroy) | cm:legacy:admin | admin|
| rs_cm.permissions | [rs_cm.index](http://reference.rightscale.com/api1.5/resources/ResourcePermissions.html#index) | cm:legacy:admin | admin|
| rs_cm.permissions | [rs_cm.show](http://reference.rightscale.com/api1.5/resources/ResourcePermissions.html#show) | cm:legacy:admin | admin|
| rs_cm.placement_groups | [rs_cm.create](http://reference.rightscale.com/api1.5/resources/ResourcePlacementGroups.html#create) | cm:legacy:actor | actor|
| rs_cm.placement_groups | [rs_cm.destroy](http://reference.rightscale.com/api1.5/resources/ResourcePlacementGroups.html#destroy) | cm:legacy:actor | actor|
| rs_cm.placement_groups | [rs_cm.index](http://reference.rightscale.com/api1.5/resources/ResourcePlacementGroups.html#index) | cm:legacy:observer | observer|
| rs_cm.placement_groups | [rs_cm.show](http://reference.rightscale.com/api1.5/resources/ResourcePlacementGroups.html#show) | cm:legacy:observer | observer|
| rs_cm.preferences | [rs_cm.destroy](http://reference.rightscale.com/api1.5/resources/ResourcePreferences.html#destroy) | cm:legacy:observer | observer|
| rs_cm.preferences | [rs_cm.index](http://reference.rightscale.com/api1.5/resources/ResourcePreferences.html#index) | cm:legacy:observer | observer|
| rs_cm.preferences | [rs_cm.show](http://reference.rightscale.com/api1.5/resources/ResourcePreferences.html#show) | cm:legacy:observer | observer|
| rs_cm.preferences | [rs_cm.update](http://reference.rightscale.com/api1.5/resources/ResourcePreferences.html#update) | cm:legacy:observer | observer|
| rs_cm.publication_lineages | [rs_cm.show](http://reference.rightscale.com/api1.5/resources/ResourcePublicationLineages.html#show) | cm:legacy:publisher | publisher|
| rs_cm.publications | [rs_cm.import](http://reference.rightscale.com/api1.5/resources/ResourcePublications.html#import) | cm:legacy:designer | designer|
| rs_cm.publications | [rs_cm.index](http://reference.rightscale.com/api1.5/resources/ResourcePublications.html#index) | cm:legacy:observer | observer|
| rs_cm.publications | [rs_cm.show](http://reference.rightscale.com/api1.5/resources/ResourcePublications.html#show) | cm:legacy:observer | observer|
| rs_cm.recurring_volume_attachments | [rs_cm.create](http://reference.rightscale.com/api1.5/resources/ResourceRecurringVolumeAttachments.html#create) | cm:legacy:actor | actor|
| rs_cm.recurring_volume_attachments | [rs_cm.destroy](http://reference.rightscale.com/api1.5/resources/ResourceRecurringVolumeAttachments.html#destroy) | cm:legacy:actor | actor|
| rs_cm.recurring_volume_attachments | [rs_cm.index](http://reference.rightscale.com/api1.5/resources/ResourceRecurringVolumeAttachments.html#index) | cm:legacy:observer | observer|
| rs_cm.recurring_volume_attachments | [rs_cm.show](http://reference.rightscale.com/api1.5/resources/ResourceRecurringVolumeAttachments.html#show) | cm:legacy:observer | observer|
| rs_cm.repositories | [rs_cm.cookbook_import](http://reference.rightscale.com/api1.5/resources/ResourceRepositories.html#cookbook_import) | cm:legacy:designer | designer|
| rs_cm.repositories | [rs_cm.cookbook_import_preview](http://reference.rightscale.com/api1.5/resources/ResourceRepositories.html#cookbook_import_preview) | cm:legacy:designer | designer|
| rs_cm.repositories | [rs_cm.create](http://reference.rightscale.com/api1.5/resources/ResourceRepositories.html#create) | cm:legacy:designer | designer|
| rs_cm.repositories | [rs_cm.destroy](http://reference.rightscale.com/api1.5/resources/ResourceRepositories.html#destroy) | cm:legacy:designer | designer|
| rs_cm.repositories | [rs_cm.index](http://reference.rightscale.com/api1.5/resources/ResourceRepositories.html#index) | cm:legacy:observer | observer|
| rs_cm.repositories | [rs_cm.refetch](http://reference.rightscale.com/api1.5/resources/ResourceRepositories.html#refetch) | cm:legacy:designer | designer|
| rs_cm.repositories | [rs_cm.resolve](http://reference.rightscale.com/api1.5/resources/ResourceRepositories.html#resolve) | cm:legacy:observer | observer|
| rs_cm.repositories | [rs_cm.show](http://reference.rightscale.com/api1.5/resources/ResourceRepositories.html#show) | cm:legacy:observer | observer|
| rs_cm.repositories | [rs_cm.update](http://reference.rightscale.com/api1.5/resources/ResourceRepositories.html#update) | cm:legacy:designer | designer|
| rs_cm.repository_assets | [rs_cm.index](http://reference.rightscale.com/api1.5/resources/ResourceRepositoryAssets.html#index) | cm:legacy:observer | observer|
| rs_cm.repository_assets | [rs_cm.show](http://reference.rightscale.com/api1.5/resources/ResourceRepositoryAssets.html#show) | cm:legacy:observer | observer|
| rs_cm.resource_groups | [rs_cm.create](http://reference.rightscale.com/api1.5/resources/ResourceResourceGroups.html#create) | cm:legacy:actor | actor|
| rs_cm.resource_groups | [rs_cm.destroy](http://reference.rightscale.com/api1.5/resources/ResourceResourceGroups.html#destroy) | cm:legacy:actor | actor|
| rs_cm.resource_groups | [rs_cm.index](http://reference.rightscale.com/api1.5/resources/ResourceResourceGroups.html#index) | cm:legacy:observer | observer|
| rs_cm.resource_groups | [rs_cm.show](http://reference.rightscale.com/api1.5/resources/ResourceResourceGroups.html#show) | cm:legacy:observer | observer|
| rs_cm.resource_groups | [rs_cm.update](http://reference.rightscale.com/api1.5/resources/ResourceResourceGroups.html#update) | cm:legacy:actor | actor|
| rs_cm.right_script_attachments | [rs_cm.create](http://reference.rightscale.com/api1.5/resources/ResourceRightScriptAttachments.html#create) | cm:legacy:designer | designer|
| rs_cm.right_script_attachments | [rs_cm.destroy](http://reference.rightscale.com/api1.5/resources/ResourceRightScriptAttachments.html#destroy) | cm:legacy:designer | designer|
| rs_cm.right_script_attachments | [rs_cm.index](http://reference.rightscale.com/api1.5/resources/ResourceRightScriptAttachments.html#index) | cm:legacy:observer | observer|
| rs_cm.right_script_attachments | [rs_cm.show](http://reference.rightscale.com/api1.5/resources/ResourceRightScriptAttachments.html#show) | cm:legacy:observer | observer|
| rs_cm.right_script_attachments | [rs_cm.update](http://reference.rightscale.com/api1.5/resources/ResourceRightScriptAttachments.html#update) | cm:legacy:designer | designer|
| rs_cm.right_scripts | [rs_cm.commit](http://reference.rightscale.com/api1.5/resources/ResourceRightScripts.html#commit) | cm:legacy:designer | designer|
| rs_cm.right_scripts | [rs_cm.create](http://reference.rightscale.com/api1.5/resources/ResourceRightScripts.html#create) | cm:legacy:designer | designer|
| rs_cm.right_scripts | [rs_cm.destroy](http://reference.rightscale.com/api1.5/resources/ResourceRightScripts.html#destroy) | cm:legacy:designer | designer|
| rs_cm.right_scripts | [rs_cm.index](http://reference.rightscale.com/api1.5/resources/ResourceRightScripts.html#index) | cm:legacy:observer | observer|
| rs_cm.right_scripts | [rs_cm.show](http://reference.rightscale.com/api1.5/resources/ResourceRightScripts.html#show) | cm:legacy:observer | observer|
| rs_cm.right_scripts | [rs_cm.show_source](http://reference.rightscale.com/api1.5/resources/ResourceRightScripts.html#show_source) | cm:legacy:observer | observer|
| rs_cm.right_scripts | [rs_cm.update](http://reference.rightscale.com/api1.5/resources/ResourceRightScripts.html#update) | cm:legacy:designer | designer|
| rs_cm.right_scripts | [rs_cm.update_source](http://reference.rightscale.com/api1.5/resources/ResourceRightScripts.html#update_source) | cm:legacy:designer | designer|
| rs_cm.route_tables | [rs_cm.create](http://reference.rightscale.com/api1.5/resources/ResourceRouteTables.html#create) | cm:legacy:security_manager | security_manager|
| rs_cm.route_tables | [rs_cm.destroy](http://reference.rightscale.com/api1.5/resources/ResourceRouteTables.html#destroy) | cm:legacy:security_manager | security_manager|
| rs_cm.route_tables | [rs_cm.index](http://reference.rightscale.com/api1.5/resources/ResourceRouteTables.html#index) | cm:legacy:observer | observer|
| rs_cm.route_tables | [rs_cm.show](http://reference.rightscale.com/api1.5/resources/ResourceRouteTables.html#show) | cm:legacy:observer | observer|
| rs_cm.route_tables | [rs_cm.update](http://reference.rightscale.com/api1.5/resources/ResourceRouteTables.html#update) | cm:legacy:security_manager | security_manager|
| rs_cm.routes | [rs_cm.create](http://reference.rightscale.com/api1.5/resources/ResourceRoutes.html#create) | cm:legacy:security_manager | security_manager|
| rs_cm.routes | [rs_cm.destroy](http://reference.rightscale.com/api1.5/resources/ResourceRoutes.html#destroy) | cm:legacy:security_manager | security_manager|
| rs_cm.routes | [rs_cm.index](http://reference.rightscale.com/api1.5/resources/ResourceRoutes.html#index) | cm:legacy:observer | observer|
| rs_cm.routes | [rs_cm.show](http://reference.rightscale.com/api1.5/resources/ResourceRoutes.html#show) | cm:legacy:observer | observer|
| rs_cm.routes | [rs_cm.update](http://reference.rightscale.com/api1.5/resources/ResourceRoutes.html#update) | cm:legacy:security_manager | security_manager|
| rs_cm.runnable_bindings | [rs_cm.create](http://reference.rightscale.com/api1.5/resources/ResourceRunnableBindings.html#create) | cm:legacy:designer | designer|
| rs_cm.runnable_bindings | [rs_cm.destroy](http://reference.rightscale.com/api1.5/resources/ResourceRunnableBindings.html#destroy) | cm:legacy:designer | designer|
| rs_cm.runnable_bindings | [rs_cm.index](http://reference.rightscale.com/api1.5/resources/ResourceRunnableBindings.html#index) | cm:legacy:observer | observer|
| rs_cm.runnable_bindings | [rs_cm.multi_update](http://reference.rightscale.com/api1.5/resources/ResourceRunnableBindings.html#multi_update) | cm:legacy:designer | designer|
| rs_cm.runnable_bindings | [rs_cm.show](http://reference.rightscale.com/api1.5/resources/ResourceRunnableBindings.html#show) | cm:legacy:observer | observer|
| rs_cm.security_group_rules | [rs_cm.create](http://reference.rightscale.com/api1.5/resources/ResourceSecurityGroupRules.html#create) | cm:legacy:security_manager | security_manager|
| rs_cm.security_group_rules | [rs_cm.destroy](http://reference.rightscale.com/api1.5/resources/ResourceSecurityGroupRules.html#destroy) | cm:legacy:security_manager | security_manager|
| rs_cm.security_group_rules | [rs_cm.index](http://reference.rightscale.com/api1.5/resources/ResourceSecurityGroupRules.html#index) | cm:legacy:observer | observer|
| rs_cm.security_group_rules | [rs_cm.show](http://reference.rightscale.com/api1.5/resources/ResourceSecurityGroupRules.html#show) | cm:legacy:observer | observer|
| rs_cm.security_group_rules | [rs_cm.update](http://reference.rightscale.com/api1.5/resources/ResourceSecurityGroupRules.html#update) | cm:legacy:security_manager | security_manager|
| rs_cm.security_groups | [rs_cm.create](http://reference.rightscale.com/api1.5/resources/ResourceSecurityGroups.html#create) | cm:legacy:security_manager | security_manager|
| rs_cm.security_groups | [rs_cm.destroy](http://reference.rightscale.com/api1.5/resources/ResourceSecurityGroups.html#destroy) | cm:legacy:security_manager | security_manager|
| rs_cm.security_groups | [rs_cm.index](http://reference.rightscale.com/api1.5/resources/ResourceSecurityGroups.html#index) | cm:legacy:observer | observer|
| rs_cm.security_groups | [rs_cm.show](http://reference.rightscale.com/api1.5/resources/ResourceSecurityGroups.html#show) | cm:legacy:observer | observer|
| rs_cm.server_arrays | [rs_cm.clone](http://reference.rightscale.com/api1.5/resources/ResourceServerArrays.html#clone) | cm:legacy:actor | actor|
| rs_cm.server_arrays | [rs_cm.create](http://reference.rightscale.com/api1.5/resources/ResourceServerArrays.html#create) | cm:legacy:actor | actor|
| rs_cm.server_arrays | [rs_cm.destroy](http://reference.rightscale.com/api1.5/resources/ResourceServerArrays.html#destroy) | cm:legacy:actor | actor|
| rs_cm.server_arrays | [rs_cm.disable_runnable_bindings](http://reference.rightscale.com/api1.5/resources/ResourceServerArrays.html#disable_runnable_bindings) | cm:legacy:actor | actor|
| rs_cm.server_arrays | [rs_cm.enable_runnable_bindings](http://reference.rightscale.com/api1.5/resources/ResourceServerArrays.html#enable_runnable_bindings) | cm:legacy:actor | actor|
| rs_cm.server_arrays | [rs_cm.index](http://reference.rightscale.com/api1.5/resources/ResourceServerArrays.html#index) | cm:legacy:observer | observer|
| rs_cm.server_arrays | [rs_cm.monitor](http://reference.rightscale.com/api1.5/resources/ResourceServerArrays.html#monitor) | cm:legacy:actor | actor|
| rs_cm.server_arrays | [rs_cm.scale_down](http://reference.rightscale.com/api1.5/resources/ResourceServerArrays.html#scale_down) | cm:legacy:actor | actor|
| rs_cm.server_arrays | [rs_cm.scale_up](http://reference.rightscale.com/api1.5/resources/ResourceServerArrays.html#scale_up) | cm:legacy:actor | actor|
| rs_cm.server_arrays | [rs_cm.show](http://reference.rightscale.com/api1.5/resources/ResourceServerArrays.html#show) | cm:legacy:observer | observer|
| rs_cm.server_arrays | [rs_cm.update](http://reference.rightscale.com/api1.5/resources/ResourceServerArrays.html#update) | cm:legacy:actor | actor|
| rs_cm.server_arrays | [rs_cm.current_instances](http://reference.rightscale.com/api1.5/resources/ResourceServerArrays.html#current_instances) | cm:legacy:observer | observer|
| rs_cm.server_arrays | [rs_cm.launch](http://reference.rightscale.com/api1.5/resources/ResourceServerArrays.html#launch) | cm:legacy:actor | actor|
| rs_cm.server_arrays | [rs_cm.multi_terminate](http://reference.rightscale.com/api1.5/resources/ResourceServerArrays.html#multi_terminate) | cm:legacy:actor | actor|
| rs_cm.server_arrays | [rs_cm.multi_run_executable](http://reference.rightscale.com/api1.5/resources/ResourceServerArrays.html#multi_run_executable) | cm:legacy:actor | actor|
| rs_cm.server_template_multi_cloud_images | [rs_cm.create](http://reference.rightscale.com/api1.5/resources/ResourceServerTemplateMultiCloudImages.html#create) | cm:legacy:designer | designer|
| rs_cm.server_template_multi_cloud_images | [rs_cm.destroy](http://reference.rightscale.com/api1.5/resources/ResourceServerTemplateMultiCloudImages.html#destroy) | cm:legacy:designer | designer|
| rs_cm.server_template_multi_cloud_images | [rs_cm.index](http://reference.rightscale.com/api1.5/resources/ResourceServerTemplateMultiCloudImages.html#index) | cm:legacy:observer | observer|
| rs_cm.server_template_multi_cloud_images | [rs_cm.make_default](http://reference.rightscale.com/api1.5/resources/ResourceServerTemplateMultiCloudImages.html#make_default) | cm:legacy:designer | designer|
| rs_cm.server_template_multi_cloud_images | [rs_cm.show](http://reference.rightscale.com/api1.5/resources/ResourceServerTemplateMultiCloudImages.html#show) | cm:legacy:observer | observer|
| rs_cm.server_templates | [rs_cm.clone](http://reference.rightscale.com/api1.5/resources/ResourceServerTemplates.html#clone) | cm:legacy:designer | designer|
| rs_cm.server_templates | [rs_cm.commit](http://reference.rightscale.com/api1.5/resources/ResourceServerTemplates.html#commit) | cm:legacy:designer | designer|
| rs_cm.server_templates | [rs_cm.create](http://reference.rightscale.com/api1.5/resources/ResourceServerTemplates.html#create) | cm:legacy:designer | designer|
| rs_cm.server_templates | [rs_cm.destroy](http://reference.rightscale.com/api1.5/resources/ResourceServerTemplates.html#destroy) | cm:legacy:designer | designer|
| rs_cm.server_templates | [rs_cm.detect_changes_in_head](http://reference.rightscale.com/api1.5/resources/ResourceServerTemplates.html#detect_changes_in_head) | cm:legacy:observer | observer|
| rs_cm.server_templates | [rs_cm.index](http://reference.rightscale.com/api1.5/resources/ResourceServerTemplates.html#index) | cm:legacy:observer | observer|
| rs_cm.server_templates | [rs_cm.publish](http://reference.rightscale.com/api1.5/resources/ResourceServerTemplates.html#publish) | cm:legacy:publisher | publisher|
| rs_cm.server_templates | [rs_cm.resolve](http://reference.rightscale.com/api1.5/resources/ResourceServerTemplates.html#resolve) | cm:legacy:observer | observer|
| rs_cm.server_templates | [rs_cm.show](http://reference.rightscale.com/api1.5/resources/ResourceServerTemplates.html#show) | cm:legacy:observer | observer|
| rs_cm.server_templates | [rs_cm.swap_repository](http://reference.rightscale.com/api1.5/resources/ResourceServerTemplates.html#swap_repository) | cm:legacy:designer | designer|
| rs_cm.server_templates | [rs_cm.update](http://reference.rightscale.com/api1.5/resources/ResourceServerTemplates.html#update) | cm:legacy:designer | designer|
| rs_cm.servers | [rs_cm.clone](http://reference.rightscale.com/api1.5/resources/ResourceServers.html#clone) | cm:legacy:actor | actor|
| rs_cm.servers | [rs_cm.create](http://reference.rightscale.com/api1.5/resources/ResourceServers.html#create) | cm:legacy:actor | actor|
| rs_cm.servers | [rs_cm.destroy](http://reference.rightscale.com/api1.5/resources/ResourceServers.html#destroy) | cm:legacy:actor | actor|
| rs_cm.servers | [rs_cm.disable_runnable_bindings](http://reference.rightscale.com/api1.5/resources/ResourceServers.html#disable_runnable_bindings) | cm:legacy:actor | actor|
| rs_cm.servers | [rs_cm.enable_runnable_bindings](http://reference.rightscale.com/api1.5/resources/ResourceServers.html#enable_runnable_bindings) | cm:legacy:actor | actor|
| rs_cm.servers | [rs_cm.index](http://reference.rightscale.com/api1.5/resources/ResourceServers.html#index) | cm:legacy:observer | observer|
| rs_cm.servers | [rs_cm.show](http://reference.rightscale.com/api1.5/resources/ResourceServers.html#show) | cm:legacy:observer | observer|
| rs_cm.servers | [rs_cm.unwrap](http://reference.rightscale.com/api1.5/resources/ResourceServers.html#unwrap) | cm:legacy:actor | actor|
| rs_cm.servers | [rs_cm.update](http://reference.rightscale.com/api1.5/resources/ResourceServers.html#update) | cm:legacy:actor | actor|
| rs_cm.servers | [rs_cm.wrap_instance](http://reference.rightscale.com/api1.5/resources/ResourceServers.html#wrap_instance) | cm:legacy:actor | actor|
| rs_cm.servers | [rs_cm.launch](http://reference.rightscale.com/api1.5/resources/ResourceServers.html#launch) | cm:legacy:actor | actor|
| rs_cm.servers | [rs_cm.terminate](http://reference.rightscale.com/api1.5/resources/ResourceServers.html#terminate) | cm:legacy:actor | actor|
| rs_cm.sessions | [rs_cm.index](http://reference.rightscale.com/api1.5/resources/ResourceSessions.html#index) | cm:legacy:observer | observer|
| rs_cm.ssh_keys | [rs_cm.create](http://reference.rightscale.com/api1.5/resources/ResourceSshKeys.html#create) | cm:legacy:actor | actor|
| rs_cm.ssh_keys | [rs_cm.destroy](http://reference.rightscale.com/api1.5/resources/ResourceSshKeys.html#destroy) | cm:legacy:actor | actor|
| rs_cm.ssh_keys | [rs_cm.index](http://reference.rightscale.com/api1.5/resources/ResourceSshKeys.html#index) | cm:legacy:observer | observer|
| rs_cm.ssh_keys | [rs_cm.show](http://reference.rightscale.com/api1.5/resources/ResourceSshKeys.html#show) | cm:legacy:observer | observer|
| rs_cm.ssh_keys | [rs_cm.show_sensitive](http://reference.rightscale.com/api1.5/resources/ResourceSshKeys.html#show) | cm:legacy:credential_viewer _OR_ cm:legacy:admin | credential_viewer|
| rs_cm.ssh_keys | [rs_cm.index_sensitive](http://reference.rightscale.com/api1.5/resources/ResourceSshKeys.html#index) | cm:legacy:credential_viewer _OR_ cm:legacy:admin | credential_viewer|
| rs_cm.subnets | [rs_cm.create](http://reference.rightscale.com/api1.5/resources/ResourceSubnets.html#create) | cm:legacy:security_manager | security_manager|
| rs_cm.subnets | [rs_cm.destroy](http://reference.rightscale.com/api1.5/resources/ResourceSubnets.html#destroy) | cm:legacy:security_manager | security_manager|
| rs_cm.subnets | [rs_cm.index](http://reference.rightscale.com/api1.5/resources/ResourceSubnets.html#index) | cm:legacy:observer | observer|
| rs_cm.subnets | [rs_cm.show](http://reference.rightscale.com/api1.5/resources/ResourceSubnets.html#show) | cm:legacy:observer | observer|
| rs_cm.subnets | [rs_cm.update](http://reference.rightscale.com/api1.5/resources/ResourceSubnets.html#update) | cm:legacy:security_manager | security_manager|
| rs_cm.tags | [rs_cm.by_resource](http://reference.rightscale.com/api1.5/resources/ResourceTags.html#by_resource) | cm:legacy:observer | observer|
| rs_cm.tags | [rs_cm.by_tag](http://reference.rightscale.com/api1.5/resources/ResourceTags.html#by_tag) | cm:legacy:observer | observer|
| rs_cm.tags | [rs_cm.multi_add](http://reference.rightscale.com/api1.5/resources/ResourceTags.html#multi_add) | cm:legacy:actor | actor|
| rs_cm.tags | [rs_cm.multi_delete](http://reference.rightscale.com/api1.5/resources/ResourceTags.html#multi_delete) | cm:legacy:actor | actor|
| rs_cm.tasks | [rs_cm.show](http://reference.rightscale.com/api1.5/resources/ResourceTasks.html#show) | cm:legacy:observer | observer|
| rs_cm.user_datas | [rs_cm.show](http://reference.rightscale.com/api1.5/resources/ResourceUserDatas.html#show) | cm:legacy:observer | observer|
| rs_cm.users | [rs_cm.create](http://reference.rightscale.com/api1.5/resources/ResourceUsers.html#create) | cm:legacy:admin _OR_ cm:legacy:enterprise_manager | admin|
| rs_cm.users | [rs_cm.index](http://reference.rightscale.com/api1.5/resources/ResourceUsers.html#index) | cm:legacy:observer | observer|
| rs_cm.users | [rs_cm.show](http://reference.rightscale.com/api1.5/resources/ResourceUsers.html#show) | cm:legacy:observer | observer|
| rs_cm.users | [rs_cm.update](http://reference.rightscale.com/api1.5/resources/ResourceUsers.html#update) | cm:legacy:observer | observer|
| rs_cm.volume_attachments | [rs_cm.create](http://reference.rightscale.com/api1.5/resources/ResourceVolumeAttachments.html#create) | cm:legacy:actor | actor|
| rs_cm.volume_attachments | [rs_cm.destroy](http://reference.rightscale.com/api1.5/resources/ResourceVolumeAttachments.html#destroy) | cm:legacy:actor | actor|
| rs_cm.volume_attachments | [rs_cm.index](http://reference.rightscale.com/api1.5/resources/ResourceVolumeAttachments.html#index) | cm:legacy:observer | observer|
| rs_cm.volume_attachments | [rs_cm.show](http://reference.rightscale.com/api1.5/resources/ResourceVolumeAttachments.html#show) | cm:legacy:observer | observer|
| rs_cm.volume_snapshots | [rs_cm.copy](http://reference.rightscale.com/api1.5/resources/ResourceVolumeSnapshots.html#copy) | cm:legacy:actor | actor|
| rs_cm.volume_snapshots | [rs_cm.create](http://reference.rightscale.com/api1.5/resources/ResourceVolumeSnapshots.html#create) | cm:legacy:actor | actor|
| rs_cm.volume_snapshots | [rs_cm.destroy](http://reference.rightscale.com/api1.5/resources/ResourceVolumeSnapshots.html#destroy) | cm:legacy:actor | actor|
| rs_cm.volume_snapshots | [rs_cm.index](http://reference.rightscale.com/api1.5/resources/ResourceVolumeSnapshots.html#index) | cm:legacy:observer | observer|
| rs_cm.volume_snapshots | [rs_cm.show](http://reference.rightscale.com/api1.5/resources/ResourceVolumeSnapshots.html#show) | cm:legacy:observer | observer|
| rs_cm.volume_types | [rs_cm.index](http://reference.rightscale.com/api1.5/resources/ResourceVolumeTypes.html#index) | cm:legacy:observer | observer|
| rs_cm.volume_types | [rs_cm.show](http://reference.rightscale.com/api1.5/resources/ResourceVolumeTypes.html#show) | cm:legacy:observer | observer|
| rs_cm.volumes | [rs_cm.create](http://reference.rightscale.com/api1.5/resources/ResourceVolumes.html#create) | cm:legacy:actor | actor|
| rs_cm.volumes | [rs_cm.destroy](http://reference.rightscale.com/api1.5/resources/ResourceVolumes.html#destroy) | cm:legacy:actor | actor|
| rs_cm.volumes | [rs_cm.index](http://reference.rightscale.com/api1.5/resources/ResourceVolumes.html#index) | cm:legacy:observer | observer|
| rs_cm.volumes | [rs_cm.show](http://reference.rightscale.com/api1.5/resources/ResourceVolumes.html#show) | cm:legacy:observer | observer|
| rs_cm.volumes | [rs_cm.update](http://reference.rightscale.com/api1.5/resources/ResourceVolumes.html#update) | cm:legacy:actor | actor|
| rs_optima.allocation_table | rs_optima.show | optima:billing_center:show | billing_center_viewer (org scope only)|
| rs_optima.allocation_table | rs_optima.upsert | optima:billing_center:update | billing_center_admin (org scope only)|
| rs_optima.aws_reserved_instances | rs_optima.index | ca:legacy:user | ca_user (org scope only)|
| rs_optima.recommendation_rules | rs_optima.index | optima:recommendation:index | billing_center_viewer (org scope only)|
| rs_optima.recommendation_rules | rs_optima.show | optima:recommendation:show | billing_center_viewer (org scope only)|
| rs_optima.recommendations | rs_optima.index | optima:recommendation:index | billing_center_viewer (org scope only)|
| rs_optima.recommendations | rs_optima.show | optima:recommendation:show | billing_center_viewer (org scope only)|
| rs_optima.recommendations | rs_optima.resolve | optima:recommendation:update | billing_center_admin (org scope only)|
| rs_optima.recommendations | rs_optima.unresolve | optima:recommendation:update | billing_center_admin (org scope only)|
