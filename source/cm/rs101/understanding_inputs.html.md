---
title: Understanding Inputs
layout: cm_layout
description: RightScale Inputs are essentially variables within a script that allow you to substitute specific, user-defined values for the input when an associated script is run on a server.
---

## What are Inputs?

Inputs are used to create easily customizable and reusable scripts. Inputs are essentially variables within a script that allow you to substitute specific, user-defined values for the input when an associated script is run on a server. You should create an input for any value that should be customizable within a script. This way, the same script can be used in multiple cloud environments and on across multiple servers to produce different results depending on the context in which it's used.

A ServerTemplate's Inputs tab shows all of the inputs declared in any of its scripts (RightScripts or Chef Recipes) located under its Scripts tab. Users can define values that should be used in place of the declared input when the related script is executed. The following diagram shows how inputs are used by RightScripts however the same variable substitution rules apply to Chef recipes.

![cm-script-input-example.png](/img/cm-script-input-example.png)

## Types of Inputs

There are several different input types. You can select the input type from the dropdown menu when editing them under an Inputs tab.

![cm-input-types.png](/img/cm-input-types.png)

There are several different input types. You can select the input type from the dropdown menu when editing them under an inputs tab.

| Type | Description |
| ---- | ----------- |
| Inherit | To inherit a value, select the "inherit" option and specify from where you would like to inherit. For more information on the hierarchy of inputs, see [Inheritance of Inputs](/cm/rs101/inheritance_of_inputs.html). |
| Env | Environment Variable. Select one of the predefined environment variables from a cloud infrastructure or RightScale. When you select an environment variable, the associated value will be passed to the server. For example, if you need to use a unique identifier, you can select the 'EC2\_INSTANCE\_ID' input, which is a unique ID that's assigned by Amazon when an instance is launched (e.g. i-baad23d3). You have the option of using either the server's own environment variables or one from another server in the deployment. See [List of Environment Inputs](/cm/ref/environment_inputs.html). |
| Text | Enter a valid text value for the input parameter. Inputs that are required in order to execute a script will be highlighted in red if values are missing. Make sure there are no trailing whitespaces at the end of the text value. Values set at higher levels in the inputs hierarchy will be inherited. For more information on the hierarchy of inputs, see [Inheritance of Inputs](/cm/rs101/inheritance_of_inputs.html). |
| Array | Enter an array/string of comma-separated values. You should only use this option for Chef recipes, not RightScripts. If you use this option for a RightScript, the array of values will be collapsed into a single, comma-separated string. So, you will need to parse the values within your script if you choose to use an array type with a RightScript. |
| Cred | Select one of the credentials that you've previously created and defined in your account. Typically you will create and use credentials for referencing private/sensitive information like your AWS Secret Access Key or the login/password to access your database or SVN repository. |
| Key | A list of valid SSH Keys for a cloud/region. Only SSH Keys that contain key material will be listed. |
| No Value/Ignore | The input will be ignored. No value will be passed to the server in the context of a RightScript. This can only be applied in the event of an optional input, and cannot be used for required inputs. |

**Ambiguous Inputs** occur if two or more RightScripts both call for the same input name, but have different values. This will create ambiguous inputs and you will be given error messages in the UI and you will not be able to launch until this is fixed.

**Note**: When you launch a server all of the inputs and their values are displayed. Missing inputs are displayed in red.

## Input Hierarchy Rules

Please see [Inheritance of Inputs](/cm/rs101/inheritance_of_inputs.html).

## Creating New Inputs in Scripts

If you are creating new scripts (RightScripts or Chef Recipes), be sure to follow best practices for creating new inputs.

### RightScripts

Before you create new inputs it's strongly recommended that you check RightScale's latest published ServerTemplates to see if a similar input already exists. For example, to reference the fully qualified domain of the master database, use MASTER_DB_DNSNAME, which is used by many RightScale scripts instead of creating your own input with a slightly different name.

#### Reserved Prefixes

If you are creating your own private RightScripts and need to create new inputs, it's strongly recommended that you use unique (not generic) input variable names to avoid unintentional confusion and collision with other scripts. For example, if you need to create a set of inputs that is specific to your company or project, you should consider using a common prefix for each unique input so that all of your inputs are easily identifiable and grouped together. (e.g. COMPANY_INPUT_1). If the name is too long, consider using a meaningful acronym instead.

