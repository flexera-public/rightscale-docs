---
title: Migration Guide
alias: rl/migration/index.html
description: Migration guide for migrating ServerTemplates and RightScripts to use RightLink 10.
---

This guide provides information on how to migrate existing RightLink 5 and 6 ServerTemplates to work with RightLink 10 with the minimal amount of changes.

The components that require the most signficiant updates are RightScripts, RightScale tools used in RightScripts,  and images.
* [RightScripts](rl10_rightscript_migration.html)
* [Tooling](rl10_rightscript_rsc_tool.html)
* [Images](rl10_rightimages_migration.html)

With RightLink 10, Chef based ServerTemplates are no longer directly supported. If you are using Chef installed on RightImages with RightLink 5 and 6, several steps are needed to migrate:
* [Chef Cookbooks](rl10_chef_cookbooks_migration.html)

For the development workflow, we provide the following guide:
* [Development workflow](rl10_dev_workflow.html)
