---
title: Creating Custom Images for Azure Resource Manager (ARM)
layout: azure_resource_manager_layout_page
description: Steps to create a custom image that is discoverable in RightScale Cloud Management
---

##Pre-Requisites

### Install Azure PowerShell Module or Azure CLI
In order to create a custom image using this guide, you will need to have either the Azure PowerShell Module or Azure CLI tools available on your workstation.
* [Azure PowerShell Module](http://aka.ms/webpi-azps)
* [Azure CLI](https://azure.microsoft.com/en-us/documentation/articles/xplat-cli-install/)

### Login to Azure Account
Once the proper Azure tools are installed, you need to set them up to work with your Azure Resource Manager subscription:

1. Login to your Azure account and display the available subscriptions:
[[[
### Azure PowerShell
``` PowerShell
Login-AzureRmAccount
Get-AzureRmSubscription
```
###

### Azure CLI
``` shell
azure config mode arm
azure login
azure account list
```
###
]]]

1. Select the Azure Subscription we will be working with:
[[[
### Azure PowerShell
``` PowerShell
Select-AzureRmSubscription -SubscriptionName <Subscription Name>
```
###

### Azure CLI
``` shell
azure account set <Name>
```
###
]]]


##Image Creation

###Windows
1. Launch a VM using the base image you wish to customize. At this stage you must decide if you wish to use Managed Disks or not.
1. Connect to the operational VM and make any necessary modifications:
    - [Install RightLink 10](/../../../rl10/reference/rl10_install_windows.html#overview-usage)

        ``` powershell
        $wc = New-Object System.Net.Webclient
        $wc.DownloadFile("https://rightlink.rightscale.com/rll/10/rightlink.install.ps1", `
            "$pwd\rightlink.install.ps1")
        Powershell -ExecutionPolicy Unrestricted -File rightlink.install.ps1
        ```
    - Install updates
    - Install applications
    - Etc...

1. **From the VM:** Prepare the VM for image capture by running SYSPREP from an elevated command prompt:
`C:\windows\system32\sysprep\sysprep.exe /oobe /generalize /shutdown`
1. Wait for the VM to be in a `Stopped` state...
1. **From your Workstation:** Deallocate the VMs resources:
[[[
### Azure PowerShell
``` PowerShell
Stop-AzureRmVM -Name <VM Name> -ResourceGroupName <Resource Group Name> -Force
```
###

### Azure CLI
``` shell
azure vm deallocate --resource-group <Resource Group Name> --name <VM Name>
```
###
]]]

1. **From your Workstation:** Generalize the VM:
[[[
### Azure PowerShell
``` PowerShell
Set-AzureRmVM -Name <VM Name> -ResourceGroupName <Resource Group Name> -Generalized
```
###

### Azure CLI
``` shell
azure vm generalize --resource-group <Resource Group Name> --name <VM Name>
```
###
]]]

1. **From your Workstation:** Capture the image:<br>
**Managed Image:**
[[[
### Azure PowerShell
``` PowerShell
$vm = Get-AzureRmVM -Name <VM Name> -ResourceGroupName <Resource Group Name>
$image = New-AzureRmImageConfig -Location <Region> -SourceVirtualMachineId $vm.ID 
New-AzureRmImage -Image $image -ImageName <Name of Image> -ResourceGroupName <Resource Group Name>
```
###

### Azure CLI
``` shell
az image create --resource-group <Resource Group Name> --name <Name of Image> --source <VM Name>
```
###
]]]
**Unmanaged Image:**
[[[
### Azure PowerShell
``` PowerShell
Save-AzureRmVMImage -VMName <VM Name> -ResourceGroupName <Resource Group Name> -DestinationContainerName "vhds" -VHDNamePrefix <choose unique prefix string>
```
###

### Azure CLI
``` shell
azure vm capture --resource-group <Resource Group Name> --name <VM Name> --vhd-name-prefix <choose unique prefix string>
```
###
]]]
The unmanaged image will be captured as a virtual hard drive (VHD), with the prefix you defined and in the same Storage Account as the source VM, at the following path:<br>
`<Storage Account>/system/Microsoft.Compute/Images/vhds/`
!!info*Note:*RightScale Cloud Management will only discover vhds as "images" when stored within the `system` container.

1. The source VM is no longer usable once it has been sysprepped and marked as generalized. 
Run the following command once the image has been successfully captured to delete the source VM:
[[[
### Azure PowerShell
``` PowerShell
Remove-AzureRmVM -Name <VM Name> -ResourceGroupName <Resource Group Name> -Force
```
###

### Azure CLI
``` shell
azure vm delete --resource-group <Resource Group Name> --name <VM Name> --quiet
```
###
]]]

1. Wait for RightScale Cloud Management to discover the newly captured image. This takes approximately 5-10 minutes.

1. Once RightScale Cloud Management has discovered the image, you can [add it to an existing MultiCloud Image](/../../../cm/dashboard/design/multicloud_images/multicloud_images_actions.html#create-a-new-multicloud-image) 
or [create a new MultiCloud Image](/../../../cm/dashboard/design/multicloud_images/multicloud_images_actions.html#add-new-cloud-support-to-a-multicloud-image--mci-).
!!info*Note:* If you have installed RightLink 10, the MultiCloud Image must be tagged with `rs_agent:type=right_link_lite`


###Linux
1. Launch a VM using the base image you wish to customize. At this stage you must decide if you wish to use Managed Disks or not.
1. SSH to the operational VM and make any necessary modifications:
    - [Install RightLink 10](/../../../rl10/reference/rl10_install.html#overview-usage)
        
        ```shell
        curl -s https://rightlink.rightscale.com/rll/10/rightlink.install.sh |
            sudo bash -s
        ```
    - Install updates
    - Install applications
    - Etc...

1. **From the VM:** Run the following commands to sanitize the VM and prepare it for capture:
``` shell
sudo rm -rf /var/lib/cloud/ /tmp/*
sudo rm -f /var/log/cloud-init* /etc/udev/rules.d/70-persistent-net.rules
sudo find /root -name authorized_keys -type f -exec rm -f {} \;
sudo find /home -name authorized_keys -type f -exec rm -f {} \;
sudo find /var/log -type f -exec cp /dev/null {} \;
history -c
sync
sudo waagent -deprovision+user -force
```

1. Close the SSH session by typing: `exit`

1. **From your Workstation:** Stop and Deallocate the VMs resources:
[[[
### Azure PowerShell
``` PowerShell
Stop-AzureRmVM -Name <VM Name> -ResourceGroupName <Resource Group Name> -Force
```
###

### Azure CLI
``` shell
azure vm deallocate --resource-group <Resource Group Name> --name <VM Name>
```
###
]]]

1. **From your Workstation:** Generalize the VM:
[[[
### Azure PowerShell
``` PowerShell
Set-AzureRmVM -Name <VM Name> -ResourceGroupName <Resource Group Name> -Generalized
```
###

### Azure CLI
``` shell
azure vm generalize --resource-group <Resource Group Name> --name <VM Name>
```
###
]]]

1. **From your Workstation:** Capture the image:<br>
**Managed Image:**
[[[
### Azure PowerShell
``` PowerShell
$vm = Get-AzureRmVM -Name <VM Name> -ResourceGroupName <Resource Group Name>
$image = New-AzureRmImageConfig -Location <Region> -SourceVirtualMachineId $vm.ID 
New-AzureRmImage -Image $image -ImageName <Name of Image> -ResourceGroupName <Resource Group Name>
```
###

### Azure CLI
``` shell
az image create --resource-group <Resource Group Name> --name <Name of Image> --source <VM Name>
```
###
]]]
**Unmanaged Image:**
[[[
### Azure PowerShell
``` PowerShell
Save-AzureRmVMImage -VMName <VM Name> -ResourceGroupName <Resource Group Name> -DestinationContainerName "vhds" -VHDNamePrefix <choose unique prefix string>
```
###

### Azure CLI
``` shell
azure vm capture --resource-group <Resource Group Name> --name <VM Name> --vhd-name-prefix <choose unique prefix string>
```
###
]]]
The unmanaged image will be captured as a VHD, with the prefix you defined and in the same Storage Account as the source VM, at the following path:<br>
`<Storage Account>/system/Microsoft.Compute/Images/vhds/`
!!info*Note:*RightScale Cloud Management will only discover vhds as "images" when stored in the above mentioned path.

1. The source VM is no longer usable once it has been marked as generalized. 
Run the following command once the image has been successfully captured to delete the source VM:
[[[
### Azure PowerShell
``` PowerShell
Remove-AzureRmVM -Name <VM Name> -ResourceGroupName <Resource Group Name> -Force
```
###

### Azure CLI
``` shell
azure vm delete --resource-group <Resource Group Name> --name <VM Name> --quiet
```
###
]]]

1. Wait for RightScale Cloud Management to discover the newly captured image. This takes approximately 5-10 minutes.

1. Once RightScale Cloud Management has discovered the image, you can [add it to an existing MultiCloud Image](/../../../cm/dashboard/design/multicloud_images/multicloud_images_actions.html#create-a-new-multicloud-image) 
or [create a new MultiCloud Image](/../../../cm/dashboard/design/multicloud_images/multicloud_images_actions.html#add-new-cloud-support-to-a-multicloud-image--mci-).
!!info*Note:* If you have installed RightLink 10, the MultiCloud Image must be tagged with `rs_agent:type=right_link_lite`


##Helpful Links
* [Microsoft: How to install and configure Azure PowerShell](https://azure.microsoft.com/en-us/documentation/articles/powershell-install-configure/)
* [Microsoft: How to install the Azure CLI](https://azure.microsoft.com/en-us/documentation/articles/xplat-cli-install/)
