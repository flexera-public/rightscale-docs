---
title: Prepare ServerTemplates for Production
description: Steps for properly preparing your RightScale ServerTemplate so that it can be safely used in a production environment.
---

## Overview

Once you have finished your development and testing on a new custom ServerTemplate, you are ready to prepare it for use in a production environment. One of the most important steps of the ServerTemplate development process is to properly prepare the ServerTemplate so that it can be safely used in a production environment, or published and shared with the RightScale community via the MultiCloud Marketplace.

## Steps

Follow the checklist below for general guidelines.

1. First, the ServerTemplate candidate for production use should have been properly tested in a staging environment. See [Test ServerTemplates in Staging](/cm/servertemplate_dev_guide/test_servertemplates_in_staging.html).
2. Verify the ServerTemplate's configuration settings under each tab. If you need to make any changes to the ServerTemplate, you should repeat your ServerTemplate testing procedures.
  1. **Images** - Make sure the ServerTemplate contains MCIs that support for all of the clouds and operating system distributions with which the ServerTemplate can be used to launch servers. Verify that the proper "default" MCI is selected for the ServerTemplate.
  2. **Repos** - All repositories must be static and immutable. Make sure all software repositories (e.g. GitHub, SVN) and OS disribution repositories are locked down. The selected RepoPath should be a committed revision that points to a static version of your codebase.
      * **Cookbook Repositories Path**  - Each referenced software repository must be locked to a specific SHA to ensure that the RepoPath only references immutable versions of the cookbooks. Once the repositories are locked down, commit the RepoPath object and make sure that the ServerTemplate references the most recently committed RepoPath revision.
      * **OS Distribution Repositories**  - Make sure all of the repositories are locked down to a specific date (and not "current").
  3. **Scripts** - You should have already thoroughly tested the ServerTemplate's boot and decommission scripts. However, you should verify that the ServerTemplate contains all of the operational scripts that may be required during the lifecycle of the server to perform any type of expected operational task. If the ServerTemplate contains any RightScripts, make sure that it's using a committed revision of the script and not a editable HEAD version.
  4. **Alerts** - It's recommended that the ServerTemplate only includes alerts that are generic and not deployment-specific. For example, if the ServerTemplate is going to be used across multiple deployments, it should not contain any alerts for autoscaling purposes to prevent servers from accidentally voting for an autoscaling action in a different deployment.
  5. **Inputs** - Similar to alerts, the ServerTemplate should not contain any deployment-specific default values if it's going to be used in multiple deployments. However, in some use cases, you will want to create an application-specific ServerTemplate with very specific defaults. For advanced inputs, it's recommended that you provide an acceptable default value, if applicable. Verify that you do not have multiple inputs that are used to set the same value. (e.g. Master DB FQDN, Master Database FQDN) Ideally, the ServerTemplate only contains a single input for a particular value. However, if you are using RightScripts and Chef recipes in the same ServerTemplate, you might not be able to avoid duplicate inputs. (e.g. MASTER_FQDN, Master FQDN) In such situations, you should provide similar names as much as possible and clearly highlight the duplication in your user documentation.
3. Update the ServerTemplate's details (e.g. name, description, etc.) accordingly under its Info tab. In the ServerTemplate's description, you may want to specify which clouds are supported or if it's specifically designed to work with another ServerTemplate. Also, you may want to add a meaningful prefix/suffix to the ServerTemplate's nickname to denote any required identification or compatibility information. (e.g. v12 LTS or Beta) Add helpful support information such as links to technical documentation or list support contact information. Be sure to include any release specific information in the commit message. If shared, the commit message will be visible to users in the receiving RightScale account.
4. Commit the ServerTemplate, if necessary.
5. (Optional) If the ServerTemplate is going to be used in a different RightScale account, you will need to publish and share it accordingly. See [Publishing and Sharing](/cm/pas/).
6. (Optional) Notify the end-users when the ServerTemplate is available for use. Be specific!  It's important that an end-user knows which revision of the ServerTemplate should be used in a production deployment(s). To learn how to update a live production environment in the cloud so that the latest ServerTemplates are used, see [Performing Upgrades in the Cloud](/cm/management_guide/performing_upgrades_in_the_cloud.html) for details.
