---
title: How do I set up SSL?
category: general
description: To enable SSL (TLS) with your load-balancer server(s), you must add a RightScript to your load balancer's ServerTemplate.
---

*Note**: These instructions only apply to the 11H1 ServerTemplates. SSL is supported by default in the newer LTS and Infinity ServerTemplates. See&nbsp; [3 Tier Deployment Setup (PHP)](http://support.rightscale.com/ServerTemplates/v12.11_LTS/Supplemental/3_Tier_Deployment_Setup_(PHP)) for an example.

* * *

## Answer

To enable SSL (TLS) with your load-balancer server(s), you must add a RightScript to your load balancer's ServerTemplate, which will:

* Create an HTTPS virtual host (vhost) on the Apache HTTP server.
* Perform SSL termination on the load-balancer server for incoming client connections.
* Forward plain/unencrypted HTTP requests to application servers via HAProxy.

**Note**: Unencrypted HTTP requests are forwarded to the application servers on the internal network. To perform SSL termination on the application servers (behind your load balancers), please refer to the Stunnel documentation ( [http://www.stunnel.org/](http://www.stunnel.org/) ).

## Prerequisites

1. Ensure that your load-balancer server(s) are using a security group with TCP port 443 open for SSL/TLS connections.
2. If you would like to enable SSL on boot, ensure that you are using an editable (cloned or private) ServerTemplate. If your servers are using an imported ServerTemplate, clone the ServerTemplate and update your server(s) to use the cloned one instead.

## Procedure

1. Locate your SSL server certificate and private key (in X.509/PEM format). For development and testing purposes, you may generate a self-signed certificate using a tool such as OpenSSL.

    ~~~
    openssl req -new -x509 -nodes -out /tmp/public.pem -keyout /tmp/private.pem -days 365
    ~~~

2. Retrieve the created files from the /tmp directory.

3. Create credentials (Design -> Credentials) for your certificate and private key (e.g. "TLS Self-Signed Cert" and "TLS Self-Signed Key") using the certificate and key contents.

4. Import the WEB apache FrontEnd https vhost RightScript from the MultiCloud Marketplace and add it as a boot script to your ServerTemplate, after or replacing the existing "WEB Apache frontend http vhost" boot script. (Replace the existing "http vhost" RightScript if you want to enable HTTPS connections only and disallow connections via port 80; otherwise, simply add the "https vhost" RightScript after the "http vhost" script.)

5. Edit and save the the required input values (if not already set for your ServerTemplate, deployment, or server). Set optional (OPT) inputs to "ignore" if not used.

    | Input Value | Description |
    | ----------- | ----------- |
    | APPLICATION | The directory for your application's web files (/home/webapps/_APPLICATION_/current/); e.g. testapp. |
    | OPT_MAINTENANCE_PAGE | Maintenance URI to indicate whether the page exists (based on document root). |
    | OPT_SSL_PASSPHRASE | If your SSL certificate requires a password, you must enter it here. |
    | SSL_CERTIFICATE | The contents of the server SSL certificate, from the certificate file; e.g. cred:TLS Self-Signed Cert. |
    | SSL_KEY | The contents of the SSL private key file; e.g. cred:TLS Self-Signed Key. |
    | WEBSITE_DNS | Fully qualified domain name that clients use to connect to the server; e.g. text:www.example.com. |

6. The server is now ready to launch. You can test the SSL/TLS connection by navigating to https://\<WEBSITE_DNS>/ in your web browser.

### See also

[How do I force clients to connect via HTTPS?](http://support.rightscale.com/06-FAQs/FAQ_0155_-_How_do_I_force_HTTPS_on_my_frontends%3F/index.html)
