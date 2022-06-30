---
title: How to transfer files from EC2 to desktop using WinSCP
category: general
description: This article explains how to configure WinSCP to connect to an EC2 Server in order facilitate file transfer to and from your Windows desktop.
---

## Overview

This guide explains how to configure WinSCP to connect to an EC2 Server in order facilitate file transfer to and from your Windows desktop.

* * *
### Answer

1. Download WinSCP and install accordingly (choose double-pane view as recommended during installation). [http://winscp.net/download/winscp554setup.exe](http://winscp.net/download/winscp554setup.exe)  
2. If you already have a session running with the Server you want to connect and download the files from, WinSCP will notify you. This allows you to easily configure the login credentials for the EC2 instance you're connecting to.  
3. Copy your Private SSH key and save it on the notepad.  
4. From the Dashboard go to Clouds, select SSH Keys and open the SSH Key you assigned to the server. Copy and save to notepad the Key values starting from Begin and End Key.  
5. You will need to use Puttygen to convert the key to Putty Private Key format. So download and install the program if you have not already done so: [https://the.earth.li/~sgtatham/putty/latest/w32/puttygen.exe](https://the.earth.li/~sgtatham/putty/latest/w32/puttygen.exe)  
6. Open Puttygen, click on the Load button and locate the Private key you saved earlier, be sure to use the View All files so you can see the notepad file. Select the file and click Open, click Save to save the Private Key and then click OK.  
7. Now you are ready to configure WinSCP. Open WinSCP and in the Hostname field, enter the Public IP Address of the EC2 Host. In the Username field, enter 'root'.  
8. Click Advanced twice and go to SSH, then Authentication. In the Private key file, select the button with inline dots and select the Private key you converted to Putty format then click OK.  
9. Save the Server and click Login. WinSCP should connect automatically. If you get an error, review the steps above to ensure that you have not missed any.
