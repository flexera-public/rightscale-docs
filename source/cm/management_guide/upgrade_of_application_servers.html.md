---
title: Upgrade of Application Servers
layout: cm_layout
description: Steps for performing a minor upgrade to your Application Servers in your RightScale Deployment. This upgrade assumes you are using dedicated load balancers.
---
## Overview

You need to perform a minor upgrade to the application servers in your production environment. This upgrade assumes you're using dedicated load balancers. For this type of upgrade you could update a variety of things such as the ServerTemplate revision, RightImages<sup>TM</sup>, application code, and Inputs. However, this upgrade assumes that you are only making minor changes/additions to the database. If you are making incompatible changes to the database schema, your site upgrade will require site downtime. See the [Major Software Upgrade Scenarios](/cm/management_guide/major_software_upgrade_scenarios.html) section for details.

## Steps

The following steps assume that you've already followed best practices by creating a staging Deployment for development and testing purposes. Once you've properly tested all of your system and software upgrades, you are now ready to upgrade your production setup.

 ![cm-minor-upgrade-apps1.png](/img/cm-minor-upgrade-apps1.png)

1. If you are making minor changes to your database schema, first take a snapshot of your database before you make any modifications. Create a manual backup (EBS Snapshot) of your Master-DB by running the **db::do\_primary\_backup** Chef recipe or the **DB EBS Backup** operational script. If the upgrade is not successful, you can always use this snapshot to revert the database back to its original state before the upgrade began.
2. Run any pre-upgrade DB migrations such as adding new tables or indexes.
3. Clone an application server in the production Deployment. If possible, you should always start an upgrade with a clone from one of the existing application servers in your production environment. This way, you're ensured that you always start with an exact duplicate of a running and stable production server with the same configurations. Later, when you change a configuration and something breaks, you'll know exactly what caused the problem. If you add a server using a new ServerTemplate and tried to configure it the same way as your production server, you are simply more prone to human error.  
  ![cm-minor-upgrade-apps2.png](/img/cm-minor-upgrade-apps2.png)
4. Make any systems level changes to the new server.  
  ![cm-minor-upgrade-apps3.png](/img/cm-minor-upgrade-apps3.png)
5. In the next step you will modify the inputs at the Deployment level. Go to the Deployment's **Inputs** tab. As a safety precaution, you should save a copy of the Deployment's current Input settings before you make any changes. Use the [Download CSV of External References](/cm/dashboard/manage/deployments/deployments_actions.html#download-csv-of-external-repositories) action button to save a .csv file of your input settings. This way, if problems occur you can always revert back to the original settings. Remember, there is no version control at the Deployment level.
6. Make any application level changes to the server by modifying inputs at the Deployment level. Remember, inputs that are defined at the Deployment level only affect new servers that are launched. The original application servers will keep their inputs (as long as you don't relaunch or execute a script on them).
  - Specify the location of the latest application code ('Repository URL/ROS Container', 'Repository Branch/Tag/Commit inputs')
  - Define values for any new inputs that were introduced by new RightScripts (that you want to define at the Deployment level)
7. Launch and test the new application server to make sure that it can properly connect to the database. If problems occur, shutdown the server. You might have to launch and test the server after each modification to determine the exact cause of the problem.
8. If the new server looks stable, clone it and launch an additional application server.  
  ![cm-minor-upgrade-apps4.png](/img/cm-minor-upgrade-apps4.png)  
9. Test the second application server to make sure that it can properly connect to the database. Repeat as necessary until you have equal number of old and new application servers.
10. Disable the array (if applicable) so no new application servers can be launched. Any servers that are already running in the Server Array will remain operational.
11. At the Deployment level, run the **lb::do\_attach\_all** Chef recipe or the **LB Application to HAProxy Connect** operational script to connect the new application servers to the existing load balancers so they can start receiving traffic. Select only the new application servers when running the RightScript.
12. Depending on how your application is coded, there may be existing sessions opened to your old application servers that we do not want to prematurely disconnect. In this case, the best strategy is to manually or programmatically remove the health check file used on the old application server(s). When removing the health check file, HAProxy will fail the health check tests, which will allow no new sessions to the application server, however existing application server sessions will be preserved.
13. Once the health check file is removed from your old application servers, feel free to monitor the existing sessions on these servers. This can be done in many ways, but the easiest may be to check the HAProxy status dashboard for the server and it's associated sessions. From the HAProxy status dashboard, you can view the current and total number of sessions active on the application server as well as any queued sessions, if applicable.
14. Once you have verified that all sessions have ceased on the old application servers, it is time to disconnect them from the load balancer. On the Deployment level, run the **lb::do\_detach\_request** Chef recipe or the **LB Application to HAProxy Disconnect** operational script to disconnect the old application servers from the existing load balancers so no new users will be sent to the old application servers. Be _SURE_ to select only the 'old' application servers when running the RightScript! We do _not_ want to disconnect the newly launched/modified application servers_._  
  ![cm-minor-upgrade-apps5.png](/img/cm-minor-upgrade-apps5.png)
15. Make any systems level changes to the server array (if applicable). For example, update the ServerTemplate of the Server Array. Make sure that any inputs that you've defined at the deployment will not be overwritten because they are defined at the Server Array level.
16. Enable the Server Array (if applicable).
17. Test site. Monitor log files.
18. Terminate old application servers when convenient. Terminate any old servers in the array. Always use discretion before terminating servers. Remember, if you terminate a server, you will end any active sessions unless steps 12-14 were followed above. You can always check a server's Apache monitoring graphs for active sessions or safely terminate the server after its TTL has expired.  
 ![cm-minor-upgrade-apps6.png](/img/cm-minor-upgrade-apps6.png)
