---
title: Inheritance of Software Repositories
layout: cm_layout
description: Software repositories follow the same hierarchy rules as Inputs in RightScale. You can edit the software repositories at the ServerTemplate, Deployment, and Server.
---

## Overview

Software repositories follow the same hierarchy rules as Inputs. You can edit the software repositories at the following levels:

* ServerTemplate
* Deployment
* Server

Software repositories are typically frozen at the ServerTemplate level, so most Servers inherit their repository settings from their ServerTemplate. However, if you want to ensure that all of the Servers in your Deployment use the same software repository versions, you can make modifications to the frozen repository settings at the Deployment level, which will overwrite settings at the ServerTemplate level. Lastly, you can freeze repositories at the Server level to overwrite any inherited settings from either the ServerTemplate or Deployment levels.

**Note**: You can change the frozen software repository settings for a Current or Next Server. However, in the case of a currently running Server, it will not recursively change the version that's been installed on an instance. Changes will only be applied when a script is manually run that pulls from one of the listed repositories. To avoid problems, if you want to make changes to the software repositories you should relaunch the operational Server or launch a fresh new Server.

![cm-repos-inheritance-servers.png](/img/cm-repos-inheritance-servers.png)

## Inheritance Hierarchy for Repositories

### ServerTemplate Level

When you freeze repositories at the ServerTemplate level (under the Repos tab), the changes will only take effect on new Servers that are launched with that committed revision of the ServerTemplate. Each ServerTemplate can define which software repositories (current/frozen) are used when a new Server is launched. To define a different set of software repositories, simply commit or clone the ServerTemplate.  For example, if you freeze all of a template's software repositories to a specific day (ex: Dec 31, 2010), all future servers will be launched with the software repositories that existed on Dec 31, 2010. By using frozen repositories, you can be certain that the Server is launched in the exact same manner every time, whether you launch it tomorrow, next week, or in five years. Using frozen repositories is critical for auditing purposes.

By default, when you commit a ServerTemplate you are prompted to freeze the software repositories. As a best practice, you should freeze all repositories when you commit a ServerTemplate. When the "freeze repositories" option is checked, all repositories are frozen. If your repositories are not frozen, you could experience problems launching new servers because the current repositories might have changed. For example, you might have Servers that were launched with "ServerTemplate A" six months ago that are still operational. But, if you launch a new Server using the same template, it could become stranded in booting because one of the software repositories might have been updated, which could introduce compatibility issues. Freezing repositories will help ensure that a server is always launched with the same software versions every time.

If you are using an older RightImage (prior to V4.1.0), you can still select the "freeze repositories" option but you will see a warning message indicating that the image may not support frozen repositories. In such cases, an audit entry will be generated.

### Deployment Level

When you freeze software repositories at the Deployment level, the changes affect all Servers in the Deployment. By default, the preference is set to "Inherit" (i.e. It inherits the repository preferences that are defined at the ServerTemplate level.) Typically, you define your frozen repository settings at the ServerTemplate level.

### Server Level

When you freeze software repositories at the (Next) Server level, you are overwriting repository settings that were defined at the ServerTemplate or Deployment levels. You can only modify frozen software repository dates for an unlaunched (Next) Server. Once a Server is launched, you cannot make changes to the repository date. If you are looking at a running (Current) server, you can see which repositories (if any) have been frozen under the Server's Info tab under the Software Repositories row.

## Best Practices

* When publishing a ServerTemplate for use within a production environment, you should always freeze the software repositories to a specific date that is older than the date when the image was built or you run the risk of experiencing software compatibility issues.
* For most cases, you should freeze repositories at the ServerTemplate level.
* Do not change the repository settings on a running "Current" Server. It's better to change the repository setting at a different level and then relaunch the server or launch a new Server.

## See also

* [Freezing Software Repositories](/cm/rs101/freezing_software_repositories.html)
* [Rightscale Software Repositories](/cm/rs101/rightscale_os_software_mirrors.html)
