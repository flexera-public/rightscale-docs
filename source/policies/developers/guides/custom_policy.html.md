---
title: Create a Custom Policy
description: Flexera allows users to not only take advantage of our policies but also write their own based on their organizational needs. This page outlines the policy template language and how to write a new policy.
alias: [policies/getting_started/custom_policy.html]
---

## Overview

In addition to built-in **Cost, Security, Operational, and Compliance** policies, the system supports creating *custom policies* using the new and purpose built [Policy Template Language](/policies/reference/policy_template_language.html). These policies can then be uploaded and applied in RightScale just like the pre-built ones.

It's first recommended to view the [Policy Lifecycle](/policies/getting_started/policy_lifecycle.html) to get a general sense of what happens during the execution of a policy.

## Tooling

There are a few tools that a developer might find useful for interacting with APIs in general and the policy APIs and workflow specifically.
* [rsc](https://github.com/rightscale/rsc) is the all-purpose RightScale API client, written in Go. It supports all API calls from the Policy, Self-Service, and Cloud Management APIs with built-in help and validation.
* [fpt](https://github.com/rightscale/policy_sdk/tree/master/cmd/fpt) or the Flexera Policy Tool is a command-line tool that interacts with the Policy API in a more specific way. It helps with the most common tasks that come up when developing your own policies, such as testing JavaScript, calling against external APIs, and checking Policy Template syntax.
* [Postman](https://www.getpostman.com/) or [HTTPie](https://httpie.org/) are also popular general-purpose tools for calling APIs and can get used to examine raw API responses from external sources.

## Sample Policies

The easiest way to get started on developing your own policies is to look at pre-existing code. The full source code to all published [RightScale policies](/policies/getting_started/policy_list.html) is open source and available online. Policies such as [Unattached Addresses](https://github.com/rightscale/policy_templates/blob/master/cost/unattached_addresses/unattached_addresses.pt) and [Azure Reserved Instance Utilization](https://github.com/rightscale/policy_templates/blob/master/cost/azure/reserved_instances/utilization/azure_reserved_instance_utilization.pt) demonstrate many of the different parts of the language.

We recommend storing all your custom policy source code in a version control system such as github with the `.pt` file extension.

## Policy Tutorial

A [short tutorial](/policies/getting_started/policy_tutorial.html) is available that walks through developing a simple policy using the above tooling.

## Debugging Tips and Tricks

### Policy debug log

Whenever a policy is applied it automatically creates a debug log that can be viewed by users with the `policy_designer` role in the given account. The debug log is viewable in the UI in Applied Policies -> Actions -> View log. It displays the following information as the policy is evaluated:
* Outgoing http requests including headers, body, and query parameters.
* Resources, Datasource, and JavaScript data as its evaluated.
* console.log and console.dir statements from JavaScript.
* Info about failed validation/check statements.

    ![policy-view-log.png](/img/policy-view-log.png)

### API-based Datasources

* Raw JSON responses can be gathered using whichever tool you choose and compared against the debug log above to see if transformations are proceeding as planned.
* The debug log always prints out the first 6K of the final datasource after all transformations have been applied.

### JavaScript-based Datasources

* For more complicated data transformations and logic, its recommended to do most of the [work using JavaScript](/policies/reference/policy_template_language.html#processing-datasources-with-javaScript) in a policy template `script` block. Policy scripts are run in an interpreter with a limited set of capabilities. A script datasource can contain one or more other datasources as inputs and always outputs a single datasource. [fpt](https://github.com/rightscale/policy_sdk/tree/master/cmd/fpt) contains a `retrieve_data` command which can fetch those input datasources and extract them to disk. The `fpt script` command can then be run on those extracted datasources to test out logic. Arbitrary data can also be fed in to test out corner cases and other conditions. The `fpt script` command evaluates scripts locally using the same environment and libraries as the service does.

### Incidents

* All data failing validation will be listed in the debug log. To force all data to fail, in order to test subsequent actions such as email, run or data templates, you can add a `check false` statement which will cause an incident to always be created.

~~~
policy "my_policy"
  validate_each $my_datasource   do
    detail_template <<-EOS
# Table of data

| Account | Type | Field1 |
| ------- | ---- | ------ |
{{ range data -}}
| {{ .account }}({{ .type }}) | {{.field1}} |
{{ end -}}
EOS
    escalate $my_escalation
    check false
  end
end
~~~

### Escalation and Resolution Actions

* Any escalation and resolution actions containing a `run` action will be executed in [Cloud Workflow](/ss/reference/rcl/v2/index.html). These executions will show up under the [Self-Service CWF Console](/ss/tools/cloud_workflow_console.html). The Self-Service product must first be selected by going to the Product selector in the upper right corner and select "Self-Service" -- users must have the `ss_designer` role to access this tool.
* For `run` escalation actions, code from a `define` block can be pasted into the CWF console and arbitrary data supplied in order to test out actions in isolation.
* For `run` escalation actions, within the code defined in a `define` block, you can log to [audit entries](/cm/dashboard/reports/audit_entries/). These entries can be found in Cloud Management > Reports > Audit entries and require at minimum the `observer` role to access.

~~~ ruby
escalation "foo" do
  run "myaction", data
end

define myaction($data) do
  $$debug = true
  call sys_log('policy action',$data)
end

define sys_log($subject, $detail) do
  if $$debug
    rs_cm.audit_entries.create(
      notify: "None",
      audit_entry: {
        auditee_href: @@account,
        summary: $subject,
        detail: $detail
      }
    )
  end
end
~~~

* For `run` escalation actions, within the code defined in a `define` block, you can reference any authentication defined in an `auth` or `credentials` declaration. These request signers will automatically be exported as global variables to the Cloud Workflow process. It is recommended to use the `credentials` declaration.

~~~ ruby
credentials "auth_aws" do
  schemes "aws", "aws_sts"
  label "AWS"
  description "Select the AWS credential from the list"
  tags "provider=aws"
end

escalation "delete_unencrypted_s3_buckets" do
  run "delete_unencrypted_s3_buckets", data
end

#https://docs.aws.amazon.com/AmazonS3/latest/API/RESTBucketDELETE.html
define delete_unencrypted_s3_buckets($data) return $all_responses do
  $$debug=true
  $all_responses = []
  foreach $item in $data do
    sub on_error: skip do
      $response = http_delete(
        auth: $$cred_aws,
        url: join(["https://",$item['host'],"/", $item['bucket_name']]),
      )
      $all_responses << $response
      call sys_log('Delete AWS Unencrypted S3 Buckets',to_s($response))
    end
  end
end
~~~
If you want to test out the code in a [Self-Service CWF Console](/ss/tools/cloud_workflow_console.html) you can mimic the credentials reference passed through from the policy with the [signer function](/ss/reference/rcl/v2/ss_RCL_functions.html#miscellaneous-signer) function to authenticate requests using existing credentials. The signer function accepts the credential id, available on the credentials show page as "Identifier".
