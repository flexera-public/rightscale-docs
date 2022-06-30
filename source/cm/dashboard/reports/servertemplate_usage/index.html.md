---
title: ServerTemplate Usage
layout: cm_layout
alias: cm/dashboard/reports/servertemplate_usage/servertemplate_usage.html
description: Use the ServerTemplates Usage Report in the RightScale Cloud Management Dashboard to track the monthly or daily usage of your published/shared Server Templates.
---

## Overview

Use the ServerTemplates Usage Report to track the monthly or daily usage of your published/shared Server Templates for the RightScale account you're currently viewing.

### Create a ServerTemplates Usage Report

A ServerTemplates Usage Report is typically downloaded in comma-separated values (CSV) format, but can optionally be displayed on the screen as well. This report can be run for a daily or monthly timeframe, or for a range of recent dates. The report can be run in On Demand or Periodic mode.

#### Prerequisites

Access is available to all new customers and trial signups, however existing customers and legacy free developer accounts must contact [sales@rightscale.com](mailto:sales@rightscale.com) for upgraded access.

#### Running an On Demand Report

When running an On Demand report, you have control over the following report parameters:

* Time:
  * Select Day or Month
    * If by month, a drop down assists in selecting the correct month of the year
    * If by day, a menu pop-up assists in selecting the correct day.  The current day is not defaulted, but is surrounded by a dotted line.
* Action:  Overview or Download
    * **Overview** - Displays directly to the screen.  Depending on whether you run the report by Instance, ServerTemplate or Publisher, the output fields will differ.
    * **Download** - Download a CSV file to your local hard drive.
      * Filename convention:  isv_server_template_report_MM######.csv (where MM is the month)
      * Output fields:
        * Sharing Group
        * Deployment
        * Server Template
        * User - User email address or "unknown"
        * Instance - Unique Instance ID
        * Instance Size
        * Instance Start - Date/time stamp when the Instance went active
        * Instance End - Date/time stamp when the Instance went inactive (blank if its still running/active)
        * Lodgement Type - Lodgement typically billed by Cloud provider for, such as instance usage or volume usage
        * Lodgement Start - Date/Time stamp for lodgement start
        * Lodgement End - Date/Time stamp for lodgement end
        * Instance Hours
        * Max Disk Volume Size
        * Disk Volume Hours
        * Custom Unit - See Creating Custom Metering Reports for more information.
        * Custom Metric - See Creating Custom Metering Reports for more information.
        * Server ID
        * Availability Zone
* View by - When the action is Overview, you must select how you want to view:
  * by Instance - The following fields are displayed:  Instance Size, Server Hours, Servers Launched, Disk Volume Hours, Max Disk Volume Size
  * by ServerTemplate - The following fields are displayed:  ServerTemplate, Publisher, Instance Size, Server Hours, Servers Launched, Disk Volume Hours, Max Disk Volume Size
  * by Publisher - The following fields are displayed:  Publisher, Instance Size, Server Hours, Servers Launched, Volume Hours, Max Disk Volume Size

!!info*Note:* Underlined fields indicate they are sortable.  (Select to sort by that field.)

Take the following steps to run a On Demand report.

1. In the CM Dashboard navigate to **Reports** > **ServerTemplates Usage** > **On Demand tab** (default tab)
2. Select **Overview** to display on the screen or **Download** to save a CSV file. If **Overview**, select **View by Instance**, **ServerTemplate**, or **Publisher**, depending on the needed report data.
3. Select the timeframe (year/month or day) from the drop-down menus provided.
4. Click the **Submit** button when ready.

!!info*Note:* If the definition of any fields are unclear use the field information in the Overview section above to help interpret your report. Consider running and archiving this report as part of your monthly best practices.

#### Running a Periodic Report

A periodic report consists of the exact same data that is provided in an On Demand report, in a .csv file format. Periodic reports automatically run in the background based on a user-configured schedule, and you can view their output at your convenience. Output files are uploaded to an S3 bucket of your choice and you can choose to receive notification via email when your report output is complete and ready for viewing. You must specify the following parameters when running a periodic ServerTemplates Usage Report:

* **Frequency** - Select Monthly or Daily from the drop-down menu. A date stamp will be included in the .csv output file name.
* **S3 bucket** - Select the S3 bucket where your report output should be placed.
* **Report Name** - Specify a name for your report, to be included in the .csv file that is uploaded to S3.
* **Email Notification (optional)** - Specify an email address to receive notification when the report is complete. If you enable email notification for your report, then each time the report runs, an email message with a subject like "Your Periodic Report 'GregDoeTest' has been uploaded" will be sent to the specified address. The email content will be similar to the following:

~~~
Your Periodic Report 'GregDoeTest' has been uploaded to S3 bucket
'<a href="https://my.rightscale.com/s3/view?bucket=gregdoe-rs-testbucket">gregdoe-rs-testbucket</a>'
as key 'Monthly_2010-04_GregDoeTest.csv.'
~~~

!!info*Note:* At the bottom of the dialog box a message similar to the following is displayed.  As you make your selections the description dynamically reflects your choices making it more helpful in explaining exactly the the report you are about to run.  The [variables] are displayed in bold to highlight where changes are made as you make your choices.

~~~
Your report will usually be generated [select frequency] by 12:00 PM UTC in the
[select S3 bucket] bucket with the filename [frequency]_[report name].csv.
No email notification will be sent when the report is generated.
~~~

Take the following steps to setup a periodic report.

1. In the CM Dashboard navigate to **Reports** > **ServerTemplates Usage** > **Periodic tab**
2. Click the **Add Periodic Report** action button.
3. Select the **Frequency**, **S3 bucket**, and **Report Name**. Optionally, specify an email address to receive a notification when the report is completed and ready for viewing.
4. Click the Create Periodic Report action button.

!!info*Note:* If the definition of any fields are unclear use the field information in the Overview section above to help interpret your report.

Here are some additional actions you may take when running periodic reports.

* If the number of reports grows over time, you can filter (or sort) by:
  * ReportName
  * Frequency
  * S3 bucket
  * Email Notification
* Each report can be edited or deleted by selecting the corresponding action icons.

Finally, you should consider running and archiving periodic reports as part of your monthly best practices.
