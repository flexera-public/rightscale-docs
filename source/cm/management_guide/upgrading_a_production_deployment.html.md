---
title: Upgrading a Production Deployment
layout: cm_layout
description: Whenever you upgrade your Production deployment, it's critical that you have a properly detailed upgrade strategy. Here are the steps for performing software upgrades in a RightScale Production Deployment.
---
The following software upgrade strategies provide general guidelines and principles. Please use discretion at all times to develop your own software upgrade strategies that are sufficient for your application and environment.

## Overview

Whenever you upgrade your Production deployment, it's critical that you have a properly detailed upgrade strategy. Although, you have a lot more flexibility in the Cloud, it's important that you take the necessary precautions to fully protect your site during a major upgrade. The steps below provide general guidelines and upgrade strategies for performing major site upgrades in the Cloud. In all cases, we recommend that you create your own upgrade plan that's customized for your own deployment.

## Objective

The upgrade procedure below is designed for performing a major software upgrade to a live production deployment. This procedure assumes that you are making changes to your database that would otherwise break your current application. A period of site downtime is mandatory.

![cm-major-upgrade-with-staging1.png](/img/cm-major-upgrade-with-staging1.png)

## Steps

1. Before you perform any changes to your production database, test and make sure backups are working correctly.
2. This software upgrade assumes that you're already following best practices and that you've been using a separate Staging Deployment for testing the new software release with all of your upgrades. See [Create a Staging Deployment](/cm/management_guide/create_a_staging_deployment.html) **.**
3. Once you're convinced that the Staging Deployment has been sufficiently tested, you can start the upgrade process.
4. The first step is to prepare your database for the upgrade.
5. Create an additional Slave-DB that will serve as a "warm" backup of your database. Clone the Slave-DB server.
 ![cm-major-upgrade-with-staging2.png](/img/cm-major-upgrade-with-staging2.png)
6. Make sure that the new slave will initialize to the master at boot time. Under its Inputs tab, set the input variable, INIT_SLAVE_AT_BOOT = true. Be sure to disable backups on the additional "warm" slave ("DB EBS continuous backups" RightScript). Launch the new Slave-DB server. It will take several minutes for the new slave to become operational and catch up to the Master-DB.
7. In this example, you're only going to upgrade the application servers. You're going to keep the old load balancers. In order to test and make sure that the new application server(s) can communicate properly via HAProxy, set up a temporary load balancer inside of your production deployment that will only be used for internal testing of the new application servers. Clone one of the existing dedicated load balancers. Before you launch the cloned load balancer, you'll need to change the following inputs at the server level in order to isolate it from your production setup.  
 LB_APPLISTENER_NAME = test1  
 LB_HOSTNAME = test1.mysite.com  
 ![cm-major-upgrade-with-staging4.png](/img/cm-major-upgrade-with-staging4.png)
8. Create new DNS A records that allow you to access the new application servers via the new load balancer directly through HAProxy (but not through 'www'). For example, you should create an A record for 'test1.mysite.com' that points to the new load balancer (load balancer-3).
9. Launch the new load balancer (Load Balancer-3).
10. Clone an application server in the production Deployment that you want to upgrade and rename it (e.g. App Server-3). Change the LB_HOSTNAME input at the server level (e.g. test1.mysite.com) to ensure that the new application server connects to the temporary load balancer and not to your production load balancers. Modify any of the server's configurations that you want to change (except the application code). For example, change the ServerTemplate revision, select a different RightImage, change the instance type, etc.  
 ![cm-major-upgrade-with-staging9.png](/img/cm-major-upgrade-with-staging9.png)  
11. Launch the "App Server-3" server (with the old application code) and test to make sure that it can connect to the database correctly. Use the new DNS A record (e.g. test1.mysite.com) to view the new application server via HAProxy.
12. Once the server's configuration is stable, you can now update the application code. Modify the "App Server-3" server's inputs at the Server level so that it grabs the new application code. (e.g. SVN_APP_REPOSITORY, APPLICATION, etc.) Run the appropriate code update/checkout RightScript (e.g. WEB app svn code checkout, RB rails svn code update) to load the new application code. It's now ready to talk to the database once you finish the migration of the database. Most likely you will no longer be able to test the new application server because the new application is probably incompatible with the current database schema.
13. If the new application server looks stable, clone the upgraded server ("App Server-3") until you have equal number of new servers as old servers. Launch and test the new servers. If everything looks good, lock the servers so you don't accidentally terminate the wrong application servers at the end of the upgrade.  
 ![cm-major-upgrade-with-staging5.png](/img/cm-major-upgrade-with-staging5.png)  
