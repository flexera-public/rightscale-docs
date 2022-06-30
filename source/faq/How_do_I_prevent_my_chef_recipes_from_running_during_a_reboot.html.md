---
title: How do I prevent my chef recipes from running during a reboot?
category: general
description: It is generally a good idea to try and design your recipes along the lines of idempotency. The best way to do this, is to utilize "not_if" or "only_if" within your recipes.
---

## Background

Chef has it's own properties for checking if a machine is rebooting, or launching. Some people find this a little hard to understand and work with and will ask the question, 'How do I prevent my chef recipes from running during a reboot?'

## Answer

It is generally a good idea to try and design your recipes along the lines of idempotency. The best way to do this, is to utilize "not_if" or "only_if" within your recipes, as that will ensure that the recipes are not run again. If you aren't familiar with either command, you can find some documentation on them, here:

[https://docs.chef.io/resource_common.html#attributes](https://docs.chef.io/resource_common.html#attributes)

In addition to this, our own [Chef Cookbooks Developer Guide](http://support.rightscale.com/12-Guides/Chef_Cookbooks_Developer_Guide) is continually growing and contains lots of very useful information and guidance, on how you should write your chef recipes and cookbooks to work with RightScale.
