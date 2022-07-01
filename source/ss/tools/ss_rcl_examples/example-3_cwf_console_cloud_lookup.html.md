---
title: CWF Console Show Date
description: CWF Console code cloud lookup all clouds.
---

## Introduction

Cloud Workflow Console (**CWF**) code to lookup clouds. 

## Code Syntax
 ```
 define cloud_lookup($href_of_selected_cloud) return $cloud_name do
  $clouds = {
    "/api/clouds/1"    => "AWS US-East",
    "/api/clouds/10"   => "AWS China-Beijing",
    "/api/clouds/11"   => "AWS US-Ohio",
    "/api/clouds/12"   => "AWS AP-Seoul",
    "/api/clouds/13"   => "AWS EU-London",
    "/api/clouds/14"   => "AWS CA-Central",
    "/api/clouds/1869" => "SoftLayer",
    "/api/clouds/2"    => "AWS EU-Ireland",
    "/api/clouds/2175" => "Google",
    "/api/clouds/2178" => "Azure West US",
    "/api/clouds/2179" => "Azure East US",
    "/api/clouds/2180" => "Azure East Asia",
    "/api/clouds/2181" => "Azure Southeast Asia",
    "/api/clouds/2182" => "Azure North Europe",
    "/api/clouds/2183" => "Azure West Europe",
    "/api/clouds/3"    => "AWS US-West",
    "/api/clouds/3040" => "Azure Australia East",
    "/api/clouds/3041" => "Azure Australia Southeast",
    "/api/clouds/3070" => "Openstack Juno",
    "/api/clouds/3243" => "Cisco OpenStack",
    "/api/clouds/3391" => "RCA-V VMware 5.5 Services",
    "/api/clouds/3482" => "VMware Private Cloud",
    "/api/clouds/3499" => "Openstack Liberty",
    "/api/clouds/3518" => "AzureRM West US",
    "/api/clouds/3519" => "AzureRM Japan East",
    "/api/clouds/3520" => "AzureRM Southeast Asia",
    "/api/clouds/3521" => "AzureRM Japan West",
    "/api/clouds/3522" => "AzureRM East Asia",
    "/api/clouds/3523" => "AzureRM East US",
    "/api/clouds/3524" => "AzureRM West Europe",
    "/api/clouds/3525" => "AzureRM North Central US",
    "/api/clouds/3526" => "AzureRM Central US",
    "/api/clouds/3527" => "AzureRM Canada Central",
    "/api/clouds/3528" => "AzureRM North Europe",
    "/api/clouds/3529" => "AzureRM Brazil South",
    "/api/clouds/3530" => "AzureRM Canada East",
    "/api/clouds/3531" => "AzureRM East US 2",
    "/api/clouds/3532" => "AzureRM South Central US",
    "/api/clouds/3546" => "AzureRM West US 2",
    "/api/clouds/3547" => "AzureRM West Central US",
    "/api/clouds/3567" => "AzureRM UK South",
    "/api/clouds/3568" => "AzureRM UK West",
    "/api/clouds/3569" => "AzureRM West India",
    "/api/clouds/3570" => "AzureRM Central India",
    "/api/clouds/3571" => "AzureRM South India",
    "/api/clouds/4"    => "AWS AP-Singapore",
    "/api/clouds/5"    => "AWS AP-Tokyo",
    "/api/clouds/6"    => "AWS US-Oregon",
    "/api/clouds/7"    => "AWS SA-São Paulo",
    "/api/clouds/8"    => "AWS AP-Sydney",
    "/api/clouds/9"    => "AWS EU-Frankfurt"
  }

  $cloud_name = $clouds[$href_of_selected_cloud]
end
 ```

## CWF Console
**$href_of_selected_cloud** is an input variable. Example: `/api/clouds/3525`

![ss-cwf-console-example-3-cloud-lookup-1.png](/img/ss-cwf-console-example-3-cloud-lookup-1.png)

## Expected Outcome

### Process Info
![ss-cwf-console-example-3-cloud-lookup-process-info-2.png](/img/ss-cwf-console-example-3-cloud-lookup-process-info-2.png)
 
### Outputs
![ss-cwf-console-example-3-cloud-lookup-outputs-3.png](/img/ss-cwf-console-example-3-cloud-lookup-outputs-3.png)

### Tasks
![ss-cwf-console-example-3-cloud-lookup-tasks-4.png](/img/ss-cwf-console-example-3-cloud-lookup-tasks-4.png)

### Source
 * Displays the source code that was used.  If you want to modify and reuse the code, click on `Clone`
![ss-cwf-console-example-3-cloud-lookup-source-5.png](/img/ss-cwf-console-example-3-cloud-lookup-source-5.png)


