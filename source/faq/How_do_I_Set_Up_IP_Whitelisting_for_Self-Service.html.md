---
title: How Do I Set Up IP Whitelisting for Self-Service?
category: general
description: Before using RightScale Self-Service in an organization, IP whitelisting rules must be configured in the CM Dashboard. Take the following steps to configure your IP whitelisting rules for use with Self-Service.
---

## Background Information

Enterprise managers must configure their IP whitelisting rules for use with Self-Service.

* * *

## Answer

Before using RightScale Self-Service in an organization, IP whitelisting rules must be configured in the CM Dashboard. Take the following steps to configure your IP whitelisting rules for use with Self-Service.

!!info*Note:* You must have enterprise_manager role permissions in order to configure IP whitelists.

<!-- <ol class="list-steps"> -->
<ol>
  <li>Log in to the CM Dashboard and navigate to <b>Settings</b> > <b>Enterprise</b> > <b>IP Whitelist</b>.</li>
  <li>Click the <b>New Rule</b> button. The New Rule dialog displays.</li>
  <div class="media">
    <img src="/img/faq-ip-whitelist-new-rule.png" alt="">
    <div class="media-caption">
      <small>New Rule dialog</small>
    </div>
  </div>
  <li>Using the information found in the <a href="/faq/Firewall_Configuration_Ruleset.html#rightscale-owned-ip-networksFirewall" target="blank">list of RightScale-owned IP networks</a>, create an IP whitelist rule for the first RightScale-owned IP network shown. Enter the appropriate values for the <b>IP Range (CIDR)</b> and <b>Description</b> fields. Select the accounts to which you want to apply the IP whitelist rule and click <b>Save</b>.</li>
  <li>Repeat the previous step for each RightScale-owned IP network.</li>
</ol>

## See also

* [Firewall Configuration Ruleset](/faq/Firewall_Configuration_Ruleset.html)
