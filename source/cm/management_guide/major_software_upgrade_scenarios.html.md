---
title: Major Software Upgrade Scenarios
layout: cm_layout
description: Major software upgrades in context of the RightScale Cloud Management Platform are generally reserved for performing large scale changes that would otherwise break you current application.
---


A major upgrade is generally reserved for performing large scale changes that would otherwise break you current application. In such cases, site downtime is mandatory. For example, if you drastically change the database schema or use completely new ServerTemplates that might install new versions of software (e.g. migrating from MySQL v5.1 to v5.2). Essentially, if you ever have any compatibility concerns whatsoever that your changes could possibly break your current application, you will need a solid upgrade strategy.

* [Upgrading a Production Deployment](/cm/management_guide/upgrading_a_production_deployment.html)