---
title: Why do I receive "permission denied" errors setting up MySQL servers?
category: general
description: The error is caused by a space in the DNS Made Easy username and password.
---

## Background Information

When you try and set up MySQL servers, you get the following error message:

~~~
Permission denied (publickey,gssapi-with-mic)
~~~

Audit entries shown below:

~~~
debug1: Trying private key: /root/.ssh/id_dsa
debug1: No more authentication methods to try.
Permission denied (publickey,gssapi-with-mic).
~~~

* * *

## Answer

The error above is caused by a space in the DNS Made Easy username and password.