However, there are several input prefixes that are reserved and cannot be used to create your own inputs.

* **EC2_** Prefix is reserved for EC2 environment variables.
* **RS_**  Prefix is reserved for RightScale. Inputs with the "R_" prefix are reserved for RightScale's internal use only and are not user-configurable. Therefore, they will not be displayed under the Inputs tab or on the input confirmation screen when you launch an instance.

#### Syntax

The syntax that is used to declare an input inside the code of a script differs slightly depending on the language. Most RightScripts published by RightScale are written in Bash, whereas most of the Chef Recipes are written in Ruby. It's recommended that you also use underscores (\_) and not spaces or dashes to separate two words. (e.g. MY_INPUT)

!!warning*Warning:* If a script contains [RightScript Metadata Comments](/cm/dashboard/design/rightscripts/rightscripts_metadata_comments.html), this input detection will not work and the input definitions in the comments will be used instead.

* **Bash** - $MYINPUT
* **Ruby** - ENV['MYINPUT']
* **Perl** - $ENV{'MYINPUT'}
* **Powershell** - $env:MYINPUT

#### Identifying Inputs

When you are looking at a RightScript's Inputs tab, the inputs in the code are automatically identified if they are defined with the correct syntax. The identified inputs display as user-defined input parameters under the Inputs tabs. The following example shows how inputs are identified within a bash script.

![cm-rightscript-inputs.png](/img/cm-rightscript-inputs.png)

If you are in Edit mode, you can use the **Identify** button to parse through the new code and display all properly declared inputs. As a best practice, you should always provide helpful descriptions that appear as tooltip hints when a user declares values for the inputs.

Below are a few examples of different types of inputs.

![cm-input-descriptions.png](/img/cm-input-descriptions.png)

* **Input Type** - An input can either be used to pass a single string value or an array or values to a script.
* **Default Value** - If an input is 'Advanced', it's strongly recommended that you provide an acceptable default value for the input. It can either be a hard coded value or a selection from a dropdown menu.
* **Category** - Select a category under which the input will be displayed when viewing an Inputs tab. You can also create a new category, if necessary.
* **Input Description** - You should always provide a detailed input description that clearly states what value should be passed as well as include an example value or list the acceptable range of values to demonstrate correct values with the correct syntax.
* **Advanced Options** - Use the checkboxes to control how inputs are displayed under the Inputs tab when users provide values for missing inputs.
  * **Required** - Check this box if a value for the input is required in order for the script to run successfully.
  * **Advanced** - Check this box if it's an input that applies to an advanced configuration. Since Advanced inputs are not displayed by default under the Inputs tab, it's strongly recommended that you provide an acceptable default value for the input.
  * **Provide a dropdown list of values** - Check this box to provide a predefined dropdown menu of acceptable values. It's recommended that you provide a dropdown menu if there is a defined list of acceptable values, which helps prevent users from entering an unsupported value or use incorrect syntax.

### Chef Recipes

#### Reserved Prefixes

Unlike RightScripts, there are no reserved prefixes that you are not allowed to use in Chef recipes.

#### Syntax

To declare an input (also called a "Chef attribute") in a Chef recipe, use the following syntax: **[:part1][:part2][:part_N_]**

Below is the code from one of our Chef cookbooks. Notice the three inputs (Chef attributes) that are declared in the code.

* [:db][:data_dir]
* [:db][:admin][:user]
* [:db][:admin][:password]

**'db::setup_privileges_admin.rb'**
~~~
#
# Cookbook Name:: db
#
# Copyright RightScale, Inc. All rights reserved. All access and use subject to the
# RightScale Terms of Service available at http://www.rightscale.com/terms.php and,
# if applicable, other agreements such as a RightScale Master Subscription Agreement.

rightscale_marker :begin

DATA_DIR = node[:db][:data_dir]

user = node[:db][:admin][:user]
log "Adding #{user} with administrator privileges for all databases."

db DATA_DIR do
  privilege "administrator"
  privilege_username user
  privilege_password node[:db][:admin][:password]
  privilege_database "*.*" # All databases
  action :set_privileges
end

rightscale_marker :end
~~~

#### Identifying Inputs

