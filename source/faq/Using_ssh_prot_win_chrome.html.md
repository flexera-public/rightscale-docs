---
title: Using ssh:// Protocol Links with Chrome on Windows
category: general
description: Some customers have reported issues attempting to log in to servers from Windows PCs using the Run a Java Applet option in the RightScale Cloud Management Dashboard.
---

## Overview

Some customers have reported issues attempting to log in to servers from Windows PCs using the **Run a Java Applet** option in the Cloud Management (CM) Dashboard (Settings > User Settings > SSH). If you are using the Chrome browser on the Windows operating system you will need to use the **ssh:// Protocol** option and Putty in order to successfully log in to servers using the ssh links in the CM Dashboard.

## Procedure

Here are the steps to properly configure your Windows PC to use the **ssh:// Protocol** option and Putty to log in to servers from the ssh links in the CM Dashboard.

1. Install and configure Putty, and download your Private SSH Key from RightScale as described in [How Do I Access Servers Using SSH.html](How_Do_I_Access_Servers_Using_SSH.html) - specifically the sections...
  * [Install the PuTTY Client and Download Private Key from RightScale](How_Do_I_Access_Servers_Using_SSH.html#install-putty)
  * [Convert Private Key to PuTTY-Friendly Format](How_Do_I_Access_Servers_Using_SSH.html#convert-key)
  * [Configure PuTTY to Use SSH Key-based Authentication](How_Do_I_Access_Servers_Using_SSH.html#putty-auth)
2. Download and unzip this <a href="ssh.vbs.zip" download>VBScript file</a> and place it in the Putty install directory on your PC. You may need to edit the script to point to the correct Putty install directory on your PC. (e.g., strSSH = "C:\program files
(x86)\putty\putty.exe")
3. Instruct the Windows operating system to use Putty to open ssh links from the Dashboard.
  * Download and unzip the example Windows registry file <a href="ssh.reg.zip" download>here</a>.
  * Edit the last line of the registry file as needed to point to the correct Putty install directory on your PC.
  * Run the registry file by double-clicking it.

* * *

#### Note for Firefox Users

If you are using FireFox on Windows you will need to tell FireFox to open ssh:// links externally.

1. In firefox, go to "about:config"
2. Right-click and select **New -> \<type specified below\>** and enter the values below.

* network.protocol-handler.external.ssh BOOL true
* network.protocol-handler.expose.ssh BOOL true
* network.protocol-handler.warn-external.ssh BOOL false
