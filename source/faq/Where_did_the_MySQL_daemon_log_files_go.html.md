---
title: Where did the MySQL daemon log files go?
category: general
description: Starting with the v12.11.x ServerTemplate release, we have now moved the MySQL daemon log and MySQL daemon error log to a new location.
---

## Background

I'm launching one of RightScale's v12.11.x servertemplates and the /var/log/mysqld log file isn't populating with data. What gives?

## Answer

Starting with the v12.11.x ServerTemplate release, we have now moved the MySQL daemon log and MySQL daemon error log to a new location. This location is found at:

    `/mnt/storage/<hostname>.log` <br />
    `/mnt/storage/<hostname>.err`

An example would be `/mnt/storage/ip-10-252-80-195.err` for an AWS EC2 based instance.

**More questions?**

Feel free to call RightScale Support at **(866) 787-2253** or send us a support ticket from the dashboard via the **Support -> Email** link.
