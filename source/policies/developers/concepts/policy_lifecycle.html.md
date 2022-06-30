---
title: Policy Lifecycle
description: The entire lifecycle of a RightScale policy, from start to finish.
alias: [policies/getting_started/policy_lifecycle.html]
---

## Overview

For an overview of basic policy concepts, please read [policy engine in a nutshell](/policies/#policy-engine-in-a-nutshell). This document will delve further into what happens when a policy is applied in a given account.

An "applied policy" represents policy template code that is evaluated on a fixed schedule that is configured by the user applying the policy. The schedule can range from  15 minutes to monthly depending on the needs and requirements of the policy and will run on that schedule until terminated by a user.

Each evaluation of a given policy is stateless -- all data needed must be fetched every iteration and processed as needed.

Each applied policy runs in the context of a single RightScale account. The policy UI allows for applying a policy across multiple accounts, in which case an applied policy is created in each account selected.

## Evaluation

Policy evaluation consists of a series of steps:
* permissions check
* data retrieval and transformation
* validation
* incident handling

### Permissions Check

Permissions are checked if an optional [`permissions` block](/policies/reference/policy_template_language.html#permissions)` is supplied. If the user doesn't have sufficient permissions to take the actions specified, the policy is not applied. These permission checks are currently limited to user roles and actions within the CMP platform.

### Data retrieval and transformation

Data retrieval is accomplished using the [datasource](/policies/reference/v20180301/policy_template_language.html#retrieving-data-api-data-with-datasources) and [resource](/policies/reference/v20180301/policy_template_language.html#retrieving-data-listing-resources) references. A policy can have any number of such references, each of which will typically correspond to a single API request to RightScale or an external API. 

If a policy needs to act on data from multiple API calls, datasources may be [chained together](/policies/reference/policy_template_language.html#chaining-datasources) to have one feed into another. The [debug log](/policies/getting_started/custom_policy.html#policy-debug-log) will list API requests as they happen as well as a snippet of the data downloaded.

### Validation

Once all data has been gathered, the validations defined in the [`policy` block](/policies/reference/policy_template_language.html#policy) are evaluated. Validations consist of a series of checks on the data. Any items failing those checks are gathered together as violation data. Each `validate` and `validate_each` statement occurs independently of the others and can produce 1 "incident". Multiple `validate` statements can therefore produce multiple incidents. A `validate` or `validate_each` statement may have multiple `check` statements. The first failed `check` will result in that data being added as a violation.

If all checks pass and there is no violation data, then one of two things can happen. If no incident exists, nothing will happen and no incident will be generated. If an incident currently exists in a `triggered` state, it will proceed to a `resolved` state and any `resolution` actions defined will be run.

If there is violation data, that data is acted on by any `escalate` actions defined on the policy.

### Incident Actions

In the case where a violation is detected and an incident already exists, the system evaluates the whole of the violation information to determine if any piece of data in the violation has changed, and if so then the incident actions defined in the `escalation` section will be run. This means that if an existing incident is updated with new violation data, the escalation actions such as `email`, `run`, or `request_approval` will be run again **as if it were created for the first time**. Actions can be run manually on some or all items in violation with [`run_action`](/policies/users/getting_started/index.html#run-action).

Escalations will proceed until they come to a stopping point. This is a either a manual action such an `approval_request`, an error, or because all actions have finished. If multiple `escalate` fields are given, they will be evaluated in parallel and the status of each one gathered separately. The incident will continue to exist in a `triggered` state until the underlying conditions which triggered it change.

## Termination

When an applied policy is terminated, any incidents are immediately moved to a `terminated` state. Any cloud workflow actions defined in `run` statements will run to completion unless manually aborted in the [CWF console](/policies/getting_started/custom_policy.html#escalation-and-resolution-actions). No additional escalation or resolution actions will be taken.
