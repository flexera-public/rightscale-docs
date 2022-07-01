---
title: Option to Disable Floppy-Drive Based Configuration
category: vmware
description: There is a new option in the Cloud configuration file that was added from RCA-V Release v1.2 to circumvent some of the issues related to floppy drive usage that caused server launches to fail from time to time.
---

## Overview

There is a new option in the Cloud configuration file that was added from RCA-V Release v1.2 to circumvent some of the issues related to floppy drive usage that caused server launches to fail from time to time.

In order to modify the Cloud configuration file, perform the following operation:

* In the Admin UI, go to **Cloud Configuration -> Advanced**.
* Click **Edit** on the Cloud Configuration card.
* Look for the "tenant_defaults" section in the configuration JSON.
* Add  `"no_fd_support": true,` as the first line in the "tenant_defaults” section. Note that the comma at the end of the string is important for maintaining the JSON format.

Use this option only if you are using RightImage 14.1 (for Linux), RightImages 14.2 (for Windows) or images that you created using a RightLink 6.1 package. Please refer to the section on [ServerTemplates and other assets](/release-notes/rca-v.html) for information on compatibility between various assets.
