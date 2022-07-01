---
title: Create Custom ServerTemplates
description: Detailed steps for creating your own custom ServerTemplates in RightScale including cloning and modifying an existing ServerTemplate or creating a ServerTemplate from scratch.
---

## Overview

There are two different ways to create a custom ServerTemplate.

* Clone and modify an existing ServerTemplate
* Create a ServerTemplate from scratch

If possible, it is best to clone and modify an existing ServerTemplate, especially if you are only going to make minor changes such as adding a few new scripts or changing the inputs.

## Getting Started

### Clone and Modify a ServerTemplate

You will save time and effort if you can find an existing ServerTemplate whose functionality is already similar to your current development needs. However, if you cannot find a similar ServerTemplate to modify, you will need to create a ServerTemplate from scratch. Before you invest the time and effort to create your own ServerTemplate from scratch, you should always check the MultiCloud Marketplace to see what's available.

If you are successful finding a ServerTemplate in the MultiCloud Marketplace that you want to customize, you will need to import the latest committed revision and clone it to create an editable version.

1. Go to **Design** > **MultiCloud Marketplace** > **ServerTemplates**. Use the keyword searches and category filters to find a ServerTemplate that best meets your requirements.
2. Select and import the ServerTemplate that best meets your requirements.
3. Clone the ServerTemplate to create an editable HEAD version. Change the ServerTemplate's name accordingly.
4. (Recommended) Commit the ServerTemplate. This way, you'll know that the first revision of the cloned ServerTemplate matches the original version of the ServerTemplate that it was cloned from, which will allow you to always revert back to the original state of the ServerTemplate before you made any modifications to it. For the commit message, you can use a simple commit message like "original version."
5. (Optional) Attach new (Chef) cookbooks to the ServerTemplate.
6. Modify the ServerTemplate's script lists by adding Chef recipes (from one of the attached cookbooks) and/or RightScripts.

![cm-clone-servertemplate.png](/img/cm-clone-server-template.png)

### Create a ServerTemplate from Scratch

If you want to build a ServerTemplate from scratch, it is strongly recommended that you start your ServerTemplate development using the latest version of RightScale's "Base" ServerTemplates in the MultiCloud Marketplace (MCM). You'll find base ServerTemplates for launching Linux or Windows servers. You will also find ones that use primarily RightScripts or Chef recipes.

