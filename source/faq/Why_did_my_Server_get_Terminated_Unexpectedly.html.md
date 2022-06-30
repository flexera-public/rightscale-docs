---
title: Why did my Server get Terminated Unexpectedly?
category: general
---

## Background Information

User receives an alert if the instance has been terminated abnormally, i.e., not through the RightScale interface or by an elasticity daemon resizing server arrays.

## Answer

If you get an alert that says, "Server was terminated outside of RightScale Interface", this could only mean two things. One of your teammates may has accidentally terminated the Server in the Cloud Provider Console, or the Cloud Provider itself terminated the Server due to an issue or maintenance task on their side. You can check the latter by raising a ticket to the Cloud Provider to inquire why the Server was terminated unexpectedly. Also, in this scenario, you will not see an Audit Entry indicating that someone terminated the Server as shown below.


```
To: MyServer@Alert.com
Subject: Test Server Critical Issue 'My Test Server' rs instance terminated
Message: There is an issue with My Deployment. Please respond to this alert immediately.

Alert Description: Raise an alert if the instance has been terminated abnormally, i.e. not through the RightScale interface or by an elasticity daemon resizing server arrays.

2016-01-22 16:42:36 PST	My Test Server	N/A	terminated
2016-01-22 16:41:36 PST	My Test Server	N/A	terminate Instance: completed
2016-01-22 16:40:36 PST	My Test Server	N/A	termination queued
2016-01-22 16:40:05 PST	My Test Server	N/A	terminate Instance: pending
2016-01-22 16:40:05 PST	My Test Server	N/A	terminate Instance: queued
```
