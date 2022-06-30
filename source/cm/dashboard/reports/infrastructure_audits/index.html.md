---
title: Infrastructure Audits
layout: cm_layout
alias: cm/dashboard/reports/infrastructure_audits/infrastructure_audits.html
description: In the RightScale Cloud Management Dashboard, Infrastructure Audits provide a quick overview of the usage of cloud resources within your RightScale account.
---
## Overview

Infrastructure Audits provide a quick overview of the usage of cloud resources within your RightScale account. The audits focus on security aspects and cover all EC2 regions available to your RightScale account. Create audit reports that summarize your account usage of Security Groups or SSH Keys. You may keep up to 10 historical audits. Beyond that, the oldest audit will be rotated out (deleted). You may lock audits to prevent them from being deleted in the rotation, which will allow you to keep an old report as a baseline for performing differentials.

**Note**: Under the source tab, which can either represent a range of public IP addresses or Security Groups, an IP address may have "!!" after it. This denotes that the entire world can view that IP.

## Actions and Procedures

### Download an Infrastructure Audit Report

#### Objective

To download an Infrastructure Audit Report for either Security Groups or SSH Keys.

!!info*Note:* Currently you can only create Infrastructure Audits Reports for EC2. Also, under the source tab, which can either represent a range of public IP addresses or Security Groups, an IP address may have "!!" after it. This denotes that the entire world can view that IP.

#### Prerequisites

* An existing Infrastructure Audit Report.
* 'security_manager' or 'admin' user role privileges

#### Steps

You can either download the audit report as a text (.txt) or json (.json) file.

##### Download a Text file Audit Report

1. Go to **Reports** > **Infrastructure Audit.** Select an audit report.
2. Click the **Download Text** button and specify where to save the file on your local machine. The filename will include the timestamp of when the report was created. (e.g. SecurityGroupAudit_2012-09-06 20_46_43.txt)

##### Download an JSON file Audit Report

1. Go to **Reports** > **Infrastructure Audit**. Select an audit report.
2. Click the **Download JSON** button and specify where to save the file on your local machine. The filename will include the timestamp of when the report was created. (e.g. SecurityGroupAudit_2012-09-06 20_46_43.json)
3. Once a report is downloaded you can use a JSON parser to get back a specific object (e.g. Ruby object or java object). You can have different JSON object parsers for different objects.

### Perform an Infrastructure Audit Report

#### Objective

To perform an Infrastructure Audit for either Security Groups or SSH Keys usage in your RightScale account.

!!info*Note:* Currently you can only create Infrastructure Audits Reports for EC2. Also, under the source tab, which can either represent a range of public IP addresses or Security Groups, an IP address may have "!!" after it. This denotes that the entire world can view that IP.

#### Prerequisites

* 'admin' or 'security_manager' user role privileges

#### Steps

You can create an Infrastructure Audit Report for the following EC2 cloud resources:

* EC2 Security Groups
* EC2 SSH Keys

##### EC2 Security Groups

* Navigate to **Reports** > **Infrastructure Audit**. Then click the **Security Groups** tab.
* Click **Perform New Audit.** You will be prompted with the option of performing an Infrastructure Audit on 'Public Ports' or 'All Ports'.
  * **Public Ports** - Create a report on all ports that are highly accessible to the public, meaning ports that allow access from subnets larger than a /24 (i.e. /0 through /23).Ports that only allow access from other security groups or from subnets of size /24 or smaller (i.e. /24 through /32) are not reported.
  * **All Ports** - Create a report on all ports to which any access is allowed. This is the most comprehensive report.

##### EC2 SSH Keys

* Navigate to: **Reports** > **Infrastructure Audit** > **SSH Keys**
* Click **Perform New Audit.** You be prompted with the option of performing an Infrastructure Audit on 'Running servers' or 'All keys'.
  * **Running servers** - Create a report on all SSH keys that are used by running servers. SSH Keys that are associated to inactive Servers will not be listed.
  * **All keys** - Create a report on all SSH keys. This is the most comprehensive report.
