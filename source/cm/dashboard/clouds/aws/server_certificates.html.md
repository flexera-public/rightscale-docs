---
title: Server Certificates
description: A Server Certificate is required in order to create an Elastic Load Balancer (ELB) where client connections to the ELB use HTTPS. To create a server certificate you will need to upload a security certificate (CSR) and private key to AWS.
---

## Overview

A **Server Certificate** is required in order to create an Elastic Load Balancer (ELB) where client connections to the ELB use HTTPS. To create a server certificate you will need to upload a security certificate (CSR) and private key to AWS.

## Actions

* [Create an AWS Server Certificate](/cm/dashboard/clouds/aws/actions/server_certificates_actions.html#create-an-aws-server-certificate)
* [Create a Certificate Signing Request (CSR)](/cm/dashboard/clouds/aws/actions/server_certificates_actions.html#create-a-certificate-signing-request--csr-)

After you create your Server Certificate you can use it to add SSL Listeners over HTTPS by following the [Add Listeners to an Elastic Load Balancer](/cm/dashboard/clouds/aws/actions/load_balancing_actions.html#add-listeners-to-an-elastic-load-balancer) tutorial.

## Further Reading

* [Load Balancing](/cm/dashboard/clouds/aws/load_balancing.html)
* [How do I create an SSL certificate for my web server?](/faq/How_do_I_create_an_SSL_certificate_for_my_web_server.html)
* [How do I set up SSL?](/faq/How_do_I_set_up_SSL.html)
