---
title: I renamed my MySQL Slow log and now MySQL does not log slow queries
category: general
description: This article describes the process for enabling log rotation for your logs on your instances in RightScale.
---

## Background

Many people with large databases and applications, will find that their mysqlslow.log file will grow extensively and needs to be rotated periodically. If you haven't configured log rotation for the `mysqlslow.log` and decided to rename/move/delete it manually instead, you'll now find that MySQL hasn't created a new log file as you probably expected and instead, is no longer logging slow queries.

## Answer

First and foremost, in order to enable log rotation for your logs on your instances, you should follow the following document:

[How to Configure Log Rotation on my Instances](http://support.rightscale.com/06-FAQs/FAQ_0174_-_How_do_I_configure_log_rotation_on_my_instances%3F)

To re-enable your mysqlslow.log file on the instance you're having problems with, you'll need to log in to your database server via it's interactive mysql console and perform the following command:

*SET GLOBAL SLOW_QUERY_LOG_FILE=/var/log/mysqlslow.log;*

This command will reset the variable for the log file (Even though it's exactly the same as it was previously) and kickstart the logging process within MySQL, without having to restart the MySQL service.
