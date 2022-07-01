---
title: Input Types
layout: cm_layout
description: Definitions of the Input Types you will encounter while working in the RightScale Cloud Management Dashboard.
---
There are several different input types. You can select the input type from the dropdown menu when editing them under an inputs tab.

| **Type** | **Description** |
| -------- | --------------- |
| Inherit | To inherit a value, select the "inherit" option and specify from where you would like to inherit. For more information on the hierarchy of inputs, see [Inheritance of Inputs](/cm/rs101/inheritance_of_inputs.html). |
| Env | Environment Variable. Select one of the predefined environment variables from a cloud infrastructure or RightScale. When you select an environment variable, the associated value will be passed to the server. For example, if you need to use a unique identifier, you can select the 'EC2\_INSTANCE\_ID' input, which is a unique ID that's assigned by Amazon when an instance is launched (e.g. i-baad23d3). You have the option of using either the server's own environment variables or one from another server in the deployment. See [List of Environment Inputs](/cm/ref/environment_inputs.html). |
| Text | Enter a valid text value for the input parameter. Inputs that are required in order to execute a script will be highlighted in red if values are missing. Make sure there are no trailing whitespaces at the end of the text value. Values set at higher levels in the inputs hierarchy will be inherited. For more information on the hierarchy of inputs, see [Inheritance of Inputs](/cm/rs101/inheritance_of_inputs.html). |
| Array | Enter an array/string of comma-separated values. You should only use this option for Chef recipes, not RightScripts. If you use this option for a RightScript, the array of values will be collapsed into a single, comma-separated string. So, you will need to parse the values within your script if you choose to use an array type with a RightScript. |
| Cred | Select one of the credentials that you've previously created and defined in your account. Typically you will create and use credentials for referencing private/sensitive information like your AWS Secret Access Key or the login/password to access your database or SVN repository. |
| Key | A list of valid SSH Keys for a cloud/region. Only SSH Keys that contain key material will be listed. |
| No Value/Ignore | The input will be ignored. No value will be passed to the server in the context of a RightScript. This can only be applied in the event of an optional input, and cannot be used for required inputs. |

**Ambiguous Inputs** occur if two or more RightScripts both call for the same input name, but have different values. This will create ambiguous inputs and you will be given error messages in the UI and you will not be able to launch until this is fixed.

_Note_: When you launch a server all of the inputs and their values are displayed. Missing inputs are displayed in red.
