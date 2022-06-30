---
title: Major Software Upgrade Scenarios
layout: cm_layout
description: Major software upgrades in context of the RightScale Cloud Management Platform are generally reserved for performing large scale changes that would otherwise break you current application.
---
Fortunately, there are several ways to perform major software upgrades in the Cloud. Since each website and application is unique, each person might have a different upgrade strategy. When discussing upgrade strategies, it's important to realize that one upgrade strategy does not fit all. Remember, the goal is always the same--to have a safe and successful upgrade with minimal site downtime and impact to your users. However, determining the best steps to achieve that goal may be different for each person. Use the upgrade scenarios below as general guidelines for developing your own upgrade strategy.

A major upgrade is generally reserved for performing large scale changes that would otherwise break you current application. In such cases, site downtime is mandatory. For example, if you drastically change the database schema or use completely new ServerTemplates that might install new versions of software (e.g. migrating from MySQL v5.1 to v5.2). Essentially, if you ever have any compatibility concerns whatsoever that your changes could possibly break your current application, you will need a solid upgrade strategy.

* [Upgrading a Production Deployment](/cm/management_guide/upgrading_a_production_deployment.html)
