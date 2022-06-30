---
title: Why do I see a Server Out Of Memory when running a powershell script to a server?
category: general
description: By default, a remote shell will be allocated 250 MB of memory, this may cause some of the command to fail, for example site collection creation.
---

## Overview

When running a powershell script in a boot sequence or as an operational script, you may encounter the following error:

~~~
> 10:34:30: Server Out Of Memory.  
> There is no memory on the server to run your program. Please contact your administrator with this problem.
~~~

When run directly on the box, it works fine, however it failed with the above error when used as a RightScript. That's because the script maybe invoking the PowerShell Remoting function, pssession.

## Resolution

By default, a remote shell will be allocated 250 MB of memory, this may cause some of the command to fail, for example site collection creation.  

Use the following command to increase the limit (run from elevated PS instance):

~~~
> set-item wsman:localhost\Shell\MaxMemoryPerShellMB 512
~~~

This is only necessary if you need to run those commands on that server.  

And for users wanting to invoke a script through RightScale as another user they need to use:

~~~
> Enable-WSManCredSSP -Role Server -Force  
> Enable-WSManCredSSP -Role Client -DelegateComputer $env:COMPUTERNAME -Force  
> enable-psremoting -force  
> $cred = new-object System.Management.Automation.PsCredential($runasuser,(ConvertTo-SecureString $RunasPassword -AsPlaintext -force))  
> $s = new-pssession -ComputerName $ENV:COMPUTERNAME -Credential $cred -Authentication Credssp  
> invoke-command -Session $s -ScriptBlock {Script to run}
~~~

<u><strong>Still need help?</strong></u>

If you still need help, feel free to open a ticket from the RightScale dashboard under the **Support -> Email** link in the top right corner.

Alternatively, email us at [support@rightscale.com](mailto:support@rightscale.com)
