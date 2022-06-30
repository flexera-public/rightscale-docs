---
title: Setting up collectd
layout: cm_layout
description: Background and high-level steps for setting up collectd in the RightScale Cloud Management Platform.
---

If you are using a ServerTemplate that does not have monitoring enabled, you must add the appropriate RightScript or Chef Recipe to the boot sequence of your ServerTemplate to enable monitoring, otherwise you will not be able to see any graphs (under a server's Monitoring tab) or set any alert specifications. For this reason, it is recommended that you start your ServerTemplate development by cloning the "Base" ServerTemplate. The lineage of your ServerTemplate determines which scripts you need to work with in order to enable monitoring.

* v13.5.x LTS Chef-based ServerTemplates utilize the **rightscale::setup_monitoring** script.
* v13.5.x LTS RightScript-based ServerTemplates utilize the **SYS_Monitoring** script.
* v14.x Infinity Chef-based ServerTemplates utilize the **rs-base::collectd** script.
* v14.x Infinity RightScript-based ServerTemplates utilize the **BASE_collectd** script.

A server cannot be monitored by RightScale unless the correct RightScript or recipe has been added to the boot sequence. Since new features are constantly being added to the Monitoring utility, it is highly recommended that you install collectd using our RightScripts or recipes.

## Installing collectd with RightScripts

Assuming you have already imported one of RightScale's RightScript-based (RSB) ServerTemplates from the MultiCloud Marketplace, you can add the RightScript required to enable monitoring to another ServerTemplate. Be sure to add it to the Boot Sequence. The following example illustrates adding the **BASE_collectd** RightScript to a v14.x Infinity SeverTemplate. If you are working with a v13.5.x LTS ServerTemplate you would use the **SYS_Monitoring** RightScript.

![cm-add-rightscript-to-boot-sequence.png](/img/cm-add-rightscript-to-boot-sequence.png)

## Installing collectd with Chef Recipes

Assuming you have already imported one of RightScale's Chef-based ServerTemplates from the MultiCloud Marketplace, you can add the Chef Recipe required to enable monitoring to another ServerTemplate. Be sure to add it to the Boot Sequence. The following example illustrates adding the **rs-base::collectd** Chef Recipe to a v14.x Infinity SeverTemplate. If you are working with a v13.5.x LTS ServerTemplate you would use the **rightscale::setup_monitoring** Chef Recipe.

![cm-add-recipt-to-boot-sequence.png](/img/cm-add-recipt-to-boot-sequence.png)

## Installing collectd Yourself

!!warning*Warning!* It is highly recommend that you _only_ install Collectd from Rightscale's official scripts and recipes mentioned above. If you need a specific collectd version or must install it yourself, it is best to contact our support team for further clarification and insight before moving on.

That being said, if you must install collectd yourself and use a non-Rightscale sanctioned version then you will want to follow the advice below.

If RightScale's RightScripts cannot be used, collectd can be installed from public repositories or from a specified source. An appropriate config file should also be copied from the RightScripts. If for some reason you need to install collectd yourself, use the following steps:

* Install collectd version 4.3.1 or later.
* Set the hostname in the config file to the TSS ID number (formatted like this: 01-3IPDVL6CR0FSK) found on the info tab of your server, or the Env variable RS_Instance_UUID)
* Configure the network plugin to send the monitoring data to the monitoring server specified in the launch data as RS_TSS=<*hostname*>
* Use a 20-second interval
* Be sure to add the following tag to your server: "rs_monitoring:state=active"

## See Also

- [Collectd Plugin: Apache Log Monitor](/cm/rs101/collectd_plugin_apache_log_monitor.html)
