---
title: Freezing Software Repositories
layout: cm_layout
description: RightScale uses mirrors to maintain the following software repositories in order to ensure that your deployments stay current and up-to-date with the latest software versions.
---

RightScale uses mirrors (see [RightScale Mirrors](/cm/rs101/rightscale_os_software_mirrors.html)) to maintain the following software repositories in order to ensure that your deployments stay current and up-to-date with the latest software versions. Software repositories are archived each day, however RightScale does not keep track of what versions of software packages are frozen on a particular day. The purpose of the frozen repositories is to ensure that a server will be launched with the same versions of software regardless of when that server is launched again in the future.

RightScale ServerTemplates are published with frozen repositories and are associated with a particular RightImage<sup>TM</sup>. It's important to understand that there is no guarantee that newer RightImages will work correctly using older versions of software packages in the frozen repositories. To ensure that an older ServerTemplate works with one of the newer RightImages, you need to clone the template and refreeze the software repositories to a more recent date where the RightImage and the repositories are compatible. Always check to make sure that a server boots correctly.

There may be situations where you want to "freeze" or lockdown particular software repositories. For example, your current application is not compatible with the latest version of CentOS. You now have the ability to freeze the CentOS repository to a particular date in time. This ensures that your servers are always launched with the appropriate version of CentOS.

The following 3 categories of repository are enabled by default on all RightImages v4.1.0 or higher

- Standard system software repositories
  - CentOS 5, 6, 7: Base, Updates, Extra, Plus, Add-ons (5 only)
  - Ubuntu Hardy\*, Intrepid\*, Jaunty\*, Lucid\*, Maverick\*, Precise, Quantal, Trusty
- Third party repositories
  - Fedora EPEL
  - ​RubyGems
- RightScale EPEL\*\*
  - RightScale Software EPEL for CentOS 5, 6, 7
  - Ubuntu RightScale Software Lucid, Precise, Trusty

**Note**: You can only freeze software repositories in RightImage V4.1.0 or higher.

**Note**: Enterprise linux distributions (such as RedHat or SLES) operate separate repositories that cannot be frozen.

\* Distributions are past EOL. Packages for distributions past a final freeze date coinciding with the EOL date of the distribution. For example, packages for Ubuntu 8.04 are no longer available in the RightScale mirrors past the 9/10/2013 "freeze" date. It is recommended that customer upgrade to a more current Ubuntu LTS release to continue to receive the latest bug fixes and security updates, but those who still wish to use the old images will have to freeze repositories old enough freeze dates for instances to boot.

\*\* RightScale EPEL contains additional packages necessary for functioning for ServerTemplates, such versions of collectd compatible with RightScale's monitoring severs.

### See also

- [Rightscale Package Mirrors](/cm/rs101/rightscale_os_software_mirrors.html)
- [Software Repository Inheritance](/cm/rs101/laws_of_inheritance_and_hierarchy.html)
