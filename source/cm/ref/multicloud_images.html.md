---
title: MultiCloud Images
layout: cm_layout
description: Information on using tags with MultiCloud Images in RightScale.
---

## Tag at the MultiCloud Image Level

The following tags may be applied to MultiCloud Image (MCI) in order to denote that an image is RightScale-enabled.

| **Namespace** | **Predicate** | **Value** | **Description / Example** |
| ------------- | -------- | --------- | ------------------------- |
| provides | rs\_agent\_type | rrs | **Description:**<br>The MCI includes the RightScale instance agent v1-v4 and is compatible with ServerTemplates that include RightScripts.<br>**Example:**<br>provides:rs\_agent\_type=rrs |
| provides | rs\_agent\_type | right\_link | **Description:**<br>The MCI includes the RightScale agent v5 or higher and is compatible with ServerTemplates that include Chef recipes and/or RightScripts.<br>**Example:**<br>provides:rs\_agent\_type=right\_link |

So if you're using a RightLink enabled machine image (v5 RightImages and above), its MCI should have a tag under its Info tab that looks like the following screenshot.

![cm-right-link-tag.png](/img/cm-right-link-tag.png)

### Identifying RightScale-enabled MultiCloud Images

The RightScale Dashboard uses the MultiCloud Image tags to determine whether a given MultiCloud Image can be used to launch RightScale-enabled Servers and ServerArrays.


If a MultiCloud image is marked as being **RightLink-compatible** (`provides:rs_agent_type=right_link`), it will be provided with RightLink initialization information at boot time and can be used with ServerTemplates that contain Chef recipes and/or RightScripts.

If an image is marked as being **RightScript-compatible** (`provides:rs_agent_type=rrs`), it can be used with ServerTemplates that contain RightScripts. For backwards compatibility this tag is not required; RightScript servers can be booted from an untagged MultiCloud Image with no negative side-effects. However, tagging RightScript-compatible MultiCloud Images is a good practice that will better inform others of the capabilities of your images and ensure better future compatibility with RightScale.

Note that merely tagging a MultiCloud Image does not automatically enable it to run Chef recipes or RightScripts. The MCI's creator is responsible for installing the necessary software; the tag is merely an indication that the software has been installed in the MCI.

For optimal compatibility we recommend using RightImages, which are fully supported by RightScale and are always tagged appropriately.

### Missing Tag

If you do not tag your MultiCloud Image, it may cause problems for RightLink-enabled servers. Your MCI will not be tagged as RightScale-compatible, which will cause problems if the underlying image uses RightLink.

## See also

- [RightLink](/rl10/index.html)
- [Tagging](/cm/rs101/tagging.html)
