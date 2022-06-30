---
title: How do I install Ruby or Python for Windows servers and instances?
category: general
description: Automate the installation of Ruby or Python for Windows process by using a Powershell script.
---

## Background

You are running a RightScale Windows Server or cloud instance and would like to install [Ruby](https://www.ruby-lang.org/en/) or [Python](http://www.python.org/) into the system for general use.

## Answer

Of course, you can always use the traditional method of manually downloading an installer via a web browser and manually installing it on a Windows server.&nbsp; However, a better way is to automate the installation process by using a Powershell script to accomplish the same task.&nbsp; You could either add one of the following Powershell RightScripts as a boot script on a Windows ServerTemplate or run it manually as an operational or any script.

### Ruby Install Powershell script

~~~
# Set up the download URL for ruby
$download_url = "http://rubyforge.org/frs/download.php/72170/rubyinstaller-1.9.2-p0.exe"

# Extract the name of the EXE from the URL
$installer_dest = "$env:temp\"+$download_url.Split('/')[-1]

# Download file using the .NET WebClient object
$webclient = New-Object System.Net.WebClient
$webclient.DownloadFile($download_url, $installer_dest)

# Execute the silent installer
Invoke-Expression "$installer_dest /silent"

# Remove the original installation file from the file system
Remove-Item $installer_dest -recurse
~~~    

### Python Install Powershell script

~~~
# Set up the download URL for python
$download_url = "http://www.python.org/ftp/python/3.1.3/python-3.1.3.amd64.msi"

# Extract the name of the installer from the URL
$installer_dest = "$env:temp\"+$download_url.Split('/')[-1]

# Download file using the .NET WebClient object
$webclient = New-Object System.Net.WebClient
$webclient.DownloadFile($download_url, $installer_dest)

# Execute the silent installer
Invoke-Expression "msiexec /i /qn $installer_dest"

# Remove the original installation file from the file system
Remove-Item $installer_dest -recurse
~~~

### See also

- [Using Windows MSI Installer](http://www.python.org/download/releases/2.4/msi/) (python.org)
- [How do I run Ruby or Python scripts on Windows Servers?](http://support.rightscale.com/06-FAQs/FAQ_0177_-_How_do_I_run_Ruby_or_Python_scripts_on_Windows_Servers%3F)