Even though an input (Chef attribute) is declared in a Chef recipe, RightScale will not identify it as such until it's been properly declared in the cookbook's metadata. If you create a new input in a Chef recipe you must also remember to manually update the metadata file (metadata.rb). Before you commit your changes to your cookbook repository, you must first rake the metadata, which updates the metadata.json file (from the metadata.rb file). RightScale only displays inputs if they are found in the cookbook's metadata (specifically the metadata.json file).

The following is an example of two properly documented inputs within the cookbook's metadata.

**'db::metadata.rb'**
~~~
attribute "db/admin/user",
  :display_name => "Database Admin Username",
  :description => "The username of the database user with 'admin' privileges (e.g., cred:DBADMIN_USER).",
  :required => "required",
  :recipes => [
      "db::install_server",
      "db::setup_privileges_admin"
  ]

attribute "db/admin/password",
  :display_name => "Database Admin Password",
  :description => "The password of the database user with 'admin' privileges (e.g., cred:DBADMIN_PASSWORD).",
  :required => "required",
  :recipes => [
       "db::install_server",
       "db::setup_privileges_admin"
  ]
~~~
If the recipe and metadata are properly constructed, the Chef attributes will appear as user-definable inputs in the Dashboard.

![cm-chef-input.png](/img/cm-chef-input.png)

