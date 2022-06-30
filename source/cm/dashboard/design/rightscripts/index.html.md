---
title: RightScripts
layout: cm_layout
alias: cm/dashboard/design/rightscripts/rightscripts.html
description: In the RightScale Cloud Management Dashboard, A RightScript is an executable piece of code that can be run on a server in the cloud.
---
## Overview

A **RightScript** is an executable piece of code that can be run on a server. RightScripts consist of changes that can be run on a server during the boot, operational, or shutdown phases. They cannot be run on a "stranded" server. A RightScript consists of a script (typically written in Bash, Ruby, or Perl), a set of attachments that are downloaded from S3, a set of packages that are installed using the system's package manager (yum in the case of Red Hat-based systems), and a set of input parameters that must be passed into the script. In order to use RightScripts on a server, a ServerTemplate must be created, the RightScript(s) must be added to the template, inputs must be provided, and lastly a server must be launched.

The following operational buttons exist from this page:

* **New** - Create a new RightScript from scratch.
* **Diff** - Compare two RightScripts or multiple revisions of the same RightScript.
* **Merge** - Merge the differences of two RightScripts together into one RightScript. Perform a 3-way merge of RightScripts. For example, let's say you have cloned and customized a public script. When a new revision of the public script is published, you can merge those updates into your customized script.
* **Search** - Search through Private, Shared, RightScale and/or Partner RightScripts for a specific text pattern.

Visit the [RightSripts - Actions and Procedures](/cm/dashboard/design/rightscripts/rightscripts_actions.html) page for information on common RightScript-related tasks.

See [Developing RightScripts](/cm/dashboard/design/rightscripts/rightscripts_developing.html) for a step-by-step guide to creating RightScripts on your own.

## Concepts

RightScripts consist of changes that can be applied to a Server during the boot, operational, or shutdown phase. When a ServerTemplate is imported from the MultiCloud Marketplace, all of its RightScripts become visible under Design -> RightScripts. You can publish RightScripts by themselves or in the context of a ServerTemplate.

When a RightScript is added to a ServerTemplate, it can be added as a boot, operational, or decommission script.

1. **Boot Scripts** - RightScripts that are automatically run during a Server's boot time. Boot scripts are often software installation and configuration scripts.
2. **Operational Scripts** - RightScripts that are run during a Server's run time, often to automate 'runbook' operations.
3. **Decommission Scripts** - RightScripts that are run during a Server's decommissioning phase when a Server is terminated.

* **Any Script** - (available on operational servers only) If a server is running, you also have the ability to run any available RightScript from a dropdown menu. The "Any Script" option will only appear when an instance is operational, under the **Scripts** tab.

A RightScript consists of the following components:

