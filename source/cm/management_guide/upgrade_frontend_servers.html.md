---
title: Upgrade FrontEnd Servers
layout: cm_layout
description: Steps for upgrading your frontend servers in the RightScale Cloud Management Platform. This upgrade assumes that you are only making minor changes/additions to the database.
---

## Overview

You need to perform a minor upgrade to the frontend servers in your deployment. For this type of upgrade you could update a variety of things such as the ServerTemplate revision, RightImage<sup>TM</sup>, application code, and Inputs. However, this upgrade assumes that you are only making minor changes/additions to the database. If you are making incompatible changes to the database schema, your site upgrade will require site downtime. See the [Major Software Upgrade Scenarios](/cm/management_guide/major_software_upgrade_scenarios.html) section for details.  

![cm-minor-upgrade-frontends1.png](/img/cm-minor-upgrade-frontends1.png)

## Steps

The following steps assume that you've already followed best practices by creating a staging deployment for development and testing purposes. Once you've properly tested all of your system and software upgrades, you are now ready to upgrade your production setup.

1. If you are making minor changes to your database schema, first take a snapshot of your database before you make any modifications. Create a manual backup (EBS Snapshot) of your Master-DB by running the "DB EBS backup" operational script. If the upgrade is not successful, you can always use this snapshot to revert the database back to its original state before the upgrade began.
2. Run any pre-upgrade DB migrations such as adding new tables or indexes.
3. Clone a frontend server in the production deployment. If possible, you should always start an upgrade with a clone from one of the existing frontends in your production environment. This way, you always start with an exact duplicate of a running and stable production server with the same configurations. Later, when you change a configuration and something breaks, you'll know exactly what caused the problem. If you add a server using a new ServerTemplate and tried to configure it the same way as your production server, you're simply more prone to human error.
  ![cm-minor-upgrade-frontends2.png](/img/cm-minor-upgrade-frontends2.png)  
4. Before you launch the "FrontEnd-3" server, make any systems level changes to its configuration. For example, you can change the instance type, RightImage, ServerTemplate revision, etc. If you are vertically scaling up/down you will need to make sure that you select a machine image (e.g. RightImage) that's appropriate for the instance type you are going to launch. For example, if you're vertically scaling up from an m1.small to m1.large instance type on EC2, you will need to select the new instance type (m1.large) and also select a 64-bit platform image (e.g. RightImage\_CentOS\_5.4\_ **x64** \_v5.5\_EBS). Conversely, you would need to select a 32-bit image for vertically scaling down.<br>
  ![cm-minor-upgrade-frontends3.png](/img/cm-minor-upgrade-frontends3.png)
5. On the "Front End-3" server, go to the Inputs tab at the server level and change the LB\_HOSTNAME input (e.g. test1.mysite.com) otherwise it will be added to the current load balance pool if you launched the server as-is. The server is not ready to serve any traffic.
6. In the next step you will modify the inputs at the Deployment level. Go to the Deployment's Inputs tab. As a safety precaution, you should write down or copy the inputs that were defined at the Deployment level before you start making any changes, so you can always revert back to the original settings if problems arise. Tip: Take a screenshot or use the cursor to select all of the inputs. Copy and paste them into a text editor.
7. Make any application level changes to the server by modifying inputs at the deployment level. Remember, inputs that are defined at the deployment level only affect new servers that are launched. The original frontends will keep their inputs (as long as you don't relaunch or execute a script on them).
  - Specify the location of the latest application code (SVN\_APP\_REPOSITORY)
  - Define values for any new inputs that were introduced by new RightScripts (that you want to define at the deployment level)
8. Launch and test the new frontend server to make sure that it can properly connect to the database. If problems occur, shutdown the server. You might have to launch and test the server after each modification to determine the exact cause of the problem.
9. If the new server looks stable, clone it and launch a second frontend server.  
  ![cm-minor-upgrade-frontends4.png](/img/cm-minor-upgrade-frontends4.png)
10. Test the second frontend server to make sure that it can properly connect to the database.
11. Run "LB app to HA proxy connect" operational RightScript at the deployment level to connect the two new front ends so that the load balancer can send round-robin traffic to both servers.  
  ![cm-minor-upgrade-frontends5.png](/img/cm-minor-upgrade-frontends5.png)
12. Disable the array (if applicable) so no new application servers can be launched. Any servers that are already running in the server array will remain operational.
13. Make any systems level changes to the server array (if applicable). For example, update the ServerTemplate of the server array. Make sure that any inputs that you've defined at the deployment will not be overwritten because they are defined at the server array level.
14. Switch Elastic IPs to new front end servers.  
  ![cm-minor-upgrade-frontends6.png](/img/cm-minor-upgrade-frontends6.png)
15. Enable the server array (if applicable).
16. Test site. Monitor log files.
17. Terminate old front end servers when convenient. Terminate any old servers in the array. Always use discretion before terminating servers. Remember, if you terminate a server, you will end any active sessions. You can check a server's Apache monitoring graphs for active sessions or safely terminate the server after its TTL has expired.  
  ![cm-minor-upgrade-frontends7.png](/img/cm-minor-upgrade-frontends7.png)
