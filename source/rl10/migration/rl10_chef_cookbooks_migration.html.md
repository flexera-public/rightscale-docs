---
title: Chef Cookbooks RightLink 10 Migration Guide
alias: rl/migration/rl10_chef_cookbooks_migration.html
description: Migration guide for migrating Chef Cookbook based ServerTemplates to use RightLink 10.
---

With RightLink 10, [Chef] based ServerTemplates where cookbooks and recipes are managed within the RightScale platform
are no longer directly supported, so several steps are needed to migrate. Instead of storing [Chef] cookbooks within the
RightScale platform with previous RightLink versions, you will need to store them with a Chef Server or using
[Hosted Chef]. For information about launching and using a Chef Server with the RightScale platform, please see
[Chef Server for Linux (RightLink 10) - Tutorial]. RightScale Professional services has a set of
[RightLink 10 ServerTemplates] which are based on the previous Version 14 ServerTemplates, but updated to work with
RightLink 10 and a Chef Server or Hosted Chef following the same methodology described here. They can be used directly,
or as reference examples, and they can be found on GitHub in [rs-services/server-templates] where they are managed using
the [Right ST tool method] of syncing ServerTemplates and RightScripts from a Git repository.

[Chef]: https://www.chef.io/chef/
[Hosted Chef]: https://manage.chef.io/
[Chef Server for Linux (RightLink 10) - Tutorial]: /st/rl10/chef-server/tutorial.html
[RightLink 10 ServerTemplates]: /st/rl10/index.html
[Right ST tool method]: /rl10/reference/rl10_storing_scripts_in_git_svn.html#right-st-tool-method
[rs-services/server-templates]: https://github.com/rs-services/server-templates

## Building a new ServerTemplate

The basic methodology for migrating an older Chef cookbook based ServerTemplate to work with RightLink 10 is to clone or
otherwise base a new ServerTemplate on the [Chef Client for Linux (RightLink 10)] ServerTemplate. After cloning or basing the new SeverTemplate, add a RightScript or RightScripts that invoke the Chef command line tools with the Chef recipes from your old ServerTemplate that it will be fetching from the Chef Server or Hosted Chef. In addition these RightScripts will most likely need to
also set up Chef attributes JSON based on RightScale inputs before invoking Chef.

[Chef Client for Linux (RightLink 10)]: https://www.rightscale.com/library/server_templates/RightLink-10-Linux-Chef-Client/lineage/57237

Here is an example of a RightScript that invokes the [rs-base::swap] recipe from the [rs-base cookbook] with
`BASE_SWAP_SIZE` and `BASE_SWAP_FILE` inputs:

[rs-base::swap]: https://github.com/rightscale-cookbooks/rs-base/blob/master/attributes/swap.rb
[rs-base cookbook]: https://github.com/rightscale-cookbooks/rs-base

```bash
#!/usr/bin/sudo /bin/bash

set -e

# Set defaults for inputs; this is useful if you use the "right_st scaffold"
# command to add RightScript metadata comments
: ${BASE_SWAP_SIZE:=1}
: ${BASE_SWAP_FILE:=/mnt/ephemeral/swapfile}

chef_attributes=chef_attributes.json

# Construct the Chef attributes as a JSON file including passing in inputs and
# the recipe(s) to run in the run list
cat >$chef_attributes <<EOF
{
  "rs-base": {
    "swap": {
      "size": $BASE_SWAP_SIZE,
      "file": "$BASE_SWAP_FILE"
    }
  },
  "run_list": [
    "recipe[rs-base::swap]"
  ]
}
EOF

# Run Chef with the JSON attributes (Chef's other configuration is taken care
# of by earlier RightScripts in the "Chef Client for Linux (RightLink 10)"
# ServerTemplate
chef-client --json-attributes $chef_attributes
```

## Issues with RightLink 5 and Version 13 ServerTemplates

RightLink 5 and its accompanying Version 13 ServerTemplates used several non-standard Chef resources, which were built
into RightLink itself and subsequently removed in RightLink 6. Here are those resources and our recommendations for what
to do when migrating Chef cookbooks that use them:

* `remote_recipe`: This resource was used for running Chef recipes on other Server instances in a deployment. For this
  kind of orchestration we now recommend using [Self-Service] instead. Alternatively, the RightScale Professional
  Services team provides the [rsc_remote_recipe] cookbook which provides a new implementation of `remote_recipe`, but it
  requires passing a RightScale API refresh token to your instance rather than just using the instance facing API
  access so you will need to be sure to take extra care in choosing which account and access to use for this access.
  Also, sometimes the `remote_recipe` resource was used to run recipes on the same instance, in that case you may be
  able to use API calls through [local and proxied HTTP requests] to schedule RightScripts to run instead.
