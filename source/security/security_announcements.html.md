---
title: Security Announcements
layout: security_layout
description: Below is a list of all RightScale security announcements with their original posting dates.
---

Below is a list of all RightScale security announcements with their original posting dates.

## glibc Vulnerability (CVE-2015-7547)

Original posting date: **February 23, 2016**

### Overview

There was a recent discovery of the CVE-2015-7547 Vulnerability. The information below will assist you in taking the proper steps toward mitigating the security risk.

### Impact Mitigation

Options for Mitigating the CVE-2015-7547 Vulnerability.

1. If you are an AWS Customer and your are using their DNS infrastructure, you are not affected by this security risk. [See the AWS customer advisory here](https://aws.amazon.com/security/security-bulletins/cve-2015-7547-advisory/).
2. If you are not using AWS' DNS Infrastructure and are using a different Cloud Provider, then you may do the following.
  * As a RightScale Customer, you can now patch your Servers by running `yum update` or `apt-get update` as the patch package is now available in our mirror. A restart is required for this update.
      Package Name: `glibc-2.12-1.166.el6_7.7.i686.rpm`
  * You may also follow Google's recommendation shown below if you are not able to immediately patch your Servers.

        ~~~
        Google has found some mitigations that may help prevent exploitation if you are not able to immediately patch your instance of glibc. The vulnerability relies on an oversized (2048+ bytes) UDP or TCP response, which is followed by another response that will overwrite the stack. Our suggested mitigation is to limit the response (i.e., via DNSMasq or similar programs) sizes accepted by the DNS resolver locally as well as to ensure that DNS queries are sent only to DNS servers which limit the response size for UDP responses with the truncation bit set.
        ~~~

## OpenSSL - Data Encryption Vulnerability (CVE-2014-0224)

Original posting date: **June 5, 2014**

### Overview

An announcement was recently disclosed about a potential vulnerability related to encrypted SSL/TLS communications that were exposed in the widely used OpenSSL library. To learn more, see [New OpenSSL vulnerability puts encrypted communications at risk of spying](https://www.computerworld.com/article/2490316/data-security/new-openssl-vulnerability-puts-encrypted-communications-at-risk-of-spying.html).

### Impact to RightScale Users

RightScale users are not vulnerable to the related OpenSSL issues. There was only one potential vulnerability (**CVE-2014-0224**), but RightScale deployed a patch to resolve the issue on June 5, 2014.

## RSSA-2010-Dec-0001 Host SSH Key

Original posting date: **December 29, 2010**

### Summary

The following is a RightScale Services Security Announcement. All v4 and v5 Ubuntu RightImages, and some customer built Ubuntu-based images, share the same SSH host key fingerprint.

### Relevant Releases

* All Ubuntu RightImages (v4 and v5)
* Customer-built Ubuntu images (except those that were bundled with the cloudinit package installed)

### Problem Description

!!info*Note:* SSH *host* keys serve as a fingerprint for server identification. These are <u>not</u> related to the *root user keys* that the RightScale Dashboard generates to provide login authentication to servers. No *SSH root user keys* are impacted by this advisory and they should not be regenerated.

Ubuntu generates host keys when the openssh-server package is installed. This package is installed during the RightImage creation process and not at boot time. Therefore, all Ubuntu RightImages share the same SSH host key, making Ubuntu-based RightImages vulnerable to an active middleperson attack.

!!info*Note:* CentOS based images are not impacted by this issue as SSH for CentOS generates keys at boot time.

This vulnerability would allow an attacker to hijack an SSH session by interfering with the SSH key exchange protocol, provided:

**(a)** they knew the exact RightImage from which an instance was booted

*and*

**(b)** they could actively hijack the TCP connection between an authorized SSH client and the instance.

Both of these criteria must be satisfied in order for the attack to succeed; a passive middleperson cannot mount an attack, nor can knowledge of a host's private key alone be used to gain unauthorized access to an instance.

### Classification

The severity of this vulnerability is rated Medium, but because knowledge of server launch parameters _and_ an active middleperson attack are both required to leverage this vulnerability.

RightScale rates the likelihood of this attack as Low in most environments, except in environments where the likelihood of an insider attack is increased.

### Solution

There are three ways to remediate the problem. In order of preference, they are:

1. Run a specific RightScript as an "Any" script to apply the hot patch to running servers
2. Relaunch affected servers to pick up a hot patch that fixes the issue
3. Update your ServerTemplates to use a v5.6 RightImage, which is not vulnerable

The three remediation methods are detailed below.

!!warning*Important!* Should you need to implement remediation steps, you only need to perform one of the three below.

#### Option 1 - Patching Running Servers Using a RightScript

We have published a RightScript that will regenerate SSH keys on a running server.

To patch running instances using the RightScript:

1. Import the RightScript [SYS ssh key freshen](http://www.rightscale.com/library/right_scripts/SYS-ssh-host-key-freshen/16237) to your account
2. Run it as an "Any" script on every affected server, deployment, or server array (see [Run Any Script on a Server](/cm/dashboard/manage/deployments/deployments_actions.html#run--any-script--on-a-server))
3. Test any operational scripts or procedures that rely on SSH connectivity between hosts to ensure that the changed keys do not cause any problems

*Patching a running instance has significant drawbacks and should be used with caution.* If your deployment uses SSH as a mechanism for inter-server communication and enables strict host checking, you may find that some operational scripts or automation tasks no longer function correctly. This patch does not affect *client* SSH keys (you will still be able to connect with your current client keys), but if you SSH into an instance for which you have regenerated the *host* key, you may receive errors from your SSH client like the following:

~~~
    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    @ WARNING: REMOTE HOST IDENTIFICATION HAS CHANGED! @
    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    IT IS POSSIBLE THAT SOMEONE IS DOING SOMETHING NASTY!
    Someone could be eavesdropping on you right now (man-in-the-middle attack)!
    It is also possible that the RSA host key has just been changed.
    Offending key in /Users/joe-user/.rightscale/known_hosts:6 
~~~

If this happens, you can remove the offending line from the known_hosts file to get rid of the error.

#### Option 2 - Relaunching Servers

Relaunching your servers will automatically apply a hot patch which fixes the SSH host key issue. A hotpatch is available for the following Ubuntu RightImage/RightLink versions:

* v5.5.9
* v5.4.6
* v5.3.0
* v4.3.7 and v4.5.x

Relaunching is appropriate in the following circumstances

* Your server is running a RightImage version for which a patch is available (or your server is running a custom image that uses a RightLink software version for which a patch is available)
* You do not wish to update to the latest RightImage for testing or stability reasons
* You are capable of performing a rolling relaunch of affected servers

To relaunch your servers, simply click "Relaunch" on the affected server.

#### Option 3 - Updating ServerTemplates to use v5.6 RightImages

Updating your ServerTemplates and Servers to RightImage v5.6 is the recommended course of action because the image has numerous stability fixes in addition to fixing the SSH host key issue. Update to v5.6 is appropriate in the following circumstances:

* You have authored your own ServerTemplate and have full control over its configuration
* You were previously using RightImage v5.4 - v5.5
* You are capable of testing your ServerTemplate changes in a development or staging environment to ensure they are fully compatible with RightImage v5.6

To update ServerTemplates, perform the following:

1. Add the appropriate RightImage Ubuntu v5.6 MultiCloudImage to every affected ServerTemplate.
2. Commit a new version of the ServerTemplate if necessary (e.g. if your servers are not using HEAD).
3. Edit every server making use of the ServerTemplate; change its MCI to the v5.6 MCI you added in the previous step.
4. Relaunch every affected server.

### References

None.

### Change Log

* Updated script hyperlink to latest CentOS-safe patch. (2010-12-29 16:31 PDT)

### Contact

If you have any additional questions regarding this known issue, please contact [support@rightscale.com](mailto:support@rightscale.com) or click on 'Support' inside the Dashboard to file a ticket.
