---
title: Why are email messages sent from EC2 undelivered or flagged as spam?
category: aws
description: The problem with sending email from EC2 instances is that when Reverse DNS lookups were performed on Elastic IP addresses to validate the sender, an Amazon domain would be returned and many anti-spam software programs would subsequently label the email as SPAM.
---

## Background Information

You send various emails to users such as account activations and password resets, directly from servers on EC2, but many of these email messages are undelivered or flagged as spam. Is it possible to send email reliably via servers on EC2? If not, what are my options?

* * *

## Answer

The problem with sending email from EC2 instances is that when Reverse DNS lookups were performed on Elastic IP addresses to validate the sender, an Amazon domain would be returned and many anti-spam software programs would subsequently label the email as SPAM. In April 2010, Amazon introduced support for configuring reverse DNS (RDNS) records for your Elastic IPs.

To apply for RDNS, you must complete Amazon's [Request to Remove Email Sending Limitations](https://aws-portal.amazon.com/gp/aws/html-forms-controller/contactus/ec2-email-limit-rdns-request) form.

The example below illustrates how to check the RDNS entry for Elastic IP (174.129.248.247) and Reverse DNS Record (mail.example.com). Before you apply for an RDNS record from Amazon, a reverse DNS lookup will return an amazonaws.com subdomain.

~~~
root@domU-12-31-39-07-C0-41:~# host mail.example.com
mail.example.com has address 174.129.248.247
root@domU-12-31-39-07-C0-41:~# nslookup 174.129.248.247 | grep arpa
247.248.129.174.in-addr.arpa name = ec2-174-129-248-247.compute-1.amazonaws.com.
~~~

When the RDNS request is complete, the nslookup command should return the following:

~~~
root@domU-12-31-39-07-C0-41:~# nslookup 174.129.248.247 | grep arpa
247.248.129.174.in-addr.arpa name = mail.example.com
~~~
