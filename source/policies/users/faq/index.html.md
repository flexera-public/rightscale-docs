---
title: Policies Frequently Asked Questions
alias: [policies/faq/index.html]
---

## General Questions

### What's the difference between a Policy Template and an Applied Policy?

    A policy template is the policy-as-code (blueprint of the policy) that defines what a policy does (input, conditions, actions etc). An applied policy is the running instance of a specific policy template. A policy template can be applied as many times as needed with different input parameters. 

### How do I get access to Policy Manager?

    Check out the detailed [role matrix](/policies/#how-policies-work-access-control) and contact your administrator for appropriate access. 

### What additional roles do I need to apply (run) policies?

    Additional role requirements are captured in the [Policy List](/policies/getting_started/policy_list.html). 

### How often do policies run?

    The policy will trigger right after you first apply it. After that, it will execute based on the frequency you selected at the time of applying it. e.g.: Every 15 minutes, Hourly, Daily, Weekly, or Monthly.

### What are the different severity levels?

    RightScale has 4 pre-defined severity levels: **critical, high, medium, and low**. Severity is a mandatory field so if you don't provide one, we default it to `low`. [Learn more here](/policies/reference/v20180301/policy_template_language.html#metadata). To change the severity level of a policy template, update the `severity` field in the template and re-upload it. 

### How do I submit my feedback on Policies?

    You can directly talk to the team working on policies by clicking the "Give Feedback" button on the bottom left of the Governance. For reporting issues or bugs, please contact [support@rightscale.com](mailto:support@rightscale.com) directly.

## Credentials FAQ

### If I update a credential, will the policies using that credential be updated?

    In short, yes. When a [Credential](/policies/users/guides/credential_management.html) object is changed, any applied policies that use that credential will use the updated value the next time the policy is evaluated. To trigger an immediate policy evaluation, use the [Run Now](/policies/users/guides/ui_overview.html#applied-policies--run-now-) option on the [Applied Policies](/policies/users/guides/ui_overview.html#applied-policies-) page.

## Custom Policies FAQ

### How do I customize built-in RightScale policies as per my specific requirements?

    All RightScale policy templates are open source and can be downloaded straight from our public [git repo](https://github.com/rightscale/policy_templates). You can then modify the code based on your requirements and upload it on the **Templates** before applying it.

### How do I write my own policy?

    Learn more about our policy template language [policy template language](/policies/reference/v20180301/policy_template_language.html) and [find some examples here](/policies/getting_started/custom_policy.html).

### How do I leverage the Policy APIs?

    RightScale is an API driven platform. [API docs can be found here](http://reference.rightscale.com/governance-policies/).

### What file extension is recommended for Policy Templates?

    We recommend using `.pt` as the file extension for policy templates but it's not a mandatory requirement.

## Catalog FAQs

### Can I apply a policy template across multiple accounts?

    Yes, you can apply a Policy Template from the **Catalog** view and select the accounts you wish to apply it on. 

### How do I delete RightScale Policy Templates from the Unpublished Catalog view?

    We do not allow users to delete built-in RightScale Policy Templates at the moment.

## Troubleshooting FAQ

### Where can I find troubleshooting docs?

    Check out [Testing and Debugging](/policies/getting_started/custom_policy.html#testing-and-debugging) docs.

### What happens when the policy errors out?

    Policies in error state are shown on the Dashboard and Applied Policies page. Policy engine will keep retrying the policy when it errors out based on the policy frequency (e.g.: Every 15 minutes, Hourly, etc) to get pass potential temporary issues. 

### What are Terminated incidents?

    When a policy with incidents is terminated, the incident will be terminated and no more actions will take place. The incident will move to a **Terminated** state.

### Where are my Applied Policies that were terminated?

    We do not store information about policies that were terminated. If this is something you would like to see, please don't hesitate to submit a feedback. 

### Why don't I see an "Export to CSV" option in the Incident details panel?

    Incident details data is completely customizable and defined in the respective policy template. The data content is not always compatible in the CSV format. Hence, we only show the option to "Export to CSV" when the incident details contains a markdown table. 
