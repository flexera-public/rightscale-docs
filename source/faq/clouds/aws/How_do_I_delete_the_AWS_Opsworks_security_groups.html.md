---
title: How do I delete the AWS Opsworks security groups?
category: aws
description: Since most of the OpsWorks security groups contain dependencies on the existence of other security groups, you must delete the security groups in a specific order.
---

## Background Information

You normally launch servers using the RightScale Dashboard, but now you see a number of new "OpsWorks" EC2 security groups in your account that you did not create. You are unsure why those security groups exist in your account and if you're allowed to delete them.

When you sign-up for the AWS Opsworks service in the AWS Console, several EC2 security groups are automatically created for you in each AWS EC2 region. If you only activated the service to preview the service and do not plan to use AWS Opsworks to launch instances, you may want to delete all of the EC2 security groups that were automatically created in your account. Since most of the OpsWorks security groups contain dependencies on the existence of other security groups, you must delete the security groups in a specific order, otherwise you will receive an error message.

**Warning!**  
Before you delete any of the security groups, be sure to check with the "owner" of the account (Settings > Account Settings > Info tab) because he/she was probably the one who originally activated the OpsWorks service for the AWS account associated with the RightScale account.

### Answer

Delete the security groups in each EC2 region in the following order.

1. AWS-OpsWorks-Blank-Server
2. AWS-OpsWorks-Monitoring-Master-Server
3. AWS-OpsWorks-DB-Master-Server
4. AWS-OpsWorks-Memcached-Server
5. AWS-OpsWorks-Custom-Server
6. AWS-OpsWorks-nodejs-App-Server
7. AWS-OpsWorks-PHP-App-Server
8. AWS-OpsWorks-Rails-App-Server
9. AWS-OpsWorks-Web-Server
10. AWS-OpsWorks-Default-Server&nbsp;
11. AWS-OpsWorks-LB-Server
