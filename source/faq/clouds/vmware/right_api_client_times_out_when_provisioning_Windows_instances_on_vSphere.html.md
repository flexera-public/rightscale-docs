---
title: right_api_client times out when provisioning Windows instances on vSphere
category: vmware
description: This article addresses an issue where right_api_client times out when provisioning Windows instances on vSphere.
---

## Overview

When provisioning instances in vScale using the 1.5 API (especially when using the right-api-client) and you see a gateway timeout during the launch method on the server object like the following:

~~~
/Users/<USER_ID>/.rbenv/versions/2.0.0-p451/gemsets/rsapi/gems/right_api_client-1.5.19/lib/right_api_client/client.rb:326:in `block (2 levels) in do_post': Error: HTTP Code: 504, Response body: <html><body><h1>504 Gateway Time-out</h1> (RightApi::ApiError)
The server didn't respond in time.
</body></html>
~~~

...this could be an issue with the timeout set in the RCA cloud appliance. Take note that this is an isolated specific use case and if you encounter this, follow the resolution below.

## Resolution

In order to fix this issue, you need to set the default timeout from right-api to vSphere to 20 minutes. To do this, from the (RCA) adapter side, you will need to perform the following:

1. In the RCA-V Admin UI, navigate to vCenter link on the left navigation column.
  * Click Upgrade button in the Cloud Appliance (**vScale**) card.
  * Download the latest package (**vscale_1.1_20140814_22**)
  * Activate the package that you just downloaded using Activate button.

2. SSH into the RCA-V adapter server and perform the following:

    ~~~
    $ sudo su
    $ cd /etc/nginx/sites-enabled
    $ vi vscale
    ~~~

3. Search the nginx configuration for **proxy_read_timeout** and change it to **1200** (it is currently set to 240) in /etc/nginx/sites-enabled/vscale

    ~~~
    location /gw {
        root /home/vscale/current/public;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header Host $http_host;
        proxy_pass http://vscale-app;
        proxy_read_timeout 1200;
    }
    ~~~

4. Save and then reboot the RCA-V VM.

5. In addition, if using right_api_client, the timeout will also needs to be passed as a parameter

    ~~~
    :timeout => 1200)
    ~~~
