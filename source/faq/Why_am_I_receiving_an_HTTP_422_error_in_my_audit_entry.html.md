---
title: Why am I receiving an HTTP 422 error in my audit entry?
category: general
description: This error is an API call failure. Currently, the known reasons for this error include Amazon Web Services EBS volume limits exceeded, more than 16 EBS snapshots in a "pending" state, or a MySQL server that is neither a master nor a slave.
---

## Background Information

You receive an HTTP 422 error when you run certain scripts.

* * *

## Answer

This error is an API call failure. Currently, the known reasons for this error are:

1. You have exceeded the Amazon Web Services EBS volume limit (see [Increase my AWS limits](http://support.rightscale.com/09-Clouds/AWS/01-AWS_Basics/How_do_I_increase_my_AWS_limits_(EC2%2C_EBS%2C_EIP)%3F)). You will need to delete some of your volumes.
2. You have more than 16 EBS snapshots in a "pending" state.
3. You are trying to perform a backup on a MySQL server that is neither a master nor a slave.
4. There may be other causes that are not yet documented.
5. You use the API to run a script, and that script is missing an input.
