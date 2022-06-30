---
title: How do I SSH to a MyCloud instance?
category: general
description: This article describes how to SSH directly to your new MyCloud instance from your own network.
---

## Background

You've tried to SSH directly to your new MyCloud instance from your own network, but you keep getting the "Access Denied Public Key" message.

## Answer

Open the [RightScale Dashboard](https://my.rightscale.com/), navigate to the deployment that contains your new MyCloud instance, and click the SSH button. This will initiate an SSH session according to your configuration in **Settings > User Settings > SSH** and launch your default SSH application on your desktop. This will provide a direct SSH connection from your machine to the MyCloud instance and will also provide your private key to the SSH session, allowing the connection to succeed. After you have done this, provided you have set the security groups for the server instance to allow SSH via the local network, you could either set up password logins on the machine, or create your own private key and add it to the machine.

### See Also

- [How do I configure my native SSH client to work with RightScale?](http://support.rightscale.com/06-FAQs/FAQ_0062-_How_do_I_configure_my_native_SSH_Client%3F)
