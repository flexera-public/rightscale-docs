---
title: Policy Tutorial
description: This page is a tutorial on developing a custom policy using the fpt tool.
alias: [policies/getting_started/policy_tutorial.html]
---

## Overview

This page walks through the development of a policy using the [`fpt` command-line tool](https://github.com/rightscale/policy_sdk/tree/master/cmd/fpt) to demonstrate the general approach and utilities that can be used when developing custom policies. 

It is recommended you store policy template code in a source control system, such as github, with the extension '.pt'. Policies can be developed in any text editor and then uploaded and applied to an account using the policy manager UI or the `fpt` tool. 

For this example we're going to create a policy that identifies and deletes unattached IP addresses. On AWS, these correspond to elastic IPs and cost money even when not in use. These type of resources can often accumulate if left unchecked and run up cost unnecessarily.

## Determine inputs

As a policy designer, you will need to determine what inputs you need from users to effectively deploy this policy.

This policy will accept two parameters:

* `param_whitelist`: IP addresses to not consider for deletion
* `param_email`: who to email reports to

## Gathering data

The initial policy code we develop will include the inputs we need and then will call any APIs that are needed to gather the data for this policy. Starting with this step ensures that data is being retrieved as expected, and saves the validation and actions until we ensure our data is correct.

~~~ ruby
name "Unattached IP Addresses"
rs_pt_ver 20180301
type "policy"
short_description "Cleanup Unattached IP addresses"
long_description "Checks for Unattached IP Addresses and automatically deletes them."
severity "low"
category "Cost"

permission "perm_read__ip_addresses" do
  actions   "rs_cm.show","rs_cm.index"
  resources "rs_cm.ip_addresses","rs_cm.clouds"
end

parameter "param_whitelist" do
  type "list"
  label "White list of IP Addresses to keep"
end

resources "clouds", type: "rs_cm.clouds"

resources "addresses", type: "rs_cm.ip_addresses" do
  iterate @clouds
  cloud_href href(iter_item)
end

policy "unattached_ip_addresses" do
  validate_each @addresses do
    summary_template "Unattached IP addresses to delete"
    detail_template <<-EOF
# Unattached IP Addresses
{{ range data -}}
{{ end -}}
EOF
    # check ... TBD -- set to false for now
    check false
  end
end
~~~

In order to pass syntax checks and ensure that an incident is created with our data, we've used a `check false` in the `validate_each` statement, which we'll come back to later to provide a real check.

After saving the file as tutorial.pt you can run it with `fpt run tutorial.pt param_whitelist=`. Running the command will output the debug log which will show a list of API calls as the policy executes. If you have any IP addresses in this account, you should see them here. If not, you can create them in the RightScale [Cloud Management dashboard](/cm/dashboard/) under Clouds -> Cloud name -> IP Addresses -> New. 

You can then run the policy again to see how results have updated after adding more IP addresses. Or you can do a `fpt retrieve_data tutorial.pt param_whitelist=` to download the data to disk for use in later commands. The `retrieve_data` command will run the policy and extract the datasource data. For this example it will output `resources_clouds.json` and `resources_addresses.json`, saving them to disk.

Here's a sample API response with one sample unattached IP and one sample attached IP:

~~~ bash
[
  {
    "address": "10.20.30.50",
    "created_at": "2018/05/07 22:00:12 +0000",
    "domain": "ec2_classic",
    "links": [
      {
        "href": "/api/clouds/1/ip_addresses/B41PVJI70FMLO",
        "rel": "self"
      },
      {
        "href": "/api/networks/98IF6IJR1ERIB",
        "rel": "network"
      }
    ],
    "name": "unattached_ip_address",
    "updated_at": "2018/05/07 22:00:12 +0000"
  },
  {
    "address": "10.20.30.40",
    "created_at": "2014/10/03 17:17:34 +0000",
    "domain": "ec2_classic",
    "links": [
      {
        "href": "/api/clouds/1/ip_addresses/4C25RVT8G7U3B",
        "rel": "self"
      },
      {
        "href": "/api/networks/C72HP153S3UOF",
        "rel": "network"
      },
      {
        "href": "/api/deployments/454876003",
        "rel": "deployment"
      },
      {
        "href": "/api/clouds/1/ip_addresses/4C25RVT8G7U3B/ip_address_bindings",
        "rel": "ip_address_bindings"
      }
    ],
    "name": "attached_ip_address",
    "updated_at": "2016/04/05 05:23:04 +0000"
  }
]
~~~

Save these two sample API addresses to disk as a file named "mock_addresses.json" for now.

## Processing data

Note how an an IP address attached to an instance has an entry in the "links" array of type `"rel": "ip_address_bindings"`. An IP address which is not attached has no entry. Therefore, this policy wants to then check that all entries in the datasource have `"rel": "ip_address_binding"` entry present, indicating they are all attached and in-use.

While we could have a complicated set of extraction logic in the `validate_each` statement, it would be easier to do the logic in JavaScript and make a new variable `is_attached` that can be checked with simple `equals` statement. Add and save the existing script to your tutorial.pt:

~~~ ruby
datasource "ds_munged_addresses" do
  run_script $js_munge_addresses, @addresses, $param_whitelist
end

script "js_munge_addresses", type: "javascript" do
  parameters "addresses", "ip_whitelist"
  result "unattached_ips"
  code <<-EOS
    var unattached_ips = []

    // rs_href extracts a hrefs for a RightScale API 1.5 resource
    // hrefs are stored in an array of link objects with values "rel" and "href"
    function rs_href(res, rel) {
      for (var j = 0; j < res["links"].length; j++) {
        if (res["links"][j]['rel'] == rel) {
          return res["links"][j]['href']
        }
      }
      return ""
    }

    console.log("iterating over addresses, count:", addresses.length)

    for (var i = 0; i < addresses.length; i++) {
      var address = addresses[i]
      is_attached = false
      self_href = rs_href(address, "self")
      binding_href = rs_href(address, "ip_address_bindings")
      var is_excluded = ip_whitelist.indexOf(address['address']) >= 0
      var is_attached = binding_href != ""

      unattached_ips.push({
        address: address['address'],
        name: address['name'],
        href: self_href,
        attached: is_attached,
        excluded: is_excluded,
      })
    }
EOS
end
~~~

Note a few things about the script: 

* It has two inputs for addresses obtained earlier and an optional whitelist of IPs to ignore. When running the script from the command line all options must be supplied. Since whitelist is an array supply you just supply a JSON array when supplying this parameter. 
* It has one output called `unattached_ips`. This is the name of the variable that will turn into the script. 
* We can also define functions internally and use them later. Functions can also easily be pasted into your browsers JavaScript console to develop a bit more interactively.
* It has a `console.log` statement for printing out interim results.

Running `fpt script tutorial.pt addresses=@mock_addresses.json ip_whitelist=[]`

Gets output:
~~~ bash
Running script "js_munge_addresses" from tutorial.pt and writing unattached_ips to out.json
console.log: "iterating over addresses, count:" 2
JavaScript finished, duration=457.244µs
~~~

Which outputs
~~~
[
  {
    "address": "10.20.30.50",
    "attached": false,
    "excluded": false,
    "href": "/api/clouds/1/ip_addresses/B41PVJI70FMLO",
    "name": "unattached_ip_address"
  },
  {
    "address": "10.20.30.40",
    "attached": true,
    "excluded": false,
    "href": "/api/clouds/1/ip_addresses/4C25RVT8G7U3B",
    "name": "attached_ip_address"
  }
]
~~~

Excellent! We have simplified the output to show only what we need and added an explicit field to indicate whether the IP is attached or not. 

## Adding the validations

With our processed data, the policy logic validation logic is fairly easy to write. The record should have `attached==true`. If it isn't attached, then it's in violation unless `excluded==true`. Let's add the validation logic to check for those conditions.

~~~ ruby
policy "unattached_ip_addresses" do
  validate_each $ds_munged_addresses do
    summary_template "{{ rs_project_name }} (Account ID: {{ rs_project_id }}): {{ len data }} Unattached IP Addresses"
    detail_template <<-EOS
# Unattached IP Addresses

| Name | Address | Href |
| ---- | ------- | ---- |
{{ range data -}}
| {{.name}} | {{.address}} | {{.href}} |
{{ end -}}
EOS
    check logic_or(
      val(item, 'attached'), 
      val(item, 'excluded')
    )
  end
end
~~~

Try out passing in different parameters such as `fpt script tutorial.pt addresses=@mock_addresses.json ip_whitelist=["10.20.30.50"]` and seeing how the output changes. Run the script to see the final table of entries printed out by the detail_template block above.

## Define the escalation actions

Finally add the escalation and save the file. Data is equal to all the IP addresses violating the policy. This means that you don't have to check for the excluded or attached fields and can just destroy everything passed in. 

~~~ ruby
escalation "delete_addresses" do
  request_approval  do
    label "Delete IP"
    description "If approved, automatically deleted unattached IP address"
    parameter "approval_reason" do
      type "string"
      label "Reason for approval"
      description "Explain why you are approving the action"
    end
  end

  run "delete_unattached_addresses", data
end

define delete_unattached_addresses($data) do
  foreach $item in $data do
    @ip_address = rs_cm.get(href: $item['href'])
    @ip_address.destroy()
  end
end
~~~

The `policy` block should get a reference to the escalation:
~~~ ruby 
policy "unattached_ip_addresses" do
  .... 
  escalate $delete_addresses
end
~~~

By default actions are not run. You can pass `-r` to the `fpt run` command to run things. Any code in a define block will get run as a Cloud Workflow, a custom orchestration language. The RCL language which powers Cloud Workflow is powerful and outside the scope of this tutorial, see [Custom Policies](/policies/getting_started/custom_policy.html) for a bit more info about developing these.

