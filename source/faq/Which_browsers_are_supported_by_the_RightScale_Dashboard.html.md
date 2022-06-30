---
title: Which browsers are supported by the RightScale Dashboard?
category: general
description: This article lists the various internet browsers that are currently supported in RightScale.
---

## Background Information

Customers often experience various problems or odd behavior when using the RightScale Dashboard in various browsers. We acknowledge the fact that each user has their own web browser preferences. Unfortunately, we can't guarantee consistent behavior across all browsers or versions. Based on the web characteristics of our user base, we've tried our best to support the most commonly used browsers.

## Answer

RightScale currently supports the functionality of the RightScale platform on the following desktop browsers and versions (as of September 18, 2017):

* Google Chrome, most recent stable version
* Mozilla Firefox, most recent stable version
* Microsoft Edge, most recent stable version

Other browsers may work, but are not officially supported or tested. Additionally, RightScale's dashboard/services may exhibit unexpected behavior when using 'dev' or 'beta' versions of the aforementioned browsers.

<hr>
#### Legacy Note

If you are seeing problems with Firefox 5.0 and OS X, it is due to an issue created from Apple's java update. In order to work around the issue, please run the following command:

~~~
sudo ln -s
/System/Library/Java/Support/Deploy.bundle/Contents/Resources/JavaPlugin2_NPAPI.plugin
"/Library/Internet Plug-Ins/JavaPlugin2_NPAPI.plugin"
~~~
