---
title: Perform a Health Check Test
layout: cm_layout
description: Steps and procedures for performing a standard health check test to make ensure proper communication between HAProxy load balancers and the application servers in a RightScale Deployment.
---
## Objective

To perform a standard health check test to make ensure proper communication between HAProxy load balancers and the application servers in its load balancing pool.

## Prerequisites

* A running 3-tier deployment that's based on the v12.11 LTS or Infinity ServerTemplates published by RightScale.
* Load Balancer tier must be HAProxy
* 'designer', 'actor', and 'server\_login' user role privileges

## Overview

In this tutorial, you will perform the following actions:

* Create a RightScript that tests the connection between the load balancers and application servers.
* Customize a Chef-based ServerTemplate by adding a RightScript.
* Modify the current inputs on running servers.
* Test the script and save the changes.

## Steps

### Check the Load Balancing Pool

The first step is to check your load balancing pool to make sure that you have at least two operational application servers. There are two different ways to check the load balancing pool to make sure that all running application servers are properly connected to a load balancer.

#### SSH

The following test shows a mapping of the Resource ID of the array servers with their internal, Private IP Address. In the example below, the traffic to these servers is routed over port 8000.

1. SSH into one of the running load balancer servers.
2. Run the following shell command to view the HAProxy configuration file (/etc/haproxy/haproxy.cfg)
~~~
    cd /home/haproxy/
    less rightscale_lb.cfg
~~~
3. Scroll to the bottom of the return message (spacebar) and you should see entries for each application server in the load balancer pool, similar to the following:
~~~
    server i-f3ee8795 10.203.85.169:8000 check inter 3000 rise 2 fall 3 maxconn 255
    server i-a3d1b8c5 10.204.97.84:8000 check inter 3000 rise 2 fall 3 maxconn 255
~~~

#### HAProxy Status Page

Add **"/haproxy-status"** to the end of the URL to see which application servers are part of the HAProxy load balancing pool. (e.g. www.example.com/haproxy-status)

![cm-ha-proxy-status.png](/img/cm-ha-proxy-status.png)

You should see the instance ID of each operational application server. If an application server is properly connected to the HAProxy servers in the load balancing tier, it will be listed in a row highlighted in green. If the server is highlighted in red, the application server is not in the load balancing pool and will not receive any requests from a load balancer server.

### Create a RightScript

The next step is to create a simple RightScript that tests the ability of the load balancers to send incoming requests to the application servers in a rotating fashion.

1. Go to **Design > RightScripts > New**.
2. Provide the following information about the RightScript.
  * **Name** - Enter a name. (e.g. Load Balancer Test)
  * **Description** - Provide a simple description. (e.g. "Simple test for the HAProxy load balancers and the application servers in its load balancing pool.")
  * **Script** - Copy and paste the following code, which creates a webpage ( **servername.html** ) that will display the instance ID of the application server that's used for the current session.

        ~~~
        #!/bin/bash -ex
        cat > /home/webapps/$APPLICATION_NAME/servername.html << EOF
        <html><body><center><h1>Which application server am I connected to?</h1>
        <h2>Instance ID: <font color="blue">
        EOF
        cat /var/spool/cloud/meta-data/instance-id >> /home/webapps/$APPLICATION_NAME/servername.html
        cat >> /home/webapps/$APPLICATION_NAME/servername.html << EOF
        </font></h2></center></body></html>
        EOF
        ~~~
  * **Packages** - Leave this field blank.
  * **Inputs** - After pasting in the sample code, click the **Identify** button to show all of the user configurable inputs in the script. For this example, you will only have one input ('APPLICATION_NAME').
    - **Enabled** - Make sure the input is enabled. The checkbox should be checked.
    - **Input Type** - Since the application name will be a string value, use the "Input is a single value" option. (default)
    - **Default Value** - You have the option to create a default value for this input. For this example, keep the "None" option. (default)
    - **Category** - Select under which category the input will displayed under in the Inputs tab. Select the "Application" option.
    - **Input description** - Enter a brief description for the input. (e.g. The application name.)

