---
title: Application Update - "Classic Code Push"
layout: cm_layout
description: The following software upgrade strategies provide general guidelines and principles when working in the RightScale Cloud Management Platform.
---
The following software upgrade strategies provide general guidelines and principles. Please use discretion at all times to develop your own software upgrade strategies that are sufficient for your application and environment.

## Overview

If you are only making minor updates to your site and there is no risk of possibly breaking your application, it's probably safe to make these "rolling upgrade" changes on the live running servers. For example, you may need to perform a simple code push of some minor bug fix patches to the current release or perhaps you have a slightly modified CSS file that you want to apply across your site. As long as you know those changes will not break your site, you can run a single operational RightScript to make these changes on the live production servers.

![cm-minor-update.png](/img/cm-minor-update.png)

## Steps

For example, let's say you just had a major software release last week and now you need to push out some minor bug fixes. You need to update your application servers so that they use the latest branch in your SVN repository.

Note: This tutorial assumes that you've followed best practices and defined the SVN_APP_REPOSITORY input at the Deployment level and not at the individual Server levels. See [Inheritance of Inputs](/cm/rs101/inheritance_of_inputs.html).

1. Go to the Inputs tab of the production deployment.
2. Click Edit and modify the SVN_APP_REPOSITORY input to point to the new branch.
  - Ex: Change http://mysite.com/svn/production/v2/A/ to http://mysite.com/svn/production/v2/B/
3. Under the deployment's Scripts tab, run the **WEB app svn code checkout** RightScript. You'll need to select all of the application servers that need to be updated before running the script. The updated servers will grab the latest code from the new SVN repository branch.
4. Test to make sure that the new application code is being served. You may need to test the site with a new browser due to caching issues. If there's a problem, you can always change the input back to the old branch and run the same RightScript again.
5. (Optional) If you have a server array, you must also apply the change to all of the current running server instances. Under the server array's Scripts tab, execute the same RightScript. (Make sure the input is not set at the server array level. If an input is defined under the server array's Inputs tab, it will overwrite the value that's set at the deployment level.)
