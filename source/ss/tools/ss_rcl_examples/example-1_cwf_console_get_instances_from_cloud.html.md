---
title: CWF Console Get Instances from Cloud
description: CWF Console code to get instances from cloud.
---

## Introduction

Cloud Workflow Console (**CWF**) code to get data from AWS Sydney (Cloud 8) with instance name from end user. 

## Code Syntax
 ```
 define get_servers($name) return $new_instance do 
  @instances =rs_cm.clouds.get(cloud_id: 8).instances(filter: ["name=="+$name], view: "tiny")
  $new_instance=size(@instances) 
 end
 ```

## CWF Console
 **name**  is an input variable.  Ex.  `sql`

![ss-cwf-console-example-1-launch-get-servers-1.png](/img/ss-cwf-console-example-1-launch-get-servers-1.png)

## Expected Outcome

### Process Info
![ss-cwf-console-example-1-launch-get-instance-process-info-2.png](/img/ss-cwf-console-example-1-launch-get-instance-process-info-2.png)

### Outputs
![ss-cwf-console-launch-get-instance-outputs-3.png](/img/ss-cwf-console-example-1-launch-get-instance-outputs-3.png)

### Tasks
![ss-cwf-console-launch-get-instance-tasks-4.png](/img/ss-cwf-console-example-1-launch-get-instance-tasks-4.png)

### Source
 * Displays the source code that was used.  If you want to modify and reuse the code, click on `Clone`
![ss-cwf-console-launch-get-instance-source-5.png](/img/ss-cwf-console-example-1-launch-get-instance-source-5.png)

## Notes
 The RCL code can above be changed to point to any cloud. For example:

 * AWS EU Ireland:  **cloud_id: `2`**
 * GCP:             **cloud_id: `2175`**
 * AzureRM West US: **cloud_id: `3518`**


