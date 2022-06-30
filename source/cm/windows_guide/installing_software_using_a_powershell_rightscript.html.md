---
title: Installing Software Using a PowerShell RightScript
description: Steps for installing software on a Windows Server using a PowerShell RightScript in the RightScale Cloud Management Platform.
---

## Overview

A common use case for Windows users is need to install various pieces of software on a running Windows Server. The aim of the tutorial is to use PowerShell to install Firefox as an example. This will help to draw attention to the individual steps and also the different PowerShell constructs involved.

Before you begin you may wish to RDP into your running Windows server so you can see the installation activity as you run the scripts. In particular, if you open Windows Explorer you should see new directories being created under 'C:\Program Files(x86)'.

## Prerequisites

This tutorial assumes you have a running Windows Server, and access to the software installation files. If you do not have a Windows server running, you could launch one using the 'Base ServerTemplate for Windows' ServerTemplate from the Marketplace.

## Steps

### Create the Firefox Install RightScript

To install the software on the server we will create a RightScript and attach to it the relevant installation files. When we run the script these installation files will be copied over onto the server. If you have never created a RightScript before, see [Create a New RightScript](/cm/dashboard/design/rightscripts/rightscripts_actions.html#create-a-new-rightscript).

Download the Firefox Installer ([Firefox_Setup_42.0.2](https://s3-us-west-2.amazonaws.com/rs-docs-assets/Firefox+Setup+41.0.2.exe)) and the INI file ([firefox_quiet_install.ini](https://s3-us-west-2.amazonaws.com/rs-docs-assets/firefox_quiet_install.ini)) locally to your PC. You will attach these to your RightScript a little later.

1. To create the RightScript, navigate to **Design** > **RightScripts**. Click **New**, and enter the name and description for your installation RightScript. Copy the following and paste it into the Script area:

    ~~~
    # Windows powershell RightScript to install Firefox browser

    #stop and fail script when a command fails
    $errorActionPreference="Stop"

    if (${env:programfiles(x86)})
      { $firefox_path = join-path "${env:programfiles(x86)}" "Mozilla Firefox" }
    else
      { $firefox_path = join-path "${env:programfiles}" "Mozilla Firefox" }

    if (test-path $firefox_path)
    {
       Write-Output "Firefox already installed. Skipping script"
       exit 0
    }

    cmd /c "$env:RS_ATTACH_DIR\Firefox Setup 41.0.2.exe" /INI="$env:RS_ATTACH_DIR\firefox_quiet_install.ini"

    #Permanently update Windows Path
    if (Test-Path $firefox_path)
    {
      [environment]::SetEnvironmentvariable("Path", $env:path+";"+$firefox_path, "Machine")
    } Else {
      Write-Error "Failed to install FireFox. Aborting."
      exit 1
    }
    ~~~

2. Click **Save**.
3. Click the script's **Attachments** tab, and upload the following files that you downloaded to your local machine earlier.
  * **Firefox Setup 41.0.2** - Firefox Installer
  * **firefox_quiet_install.ini** - INI file

### Run the Script on the Server

1. Navigate to **Manage** > **Instances & Servers** and filter for Running Instances.
2. Click your running Windows server and select the Scripts tab. Expand the 'Any Script' section and click the **Select a Script to Run** button.
3. Click 'Unpublished', click on your new script in the RightScripts column, click the **Select** button, then click the **Run** button.

Wait for the script to complete before going to the next step.

### RDP into the Server

1. To verify the successful installation of Firefox, RDP into the Windows Server. *Note*: TCP port 3389 must be open in the server's security group.
2. Use the RDP server button or use your preferred RDP client with the public IP of the server. You should see Firefox as successfully installed under **Start** > **All Programs** > **Mozilla Firefox**.

![cm-firefox-installed.png](/img/cm-firefox-installed.png)

## Post Tutorial Steps

Once completed, remember to shut down the server (if no longer required) in order not to incur any unnecessary charges.

## Further Reading

* [How do I install Ruby or Python for Windows servers and instances?](/faq/How_do_I_install_Ruby_or_Python_for_Windows_servers_and_instances.html)
* [How do I run Ruby or Python scripts on Windows Servers?](/faq/How_do_I_run_Ruby_or_Python_scripts_on_Windows_servers.html)
