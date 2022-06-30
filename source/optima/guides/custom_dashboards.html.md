---
title: Custom Dashboards in Optima
layout: optima_layout
description: Describes how to create and manage custom dashboards in Optima
---

## Overview

This page describes how to create and modify custom dashboards in Optima, allowing you to tailor your view of billing data based on your use case.

Custom dashboards are currently available within each billing center, and soon will also be available on the main Dashboard page.

Custom dashboards are scoped to the user within the organization, so creating and modifying them only affects the current user.

The ["Default" dashboard](#the-default-dashboard) is a built-in dashboard and has special properties.

## Working with dashboards

Custom dashboards are made up of **reports** which can be defined and arranged in a layout of the user's choosing. Each report is configured independently, with all reports using the dashboard-level time frame selection for showing the duration of data and data type for showing amortized/nonamortized/etc.

		![optima-custom-dashboard-selectors.png](/img/optima-custom-dashboard-selectors.png)

Once dashboards are created, you can select which one you are viewing using the dashboard selector within any billing center by clicking on the name of the dashboard you are currently viewing.

		![optima-custom-dashboard-picker.png](/img/optima-custom-dashboard-picker.png)

## Creating a dashboard

To create a new dashboard, click on the name of the dashboard you are currently viewing and then select `New Dashboard`. You can create a dashboard either from scratch or copy the current dashboard (the `Default` dashboard can not be duplicated).

		![optima-custom-dashboard-picker-new.png](/img/optima-custom-dashboard-picker-new.png)

The create dashboard panel lets you change the name, description, and layout of the dashboard. The dark gray lines in each layout preview show the zones while the light gray lines indicate how reports will be layed out in each zone.

		![optima-custom-dashboard-new-modal.png](/img/optima-custom-dashboard-new-modal.png)

The dashboard properties can be modified at any time by selecting the `Edit` button on the upper-right corner of the dashboard.

		![optima-custom-dashboard-edit-dashboard.png](/img/optima-custom-dashboard-edit-dashboard.png)

## Configuring dashboard reports

Reports are the configurable visualizations of data that show up on your dashboard. Each report has independently configured fields and filters but all reports respect the timeframe and cost type selected at the top of the dashboard.

### Adding a report

To add a report to the current dashboard, press the "Add Report" button in the upper-right of the dashboard.

		![optima-custom-dashboard-add-report.png](/img/optima-custom-dashboard-add-report.png)

After you select to add a new report, the dashboard enters "layout mode". Select the region in which you'd like the report to appear, or press the "Cancel" button to cancel the action and exit layout mode.

		![optima-custom-dashboard-layout-mode-cancel.png](/img/optima-custom-dashboard-layout-mode-cancel.png)

### Editing report details

After adding a new report and selecting the region, or by selecting the "Settings" icon on an existing report, you will be in the report editor panel.

All reports must be given a "Name" - this is the name that shows up above the report content in the dashboard.

		![optima-custom-dashboard-report-name.png](/img/optima-custom-dashboard-report-name.png)

### Custom report types

All reports also have a "Report Type" that must be selected. The table below lists all of the report types and describes their properties and configurable settings:

Report Type | Description | Timeframe | Settings
----------- | ----------- | --------- | --------
Bar Chart | A vertical clustered bar chart with each element of the bar configured in the settings. | Each vertical bar in the chart is 1 month in duration. | `Dimension` - the dimension that breaks up the colors within each vertical bar.
Costs List | A list of costs broken down by up to 3 dimensions, with the styling of the list slightly changing depending on the number of dimensions selected | The values in the list are across the entire timeframe selected on the dashboard. | `Group By` - the dimension(s) to group the data by in the list. At least 1 and as many as 3 can be selected.
Line Chart | A line chart with each line representing the selected dimension in the settings. | Each data point on the line is 1 day, and the graph in total covers the entire timeframe selected on the dashboard. | `Dimension` - the dimension that breaks up the graph into each line.
Single Total | A single cost number that is the sum of the costs configured in the settings. | None
Table | A data table breakdown of cost information based on the configured dimensions in the settings (similar to Tabular View). | Each column of the data table represents one month. | `Group By` - the dimension(s) to group the data by in the list. At least 1 and as many as 5 can be selected.

#### Filters

Every report type optionally allows "Filters" to be defined in order to narrow down the data that is displayed in the report. With no filters set, the data in every report shows **all data within the scope of the Dashboard**. This means that if you are in billing center X, and a report has no filters defined, then it is showing all data for billing center X. If you were to navigate to billing center Y and select the same dashboard, you would be seeing all data for billing center Y.

To narrow down the data that is in a given report, you can use Filters. Filters let you specify which *dimension values* to show in a given report.

When filters contain multiple dimensions, they are "AND"ed together. Filter **values** within a given dimension are "OR"ed together.

!!info*Tip:*Use `Table` report type or Tabular View to drill-down into various dimensions and see the "values" that you can use for filters, then switch to the report type that you want for the dashboard.

### Moving a report

To move a report, click the "move" icon on the report you'd like to move. You will enter "layout mode" on the dashboard -- click on the zone that you'd like to move the report to.

    ![optima-custom-dashboard-report-move.png](/img/optima-custom-dashboard-report-move.png)

!!warning*Note*Moving a report is not a drag-and-drop operation, rather a "click" on the move icon and a "click" on the target zone

### Deleting a report

To remove a report from a dashboard, click on the "Settings" icon to enter the report editor panel, and then click on the "Remove" button in the lower-left of the panel.

		![optima-custom-dashboard-report-settings.png](/img/optima-custom-dashboard-report-settings.png)

		![optima-custom-dashboard-report-remove.png](/img/optima-custom-dashboard-report-remove.png)

## Deleting a dashboard

Dashboards can be deleted by selecting the red `Delete` button in the upper-right hand corner while on the dashboard. A confirmation dialog will confirm that you wish to delete the dashboard.

		![optima-custom-dashboard-delete.png](/img/optima-custom-dashboard-delete.png)

!!error*Warning*Once a dashboard has been deleted, it can not be recovered

## The "Default" dashboard

The `Default` dashboard is built-in and matches what has historically been shown as the dashboard on the billing center overview page. This dashboard has some special behaviors to be aware of:
1. It can not be deleted
2. It can not be modified in any way (no adding, removing, changing, or moving reports)
3. It can not be duplicated to create a new dashboard
4. The time selector at the top of the page affects only the top bar chart
5. All reports other than the bar chart show 1 month of data - the month that is "selected" in the top bar chart (it is highlighted in a gray background)
