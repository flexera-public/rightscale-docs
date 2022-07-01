---
title: How can I generate the metadata.json file From metadata.rb?
category: general
description: As of the 2013-10-01 RightScale Cloud Management Dashboard release you no longer have to manually generate a cookbook's metadata.json file.
---

## Background Information

You have made changes to your Chef cookbook in the `metadata.rb` file and need to generate or regenerate `metadata.json`.

**Important!** As of the [2013-10-01](http://support.rightscale.com/18-Release_Notes/01-RightScale_Dashboard/2013-10-01) Dashboard release you no longer have to manually generate a cookbook's metadata.json file because RightScale automatically creates the metadata.json file (from the metadata.rb file) upon a fetch or refetch of your cookbooks into Repose. See [Chef Metadata](http://support.rightscale.com/12-Guides/Chef_Cookbooks_Developer_Guide/02-End_User/04-RightScale_Support_of_Chef/Chef_Metadata) for more technical details.

## Answer

There are two tools to facilitate this process—knife or rake. Using knife is the preferred method.

### Update Metadata with Knife (Preferred Method)

[Knife](https://docs.chef.io/knife.html) is included in the chef RubyGem. You can still install Chef without configuring the node for chef-client or chef-server to obtain knife:

~~~
gem install chef
~~~

Re-generate `metadata.json` by pointing to the cookbooks path and specifying the cookbook to update. This example updates a cookbook called "munchies" residing in `~/chef-cookbooks/cookbooks`:

~~~
knife cookbook metadata munchies -o ~/chef-cookbooks/cookbooks
~~~

For more information on how you can use Knife to manage your cookbooks, run the command `knife --help`.

### Update Metadata with Rake (Additional Method)

Chef comes with a metadata Rake task to generate the metadata.json file.

In your Chef repository, run the following command to update the metadata.json for all cookbooks:

~~~
rake metadata
~~~

Or, use the cookbook parameter to target a specific cookbook (e.g., db\_mysql):

~~~
rake metadata cookbook=db_mysql
~~~

This is a Ruby command and requires that the rake RubyGem is installed. To install the rake gem, run the following command:

~~~
gem install rake
~~~
