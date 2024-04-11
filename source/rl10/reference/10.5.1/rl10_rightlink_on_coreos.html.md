---
title: RightLink on CoreOS
description: Support for CoreOS is available starting with RightLink 10.3.0 under the Enable-running, Install-at-boot, and Install-on-image use cases.
version_number: 10.5.1
versions:
  - name: 10.6.4
    link: /rl10/reference/10.6.4/rl10_rightlink_on_coreos.html
  - name: 10.6.3
    link: /rl10/reference/10.6.3/rl10_rightlink_on_coreos.html
  - name: 10.6.2
    link: /rl10/reference/10.6.2/rl10_rightlink_on_coreos.html
  - name: 10.6.1
    link: /rl10/reference/10.6.1/rl10_rightlink_on_coreos.html
  - name: 10.6.0
    link: /rl10/reference/10.6.0/rl10_rightlink_on_coreos.html
  - name: 10.5.3
    link: /rl10/reference/10.5.3/rl10_rightlink_on_coreos.html
  - name: 10.5.2
    link: /rl10/reference/10.5.2/rl10_rightlink_on_coreos.html
  - name: 10.5.1
    link: /rl10/reference/10.5.1/rl10_rightlink_on_coreos.html
---

## Overview

Support for CoreOS is available starting with RightLink 10.3.1 under the following [use-cases](/rl10/about.html#use-cases): Enable-running, Install-at-boot, and Install-on-image.

Please note that the installation of RightLink 10 is done to the CoreOS operating system and has no reference to containers.

## Changes Specific to CoreOS

Due to the unique properties of CoreOS compared to other Linux flavors, some updates where made to accommodate the installation.

### Install location of RightLink and dependencies

Since the `/usr` directory is frozen, binaries are placed in `/opt/bin`.

### cloud-config liquid user-data

CoreOS uses the cloud-config syntax to provide user-data. As a result, we provide user-data conforming to this syntax on images in the CoreOS MCI, available with the Linux Base ServerTemplate.  Also, in order to provide RightScale information from the core, the user-data is treated as a Liquid Template. To pass this as a Liquid Template to RightScale, the `rs_agent:userdata=liquid` tag must be set as it is on the CoreOS MCI images (see next section). (See [Liquid User-data](/rl10/reference/rl10_install_at_boot.html#advanced-usage-liquid-user-data) for more details)

~~~
#cloud-config

write_files:
  - content: |
{% for rs_item in rs_agent %}
      {{ rs_item[0] }}='{{ rs_item[1] }}'
{% endfor %}
    path: /var/lib/rightscale-identity
    permissions: '0600'

coreos:
  units:
    - name: "rightlinkinstall.service"
      command: "start"
      content: |
        [Unit]
        Description=Installs RightLink
        ConditionPathExists=!/opt/bin/rightlink
        ConditionPathExists=!/usr/local/bin/rightlink

        [Service]
        Type=oneshot
        RemainAfterExit=yes
        ExecStart=/usr/bin/bash -c "/usr/bin/curl -s https://rightlink.rightscale.com/rll/10.5.1/rightlink.boot.sh | /usr/bin/bash"
~~~

#### Dealing with Reboot Strategies

Although it is not strictly specific to RightLink, by default CoreOS has automatic updates which can sometimes trigger
reboots. Be sure to read about [CoreOS: Reboot strategies on update] so you can configure CoreOS with settings that suit
your needs. The settings are configured through the cloud-config user-data so you will need to use Liquid user-data as
above.

[CoreOS: Reboot strategies on update]: https://coreos.com/os/docs/latest/update-strategies.html

### MCI tags

If the CoreOS MCI provided with the Linux Base Server Template is not being used, the following tags must be added to the MCI in addition to the user-data described above:

  `rs_agent:type=right_link_lite`</br>
  `rs_agent:userdata=liquid`

### RightLink Monitoring

Other Linux flavors supported by RightLink can install and configure collectd to pass monitoring information to RightScale.  RightLink has the ability to pass the same monitoring information as the default installation of collectd.  By default, because CoreOS does not support installation of collectd packages, the [RightScript](https://github.com/rightscale/rightlink_scripts/blob/master/rll/enable-monitoring.sh) to enable monitoring uses RightLink to monitor on CoreOS. (see [Alternative Linux Monitoring Setup](/rl10/reference/rl10_monitoring.html#linux-setup-procedure-alternative-linux-monitoring-setup) for more details)
