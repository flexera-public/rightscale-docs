---
title: Inheritance of Inputs
layout: cm_layout
description: Inputs in RightScale can be defined at several different levels and each level has its own set of input tabs. The enforced input hierarchy rules help you more efficiently manage server configurations across a deployment.
---

## Overview

Inputs can be defined at several different levels and each level has its own set of input tabs. The enforced input hierarchy rules help you more efficiently manage server configurations across a deployment. It's important to understand the input hierarchy rules and how they're applied to servers so that you can control which values will ultimately be inherited and used when a script is executed.

**Important!** Input hierarchy rules are only evaluated and applied to a server at launch time. Once a server is operational, the input values are saved locally to the current server. If you want to change the input on a running server, you need to modify the input value under the "current" server's Inputs tab and run the associated script. Any changes to a "current" server will not affect future launches or relaunches of that server unless the setting is preserved at one of the input hierarchy levels.

![cm-input-hierarchy.png](/img/cm-input-hierarchy.png)

* **RightScript / Chef Recipe** - The lowest level of precedence is at the script level.
* **ServerTemplate** - Define commonly used generic values for inputs at the ServerTemplate level. Inputs defined at the ServerTemplate level overwrite values set at the script level.
* **Deployment** - Define inputs that you want all servers in your deployment (or associated server arrays) to use at the deployment level. Inputs defined at the deployment level overwrite inputs defined at the ServerTemplate or script level.
* **Server / Server Array** - The highest level of precedence is the server or server array level. Inputs defined at this level overwrite inputs defined at any other level.

## ServerTemplate Level

Typically, most servers inherit their input values from their ServerTemplates. Many of the ServerTemplates published by RightScale already have default values that are predefined for many of the more generic inputs, which helps streamline and simplify the setup process for end users. Only application-specific inputs should be left undefined since they are unique to each setup. To improve the usability of your ServerTemplate, keep the number of undefined inputs at the ServerTemplate to a minimum. Setting values for your Inputs is arguably the most difficult part of becoming proficient using the RightScale Dashboard to manage your cloud assets. Using our ServerTemplates as a starting point for what you build and manage in the cloud facilitates using sensible settings for your inputs. Although you can change or override the default inputs of a ServerTemplate, making unnecessary changes increases the risk of entering incorrect or invalid input settings.

![cm-input-inheritance-template.png](/img/cm-input-inheritance-template.png)

## Deployment Level

Input values defined at the deployment level take precedence over any input values defined at the ServerTemplate level. When you edit and define input values at the deployment level, they are inherited by *all* servers in the deployment and overwrite *any* input values that are inherited from ServerTemplates or scripts. It's useful to define inputs at the deployment level if you have multiple deployments that use the same ServerTemplate revision. For example, your 'staging' deployment might use the same ServerTemplates as your 'production' deployment. In such cases, you can modify inputs for the 'staging' deployment in order to isolate it from the 'production' deployment so that you do not accidentally overwrite data on your production database. In the following example, we changed the ADMIN_EMAIL input at the deployment level.

![cm-input-inheritance-deployment.png](/img/cm-input-inheritance-deployment.png)

## Server / Server Array Level

Lastly, inputs that are defined at the individual server or server array level overwrite input values that are defined at the script, ServerTemplate or deployment levels. In the following diagram, notice that the values that are set at the server level are inherited by the server.

As a general rule, you should always define inputs at either the ServerTemplate or deployment levels for configuration settings or changes that you want to persist across your current deployment, as well as for future server launches/relaunches. You should only define inputs at the server level for making temporary changes. The ability to define inputs at the server level should only be used in unique situations or for performing quick tests on a single server. In a production environment, it's important to define inputs at a higher level for organizational and consistency reasons. For example, let's say you define the location of your SVN repository for application code (Input: SVN_APP_REPOSITORY) at the deployment level. Now, when you need to perform an update to your application and point to the latest branch, all you have to do is change the value in one location and then run the code update script (RightScript: WEB app svn code checkout) across all servers in the deployment. In a single action you just updated all of your application servers, performing code pushes easily.

![cm-input-inheritance-server.png](/img/cm-input-inheritance-server.png)

## Best Practices for Inputs

### ServerTemplate End User

* Set any application-specific inputs at the deployment level. You must provide values for any missing inputs that are required by boot scripts prior to launching a server. At the deployment level you can also override any inputs set at either the Script or ServerTemplate levels. Missing inputs that are required for operational scripts can be left unset prior to launching a server (since the inputs are not used by any of the boot scripts). You will be prompted to provide values for any missing inputs (that are required) before an operational script can be executed.
* If possible, do not override any inputs at the server or server array level so that the deployment's Inputs tab will show the values that are used by all servers in the deployment to promote configuration consistency across all the servers. If you override inputs at the server level, it will be difficult to troubleshoot configuration inconsistencies across all servers in the deployment.
* Since the input inheritance rules are only applied when a server is launched, if you want to change the inputs on a "current" running server you must change the input(s) under the current server's Inputs tab and run a script that uses the modified input(s). Values are only applied when you run an associated script; they are not instantly applied to the instance when you change the value under the "current" server's Inputs tab.

### ServerTemplate Developer

* Leave application-specific inputs unset at the ServerTemplate level so that end users will be forced to provide their own values that are unique to their application. (e.g. Database Backup Lineage, Database Master FQDN, Application Name, etc.)
* If you can provide an acceptable value for an input that will satisfy most configurations, you should set a default value for the input at either the script or ServerTemplate levels. For example, setting the ' **Database DNS TTL Limit**' input to 60 (seconds) is an acceptable default value for a database server's DNS record.
* Provide helpful tooltip descriptions for each input that you add to a script. It's also helpful to provide a sample value with the correct syntax.
* If an input requires the use of a sensitive value such as a password, select a credential for the input to encourage best practices for passing sensitive values via inputs. (e.g. Database Admin Password) *Note*: The ServerTemplate's documentation should tell users to create any required credentials as a prerequisite.

## See also

- [How do RightScript inputs work?](/faq/How_do_RightScript_inputs_work.html)
- [Understanding Inputs](/cm/rs101/understanding_inputs.html)