For more information about how to update the Chef metadata correctly, see [Chef Metadata](http://support.rightscale.com/12-Guides/Chef_Cookbooks_Developer_Guide/02-End_User/04-RightScale_Support_of_Chef/Chef_Metadata/index.html).

## Defining Values for Inputs

### Where Should I Define Inputs?

As a best practice, you should define a majority of your inputs at either the ServerTemplate or deployment level.

You should only define inputs at the server or server array levels for performing tests or under unique circumstances. In a production environment, all inputs should inherit their values from previous levels (deployment level and below). The key benefit of defining inputs at the deployment level or below is that you can more easily maintain consistent server configurations across your entire deployment and associated arrays, because you can go to a single location (the deployment's Inputs tab) to see which input values are being used and know where those values are being inherited from. It's easier to troubleshoot problems within a deployment if you follow strict processes for defining inputs. For example, a problem within a deployment could be caused by the wrong input value being used by a server because the incorrect value was overwritten at the server level.

Although you have the flexibility to define inputs at the server or server array level, it's not a recommended best practice for most use cases. Unless you're an advanced user with unique configuration circumstances, you should only set an input parameter at the server level for development and testing purposes. An example might be that you've cloned a server and want to test it with a slightly different input parameter. One of the problems with defining input values at the server or server array (highest precedence) level is that it's difficult to keep track of a server's inputs. For example, if you need to troubleshoot a configuration problem you might have to manually check each server's Inputs tab to investigate the cause of the problem. However, setting input parameters at the Server level can prove to be quite useful in the right situation.

### When Should I Define Values for Inputs?

As a best practice, you should always define any inputs that are required by any boot/decommission scripts before you try to launch a server or enable a server array. Ideally, when a server is launched either manually or automatically, it inherits input values that were previously defined at one of the inheritance levels.

As a safety precaution, you are not allowed to manually launch a server if there are required inputs with missing values. If you try to launch a server that contains missing inputs, you will receive an error message that prompts you to provide values for any missing inputs that are highlighted in red. The following example screenshot shows an error message for missing inputs.

![cm-missing-inputs.png](/img/cm-missing-inputs.png)

If you receive this error message, you should cancel the server launch. At this point, you should go back and define values for any missing (required) inputs under the deployment's Inputs tab before launching the server again.

Although you can provide values for any missing inputs on this screen and continue the launch process, it's not a recommended best practice. See the following section for details.

### What is the Difference Between "Launch" and "Save and Launch"?

When you manually launch a single server from the Dashboard, the "Inputs Confirmation" screen displays which user-defined values are used for the declared inputs. When values have been provided for the missing inputs, you can continue the launch process.

At this point, you have two options if are going to continue launching the server. It's important to understand the difference between these two distinct actions.

* **Launch** - The current server will be launched with the specified input values. However, the specified values for the missing inputs will only be applied to the current server that's being launched. Any values that are provided at this screen for missing inputs will not be preserved. So, if the server is relaunched (thereby terminating the current server and launching a new server), the same inputs will be missing values. As a result, the new server will become "stranded in booting" and fail to reach the operational state. If you want to preserve the specified inputs for future launches, you must define the same values at the deployment (recommended) or server level. If you want to preserve the input at the server level, you must define it under the "Next" server's Inputs tab, which affects future launches and relaunches of that server.
* **Save and Launch** - The current server will be launched with the specified input values and the values will be saved at the server level. The same input values will be saved under the server's "Next" Inputs tab, which affects future launches and relaunches of that server. To follow best practices you should not define inputs at the server level because it overwrites values set at one of the other inheritance levels. It's recommended that you define any inputs that you want to preserve at the deployment level or below.

### Can I Define Multiple Values for an Input?

Yes, although it is not a recommended best practice for most use cases.

Ideally, you should only have a single input to represent a particular value. If you're using RightScale's published ServerTemplates, you should verify whether or not an input already exists that represents the value you're trying to parametize before you create a new one. Avoid creating multiple inputs that are designed to represent the same value. For example, inside of a single script or across multiple scripts, you shouldn't have two inputs that are used to pass the name of your application (e.g. Application Name, Application). If you are using several different ServerTemplates within a single deployment, you can go to the deployment's Inputs tab to see if there are multiple inputs where the same value is being used. If such cases do exist, you may want to consider consolidating the inputs.

At the deployment level, you can only define one value for an input. However, you may have a deployment that contains servers where different values are used for the same input depending on its ServerTemplate. This type of configuration might be appropriate in certain use cases. For example, you may have two different types of application servers that connect to a database server on different ports. As long as you don't override the input at the deployment or server/array level, each server can inherit a different value if it's set at the ServerTemplate level. The following example screesnshot shows the ServerTemplate inheritance in a deployment.

![cm-two-inputs.png](/img/cm-two-inputs.png)

Remember, where you define inputs determines which value is used. By using the input hierarchy correctly, you can accurately control which values are ultimately inherited and used by a script.

### Can I Hide a Sensitive Value for an Input?

Yes. RightScale's Credential Store (Design -> Credentials) allows you to create credentials for hiding sensitive values where you can hide the actual value from users in the Dashboard, but still allow that value to be passed to a script at execution time. For example, as a database system administrator, you might want to hide your database's administrator username and password from other members of your team, however those secret credentials need to be applied to the database setup scripts in order to properly launch and configure the database servers. In such cases, you can create a credential for each sensitive value.

A user will need 'designer' user role privileges to create a credential. Only the user who created the credential and other users with 'admin' user role privileges will be able to see the hidden value of a credential.

![cm-input-credentials.png](/img/cm-input-credentials.png)

## Managing Inputs

### How Do I Update an Input on a Running Server?

Remember, a server receives its inputs when it's launched. Once a server becomes operational, the inputs that it was originally launched with are static and can be seen under the "current" server's Inputs tab. (The "next" server's Inputs tab shows which inputs will be used to launch the next iteration of that server that results from either a launch or relaunch action.) You can execute any of the scripts defined by the server's ServerTemplate during runtime, even boot and decommission scripts.

If you want to change one of the inputs on the current server, you can run a script that uses the input. However, you must specify the new value for the input under the "current" server's Inputs tab before you run the script. Input hierarchy rules do not apply anymore because the server is already operational.

Typically, you will only need to run one of the boot/operational/decommission scripts. However, you can also use the 'Any Script' option to execute any script in your RightScale account.

**Note**: When you use the 'Any Script' option, the new inputs will not be saved to the "current" server's Inputs tab, however they will be recorded in the audit entry.

It's important to remember that when you change the input on a running server, the change is not automatically preserved. If you want to save the modified input for future iterations of that server, you need to update the Inputs tab at one of the input inheritance levels, preferably the deployment level.

### Does the "Current" Server's Inputs Tab Always Reflect what the Server was Originally Launched With?

No. Remember, since you can change an input on a running server, the "current" server's Inputs tab can change over the lifetime of the server. As a result, the "current" server's Inputs tab may not reflect which inputs were used to originally launch the server. However, you can check the server's audit entries for details.

## See also

* [How do RightScript inputs work?](/faq/How_do_RightScript_inputs_work.html)
