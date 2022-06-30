---
title: Applying Policies
---

## Applying Policies Overview

[Policy managers](/policies/users/getting_started/policy_roles.html) and designers have the ability to apply policies in any account they have permissions to. Policies can be applied from the [Catalog](catalog.html) or, for policy designers, from the [Templates page](/policies/users/guides/ui_overview.html#feature-overview--templates-). When applying a policy, the applier will have to fill out  configuration information for the policy, some of which is common across all policies and some of which is specific to the policy that is being applied. Once applied, the policy can be managed using the [Applied Policy](/policies/users/guides/ui_overview.html#feature-overview--applied-policies-) page. Once a policy is applied it continues to run indefinitely until terminated by a policy manager.

## Common Policy Configuration Options

For every applied policy, there are a set of configuration options that are generally applicable. This section describes each of those options.

### Policy Name

The name entered here is what is shown in the [Applied Policies](/policies/users/guides/ui_overview.html#feature-overview--applied-policies-) page. By default, the policy template name, but it can be customized to more accurately describe the behavior of this specific application of the policy.

### Policy Description

The name entered here is what is shown in the [Applied Policies](/policies/users/guides/ui_overview.html#feature-overview--applied-policies-) page. By default, the policy template name, but it can be customized to more accurately describe the behavior of this specific application of the policy.

### Policy Schedule

Policies are run on an interval defined by the options available in this dropdown. When a policy is applied, it is run immediately -- once a policy run has completed, the interval timer is started for the next run. The system supports only a pre-defined set of intervals:
* 15 minutes
* 1 hour
* 24 hours
* 7 days
* 1 month

For example, if a policy is applied at 2:00PM and "15 minutes" is selected, the policy will run again 15 minutes after the current run completes. Most policies run fairly quickly, so this "drift" will be small and the policy may run again around 2:16PM or so. In cases where a policy takes a long time to run, or in all cases where policies run over a long period of time, the exact time that a policy runs will "drift" later and later.

!!warning*Warning*A policy using the "monthly" option will run on that day of the month every month. If the month doesn't have that day in it, the policy won't run that month. For example, a monthly policy applied on January 31st will never run in the month of February or any month that doesn't have 31 days.

### Test Mode

When test mode is enabled, no actions will be taken when a policy triggers an incident, with the exception of the email notification. This setting can be used to test the behavior of a policy but provides assurance that no remediation actions will actually be taken. Turning this on means that policy can safely be run and will not make any changes to your environment. When enabled, the policy will show as a "Test" policy in the Applied Policies view.

### Skip Action Approvals

Many policies define actions that occur when an incident is detected, but guard against those actions automatically running by including a [manual approval](/policies/users/getting_started/#handling-incidents--manual-approval-steps-) step before the action is run. When the approval step exists, actions are paused until a [policy approver](/policies/users/getting_started/policy_roles.html) approves the action. When this setting is turned on, all manual approval steps are skipped and actions are run automatically. 

### Severity

Severity incidates how urgently this type of incident should be treated in your organization -- it is shown on the `Dashboard` view as well as the `Incidents` view. A default value is defined in the [policy template](#basic-concepts-policy-template-) and the user applying the policy can adjust it as needed based on the policy configuration. It must be  one of `"low"`, `"medium"`, `"high"` or `"critical"`.

### Select Accounts

When applying a policy, a user is permitted to apply the policy to any account to which she has access. The dropdown shows all accounts to which the user has policy manager access -- the user can select individual accounts or can use the "Select all" option to select all available accounts.

In some cases, policies are designed such that they should only be run in 1 account - in these cases the user is only able to select one account. 

## Select Credentials

When a policy fetches data from an external API the user must select appropriate credentials. The credential selector shows only those credentials that match various rules set in the policy template, but can be overridden by selecting "View all credentials". In this case any compatible credential is shown, even if it may not work with the policy itself. 

The documentation of the Policy should describe the resources accessed and the permissions needed to perform any actions.

## Policy-specific Configuration Options

Every policy is different and can contain a variety of configuration options depending on the defined behaviors of the policy checks and remediation actions. Generally speaking the policy documentation should provide a sufficient explanation of each configuration option and its effect. If not, contact the policy publisher to gather more context.

## Evaluating Policies for your Environment

Since policies can contain complex rules for checking violation states and can run actions against your infrastructure to remediate issues, you should always test policies out before allowing them to take automated actions. The general recommended sequence for evaluating a policy for your needs is:
1. Apply the policy with the "Test Mode" enabled and, if applicable, only your email for notification
2. Update the policy with different configuration values until you are happy with the incidents reported
3. Once you are satisfied with the incidents reported, update the policy with "Test Mode" disabled and a broader set of notification emails
4. After the policy has been in service for some time and you are satisfied with the actions it takes after manual approvals, optionally turn on "Skip Action Approvals" to run the policy in a fully automated fashion

If the policy doesn't quite get the results you require, you might consider [customizing the policy logic](/policies/developers/) itself to better match your specific use case.