* `right_link_tag`/`server_collection`: These resources were used for tagging Server instance and finding tagged Server
  instances respectively. In the Version 14 ServerTemplates these resources were replaced by the [machine\_tag cookbook]
  and it works with RightLink 10, so we recommend using the latest version of the [machine\_tag cookbook]'s resources
  and functions to replace the `right_link_tag` and `server_collection` resources.
* `rs_shutdown`: This resource was used to reboot, stop, or terminate the Server instance. With RightLink 10, you can
  reboot or shutdown (stop) using the operating system's native facilities and RightLink will behave correctly, so we
  recommend using the native commands for reboot and stop (both use `shutdown` with specific arguments on Linux). For
  orchestration tasks like terminating an instance we instead recommend using [Self-Service].

[Self-Service]: /ss/about.html
[rsc_remote_recipe]: https://github.com/RightScale-Services-Cookbooks/rsc_remote_recipe
[local and proxied HTTP requests]: /rl10/reference/rl10_local_and_proxied_http_requests.html
[machine\_tag cookbook]: https://github.com/rightscale-cookbooks/machine_tag

The Version 13 ServerTemplates also used some of the 'rs\_\*' commands as well, we recommend you [use rsc in place of
'rs\_\*' commands].

[use rsc in place of 'rs\_\*' commands]: /rl10/migration/rl10_rightscript_migration.html#--rs_*--commands-are-no-longer-used

### rightscale_tools gem

The Version 13 ServerTemplate used a proprietary Ruby gem for some of the volume management and database functionality.
For the volume management functionality used `right_api_client` and authentication credentials that were passed in the
environment when running under RightLink 5. In RightLink 10 those credentials are no longer passed in the environment
and instead API calls are made with [local and proxied HTTP requests]. If you wish to continue using the Version 13
ServerTemplates cookbooks for volume management, you will need to modify the `rightscale_tools` gem that is included in
the `rightscale` cookbook (for example [rightscale\_tools-1.7.33.gem]) with a small change to its code to use the latest
`right_api_client`'s RightLink 10 proxy support. You can extract the contents of the gem file using `gem unpack` and
later use `gem build` to create a new gem file to replace it. The code that needs to be changed is in the file
`lib/rightscale_tools/api/15.rb`:

[rightscale\_tools-1.7.33.gem]: https://github.com/rightscale/rightscale_cookbooks/blob/release13.05.01/cookbooks/rightscale/files/default/rightscale_tools-1.7.33.gem

```ruby
        def initialize(options)
          super options

          api_token = ENV['RS_API_TOKEN']
          raise 'RightScale API token environment variable RS_API_TOKEN is unset' unless api_token
          account_id, instance_token = api_token.split /:/
          api_url = "https://#{ENV['RS_SERVER']}"
          options = {
            :account_id => account_id,
            :instance_token => instance_token,
            :api_url => api_url
          }.merge options

          @client = RightApi::Client.new options
          @client.log(@logger)
        end
```

It can be replaced with the following code:

```ruby
        def initialize(options)
          super options

          @client = RightApi::Client.new({:rl10 => true}.merge(options))
          @client.log(@logger)
        end
```

## Issues with RightLink 6 and Version 14 ServerTemplates

As mentioned above, the RightScale Professional Services team has a set of [RightLink 10 ServerTemplates] which have
adapted the cookbooks that make up the Version 14 ServerTemplates to work with [Chef] under RightLink 10. If you are
directly using the Version 14 ServerTemplates, you may be able to move to an equivalent RightLink 10 ServerTemplate. If
you have built ServerTemplates using the Version 14 cookbooks, you may be able to upgrade to the latest versions of the
cookbooks which have the necessary changes to support RightLink 10 running Chef. The Version 14 ServerTemplates still
used the `rs_run_recipe`/`rs_run_rightscript` to trigger running other recipes/RightScripts, but since RightLink 10 does
not include them you should [use rsc in place of 'rs\_\*' commands]. However, there is no longer a way to run
RightScripts on other Server instances using just the instance access so we recommend doing that kind of orchestration
with RightScale [Self-Service] instead. Alternatively, if you pass a RightScale API refresh token to your instance, you
can make the API calls to run RightScripts on other instances using `rsc`. The RightScale Professional Services team
also provides the [rsc_remote_recipe] cookbook which provides a `remote_recipe` resource to do the same thing.
