---
title: Why am I unable to connect to MySQL on my LAMP stack?
category: general
description: RightScale provides LAMP-style ServerTemplates with MySQL's networking disabled for efficiency and security purposes.
---

## Background Information

RightScale provides LAMP-style ServerTemplates with MySQL's networking disabled for efficiency and security purposes. Although it can present a problem for some users, you can easily change it in the master configuration file for MySQL.

* * *

## Answer

In the file `/etc/my.cnf`, under the section `[mysqld]`, comment out the option `'skip-networking'`. Issue a 'service mysqld restart' and the problem will be solved.