3. Click **Save**.
4. Since you haven't tested the script yet to verify that there are no errors in your code, there is no reason to commit the script. You will use the editable HEAD version of the script until you can test its functionality.

### Test the Script

A common misconception is that you can't use RightScripts in a ServerTemplate that primarily uses Chef cookbooks and recipes. In fact, you may find it easier to create simple RightScripts to perform simple actions instead of creating a Chef recipe that accomplishes the same task.

#### Running Server (Committed Revision)

1. To test the script on a running application server that was launched with a committed (uneditable) ServerTemplate, you can go to the **Scripts** tab of the "current" running server and use the 'Any Script' option to select and run the new RightScript. (*Tip*: It will be located under the "Unpublished" Publisher category in the script selector.)
2. Use the same value for the **APPLICATION\_NAME** input that you used for the " **Application Name**" input under the "WEB\_APACHE" category. (_Tip_: You may want to check your settings in a different web browser tab.)
3. Wait for the script to be 100% completed. You can track the status under the Events pane or under each running server's **Audit Entries** tab.
4. Repeat the steps above across all running application servers.

#### Running Server (HEAD)

1. If you are using a server or array that's using an editable HEAD version of the application ServerTemplate, go to the **Scripts** tab of the ServerTemplate and add the new RightScript to the Operational Scripts list so that it will automatically appear as an executable script on your running application servers. (_Tip_: It will be located under the "Unpublished" Publisher category in the script selector.)  
  ![cm-add-blt-test-script.png](/img/cm-add-blt-test-script.png)
2. Go to the **Inputs** tab of the "current" running server. Edit the inputs and enter the same value for the **APPLICATION\_NAME** input that you used for the " **Application Name**" input under the "WEB\_APACHE" category.
3. Go to the **Scripts** tab of the running application server and run the script.
4. Wait for the script to be 100% completed. You can track the status under the Events pane or under each running server's **Audit Entries** tab.
5. Repeat the steps above across all running application servers.

### Check the Webpage

Since a server's scripts are defined by its ServerTemplate and you launched the application server(s) with an editable HEAD version of the application ServerTemplate, you can now test the script on a running server.

1. In a new browser window, view the **servername.html** web page that the RightScript just created on the application server. Construct a URL using the FQDN associated with the load balancer servers (e.g. www.example.com/servername.html) or use the public IP address of a load balancer server (e.g. 204.33.451.23/servername.html). You should see a web page that displays the instance ID of the application server that responded to the web request.
2. Refresh the browser to verify that the load balancer servers are properly sending requests to all of the application servers in a round-robin fashion. Refresh the browser a few more times to see all of the application servers in the load balancing pool. (_Tip_: It sometimes helps to click the refresh button really fast if the instance ID does not change after each refresh.)<br>
  ![cm-web-instance-id2.png](/img/cm-web-instance-id2.png)

### Commit the Changes

If the previous test was successful and you want to save the changes, commit the ServerTemplate. Since the ServerTemplate has a HEAD RightScript, you will be prompted to also commit the RightScript as part of the same action. Make sure the checkbox is checked. When you commit a HEAD ServerTemplate that references a HEAD RightScript, both components will be committed and new, static revisions will be created. The new ServerTemplate revision will reference the latest revision of the RightScript. However, the HEAD ServerTemplate will continue to reference the HEAD RightScript so that you can continue to make modifications to the script, which is useful during development cycles. However, if you do not want to make any further changes to the script, you can select the most recently committed revision of the RightScript under the HEAD ServerTemplate's Scripts tab.

1. Go to the custom application ServerTemplate and click the **Commit** action button.
2. Leave a descriptive commit message that explains all of the changes and click **Commit**.  
  ![cm-commit-php.png](/img/cm-commit-php.png)
