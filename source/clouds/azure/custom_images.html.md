---
title: Creating Custom Images for Azure Service Management (ASM)
layout: azure_layout_page
description: Steps to create a custom image that is discoverable in RightScale Cloud Management
---

##Pre-Requisites

### Install Azure PowerShell Module or Azure CLI
In order to create a custom image using this guide, you will need to have either the Azure PowerShell Module or Azure CLI tools available on your workstation.
* [Azure PowerShell Module](http://aka.ms/webpi-azps)
* [Azure CLI](https://azure.microsoft.com/en-us/documentation/articles/xplat-cli-install/)

### Login to Azure Account
Once the proper Azure tools are installed, you need to set them up to work with your Azure Service Management subscription:

1. Login to your Azure account and display the available subscriptions:
[[[
### Azure PowerShell
``` PowerShell
Add-AzureAccount
Get-AzureSubscription
```
###

### Azure CLI
``` shell
azure config mode asm
azure login
azure account list
```
###
]]]

1. Select the Azure Subscription we will be working with:
[[[
### Azure PowerShell
``` PowerShell
Select-AzureSubscription -SubscriptionName <Subscription Name>
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
1. Launch a VM using the base image you wish to customize.
2. Connect to the operational VM and make any necessary modifications:
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

1. **From your Workstation:** Capture the image:
!!info*Note:* The VM will be deleted as part of the capture process.
[[[
### Azure PowerShell
``` PowerShell
Save-AzureVMImage -Name <VM Name> -ServiceName <Cloud Service Name> -ImageName <New Image Name> -ImageLabel <New Image Label/Description>
```
###

### Azure CLI
``` shell
azure vm capture <VM Name> <New Image Name> --label <New Image Label/Description> --delete
```
###
]]]

1. The image will be captured as a virtual hard drive (VHD) and saved in the same Storage Account as the source VM at the following path: `<Storage Account>/vhds/`.
At the same time it will also be registered as an Image within Azure.

1. Wait for RightScale Cloud Management to discover the newly registered image. This takes approximately 5-10 minutes.

1. Once RightScale Cloud Management has discovered the image, you can [add it to an existing MultiCloud Image](/../../../cm/dashboard/design/multicloud_images/multicloud_images_actions.html#create-a-new-multicloud-image) 
or [create a new MultiCloud Image](/../../../cm/dashboard/design/multicloud_images/multicloud_images_actions.html#add-new-cloud-support-to-a-multicloud-image--mci-).
!!info*Note:* If you have installed RightLink 10, the MultiCloud Image must be tagged with `rs_agent:type=right_link_lite`


###Linux
1. Launch a VM using the base image you wish to customize.
1. SSH to the operational VM and make any necessary modifications:
    - [Install RightLink 10](/../../../rl10/reference/rl10_install.html#overview-usage). Something like: 
        
        ```shell
        curl -s https://rightlink.rightscale.com/rll/10/rightlink.install.sh |
            sudo bash -s -l
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

4. Close the SSH session by typing: `exit`

5. **From your Workstation:** Shut down the VM that was already deprovisioned in the previous steps with:
[[[
### Azure PowerShell
``` PowerShell
Stop-AzureVM -Name <VM Name> -ServiceName <Cloud Service Name> -Force
```
###

### Azure CLI
``` shell
azure vm shutdown <VM Name>
```
###
]]]

1. **From your Workstation:** Capture the image:
!!info*Note:* The VM will be deleted as part of the capture process.
[[[
### Azure PowerShell
``` PowerShell
Save-AzureVMImage -Name <VM Name> -ServiceName <Cloud Service Name> -ImageName <New Image Name> -ImageLabel <New Image Label/Description>
```
###

### Azure CLI
``` shell
azure vm capture <VM Name> <New Image Name> --label <New Image Label/Description> --delete
```
###
]]]

1. The image will be captured as a vhd and saved in the same Storage Account as the source VM at the following path: `<Storage Account>/vhds/`.
At the same time it will also be registered as an Image within Azure.

1. Wait for RightScale Cloud Management to discover the newly registered image. This takes approximately 5-10 minutes.

1. Once RightScale Cloud Management has discovered the image, you can [add it to an existing MultiCloud Image](/../../../cm/dashboard/design/multicloud_images/multicloud_images_actions.html#create-a-new-multicloud-image) 
or [create a new MultiCloud Image](/../../../cm/dashboard/design/multicloud_images/multicloud_images_actions.html#add-new-cloud-support-to-a-multicloud-image--mci-).
!!info*Note:* If you have installed RightLink 10, the MultiCloud Image must be tagged with `rs_agent:type=right_link_lite`

##Helpful Links
* [Microsoft: How to install and configure Azure PowerShell](https://azure.microsoft.com/en-us/documentation/articles/powershell-install-configure/)
* [Microsoft: How to install the Azure CLI](https://azure.microsoft.com/en-us/documentation/articles/xplat-cli-install/)
