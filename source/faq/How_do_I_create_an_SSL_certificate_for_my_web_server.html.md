---
title: How do I create an SSL Certificate for my web server?
category: general
description: Before you can use SSL (Secure Socket Layer) to encrypt your web traffic, you must have an SSL certificate, which you will associate with your ServerTemplate.
---

## Background Information

Before you can use SSL (Secure Socket Layer) to encrypt your web traffic, you must have an SSL certificate, which you will associate with your ServerTemplate. Generally, SSL certificates used with production servers are issued by third-party certificate authorities (CAs).

Before a certificate authority will issue an SSL certificate, you must provide them with a CSR (certificate signing request) containing encrypted company and website information.

* * *

## Answer

Below are the basic steps required to obtain an SSL server certificate from a CA and assign it to a ServerTemplate:

1. Generate a private key file and CSR file for your web server.
2. Provide the certificate authority with the contents of your CSR.
3. Attach the SSL server certificate received from the CA to your RightScale ServerTemplate. (See the article titled [How do I set up SSL?](http://support.rightscale.com/06-FAQs/FAQ_0007_-_How_do_I_set_up_SSL%3F).)

You can generate the necessary public CSR and associated private key using OpenSSL. After connecting to a server instance via SSH, you can run a command string like the following:

~~~
openssl req -new -nodes -keyout myserver.key -out server.csr
~~~

More information on CSRs can be found on Wikipedia at [http://en.wikipedia.org/wiki/Certificate\_signing\_request](http://en.wikipedia.org/wiki/Certificate_signing_request).

Some third-party certificate authorities (CAs) issuing SSL certificates are:

* Symantec
* VeriSign
* Thawte
* InstantSSL (Comodo)
* Entrust
* GeoTrust
* GoDaddy
