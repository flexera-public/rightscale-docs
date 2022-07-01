---
title: Upgrade from MySQL 5.1 to MySQL 5.5 ServerTemplate
category: general
description: Typical questions regarding upgrading from MySQL 5.1 to MySQL 5.5 ServerTemplates in RightScale.
---

**Question**: - Does the RS upgrade script run the mysql\_upgrade command?

**Answer**: - No, currently our templates weren't designed to do a MySQL version upgrade. Presumably this is because Oracle suggests a complete DB dump and import as the "best" way to do a major version upgrade (even though the migration script should work fine), which is why the version checking was put into place with an override. Since we already detect the MySQL version of the DB I think it's a good idea to run `mysql_upgrade` when we detect that we're upgrading the version. **This feature is on the roadmap and will be included in the next revision of the template.** We'll make sure to update the documentation to warn users that there could be a potential problem with upgrading this way, but under the circumstances it makes sense to add the feature.

**Question**: - Do you know the error that we are seeing? have you seen this in your testing?

~~~
call createMultiFolderUser(520002, "qauser3", "XXX", "folder://local//mnt/emailFolderProvider/folder/qauser3", 3002, 2000002, 1)
~~~

~~~
ERROR 1548 (HY000) at line 1: Cannot load from mysql.proc. The table is probably corrupted_
~~~

**Answer**: - The error that you're seeing is common when migrating between major revisions because of changes to the schema of the mysql table.

**Question**: - We are able to run the `mysql_upgrade` command which seem to imply that the RS upgrade scripts are not doing this.

**Answer**: - We'll certainly need to use your script during the upgrade. We expect we'll see this feature rolled into the next MySQL infinity release and the next 12.11 LTS maintenance release.
