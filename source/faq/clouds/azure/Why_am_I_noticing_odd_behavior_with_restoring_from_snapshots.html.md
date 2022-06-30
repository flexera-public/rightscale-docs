---
title: Why am I noticing odd behavior with restoring from snapshots?
category: azure
description: Volumes restored from snapshots are sometimes attached as a foreign disk which prohibits RightScripts from working properly. 
---

## Answer

Volumes restored from snapshots are sometimes attached as a foreign disk which prohibits RightScripts from working properly.   A "foreign disk" is Windows terminology for disks that are brought in from another server.  For example, 'restore from snapshot' in **Database Manager for Microsoft SQL Server** and **Active Directory** ServerTemplates. Relaunching the server should resolve the issue.