14. If you have a Server Array, you should create a new one with a different name. This way, you can simply disable the old server array and enable the new one. Create a new Server Array that uses the new ServerTemplate so that it has the same configuration settings as the new application servers. Since you do not want new instances to inherit the old input parameters from the Deployment level, you will need to overwrite some inputs at the server array level. (e.g. SVN_APP_REPOSITORY, APPLICATION, etc.) The new Server Array should mirror the configurations and changes of the new application servers in the Deployment.
15. Disable database backups on both the master and slave database servers since it doesn't make sense to take a backup of your database during a migration.
16. Disconnect the new application servers from the temporary (cloned) load balancer by running the "LB Application to HA proxy disconnect" Operational Script on each application server.
17. ==BEGIN SITE DOWNTIME==
18. Put up a maintenance page on the frontend load balancer servers. You can add our "WEB rails maintenance start/stop" RightScripts to the load balancers as Operational Scripts. When you run the "start" script on the servers, it will add an Apache rewrite rule that forces new requests to the maintenance page.
19. Stop old server processes on any production server (including any servers in the array). Check the monitoring graphs of the master database server to make sure that there are no more writes to the database.
20. Before you start any of your database migrations create a manual backup (EBS Snapshot) of your Master-DB by running the "DB EBS backup" Operational Script. If the upgrade is not successful, you can always revert back to the original state of your database before the upgrade began by promoting the new slave ("warm" backup) to master. And if there's a problem with the "warm" backup, you also have a snapshot of the master database as a secondary backup.
21. Check to make sure that a slave is in-sync with the master, you can SSH into the instance and run the following MySQL command.
  - `mysql> show slave status\G`
  - You must wait for the "warm" slave to be in-sync with the master ( "`Seconds_Behind_Master: 0`") before continuing to the next step.
22. Stop database replication with the master, but do not shut it down. The new slave will serve as the "warm" backup.  
 ![cm-major-upgrade-with-staging3.png](/img/cm-major-upgrade-with-staging3.png)  
23. You can now change to your database schema. Go ahead and run your database migrations. Be sure to test your new application servers and make sure that they can still talk to the modified database.
24. It's now time to replace your old application servers with the new ones. Disconnect the old application servers from the load balancers by running the "LB Application to HA proxy disconnect" Operational Script on each application server. No application server should be connected to a load balancer.  
 ![cm-major-upgrade-with-staging6.png](/img/cm-major-upgrade-with-staging6.png)
25. Connect the new application servers to the old load balancers. Change the LB_HOSTNAME input at the server level on all new application servers so that it matches what is defined at the deployment level. Run the "LB Application to HA proxy connect" Operational Script on each new application server at the Deployment level. Make sure that no input is defined under the "Next" server launch of the new application servers that will incorrectly overwrite an input that should be inherited from the Deployment level. Later, you will need to clean up your input overrides that you've defined at the Server level.
 ![cm-major-upgrade-with-staging7.png](/img/cm-major-upgrade-with-staging7.png)
26. If necessary, restart your application. (e.g. Rails, TomCat)
27. Disable the old server array. (if applicable)
28. Enable the new server array. (if applicable) Launch the minimum number of server instances into the array that are required prior to making the site live.
29. Restart server processes on the new production servers (including any servers in the array).
30. Test the site. If there's a problem and you need to revert back, you can always use the original "warm" slave and promote it to master. If the changes are small, you can still make minor software upgrades in-place at your own discretion.
31. Once everything looks solid and you're ready to make the site "live" again, you can take down the maintenance pages. Run the "WEB rails maintenance stop" RightScript on the load balancers so that any new incoming requests will be forwarded to the new application servers.
32. Now that you've finished the upgrade, take another snapshot of your Master-DB to capture all of your changes.
33. ==END SITE DOWNTIME==
34. Enable database backups on master and slave servers. Do not enable backups on the "warm" slave.
35. Check to make sure that the Alerts and Server Array are working as expected.
36. The inputs that are defined at the Deployment level are old. It's time to clean up your inputs. During the upgrade you had to define some inputs at the Server and Server Array levels. However, now that the new site is live, you need to make sure that the correct inputs will once again be inherited at the Deployment level for future server launches/relaunches. Check the inputs ("Current" Server -> Inputs) for all new application servers and add any of those input parameters that you want to be inherited to the Deployment level. Remove any inputs that are defined at the Server level. i.e. No inputs should be defined for the "Next" server. Make sure none of these inputs are defined for the "Next" server. If you have a new Server Array, you will also need to make the same modifications at the Server Array level. Basically, you want all new/relaunched servers to once again inherit their inputs from the Deployment level.
  - SVN_APP_REPOSITORY, APPLICATION, LB_HOSTNAME, LB_APPLISTENER_NAME
37. Terminate old application servers and "warm" Slave-DB when convenient. Terminate the new, temporary load balancer. You no longer need it for testing purposes. Terminate servers in the old (disabled) Server Array. Always use discretion before terminating servers. Remember, if you terminate a server, you will end any active sessions. You can check a server's Apache monitoring graphs for active sessions or safely terminate the server after its TTL has expired.  
 ![cm-major-upgrade-with-staging8.png](/img/cm-major-upgrade-with-staging8.png)
38. Remove any terminated (unnecessary) servers from your Deployment.
