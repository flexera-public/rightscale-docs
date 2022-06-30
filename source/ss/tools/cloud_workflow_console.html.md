---
title: Cloud Workflow Console
description: RightScale's Cloud Workflow Console provides the ability to execute Cloud Workflow code (RCL) directly in order to help debugging your custom code. .
---

## Introduction

This Cloud Worflow Console (**CWF**) Console provides the ability to execute RightScale Cloud Workflow code (RCL) directly against the **CWF** engine without having to use a CAT file. **CWF Console** only works with RCL code, you can't paste in an entire CAT (it doesn't take any declarations). Plugins `cannot` be tested in the **CWF Console**

## Permissions Required

 The [ss_designer](/cm/ref/user_roles.html#-ss_designer) role is required to access CWF console

## Accessing the CWF Console

  * Click on **Designer** on the left panel. 
  * Click on **CWF Console** to the right of `Designer` 

 ![ss-cwf-console-launch-1.png](/img/ss-cwf-console-launch-1.png)

  * Click on **Create New Process**

 ![ss-cwf-console-launch-2.png](/img/ss-cwf-console-launch-2.png)

## Tips
  * If you want to see the value of a variable/resource, `return` it from your main definition – it will show up as an "Output" when the process is over. Alternatively, you could use a global variable (`$$`) or resource collection (`@@`) and it will show up while the process is running on the `Process Info Tab`.

## Examples
  * [Example 1: Get Instances from AWS Sydney/GCP/ARM](ss_rcl_examples/example-1_cwf_console_get_instances_from_cloud.html)
  * [Example 2: Show Date](ss_rcl_examples/example-2_cwf_console_show_date.html)
  * [Example 3: Cloud Lookup](ss_rcl_examples/example-3_cwf_console_cloud_lookup.html)
  * [Example 4: Random Number](ss_rcl_examples/example-4_cwf_console_random_number.html)