---
title: How do I configure my native SSH client to work with RightScale?
category: general
description: In order to start an SSH session, RightScale must determine which terminal emulator to use and which SSH client to use. This choice is influenced by which operating system you are running and by the applications you have installed.
---

## Background Information

When you initiate an SSH connection to a running server, the RightScale Dashboard lets you use a Java Web Start application, a Java Applet, or ssh:// protocol links for launching your SSH session. You can specify your SSH client preference under **Settings -> User Settings -> SSH**.

Before you can SSH into a machine, you must first ensure that port 22 is open for the security group that the server belongs to.

**Note**: If you are using the Java Web Start Application or Java Applet for launching your SSH session from RightScale you will need Java installed (5.0 Update 9 or later). You can verify whether Java is enabled for your browser <a nocheck href="https://www.java.com/en/download/installed.jsp">here</a>, and download Java (if needed) <a nocheck href="http://java.com/en/download/index.jsp">here</a>.

* * *

## Answer

In order to start an SSH session, RightScale must determine which terminal emulator to use and which SSH client to use. This choice is influenced by which operating system you are running and by the applications you have installed.

If you are running Microsoft Windows, a terminal emulator program is not always needed; GUI SSH clients such as PuTTY provide their own terminal emulator functionality. However, Windows does not ship with an SSH client pre-installed. Therefore, you will need to install one before using SSH:

* [Dowload PuTTY installer](http://www.chiark.greenend.org.uk/~sgtatham/putty/download.html)
* [Download OpenSSH for Windows](https://github.com/PowerShell/Win32-OpenSSH/releases/latest/)

Mac OS X and Linux both ship with OpenSSH, so an SSH client is always available. However, a separate terminal program is required under both operating systems, and the choice of which terminal program to use is not always clear.

The RightScale SSH launcher currently uses a hard-coded list of terminal programs and clients for each OS. It scans through the list in order and launches the first available client. At this time, there is no way for end users to influence the order in which we select the client application to use.

### Mac OS X

| SSH Client | Notes |
| ---------- | ----- |
| OpenSSH + iTerm | How do I set iTerm2 as the handler for ssh:// links?<br>1. Create a new profile called "ssh". In the General tab, select the Command: button and enter $$ as the command.<br>2. In Preferences->Profiles->General, select "ssh" for "Select URL Schemes...." |
| OpenSSH + Terminal.app | |

### Linux/Unix

| SSH Client | Notes |
| ---------- | ----- |
| OpenSSH + GNOME Terminal | |
| OpenSSH + Konsole | |
| OpenSSH + Xterm | |

### Windows

| SSH Client | Notes |
| ---------- | ----- |
| PuTTY | Must be installed to "C:\Program Files (x86)\PuTTY\" |
| Windows Command Prompt + OpenSSH | Should be installed to a folder named "OpenSSH" under Program Files. |
| Windows Command Prompt + Generic SSH client | If a program named SSH.exe is found anywhere in your search path, the launcher prompts you to invoke it. The client's command-line interface should be OpenSSH-compatible. |

## What to do if you receive permission denied when clicking on SSH links?

If you choose to use ssh:// protocol links to ssh into your servers, you will need to make sure your private key is added to your authentication agent.&nbsp; OpenSSH in particular defaults to id\_rsa, which may not be the right key to use to ssh into your Servers.

To resolve this issue, download your private key from RightScale's Cloud Management dashboard under **Settings -> User Settings -> SSH**.

Then on the command prompt, run the ssh-add command with the recently downloaded private key file name. This will add your private key identity to the authentication agent.

**Your Feedback Is Important**

If you use an SSH client that is not listed above, or if you find that the launcher invokes a program other than the one you prefer, please let us know via the public feedback tracker at [http://feedback.rightscale.com](http://feedback.rightscale.com). Simply create an "idea" for your preferred SSH client, and vote for it.
