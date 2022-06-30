---
title: How do I access 64-bit files and registry keys from a RightScript using PowerShell on a Windows instance?
category: general
description: Future versions of Windows RightImages will run the RightLink windows service completely under 64-bit processes on 64-bit instances.
---

**NOTE**: Future versions of Windows RightImages will run the RightLink windows service completely under 64-bit processes on 64-bit instances. Once these images are released, this article will contain a link to the new images. The work around described in this article only apply to Windows RightImages 5.6 and earlier.

The RightLink windows service, that runs on every Windows instance managed by RightScale, currently runs 32-bit processes under the hood even on 64-bit instances. The PowerShell processes used to run Rightscripts, as a result, are also 32-bit PowerShell processes.&nbsp;

The File System Redirector ( <a nocheck href='https://msdn.microsoft.com/en-us/library/aa384187(v=vs.85).aspx'>https://msdn.microsoft.com/en-us/library/aa384187(v=vs.85).aspx</a> ) and Registry Redirector ( <a nocheck href='https://msdn.microsoft.com/en-us/library/aa384232(v=vs.85).aspx'>https://msdn.microsoft.com/en-us/library/aa384232(v=vs.85).aspx</a> ) provide separate logical views for the registry and filesystem to 32-bit processes making it impossible for 32-bit processes to directly access files and registries settings affected by this redirection.

One of the new features of Powershell 2.0, that comes bundles with every RightLink-enabled instance, is remoting. Every 64-bit machine has two remote end points (64-bit and 32-bit) and the 64-bit end point is the default remote end point on a 64-bit instance.

Using the Invoke-Command cmdlet to send a remote command to the local machine, therefore, sends the remote command to a 64-bit listener allowing us to by pass the File System and Registry redirections. In order to use Invoke-Command, however, windows remote management (WinRM) needs to be enabled and configured on your windows instance. The following is an example of configuring your Window instance to accept remote command from localhost:

Create a RightScript with the following PowerShell Code and run it against your instance:

~~~
# Remove Remote UAC restrictions to allow changes to WinRM configuration
reg add HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v LocalAccountTokenFilterPolicy /t REG_DWORD /d 1 /f

# Check for existing WinRM listeners
$listener = winrm enumerate winrm/config/listener

# Configure a listener if it does not already exist
if ($listener -eq $null)
{
  winrm create winrm/config/listener?Address=IP:127.0.0.1+Transport=HTTP
}
~~~

Your instance should now be setup to allow remote commands issued from localhost. The following is an example of how you can now use Invoke-Command to access files and registry keys that are affected by the filesystem and registry redirections.

Create a RightScript with the following PowerShell code and run it against your instance:&nbsp;

~~~
# In order to access 64-bit files/registries from a 32-bit powershell process, use invoke-command
# to loop back to the local computer and pass-in your code using a script block. The default WinRM
# remote management listener is 64-bit.
#
# Below are some sample commands that demonstrates access to 64-bit files and registry keys

# This command will walk a registry and output Wow6432Node as part of the registry tree
# The Wow6432Node is normally inaccessible from a 32-bit process

invoke-command -computer 127.0.0.1 -scriptblock {gci 'HKLM:\Software'}

# The following commands list the file count for the system32 and syswow64 folders
# On 32-bit processes these counts would be identical as a result of the file system redirector
# On 64-bit processes they would be different.
# The following command should display different file counts as a result of using invoke-command

invoke-command -computer . -scriptblock {
  $System32FileCount = (gci c:\windows\system32).count
  $Syswow64FileCount = (gci c:\windows\syswow64).count
  Write-Output "The System32 file count is: $System32FileCount"
  Write-Output "The Syswow64 file count is: $Syswow64FileCount"
}
~~~

The output of the above should look similar to the following:&nbsp;

~~~
********************************************************************************
*RS> RightScript: 'AD: Sample for accessing 64-bit files and registry' ****
18:48:54: Hive: HKEY_LOCAL_MACHINE\Software
18:48:54: SKC VC Name Property PSComputerName
--- -- ---- -------- --------------
699 0 Classes {} 127.0.0.1
6 0 Clients {} 127.0.0.1
1 0 Gemplus {} 127.0.0.1
110 0 Microsoft {} 127.0.0.1
1 0 MozillaPlugins {} 127.0.0.1
2 0 ODBC {} 127.0.0.1
1 0 Policies {} 127.0.0.1
0 1 Program Groups {ConvertedToLinks} 127.0.0.1
1 0 Schlumberger {} 127.0.0.1
0 0 Secure {} 127.0.0.1
11 0 Wow6432Node {} 127.0.0.1
18:48:55: The System32 file count is: 1962
The Syswow64 file count is: 1755
*RS> Duration: 16.20 seconds
18:48:55: Script exit status: 0
18:48:55: Script duration: 12.189
18:48:55: Chef Run complete in 16.205 seconds
*RS> completed: AD: Sample for accessing 64-bit files and registry
~~~

The output above shows the registry key "Wow6432Node" that is normally in-accessible from a 32-bit Powershell instance. The output above also shows that the number of files in the System32 folder is different from the Syswow64 folder, implying that we are indeed accessing the actual system32 folder and not being redirected.

In summary, use the Invoke-Command cmdlet to issue a remote command to localhost and place your Powershell code inside invoke-command's script block to access 64-bit files and registry settings that are affected by the redirections.
