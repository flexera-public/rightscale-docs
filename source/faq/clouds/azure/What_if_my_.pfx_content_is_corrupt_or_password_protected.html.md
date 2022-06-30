---
title: What if my .pfx content is corrupt or password protected?
category: azure
description: This article describes a method for determining whether the .pfx file may be corrupt or password protected.
---

## Answer

If you received the error "Failed to create account: Data is not valid, can't create PFX certificate" when trying to upload your .pfx file during the add Azure flow, it may be corrupt or password protected.

The easiest wait to test the pfx file is to run commands shown below.

To extract the private key:

~~~
openssl.exe pkcs12 -in publicAndprivate.pfx -nocerts -out privateKey.pem
~~~

To extract the certificate:

~~~
openssl.exe pkcs12 -in publicAndprivate.pfx -clcerts -nokeys -out publicCert.pem
~~~

These two commands should succeed without prompting for a password.
