---
title: Inheritance of Scripts
layout: cm_layout
description: A RightScale server will always inherit its scripts from its ServerTemplate. Once you have added a server to a deployment using a ServerTemplate, you cannot add/remove scripts at the server level.
---

## Overview

A server will always inherit its scripts (RightScripts or Chef Recipes) from its ServerTemplate. Once you've added a server to a deployment using a ServerTemplate, you cannot add/remove scripts at the server level. The scripts that appear at the server level always reflect the scripts of the selected HEAD version or committed revision of the ServerTemplate. Therefore, you can only change a server's scripts if it's using an editable HEAD version of the ServerTemplate.

![cm-scripts-inheritance-servers.png](/img/cm-scripts-inheritance-servers.png)

Don't forget that on an operational server you can also use the 'Any Script' option to run any script that's currently available in your RightScale account's local collection. See [Run 'Any Script' on a Server(s)](/cm/dashboard/design/multicloud_images/index.html).

**Note**: Currently, you can only use the 'Any Script' feature to run a RightScript. The ability to select and run a Chef recipe will be supported in a future release.

## Best Practices

When you're actively developing ServerTemplates, it's best to launch servers that are referencing HEAD ServerTemplates. This way, any changes that you make to the editable HEAD version is automatically reflected at the server level. For example, if you're testing a custom PHP application ServerTemplate and you need to upgrade one of the scripts to a different revision or add/remove a script, you simply make the change to the HEAD version and it's automatically reflected at the server level. You should always commit the ServerTemplate once you're satisfied with your changes to the HEAD version. You should never launch Servers that are referencing a HEAD ServerTemplate in a production environment.

**Note**: Any modifications to the ServerTemplate's Boot Scripts will only take effect on future launches of that Server. Boot Scripts run during the boot phase when a server is launched or rebooted.

**Warning!**  
Since a user with the 'designer' user role privilege can make modifications to a HEAD ServerTemplate, keep in mind that such changes could directly impact currently running servers or future server launches.

## See also

* [RightScripts](/cm/dashboard/design/rightscripts/)
