---
title: Could not create SSL/TLS secure channel
category: general
description: This issue is likely being caused by the SSLv3 ciphers having been turned off because of the SSLv3 vulnerability and the TLS connection is not being handled correctly.
---

## Symptoms

This issue is likely being caused by the SSLv3 ciphers having been turned off because of the SSLv3 vulnerability and the TLS connection is not being handled correctly. You should be seeing an error similar to this:

~~~
15:01:49: Handling exception System.Management.Automation.MethodInvocationException: Exception calling "GetResponse" with "0" argument(s): "The request was aborted: Could not create SSL/TLS secure channel." 15:01:49: Base exception is System.Net.WebException: The request was aborted: Could not create SSL/TLS secure channel. 15:01:49: Response is not assigned.
~~~

## v13 and v14 Patch Scripts

The fix for this issue should be to use the update Powershell library Scripts which would setup a TLS connection upon installing the Powershell library rather than using SSlv3. These are the updated scripts for v13 and v14:

Updated v13.5.1-LTS Powershell script - [ https://www.rightscale.com/library/right\_scripts/SYS-Install-RightScale-Powersh/lineage/44020](https://www.rightscale.com/library/right_scripts/SYS-Install-RightScale-Powersh/lineage/44020)

Updated v14.0.1 (infinity lineage) Powershell script - [ https://www.rightscale.com/library/right\_scripts/SYS-Install-RightScale-Powersh/lineage/8497](https://www.rightscale.com/library/right_scripts/SYS-Install-RightScale-Powersh/lineage/8497)

## Manual Patch Instructions (for v12 and unsupported ServerTemplates)

Similar to the v13 and v14 patch scripts, you will need to modify the RightScale powershell script to use TLS rather than SSLv3.  To do so, follow the instructions below:

1. Navigate to **C:\Program Files (x86)\RightScale\RightLink\sandbox\RightScript\lib\rs**
2. Open `RsApiCallWithRetry.ps1` with a text-editor
3. **Find** the following line: `[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Ssl3;` and **replace** it with: `[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls;`
4. **Save** your changes, and run your script again to confirm the issue was fixed.
