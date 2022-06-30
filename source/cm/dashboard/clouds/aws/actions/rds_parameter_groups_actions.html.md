---
title: RDS Parameter Groups - Actions
description: Common procedures for working with RDS Parameter Groups in the RightScale Cloud Management Dashboard.
---

## Create a New RDS Parameter Group

### Overview

Parameter groups contain configuration parameters and their settings. They govern the behavior of your RDS database. Use the following procedure to create a new RDS Parameter Group.

### Steps

* Navigate to: **Clouds** > *AWS Region* > **RDS Parameter Groups**
* Select the **New Group** action button and provide the following information:
  * **Group Name** - Name your parameter group (One string, case is not preserved. Required. Example: StagingParams )
  * **Group Description** - Describe your group. (Alphanumeric string. Required. Example: Try new settings for stage and test deployment)
  * **DB Engine** - MySQL 5.1. Only MySQL 5.1 is currently supported, so it is pre-populated for you in the web form.
* Select the **Create** action button to save your Parameter Group and all of its settings.

### Post Tutorial Steps

* View your Parameter Group
* Modify a parameter

## View RDS Parameter Groups

### Overview

Use the following procedure to view all of the parameters for a specific RDS Parameter Group

### Steps

* Navigate to **Clouds** > *AWS Region* > **RDS Parameter Groups**
* Select an existing RDS Parameter Group
* A table with the following fields is displayed:
  * Name
  * Data type/Apply Type
  * Source
  * Value
  * Description

View all of the database engine parameter values that will be applied to all RDS Instances that are created with this RDS Parameter Group.

**Action Buttons**

You can execute operations on the selected RDS Parameter Group using the following action buttons.

* **Reset** - Reset all of the parameter values to their original default values.
* **Delete** - Delete the RDS Parameter Group. You cannot delete an RDS Parameter Group that's actively being used by a running RDS Instance.

## View MySQL Engine defaults

After creating a RDS Parameter Group, the MySQL parameters and their default values are set for you.

* To view the parameters: **Clouds** > *AWS Region* > **RDS Parameter Groups** > Select the *ParameterGroupName*

The following fields are displayed (for dozens of individual parameters):

* **Parameter Name** - Name of the individual parameter
* **Parameter Value** - Value of the parameter
* **Type**
  * *Data Type* - Boolean, integer or string.
  * *Apply Type* - The type of parameter. Either static or dynamic.
* **Source** - Parameter source.
  * *System*: Amazon RDS service.
  * *EngineDefault*: Source is the database engine;
  * *User*: Parameter value came from the user
* **Value** - Actual parameter value. (Boolean, integer or string value.) A "-" indicates it is not set, and a default value will be used.
* **Description** - A short description of the parameter

!!info*Note:* Not all parameters are modifiable. Modifiable parameters have an actionable link for the parameter name.
