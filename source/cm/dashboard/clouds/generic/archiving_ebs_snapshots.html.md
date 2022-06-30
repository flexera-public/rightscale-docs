---
title: Archiving EBS Snapshots
description: The EBS Toolbox and EBS Stripe Toolbox v2 RightScale ServerTemplates provide additional control over the archiving of your EBS snapshots.
---
## OverviewThe [EBS Toolbox](http://www.rightscale.com/library/server_templates/EBS-Toolbox/775) and [EBS Stripe Toolbox v2](http://www.rightscale.com/library/server_templates/EBS-Stripe-Toolbox-v2/13339) ServerTemplates provide additional control over the archiving of your EBS snapshots.


## Backup Scripts

Two backup scripts are provided in the respective toolbox:

**EBS Stripe Toolbox v2**

* [EBS stripe volume backup v2](http://www.rightscale.com/library/right_scripts/EBS-stripe-volume-backup-v2/13276)
* [EBS continuous backups v2](http://www.rightscale.com/library/right_scripts/EBS-continuous-backups-v2/12934)

**EBS Toolbox**

* [EBS volume backup](http://www.rightscale.com/library/right_scripts/EBS-volume-backup/3966)
* [EBS volume continuous backups](http://www.rightscale.com/library/right_scripts/EBS-volume-continuous-backups/3971)

When 'EBS volume backup' or 'EBS stripe volume backup v2' RightScripts are run, an EBS snapshot is taken and the snapshots in the EBS_BACKUP_PREFIX lineage are pruned; the corresponding continuous backup script updates the regular backup cron job according to the Inputs (see below).

Use the following input values to control the number of EBS snapshots to prune and keep. The logic behind the archiving of snapshots uses the "EBS_BACKUP_PREFIX" to identify which snapshots should be saved. Therefore, if you manually change the name of a snapshot, the archiving logic will no longer apply to that snapshot. This functionality may be useful for making sure that a particular snapshot will not be accidentally deleted by the system.

### EBS Snapshots Input Parameters

!!info*Note:* The "EBS_BACKUP_KEEP_LAST" and "EBS_BACKUP_PREFIX" inputs are mandatory; other inputs are optional.

| Input Parameter | Description |
| --------------- | ----------- |
| EBS_BACKUP_PREFIX | The prefix that will be used to name the EBS snapshots. (e.g., my_data) |
| EBS_BACKUP_FREQUENCY | Defines how frequently the snapshots should be taken. If set to ignore:ignore, hourly backups are taken. |
| EBS_BACKUP_KEEP_LAST | Defines how many of the last completed snapshots to keep. Value must be greater than zero. It counts from the latest snapshot backwards and preserves all backups in its count. (Default: 60) |
| EBS_BACKUP_KEEP_DAILY | Defines how many daily backups to keep. A daily backup is defined as the latest completed snapshot of a day that is closest to the end of the day (23:59:59). (Default: 14) |
| EBS_BACKUP_KEEP_WEEKLY | Defines how many weekly backups to keep. A weekly backup is defined as the latest completed snapshot of a week that is closest to the end of the week (Sunday 23:59:59). Monday is the first day of the week, Sunday is the last. (Default: 6) |
| EBS_BACKUP_KEEP_MONTHLY | Defines how many monthly backups to keep. A monthly backup is defined as the latest completed snapshot of a month that is closest to the end of the month (e.g. Jan-31; 23:59:59). (Default: 12) |
| EBS_BACKUP_KEEP_YEARLY | Defines how many yearly backups to keep. A yearly backup is defined as the latest completed snapshot of a year that is closest to the end of the year (e.g. Dec-31; 23:59:59). (Default: 2) |

Any changes to these input parameters will take effect immediately and cannot be reverted back to a previous state. For example, if you change your monthly backups from 6 to 4, the 2 oldest monthly backup snapshots will be deleted.

If all periods have one or more snapshots in them, the number specified in the inputs will exactly correspond to how many snapshots to keep for the last "n" period. For example, if you want 10 dailies and there are no holes or days where there are no snapshots in the history, you will end up keeping 1 backup for each one of the last 10 days.

If there are periods for which no backups exist at all due to a failed or deleted snapshot, the system will ignore them, and will continue going back in time until the number specified by the inputs has been fulfilled. In these cases, you will end up keeping the same number of backups, but they will span further into the past depending on how many snapshots are missing. For example, if you want to keep 10 dailies but last week you had 2 days for which no snapshot were generated, you will still keep 10 snapshots, but the oldest one being 12 days ago. If a snapshot fails (for whatever reason), the process will now sleep for a minute and retry (for a maximum of 2 retries).

Today's snapshots are not considered in the snapshot equation. For example, if you want to keep 3 dailies, the system will not consider today's snapshots as part of the equation. Snapshots of the three previous days will be archived. The equation will always start from yesterday and count backwards. The same logic applies to weeklies, monthlies, and yearlies, where the first snapshot to keep must be found in the last completed period. EBS_BACKUP_KEEP_LAST, on the other hand, truly keeps the last 'N' backups that are completed including today's snapshots.

The alert for the EBS Snapshot records the time since the last successful snapshot, tracking both snapshot failures and when snapshots are disabled. You can set this alert to generate a notification if the age of the last snapshot exceeds *n* hours and get notified regardless if it is a failure or simply if snapshots are disabled.

### Example

Below is an example that helps show how the logic behind the archiving of snapshots can be applied to a setup where two EBS snapshots are saved each day.

![cm-archive-snapshot-calendar-2.png](/img/cm-archive-snapshot-calendar-2.png)
