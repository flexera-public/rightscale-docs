---
title: Performing Upgrades in the Cloud
layout: cm_layout
description: The following software upgrade strategies provide general guidelines and principles. Please use discretion at all times to develop your own software upgrade strategies that are sufficient for your application and environment.
---

The following software upgrade strategies provide general guidelines and principles. Please use discretion at all times to develop your own software upgrade strategies that are sufficient for your application and environment.

## Objective

The following guide will cover several of the common scenarios for upgrading your servers in the Cloud. The upgrade guidelines and instructions discussed in this guide are derived from our own experiences deploying servers in the Cloud. We acknowledge that every deployment is different and each has its own unique customizations and requirements. The purpose of this document is to provide some general guidelines and principles that you can apply to your own deployment. Use at your own discretion.

## Overview

Obviously, there are several different ways of upgrading servers, but before you attempt to make any changes, especially to your production environment, you should always ask yourselves the following questions:

* Why are you upgrading your servers? Is an upgrade absolutely necessary? Sometimes it's better to not upgrade your servers, unless it's absolutely necessary. The same golden rule often applies, If it isn't broke, why fix it?
* Is it a minor or major update? Are you simply pushing out a minor code push or a significant update that includes changes to either the application, database, system configuration, or all of the above?
* Is the upgrade going to require some site downtime? If so, you might want to provide some advanced notification to your customers.

## Next Steps

* [Key Principles](/cm/management_guide/key_principles.html)
* [Create a Staging Deployment](/cm/management_guide/create_a_staging_deployment.html)
* [Minor Software Upgrade Scenarios](/cm/management_guide/minor_software_upgrade_scenarios.html)
* [Major Software Upgrade Scenarios](/cm/management_guide/major_software_upgrade_scenarios.html)