* A **script** (typically written in Bash, Ruby, Perl or Powershell, or other executable languages.
* A set of optional **attachments** that are downloaded (typically from S3 buckets) and made available on the instance.
* A set of **packages** that are installed using the system's package manager (for example, yum in the case of Red-Hat-Linux based systems).
* A set of **Inputs** - configuration parameters that must be passed into the script and specified in the RightScale Dashboard or via the API.

### What are the benefits of using RightScripts?

RightScripts provide an easy way of performing actions on a Server, and allow you to extract variable configuration information from common operations. Similar to ServerTemplates, they provide a very modular solution for increased reliability and repeatability. For example, you can update a single RightScript which is referenced across multiple ServerTemplates and deployments, changing the configuration for a variety of servers at once.

### How do I create a RightScript and add it to a ServerTemplate?

The [Intermediate Example](http://support.rightscale.com/03-Tutorials/02-AWS/01-Beginner_Examples/4._Intermediate_Example/index.html) tutorial walks you through the steps of creating a new RightScript from scratch, adding it to a ServerTemplate and rearranging the order of executable boot scripts.

## About RightScript Attachments

### What is an attachment?

An attachment is a file that you can statically link with a RightScript. It's useful for attaching smaller files for development and testing purposes where can easily use the attached files in your RightScript's code using the 'RS_ATTACH_DIR' environment variable. For example, you could attach a MySQL dumpfile (.gz) or tarball of your application code (.tgz) to an install boot script. However, for production environments, it is recommended that you store your application code in a git/svn repository and your database backups using automated backups that are created using RightScale-published ServerTemplates.

### How do I upload an attachment to a RightScript?

See [Upload an Attachment to a RightScript.](/cm/dashboard/design/rightscripts/rightscripts_actions.html)

### Where are attachments stored?

When you upload an attachment to a RightScript in your own RightScale account, RightScale will store the object in our local repository and will make the object available to the instance at runtime.

### Can I edit an attachment in the Dashboard?

Yes. See [Edit RightScript Attachments](/cm/dashboard/design/rightscripts/rightscripts_actions.html).

### What is the maximum size of an attachment?

100 MB

### How do I call an attachment in a RightScript?

Before a RightScript is run on an instance, all of its attachments are downloaded to a temporary directory. The path to the temporary directory is passed to the script in the RS_ATTACH_DIR environment variable. All files will be stored in that directory using their original file names (without any path component).

!!info*Note:* Please use RS_ATTACH_DIR, as the ATTACH_DIR variable has been deprecated.

**Bash**: $RS_ATTACH_DIR

**Ruby**: ENV['RS_ATTACH_DIR']

**Powershell**: "$env:RS_ATTACH_DIR"

## Decommission RightScripts

There are 3 types of RightScripts:

* Boot Scripts - RightScripts that are called when a new instance is launched and in the boot-up phase.
* Operational Scripts - RightScripts that are available from the Dashboard in the operational phase.
* Decommission Scripts - RightScripts that are called when an instance is terminated.

**Decommission Scripts** are essentially operational scripts that help you safely terminate (decommission) an instance from a deployment. Previously, when an instance was terminated, there was no way to perform any last minute actions before it was terminated and disappeared. Decommission scripts provide a great way to gracefully "un-launch" an instance and perform important last minute actions that need to be done before an instance is permanently terminated. However, there is typically a time frame of a couple minutes depending on the cloud to perform these actions. If you list too many actions or one of them takes a long time to complete, the remaining actions might not have enough time to successfully execute.

!!info*Note:* If the time allotted for Instance Termination is exceeded, the remaining portion of the script and all scripts that follow will not be called.

### What types of Decommission Scripts are recommended?

Decommission scripts should only be used for performing critical last minute actions that do not require a long time to complete.

* Deregister the instance's IP address. It usually takes a second or less to perform.
* Disconnect the instance from (HAProxy) load balancers.

### What types of events are not recommended?

* Backups to S3. Large backups may take a very long time and partial backups may cause problems later.
* Sending emails.The e-mail is queued, but may never get sent in time.

### How do I perform actions that take longer than 100 seconds before an instance is terminated?

There may be cases where 100 seconds is an insufficient amount of time to perform some necessary final actions. Therefore, you cannot use decommissioning scripts. In such cases, you'll need to perform these longer actions using operational scripts since there is no time limit associated with operational scripts. Simply end the operational script with a request to EC2 to terminate this server. After the self-termination, decommission scripts will run in the same way they would have run from the RightScale Dashboard.

#### Example: Wait 200 seconds, then self-decommission & terminate

Using RightScale-enabled images w/ RightLink >= 5.6 is recommended for this technique.

The intention of sleeping is only to simulate running a script longer than 100 seconds.

After decommission call the system's shutdown command.  

!!info*Note:* Depending on the kernel you are using (and if the instance is instance-store or EBS) a shutdown may stop the instance instead of terminate.  

To ensure termination, use the RightScale or appropriate cloud API to terminate the instance by name or identifier.

~~~
    #!/bin/sh -ex

    sleep 200; service rightlink decommission && shutdown -h now &
~~~

#### Example: Backup to S3, then self-terminate

Create a tar archive of your whole home directory (/home) and save it to S3 before your instance disappears.

The script below is very simple. For instance, you may want to add more checks to see if the backup is 100% solid.  
 Feel free to cut and paste this code as an example and expand on the error checks as needed.

Amazon EC2 API Tools is required. You can use the [Install Amazon EC2 API Tools](http://www.rightscale.com/library/right_scripts/Install-Amazon-EC2-API-Tools/23675) RightScript to install these. Your AWS/EC2 credentials are also needed. Use [Import AWS and EC2 credentials](http://www.rightscale.com/library/right_scripts/Import-AWS-and-EC2-credentials/23672) to copy them to ~/root on the instance.

~~~
    #! /bin/bash -x

    # Description: Perform a backup and then Terminate this Server.

    source /etc/profile # Must be first, the same for the OS login.
    source /var/spool/ec2/meta-data.sh
    source /var/spool/ec2/user-data.sh

    # Work in a safe place to write.
    #
    cd /tmp

    # At this point in the script we have all of the ENV set like a login to root.

    # Backup all of the /home file tree, this may take a while....
    #
    # NOTE: Assumes that we havce lots of free space. Watch out.
    tar czf /tmp/my_home_tar.tgz /home

    # Save the backup in S3 for later use.
    #
    # You need an AWS S3 account for this step.
    #
    # NOTE: Script assumes that the bucket exists before the stript is run.
    s3cmd put my_bucket:my_home_tar.tgz /tmp/my_home_tar.tgz

    # Terminate this server now that the data is saved.
    #
    # NOTE: $EC2_INSTANCE_ID has the instances name for this instance.
    ec2-terminate-instances "$EC2_INSTANCE_ID"

    # This script ends while EC2 is doing the terminate.
~~~

## Revision History Timeline for RightScripts  

The Revision timeline for RightScripts shows the most recently committed revisions of the script. Similar functionality exists for ServerTemplates.

 ![cm-revision-timeline-default.png](/img/cm-revision-timeline-default.png)

By default, the timeline will only show the two most recent revisions along with the HEAD revision.

You can either select a different revision to view or click the **Revision** button, which will take you to the script's **Revisions** tab.

If you select a revision that's older than the two most recent revisions, it will be displayed and the Revision timeline will display [...] to denote a larger gap in the revision history.

 ![cm-revision-timeline-old-revision.png](/img/cm-revision-timeline-old-revision.png)

## Related FAQs

* [How do I access 64-bit files and registry keys from a RightScript using PowerShell on a Windows instance?](/faq/How_do_I_access_64-bit_files_and_registry_keys_from_a_RightScript_using_PowerShell_on_a_Windows_instance.html)
* [Why do scripts and recipes fail with a missing project ID error?](/faq/clouds/google/Why_do_scripts_and_recipes_fail_with_a_missing_project_ID_error.html)
* [How can I stop a RightScript that is stuck in Scheduling execution](/faq/How_can_I_stop_a_RightScript_that_is_stuck_in_Scheduling_execution.html)