[Base ServerTemplate for RightLink 10](https://www.rightscale.com/library/server_templates/RightLink-10-6-0-Linux-Base/228959)

#### About the Base ServerTemplates

The purpose of the base ServerTemplates is to provide ServerTemplates that already have built-in best practices for launching servers in the cloud using ServerTemplates. The base ServerTemplates include the following:

* **Base Configurations** - Basic set of scripts for a RightLink-based server with logging, monitoring, alerts, etc. Scripts are required for displaying audit entries, log data, alerts, and monitoring graphs in the Dashboard. RightLink is a client-side agent that's installed by a RightImage and used for setting up optimized communication between an instance and the RightScale management platform.
* **MultiCloud Support** - Each base ServerTemplate includes several MultiCloud Images (MCIs) that reference the latest supported images with a frozen software repository date that has been tested across a variety of different clouds. (e.g. AWS, Azure, etc.)
* **Predefined Alerts** - Basic set of alerts that is suitable for monitoring most server types.
* **Predefined Inputs** - Examples of system required input variables.
* **Built-in Best Practices** - Each ServerTemplate includes all of RightScale's best practices for ServerTemplate development.

#### How to use the Base ServerTemplates

1. Go to Design -> MultiCloud Marketplace -> ServerTemplates. Perform a keyword search for "base servertemplate" to find the most recently published base ServerTemplates in the MCM. Look for the ServerTemplates where "RightScale" is the publisher. You'll find a few different types of base ServerTemplates for both Linux and Windows operating systems.
2. Select and import the latest published revision of the ServerTemplate that best meets your requirements.
3. Clone the ServerTemplate to create an editable HEAD version. Change the ServerTemplate's name accordingly.  
  ![cm-clone-base.png](/img/cm-clone-base.png)
4. Commit the ServerTemplate. This way, you'll know that the first revision of the cloned ServerTemplate matches the original version of the ServerTemplate that it was cloned from, which will allow you to always revert back to the original state of the ServerTemplate before you made any modifications to it. For the commit message, you can use a simple commit message like "original version."

!!info*Tip:* Under the cloned ServerTemplate's Info tab, you can always see which ServerTemplate it was originally cloned from.

![cm-cloned-from.png](/img/cm-cloned-from.png)

## Build a Test Server

If you are developing a ServerTemplate, you should start by creating a server using the HEAD version of your custom ServerTemplate in a designated deployment that you've created for performing sandbox tests. The created server should serve as your "development/test" server.

![diag-ServerTemplate2Server.png](/img/cm-server-template-server.png)

1. Create a "Test" deployment.
2. Go to the HEAD version of your custom ServerTemplate that you're currently developing and add a server to the "test" deployment. it is important that you add the server using the HEAD version so that any changes that you make to the HEAD ServerTemplate will be reflected in the created server.
3. Under the test deployment's **Inputs** tab, define any missing inputs that are required by any of the boot or decommission scripts. If you are not sure which inputs are required to successfully launch/terminate a server, you can launch the server and see which inputs are highlighted in red at the inputs confirmation page. Since operational scripts may or may not be executed during the lifetime of the server, it is not required that you specify values for all missing inputs that are used by operational scripts in order to successfully launch/terminate a server.
4. The first step is to launch the server before you have made any modifications to the ServerTemplate. Launch a test server and make sure that it successfully becomes operational. If the server "strands in booting" and does not launch successfully, create a RightScale support ticket. Although it is rare to experience an error launching an unmodified published ServerTemplate, it is best to perform this simple test to be absolutely sure that you are using a solid ServerTemplate that does not have any obvious bugs. You must be able to successfully launch a server using the unmodified HEAD ServerTemplate so that you'll know that if there are any problems with the server, it is not a result of a preexisting bug.
5. Once it becomes operational, terminate the server. Similarly, if the server "strands in decommissioning" you should log a RightScale support ticket.
6. Commit the HEAD ServerTemplate that was used to successfully launch and terminate the test server. The reason why you're committing a cloned and unmodified ServerTemplate is so that you can always revert back to the first committed revision (rev1), which is the original, pristine state of the ServerTemplate before you introduced any changes. When committing the ServerTemplate, you can leave a simple commit message. (e.g. Original version)
7. You are now ready to start modifying the ServerTemplate.

## Script Customizations

### Add Scripts

Remember, a server inherits its list of scripts from its ServerTemplate. it is a one-to-one relationship. Therefore, if you add a script to a HEAD ServerTemplate, the script will automatically appear when viewing a server that was created with the HEAD version of that ServerTemplate.

Follow the guidelines below for adding scripts to one of the boot, operational, or decommission script phases.

#### Boot Script Modifications

If you are making modifications to the boot scripts phase of a ServerTemplate, follow the guidelines below.

it is recommended that you only add one script (or a set of scripts if they're related) at a time instead of adding several unrelated scripts all at once, which will help you better troubleshoot your template and scripts, if there are problems. This way, if there's an error, you'll know exactly which script caused the problem.

1. If you are adding completely new scripts to a ServerTemplate's "boot scripts" section you should launch a server using a HEAD version of a ServerTemplate. If you intend to add the new script as a boot script and you are still developing and testing it, you will find it helpful to first test the script as an operational script instead of a boot script. This way, if the script fails, it will not result in a "stranded" server and you avoid having to relaunch or launch new servers to test the script. Therefore, you should first add a HEAD version of the script to the ServerTemplate as an operational script. Test the script on an operational server. If it fails, you can modify the HEAD version of the RightScript and execute it again on the running server. Once you have tested the script and confirmed its functionality, you should commit the RightScript. You can then safely add the newly committed revision to the end of the ServerTemplate's boot script list. Repeat the steps to add additional scripts to the boot phase.
2. Generally speaking, new scripts that introduce new functionality should be added to the end of the boot/decommission scripts list. Remember, boot and decommission scripts are executed in sequential order, so be sure to list any software installation scripts before related configuration scripts. (See screenshot below.) If you are adding scripts that introduce new server functionality it is typically safe to add them to the bottom of the list (recommended), which will make it easier to identify custom scripts that were added to the ServerTemplate and also make it easier to view the differences between revisions when you perform a differential (diff).
  [![cm-add-boot-script.png](/img/cm-add-boot-script.png)
3. If you are modifying an existing script or replacing it with a similar script be sure to add the modified version of the script in the same location to ensure that the script will be executed at the proper time. For example, in the screenshot below, we are replacing the application code checkout script that is designed to pull the application code from an SVN repository with a different script that will pull the application code from an S3 bucket. As a best practice, you should always add the new script before/after the script that it is going to replace before you delete the old script from the list.  
  ![cm-swap-script.png](/img/cm-swap-script.png)
4. Boot scripts are executed in sequential order at boot time when an server is launched/relaunched. Therefore, if you add a new script to the ServerTemplate's boot script list and there is already a running server that's using the HEAD version, you will need to relaunch the server (or launch a new server) to test the new script. If the server becomes stranded in booting, you will need to troubleshoot the script to determine the cause of the failure. Use the server's audit entries or SSH/RDP into the server to troubleshoot the problem. Although you can manually execute a newly added boot script on a running server, you should always test any modifications to the boot script list with a relaunch or launch of a fresh new server in order to test the automated execution of these scripts to ensure that there are not any script dependencies that you might not have taken into consideration.

#### Operational Script Modifications

The list of operational scripts should be reserved for only containing useful scripts that may or may not be executed during the runtime of your server. It should not contain any scripts that are not relevant to the ServerTemplate. Unlike boot and decommission scripts, the order in which the scripts are placed in the list is not important because operational scripts are always executed manually, on-demand.

it is also important to remember that any boot or decommission scripts can also be executed on-demand on a running server, so you may not want to add the same script again under the operational script list. However, some users find it useful to see all of the operational scripts listed together because a script may have a dependency which might prevent its successful execution as a standalone operational script. If you do choose to place a script in both the boot/decommission script list as well as the operational script list you must remember to keep both script revisions in-sync.

#### Decommission Script Modifications

Decommission scripts follows many of the same guidelines as boot scripts since they are also executed automatically in sequential order. However, a key difference between boot and decommission scripts is the time period in which they must be executed. When a server is terminated, RightScale enforces a 180 second time period during which all decommission scripts are executed before an instance termination request is made to the cloud. Therefore, you should keep the list of decommission scripts to a minimum. You do not want to include a script that will take a long time to complete because it may fail to execute completely or prevent subsequent scripts from ever being executed. For example, you should not include a "database backup" script in the decommission phase. On the contrary, running a script that updates a load balancer's HAProxy configuration file to remove an application server that's being terminated from the load balancing pool would be an acceptable and recommended action.

### Test Scripts

Perform the following steps to properly test any script modifications.

**Boot/Decommission Scripts**

1. Add the new script that you want to test to the editable ServerTemplate's HEAD version. Note: You should only test one script at a time.
2. You should already have a "test" server that you created earlier that references the HEAD version of the ServerTemplate so that any changes to the HEAD version will automatically be reflected in the test server. If you do not have a test server, create one now. See [Build a Test Server](/cm/servertemplate_dev_guide/create_custom_servertemplates.html#build-a-test-server).
3. Launch the server.
4. Did the server become operational?
  * **Yes** - If the server becomes operational, you can check the audit entries and/or SSH into the instance to verify that the script was executed successfully and performed the expected actions. Commit the ServerTemplate to preserve your successful modification.
  * **No** - If the server becomes "stranded" in booting/decommissioning and never becomes operational because one of the scripts failed, you should troubleshoot the problem. Once you have fixed the script you can test the ServerTemplate again by re-launching the server. Alternatively, if you do not want to terminate the running server, you can manually run the fixed script again by either manually running the script from the dashboard under the current server's Scripts tab or using the `rs_run_right_script -n "RightScriptName"` command for executing a RightScript or `rs_run_recipe -n "RecipeName"` for a Chef recipe. Continue to execute the remaining scripts in the boot/decommissioning script list. Once you are confident that all of the boot/decommission scripts will run successfully, relaunch the server to test it again. As a basic rule, you should only commit a ServerTemplate if it can successfully launch a server into an operational state.
!!info*Note:* If you use rs_run_right_script with the -p option, you must pass a COMPLETE set of input values in which case the input values that are defined on the server are not merged. If you omit any inputs, e.g. do not use -p, then the values defined on the server are used. However we do not provide a way to mix and match.

5. Reboot the server. You should always reboot the server to make sure that the new script is reboot-safe.
6. Did the server reboot properly?
  * **Yes** - it is important to make sure that the new script is reboot-safe.
  * **No** - If the server does not successfully reboot, you will need to troubleshoot the problem. Follow the troubleshooting steps outlined in the "No" section in step 4 above and then test the reboot action again.
7. If the server was successfully launched and rebooted, you should commit the ServerTemplate to preserve your successful modification. Note: By committing the ServerTemplate you will be prompted to also commit any HEAD objects (e.g. RightScripts, MultiCloud Images, etc.) by default.
8. Repeat the process to test another script.

**Operational Scripts**

![cm-add-operational-script.png](/img/cm-add-operational-script.png)

1. Add the new script to the operational scripts list of the editable HEAD version of the ServerTemplate. Note: You should only test one script at a time.
2. You should already have a "test" server that you created and launched earlier that references the HEAD version of the ServerTemplate so that any changes to the HEAD version will automatically be reflected in the test server. The new script will automatically become visible at the server level. If you do not have a test server, create and launch one now. See [Build a Test Server](/index.html).
3. Run the operational script. Provide values for any required inputs that are missing. One of the benefits of using a dev/test server that's using a HEAD ServerTemplate is that you can make changes to the ServerTemplate's list of scripts so that you can instantly test new scripts without having to relaunch the server. Alternatively, you can always use the "Any Script" option on a running server to run and test a script before you decide to add it to the ServerTemplate.
  * **Note for RightScripts**: Although you can also run a RightScript at the command line of an instance by using the `rs_run_right_script` command, it is not a recommended best practice because a complete audit entry will not be generated and there is no way to know which user is responsible for running the script. One of the key benefits of using the RightScale cloud management platform is that fact that user actions are properly tracked and recorded. See [Run a RightScript on a Server](/cm/dashboard/design/rightscripts/rightscripts_actions.html#run-a-rightscript-on-a-server).
4. Did the script execute successfully Check the server's audit entries and/or SSH into the instance to verify that the script was executed successfully and performed the expected actions.
  * **Yes** - Commit the ServerTemplate to preserve your successful modification. Note: By committing the ServerTemplate you will be prompted to also commit any HEAD objects (e.g. RightScripts, MultiCloud Images, etc.) by default.
  * **No** - Check the audit entry to troubleshoot the problem. Fix the problem and run the script again to retest.
5. Repeat the process to test another script.

## MultiCloud Images

By definition, a ServerTemplate is cloud-agnostic. On the other hand, the actual machine images that are used to launch an instance in a cloud infrastructure are cloud-specific. MultiCloud Images help bridge the gap between a cloud and the server that you're trying to launch with a ServerTemplate.

A ServerTemplate's list of MultiCloud Images (MCIs) determines which clouds it supports. At a minimum, a ServerTemplate must have at least one MCI that supports at least one cloud. However, you'll often find that ServerTemplates in the MultiCloud Marketplace are published with multiple MCIs and support multiple clouds.

If you are building a custom ServerTemplate, there are several factors to take into consideration for determining which MCIs should be included in your ServerTemplate.

* **Cloud Support** - Which clouds (AWS US-East, AWS US-West, etc.) should the ServerTemplate support? (i.e. A user should be able to use the ServerTemplate to launch a server into which cloud(s)?)
* **OS Support** - Which operating system (OS) and distribution should the ServerTemplate support? (Note: Options may be limited by the clouds themselves.)
* **Custom Images** - Will the ServerTemplate be designed to use custom-built images? If you are building custom images that you've RightScale-enabled by installing RightLink on them, you will need to create new MCIs. If you are building custom images that you want another RightScale account to be able to use, you will need to either make those custom images publicly available in the selected cloud or share them accordingly. See [Create a custom RightImage for faster boot times](/cm/dashboard/design/multicloud_images/multicloud_images_actions.html#create-a-custom-rightimage-for-faster-boot-times).

The RightScale platform makes it easy to build ServerTemplates that support multiple clouds.

If you are going to build a custom ServerTemplate, you can design it to support multiple clouds with minimal effort. For example, if you are building a ServerTemplate from scratch, it is strongly recommended that you start with one of the "Base" Linux/Windows ServerTemplates published by RightScale because they have been published with MCIs that support multiple clouds.

See [Create a New MultiCloud Image](/cm/dashboard/design/multicloud_images/multicloud_images_actions.html#create-a-new-multicloud-image).

## Inputs

One of the best ways to improve the usability of a ServerTemplate is to provide useful input descriptions and default values. As a general rule, keep the number of undefined inputs at the ServerTemplate to a minimum so that the users of your ServerTemplate will only have to provide values for a few missing inputs.

There are several things to take into consideration.

* Does an input already exist for providing the same information? For example, many of RightScale's RightScript-based ServerTemplates have an input called ADMIN_EMAIL. Therefore, if you need to pass the same information to a new script, you should reuse the existing input name instead of creating a new input variable with a similar name.
* Provide default values for generic inputs. To make it easier for a user to use your ServerTemplate, you should provide as many acceptable default values as possible and only leave the application-specific inputs blank. Users will be encouraged to define values for any missing inputs at the deployment level to promote consistent server configurations across all servers in a deployment.
* Provide detailed input tooltip descriptions for each input.  
![cm-tooltip.png](/img/cm-tooltip.png)
* Be sure to include a clear description and a sample value to show acceptable values and correct syntax.
  * **RightScripts** - To add or change an input description, go to a RightScript's Scripts tab.
  * **Chef Recipes** - To add or change an input (Chef attribute) description, update the cookbook's metadata.rb file.
* Remove duplicate input descriptions. By default, each variation of an input description will be displayed as the input's tooltip. Since multiple scripts can use the same input, it is important that every script uses the same description for a particular input in order to prevent multiple descriptions from being displayed in the dashboard. In the screenshot below, notice that LB_VHOST_NAME is an input that is "used in" two scripts.  

When you hover over the info icon for the input's tooltip description, two different descriptions are actually displayed because each script has a different description for the input. In such cases, it can be quite confusing for an end user. As a result, a user will often enter an incorrect value which will cause a script to fail. (See screenshot below.) In order to provide a consistent description for an input, the same description must be used by each script.
  [![cm-two-input-descriptions.png](/img/cm-two-input-descriptions.png)
To solve the duplicate input description problem above, update the scripts so that they use the same description for the input. As a best practice, only one description should be displayed for each input.  
For **RightScripts**, you can change the input's description under the Scripts tab.
For **Chef Recipes**, you can change the input's description in the cookbook's metadata.rb file.
* Use cloud-agnostic input names, if applicable. For example, instead of using cloud-specific input name like S3_BUCKET_NAME or CLOUD_FILES_CONTAINER, you could use a generic name for the input such as REMOTE_STORAGE_CONTAINER. Perhaps you would also need to add another input where a user can use a dropdown list to select which type of cloud storage will be used for storing backup files.

To learn the best practices for creating and managing inputs in RightScripts and Chef recipes, see [Understanding Inputs](/cm/rs101/understanding_inputs.html) and [Change the Category for an Input on a ServerTemplate](/cm/dashboard/design/server_templates/servertemplates_actions.html#change-the-category-for-an-input-on-a-servertemplate).

## Software Repositories

Since many server instances in the cloud are based off of various Linux distributions, it is strongly recommended that you "freeze" or lock the software repositories down to a specific date.

The machine images (e.g. RightImages) that are loaded onto an instance leverage several open source projects (e.g. CentOS, Ubuntu, etc.). In order to provide a predictable and reliable way to launch instances in clouds using various open source projects, RightScale creates mirrors of these commonly used public repositories. RightScale creates a static copy (once per day) of each public repository that we support on our mirrors. This way, when a server is launched from the RightScale platform and an instance is created in the cloud using a CentOS machine image for example, you can use the repository date to control exactly which CentOS packages will be used to launch the server. As a result, you'll be able to launch a server the exact same way several years later with the exact same packages, which is absolutely critical for any deployments that may be subject to audit checks in the future.

However, if you want to develop your ServerTemplates using the current versions that are available in the various software repositories, you can use the "Current" option, which will use what is currently available in the public repositories on that particular day. Obviously, in such cases, a server's configuration is not static and can change over time because the public repositories themselves will change over time.

As a best practice, before you start testing a ServerTemplate you should always freeze the software repositories to a specific date.

See [Freezing Software Repositories](/cm/rs101/freezing_software_repositories.html).

## Alerts

You may want to add predefined alerts to a ServerTemplate's Alerts tab to monitor various system and application-specific metrics that are relevant for the server/application. If you are using one of the ServerTemplates published by RightScale, it will automatically include several useful alert specifications by default. All of the alert specifications use one of the three predefined alert escalations (critical, warning, and default) that are created by default when a RightScale account is created.

If you add your own custom alert specifications to a ServerTemplate, you should make sure that any RightScale account that will use that ServerTemplate has the appropriately named and defined alert escalations otherwise a triggered alert may not perform the related actions defined by the alert escalation. For this reason, it is recommended that you use one of the three predefined alert escalations that are typically common to all RightScale accounts.

There are several factors to take into consideration when defining additional alert specifications for a custom ServerTemplate.

* Will the ServerTemplate be used outside of the current RightScale account?
  * If **yes**, you should only create new alert specifications that reference one of the three alert escalations (critical, warning, and default) that are common between all RightScale accounts, especially if you intend to make the ServerTemplate publicly available in the MultiCloud Marketplace. However, if you are going to privately share the ServerTemplate with a select set of RightScale accounts, you can include new alert specifications that reference custom alert escalations, but you must remember to coordinate the sharing process with the other RightScale accounts so that the other accounts also have the appropriately named and configured alert escalations to ensure proper alert functionality. You could also distribute the ServerTemplate as part of a macro, where part of the macro's code creates the required alert escalations. Otherwise a triggered alert will attempt to call an alert escalation that doesn't exist in the RightScale account resulting in no action. Remember, alert escalations are account-specific and are not imported/created when a ServerTemplate is imported into another RightScale account.
  * If **no**, then you can safely reference custom alert escalations that are unique to the current RightScale account.
* Does the ServerTemplate contain alerts that are designed to trigger an autoscaling event?
  * If **yes**, it is important to realize that the ServerTemplate will most likely not cause a successful autoscaling event because the alert specification configured to vote for a grow/shrink action assumes that a server array already exists in the RightScale account and is configured to look for the matching voter tag. For this reason, autoscaling should be manually configured within a RightScale account and you should not include alerts for autoscaling purposes in the ServerTemplate. The only way to predefine an autoscaling array is to create a macro that will build all the necessary components (e.g. deployment, server array, alert escalations, etc.) when it is run.
  * If **no**, you will not have a problem.
* Are there any alert specifications that already exist that you want to reuse?
  * If **yes**, use the "Import Alert" feature to use an existing alert specification that's already been defined for you instead of creating a new alert specification from scratch. See [Import an Alert Specification](/cm/rs101/import_an_alert_specification.html).

See [Alert Escalations](/cm/dashboard/design/alert_escalations/alert_escalations.html) and [Set up Autoscaling using Voting Tags](/cm/dashboard/manage/arrays/arrays_actions.html#set-up-autoscaling-using-voting-tags).

### Commit a ServerTemplate

The purpose of committing a ServerTemplate is to lock down a static revision of the ServerTemplate so that it can no longer be modified.

A committed revision of a ServerTemplate allows you to relaunch and configure a server the exact same way in the future, which may prove to be invaluable if your deployment is ever audited and you are required to recreate the exact same server environment or perform the same test. By default, when you commit a ServerTemplate you will be prompted to also lock down any editable configurations, which is strongly recommended since the purpose of committing a ServerTemplate is to create a static revision that cannot be modified.

There may be unique scenarios where you would not want to commit everything, although it is not a recommended best practice. For example, you may want to always use the current version of a software repository during the development phase and only freeze the repository when you're ready to use it in a production deployment. Or perhaps there is an operational RightScript that you're still modifying. In such cases, you can choose to not commit those design objects when committing the ServerTemplate.

By default, when you commit a ServerTemplate, the following configurations will also be committed (saved) if any of them are in an editable (HEAD) state.

* ServerTemplate name and description (Info tab)
* HEAD MultiCloud Images (Images tab)
* Software repositories (Repos tab)
* HEAD RightScripts (Scripts tab)
* Alert specifications (Alerts tab)
* Predefined input parameters (Inputs tab)

Below are some general guidelines for committing ServerTemplates.

* You should only commit a HEAD ServerTemplate if the changes have been properly tested and result in a properly functioning server that meets your requirements. You do not want to have a committed revision of a ServerTemplate that will not successfully launch a server.
* Test all operational scripts on a running server.
* Test all boot scripts by launching servers using the HEAD version of the ServerTemplate before committing the ServerTemplate.
