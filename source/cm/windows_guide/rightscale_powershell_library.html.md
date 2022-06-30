---
title: RightScale PowerShell Library
description: Overview and function descriptions for the RightScale PowerShell Library. RightScale's PowerShell Library contains a number of useful PowerShell scripts and functions.
---

## Overview

Windows ServerTemplates published by RightScale contain a script (**SYS Install RightScale PowerShell library**), which runs in the boot sequence and installs RightScale's PowerShell Library onto the Windows server. RightScale's PowerShell Library contains a number of useful PowerShell scripts and functions. Several of the other RightScripts in RightScale's Windows ServerTemplates leverage these functions in their own code, which means there is a dependency on the above script, which is why it's typically the first RightScript executed in the boot sequence.

If you are developing your own Windows ServerTemplates, it's recommended that you add the  **SYS Install RightScale PowerShell library** RightScript to the ServerTemplate's boot sequence so that you can take advantage of RightScale's PowerShell Library in your own scripts.

* * *

## File ad\AD.ps1

AD.ps1

### Function CheckAdSiteExist

This function connects to remote domain controller and check if site exists.

#### Syntax

~~~
CheckAdSiteExist [[-AdminPassword] <String>] [[-AdminAccount] <String>] [[-SiteName] <String>] [[-ServerName] <String>] [<CommonParameters>]
~~~

#### Parameters

* **AdminPassword** - Password of user name which has permissions for AD connection. .PARAMETER AdminAccount - Login, like DomainName\LoginName.
* **AdminAccount** -
* **SiteName** - Name of AD site. .PARAMETER ServerName - Address of domain controller.
* **ServerName** -

#### Return Value

$True or $False

#### Examples

~~~
CheckAdSiteExist -AdminAccount "Domain\Administrator" -AdminPassword "PaSSwo@rd" -ServerName "10.10.10.10" -SiteName "Default"
~~~

### Function Transfer_FSMO

This function transfers or seizes FSMO roles in Active directory

#### Syntax

~~~
Transfer_FSMO [[-Dc_Name] <String>] [[-FsmoRole] <String>] [[-UserLogin] <String>] [[-Userpassword] <String>] [<CommonP arameters>]
~~~

#### Parameters

* **Dc_Name** - FQDN name or IP address of the domain controller.
* **FsmoRole** - Name of FSMO role. Possible values: "becomeSchemaMaster", "becomeDomainMaster", "becomeRidMaster", "becomeInfrastructur eMaster", "becomePdc". .PARAMETER UserLogin - Active Directory's account login. .PARAMETER UserPassword - Password of AD account.
* **UserLogin** -
* **Userpassword** -

#### Examples

~~~
Transfer_Fsmo -Dc_Name "10.10.10.10" -FsmoRole "becomeSchemaMaster" -UserLogin "Administrator" -Userpassword "PasSwo5rd"
~~~

* * *

## File ad\AdBackupPolicy.ps1

Function implementing AD backup retention policy.

### Function ADBackupPolicy

This function connects to storage in different clouds and remove old backup.

#### Syntax

~~~
ADBackupPolicy [[-RemoteStorage] <String>] [[-StorageName] <String>] [[-BackupLineage] <String>] [[-NumberBackupsToKeep] <Int32>] [[-accessKeyId] <String>] [[-secretAccessKey] <String>] [[-RackspaceUserName] <String>] [[-RackspaceAuthKey] <String>] [<CommonParameters>]
~~~

#### Parameters

* **RemoteStorage** - Type of remote storage.
* **StorageName** - Name of storage conteiner.
* **BackupLineage** -
* **NumberBackupsToKeep** - Number of backups to leave.
* **accessKeyId** -
* **secretAccessKey** -
* **RackspaceUserName** -
* **RackspaceAuthKey** -

#### Examples

~~~
ADBackupPolicy -RemoteStorage "$remoteFileStorage" -StorageName "$StoragetName" -BackupLineage "$AD_Backup_Name" -NumberBackupsToKeep $NumberBackupsToKeep
~~~

* * *

## File ad\ADDownloadBackup.ps1

ADDownloadBackup.ps1

### Function GetADBackupFromRemoteStorage

#### Syntax

~~~
GetADBackupFromRemoteStorage [[-RemoteStorage] <String>] [[-StorageName] <String>] [[-BackupLineage] <String>] [[-timestamp] <String>] [[-DestinationPath] <String>] [[-accessKeyId] <String>] [[-secretAccessKey] <String>] [[-RackspaceUserName] <String>] [[-RackspaceAuthKey] <String>]
~~~

### Function GetADBackupFromRemoteStorage

#### Syntax

~~~
GetADBackupFromRemoteStorage [[-RemoteStorage] <String>] [[-StorageName] <String>] [[-BackupLineage] <String>] [[-timestamp] <String>] [[-DestinationPath] <String>] [[-accessKeyId] <String>] [[-secretAccessKey] <String>] [[-RackspaceUserName] <String>] [[-RackspaceAuthKey] <String>]
~~~

* * *

## File ad\CheckBootMode.ps1

CheckBootMode.ps1

### Function CheckBootMode

This function check boot mode of OS.

#### Syntax

~~~
CheckBootMode [<CommonParameters>]
~~~

* * *

## File aws\Aws.ps1

General AWS functions.

### Function InitAwsSdk

Loads AWS SDK into current PowerShell session. SDK should be already installed (e.g. via a RightScript).

#### Syntax

~~~
InitAwsSdk [<CommonParameters>]
~~~

#### Return Value

Nothing

* * *

## File aws\EC2.ps1

Functions dealing with AWS EC2.

### Function CreateEc2ClientByAz

Creates AmazonEC2Client instance that can be used to perform AWS SDK calls for resources located in some AWS availability zone.

#### Syntax

~~~
CreateEc2ClientByAz [[-az] <String>] [[-accessKeyId] <String>] [[-secretAccessKey] <String>] [<CommonParameters>]
~~~

#### Parameters

* **az** - Name of the availability zone. Extracted from env varibale EC2_PLACEMENT_AVAILABILITY_ZONE if not passed.
* **accessKeyId** - The Access Key ID used to authenticate requests to AWS services. Not required parameter, by default value of AWS_ACCESS_KEY_ID env variable is used.
* **secretAccessKey** - The Secret Access Key used to authenticate your requests to AWS services. Not required parameter, by default value of AWS_ACCESS_KEY_ID env variable is used.

#### Return Value

Instance implementing AmazonEC2 interface ([Amazon API Docs](http://docs.aws.amazon.com/sdkfornet/latest/apidocs/Index.html)).

#### Examples

~~~
$ec2 = CreateEc2ClientByAz 'us-east'
~~~

### Function GetAwsRegionName

Returns display name of AWS region by region id.

#### Syntax

~~~
GetAwsRegionName [[-regionId] <Object>] [<CommonParameters>]
~~~

#### Parameters

* **regionId** - String ID of the AWS region, for example 'us-east-1'

#### Return Value

Name of the AWS region.

#### Examples

~~~
$regionName = GetAwsRegionName 'us-east-1'
~~~

### Function GetEndpointByAz

Gets domain name or URL of AWS availability zone endpoint.

#### Syntax

~~~
GetEndpointByAz [[-az] <String>] [[-addHttps] <Boolean>] [<CommonParameters>]
~~~

#### Parameters

* **az** - Name of the availability zone, following AZs are supported: us-east, us-west-2, us-west-1, eu-west, ap-southeast, ap-northeast.
* **addHttps** - Flag indicating if the domain name should be prefixed by https://. $True is the default value.

#### Return Value

Domain name of availability zone endpoint prefixed by https:// if specified. Throws exception is region is invalid.

#### Examples

~~~
$endpointHttps = GetEndpointByAz 'us-west-2'
~~~

### Function GetInstanceImageName

Returns name of the image for the instance. With default parameters it returns name of the image for current instance. Uses AWS SDK calls.

#### Syntax

~~~
GetInstanceImageName [[-instanceId] <String>] [[-az] <String>] [[-accessKeyId] <String>] [[-secretAccessKey] <String>] [<CommonParameters>]
~~~

#### Parameters

* **instanceId** - AWS instance id. Extracted from env variable EC2_INSTANCE_ID by default.
* **az** - Name of the availability zone. Extracted from env varibale EC2_PLACEMENT_AVAILABILITY_ZONE by default.
* **accessKeyId** - The Access Key ID used to authenticate requests to AWS services. Not required parameter, by default value of AWS_ACCESS_KEY_ID env variable is used.
* **secretAccessKey** - The Secret Access Key used to authenticate your requests to AWS services. Not required parameter, by default value of AWS_ACCESS_KEY_ID env variable is used.

#### Return Value

Name of the EC2 image (not MCI).

#### Examples

~~~
$imgName = GetInstanceImageName
~~~

### Function GetInstanceVpcId

Returns VPC id if current instance is deployed in VPC, otherwise returns $Null.

#### Syntax

~~~
GetInstanceVpcId [[-instanceId] <String>] [[-az] <String>] [[-accessKeyId] <String>] [[-secretAccessKey] <String>] [<Co mmonParameters>]
~~~

#### Parameters

* **instanceId** - AWS instance id. Extracted from env variable EC2_INSTANCE_ID by default.
* **az** - Name of the availability zone. Extracted from env variable EC2_PLACEMENT_AVAILABILITY_ZONE by default.
* **accessKeyId** - The Access Key ID used to authenticate requests to AWS services. Not required parameter, by default value of AWS_ACCESS_KEY_ID env variable is used.
* **secretAccessKey** - The Secret Access Key used to authenticate your requests to AWS services. Not required parameter, by default value of AWS_ACCESS_KEY_ID env variable is used.

#### Return Value

Name of the EC2 image (not MCI).

#### Examples

~~~
$imgName = GetInstanceImageName
~~~

### Function GetSnapshotInfoById

Get volume snapshot information by snapshot id. Performs DescribeSnapshots AWS API call with passed snapshot id.

#### Syntax

~~~
GetSnapshotInfoById [[-snapshotId] <String>] [[-accessKeyId] <String>] [[-secretAccessKey] <String>] [<CommonParameters >]
~~~

#### Parameters

* **snapshotId** - AWS snapshot id.
* **accessKeyId** - The Access Key ID used to authenticate requests to AWS services. Not required parameter, by default value of AWS_ACCESS_KEY_ID env variable is used.
* **secretAccessKey** - The Secret Access Key used to authenticate your requests to AWS services. Not required parameter, by default value of AWS_ACCESS_KEY_ID env variable is used.

#### Return Value

Snapshot object or $Null

* * *

## File aws\S3.ps1

Functions dealing with AWS S3 service.

### Function DeleteFromS3

Deletes a file from S3 bucket.

#### Syntax

~~~
DeleteFromS3 [[-bucket] <String>] [[-name] <String>] [[-accessKeyId] <String>] [[-secretAccessKey] <String>] [<CommonPa rameters>]
~~~

#### Parameters

* **bucket** - Name of S3 bucket to delete file from.
* **name** - Name of the file in S3 bucket.
* **accessKeyId** - The Access Key ID used to authenticate requests to AWS services. Not required parameter, by default value of AWS_ACCESS_KEY_ID env variable is used.
* **secretAccessKey** - The Secret Access Key used to authenticate your requests to AWS services. Not required parameter, by default value of AWS_ACCESS_KEY_ID env variable is used.

#### Return Value

Nothing (throws exception if delete failed).

### Function GetFromS3

Downloads a file from S3 bucket.

#### Syntax

~~~
GetFromS3 [[-bucket] <String>] [[-name] <String>] [[-destPath] <String>] [[-accessKeyId] <String>] [[-secretAccessKey] <String>] [<CommonParameters>]
~~~

#### Parameters

* **bucket** - Name of S3 bucket to download file from.
* **name** - Name of the file in S3 bucket.
* **destPath** - Full destination path (dir + file name).
* **accessKeyId** - The Access Key ID used to authenticate requests to AWS services. Not required parameter, by default value of AWS_ACCESS_KEY_ID env variable is used.
* **secretAccessKey** - The Secret Access Key used to authenticate your requests to AWS services. Not required parameter, by default value of AWS_ACCESS_KEY_ID env variable is used.

#### Return Value

$True or $False.

### Function GetListFromS3

Gets list of files stored in S3 bucket.

#### Syntax

~~~
GetListFromS3 [[-bucket] <String>] [[-accessKeyId] <String>] [[-secretAccessKey] <String>] [<CommonParameters>]
~~~

#### Parameters

* **bucket** - Name of S3 bucket.
* **accessKeyId** - The Access Key ID used to authenticate requests to AWS services. Not required parameter, by default value of AWS_ACCESS_KEY_ID env variable is used.
* **secretAccessKey** - The Secret Access Key used to authenticate your requests to AWS services. Not required parameter, by default value of AWS_ACCESS_KEY_ID env variable is used.

#### Return Value

Array of file names stored in S3 bucket. Throws exception if failed.

### Function GetListFromS3Prefix

Gets list of files stored in S3 bucket which names start with specified prefix.

#### Syntax

~~~
GetListFromS3Prefix [[-bucket] <String>] [[-prefix] <String>] [[-accessKeyId] <String>] [[-secretAccessKey] <String>] [<CommonParameters>]
~~~

#### Parameters

* **bucket** - Name of S3 bucket.
* **prefix** - Prefix to filter file names (string).
* **accessKeyId** - The Access Key ID used to authenticate requests to AWS services. Not required parameter, by default value of AWS_ACCESS_KEY_ID env variable is used.
* **secretAccessKey** - The Secret Access Key used to authenticate your requests to AWS services. Not required parameter, by default value of AWS_ACCESS_KEY_ID env variable is used.

#### Return Value

Array of file names. Throws exception if failed.

### Function PutToS3

#### Syntax

~~~
PutToS3 [[-localPath] <String>] [[-bucket] <String>] [[-name] <String>] [[-accessKeyId] <String>] [[-secretAccessKey] <String>] [[-blocksize] <Int32>]
~~~

* * *

## File ebs\EbsBackupRestoreVolume.ps1

Function to do EBS snapshot of a volume (used by AD template).

### Function EbsBackupExists

Returns $True of at least one backup of given lineage name exists or $False if it doesn't.

#### Syntax

~~~
EbsBackupExists [[-lineageName] <Object>] [<CommonParameters>]
~~~

#### Parameters

* **lineageName** - Lineage name.

### Function EbsBackupVolume

Simply requests EBS snapshot of a volume and performs cleanup of previous backups.

#### Syntax

~~~
EbsBackupVolume [[-DriveLetter] <Object>] [[-lineageName] <Object>] [<CommonParameters>]
~~~

#### Parameters

* **DriveLetter** - Drive letter of a volume to do snapshot (single char).
* **lineageName** - Name of backup, used as lineage name.

### Function EbsClearBackupLineage

Deletes all backups in given backup lineage.

#### Syntax

~~~
EbsClearBackupLineage [[-lineageName] <Object>] [<CommonParameters>]
~~~

#### Parameters

* **lineageName** - Lineage name of backups to be cleared.

### Function EbsRestoreVolume

Restores single volume from EBS snapshot.

#### Syntax

~~~
EbsRestoreVolume [[-dbLineageName] <Object>] [[-timestamp] <Object>] [[-iops] <String>] [<CommonParameters>]
~~~

#### Parameters

* **dbLineageName** - Name of the backup lineage to restore from.
* **timestamp** - Timestamp of the specific backup to restore from (optional). Restores from the most recent backup if omitted.
* **iops** - The number of I/O operations per second (IOPS) that the volume supports. IOPS is currently only supported on Amazon EC2. Range is 100 to 1000. Example: 500

* * *

## File ebs\EbsBackupVolumes.ps1

Functions to do EBS snapshots.

### Function CommitSnapshot

Commits snapshot. Adds tag committed=true by invoking update_ebs_snapshot.js API 1.0 call.

#### Syntax

CommitSnapshot [[-aws_id] <String>] [<CommonParameters>]

#### Parameters

* **aws_id** - AWS ID of the snapshot.

### Function EbsBackupVolumes

Performs backup by creating EBS snapshots of data and log volumes. Simple and striped volumes are supported. This function creates EBS snapshots of data nd log volumes by invoking create_ebs_backup.js API 1.0 call. Uses VSS to guarantee consistency of files on data volume. Also performs cleanup of lineage backup with parameters passed via env variables (DB_BACKUP_KEEP_LAST, DB_BACKUP_KEEP_DAILY, etc).

#### Syntax

~~~
EbsBackupVolumes [[-dataVolRoot] <Object>] [[-logsVolRoot] <Object>] [[-dbLineageName] <Object>] [[-dataVolDevices] <Ar ray>] [[-logsVolDevices] <Array>] [<CommonParameters>]
~~~

#### Parameters

* **dataVolRoot** - Drive letter of data volume (single char).
* **logsVolRoot** - Drive letter of logs volume (single char).
* **dbLineageName** - Backups lineage name.
* **dataVolDevices** - Array of device names that make up data volume (required for striped volume, could be omitted for simple volume). If omitted the device name is assumed to be xvdX, where X is drive letter (e.g xvdd for D:\, xvde for E:\, etc).
* **logsVolDevices** - The same as dataVolDevices but for logs volume.

#### Return Value

$True if successful, throws exception if failed.

* * *

## File ebs\EbsCreateAttachStripe.ps1

Functions to create and attache striped volumes.

### Function EbsCreateAttachStripedVolume

#### Syntax

~~~
EbsCreateAttachStripedVolume [[-numberStripes] <Int32>] [[-stripeSize] <Int32>] [[-driveLetter] <String>] [[-reservedLetters] <Array>] [[-instanceId] <String>] [[-accessKeyId] <String>] [[-secretAccessKey] <String>] [[-iops] <String>]
~~~

### Function EbsGetAttachedDevices

Function to get device names of all volumes attached to the instance.

#### Syntax

~~~
EbsGetAttachedDevices [[-instanceId] <String>] [<CommonParameters>]
~~~

#### Parameters

* **instanceId** - AWS ID of the instance (optional, env variable EC2_INSTANCE_ID is used by default).

#### Return Value

Array of device names of attached volumes (array of strings).

* * *

## File ebs\EbsCreateAttachVolume.ps1

Functions to create and attach simple (not striped) volumes to the instance.

### Function EbsAttachVolume

Function to attach existing EBS volume to the instance.

#### Syntax

~~~
EbsAttachVolume [[-vol_id] <String>] [[-driveLetter] <String>] [[-timeout] <Int32>] [[-newVolume] <Boolean>] [[-device] <String>] [<CommonParameters>]
~~~

#### Parameters

* **vol_id** - AWS ID of the volume to attach.
* **driveLetter** - Drive letter to assign to new volume. Optional, if skipped device parameter should be specified.
* **timeout** - Timeout in seconds to wait for successful attachment (0 means infinity).
* **newVolume** - Flag indicating whether to format attached volume.
* **device** - Device name to attach volume as. If skipped drive letter is used as last letter of device name (i.e. 'e' means xvde, etc).

### Function EbsCreateAttachVolume

This function creates a new EBS volume, attaches to current instance, assings drive letter and formats new volume.

#### Syntax

~~~
EbsCreateAttachVolume [[-driveLetter] <Object>] [[-sizeGb] <Object>] [[-deleteOnTermination] <Object>] [[-iops] <String >] [<CommonParameters>]
~~~

#### Parameters

* **driveLetter** - Drive letter to assign to the attached volume (char). Also used as last letter of device name to attach the volume (so 'd' means 'xvdd', 'e' means 'xvde', etc).
* **sizeGb** - Size of the new volume in GB (positive integer).
* **deleteOnTermination** - Flag indicating whether to set delete on termination flag for new volume.
* **iops** - The number of I/O operations per second (IOPS) that the volume supports. IOPS is currently only supported on Amazon EC2. Range is 100 to 1000. Example: 500

### Function EbsCreateVolume

Function to create a new EBS volume and wait until new volume is actually created (i.e. for 'available' status).

#### Syntax

~~~
EbsCreateVolume [[-sizeGb] <Int32>] [[-name] <String>] [[-iops] <String>] [<CommonParameters>]
~~~

#### Parameters

* **sizeGb** - Size in GB of the new volume (positive integer).
* **name** - Name of the new volume.\
* **iops** - The number of I/O operations per second (IOPS) that the volume supports. IOPS is currently only supported on Amazon EC2. Range is 100 to 1000. Example: 500

#### Return Value

AWS volume ID of the created volume.

* * *

## File ebs\EbsDeleteOnTermination.ps1

Function to set delete on termination flag.

### Function EbsSetDeleteOnTermination

Sets delete on termination flag for EBS volume. Volume should be already attached to the instance.

#### Syntax

~~~
EbsSetDeleteOnTermination [-instance_id] <Object> [-volume_id] <Object> [-device_name] <Object> [-flag] <Object> [[-acc essKeyId] <Object>] [[-secretAccessKey] <Object>] [<CommonParameters>]
~~~

#### Parameters

* **instance_id** - AWS ID of the instance.
* **volume_id** - AWS ID of the attached volume.
* **device_name** - Name of device the volume is attached to the instance as.
* **flag** - Flag indicating whether to set or clear delete on termination flag.
* **accessKeyId** - The Access Key ID used to authenticate requests to AWS services. Not required parameter, by default value of AWS_ACCESS_KEY_ID env variable is used.
* **secretAccessKey** - The Secret Access Key used to authenticate your requests to AWS services. Not required parameter, by default value of AWS_ACCESS_KEY_ID env variable is used.

* * *

## File ebs\EbsDeleteVolume.ps1

Functions to detach and delete EBS volumes.

### Function EbsDeleteVolume

Function to detach and delete simple EBS volume.

#### Syntax

~~~
EbsDeleteVolume [[-drive] <Object>] [[-accessKeyId] <String>] [[-secretAccessKey] <String>] [<CommonParameters>]
~~~

#### Parameters

* **drive** - Drive letter of the volume to detach and delete.
* **accessKeyId** - The Access Key ID used to authenticate requests to AWS services. Not required parameter, by default value of AWS_ACCESS_KEY_ID env variable is used.
* **secretAccessKey** - The Secret Access Key used to authenticate your requests to AWS services. Not required parameter, by default value of AWS_ACCESS_KEY_ID env variable is used.

#### Return Value

$True if successful, $False is fails.

### Function EbsDetachAllVolumes

Detach all volumes from the instance or set delete on termination flag.

#### Syntax

~~~
EbsDetachAllVolumes [[-instanceId] <String>] [[-setDeleteOnTermination] <Boolean>] [[-waitForDetachment] <Boolean>] [[- accessKeyId] <String>] [[-secretAccessKey] <String>] [<CommonParameters>]
~~~

#### Parameters

* **instanceId** - AWS ID of the instance (optional, uses value of EC2_INSTANCE_ID env variable by default).
* **setDeleteOnTermination** - Flag idicating whether to set delete on termination flag instead of actual detachment (was added vecause of AWS detachment issue).
* **waitForDetachment** - Flag indicating whether to wait for actual detachment of each volume (i.e. for 'available' status of the volume).
* **accessKeyId** - The Access Key ID used to authenticate requests to AWS services. Not required parameter, by default value of AWS_ACCESS_KEY_ID env variable is used.
* **secretAccessKey** - The Secret Access Key used to authenticate your requests to AWS services. Not required parameter, by default value of AWS_ACCESS_KEY_ID env variable is used.

#### Return Value

$True if successful, $False if fails.

### Function EbsDetachVolume

Function to detach EBS volume for the instance and wait until it's detached actually.

#### Syntax

~~~
EbsDetachVolume [[-drive] <String>] [[-accessKeyId] <String>] [[-secretAccessKey] <String>] [<CommonParameters>]
~~~

#### Parameters

* **drive** - Drive letter of the volume to detach.
* **accessKeyId** - The Access Key ID used to authenticate requests to AWS services. Not required parameter, by default value of AWS_ACCESS_KEY_ID env variable is used.
* **secretAccessKey** - The Secret Access Key used to authenticate your requests to AWS services. Not required parameter, by default value of AWS_ACCESS_KEY_ID env variable is used.

#### Return Value

AWS ID of the detached volume or $False if failed.

* * *

## File ebs\EbsRestoreVolumes.ps1

Function to restore EBS volumes from snapshots.

### Function EbsGetLatestLineage

Function to compare 2 backup lineages to determine which one has the most recent backup.

#### Syntax

~~~
EbsGetLatestLineage [[-lineage1] <Object>] [[-lineage2] <Object>] [[-accessKeyId] <String>] [[-secretAccessKey] <String >] [<CommonParameters>]
~~~

#### Parameters

* **lineage1** - Name of the first lineage to compare.
* **lineage2** - Name of the second lineage to compare.
* **accessKeyId** - The Access Key ID used to authenticate requests to AWS services. Not required parameter, by default value of AWS_ACCESS_KEY_ID env variable is used.
* **secretAccessKey** - The Secret Access Key used to authenticate your requests to AWS services. Not required parameter, by default value of AWS_ACCESS_KEY_ID env variable is used.

#### Return Value

Name of the lineage which has the most recent backup or empty string if bith lineages are empty.

### Function EbsRestoreVolumes

Restores data and log volumes from EBS snapshots. Supports simple and striped volumes.

#### Syntax

~~~
EbsRestoreVolumes [[-dbLineageName] <Object>] [[-timestamp] <Object>] [[-iops_data] <Object>] [[-iops_logs] <Object>] [<CommonParameters>]
~~~

#### Parameters

* **dbLineageName** - Name of the backup lineage to restore from.
* **timestamp** - Timestamp of the specific backup to restore from (optional). Restores from the most recent backup if omitted.
* **iops_data** -
* **iops_logs** -

* * *

## File ebs\EbsVolumeInfo.ps1

Functions to get EBS volume information using AWS SDK calls.

### Function EbsGetVolumeId

Get EBS volume ID by device name.

#### Syntax

~~~
EbsGetVolumeId [[-device] <String>] [[-instanceId] <String>] [[-accessKeyId] <String>] [[-secretAccessKey] <String>] [< CommonParameters>]
~~~

#### Parameters

* **device** - Device name of attached volume, for example 'xvdd' (string).
* **instanceId** - AWS ID of the instance, optional (extracted from EC2_INSTANCE_ID env variable if omitted).
* **accessKeyId** - The Access Key ID used to authenticate requests to AWS services. Not required parameter, by default value of AWS_ACCESS_KEY_ID env variable is used.
* **secretAccessKey** - The Secret Access Key used to authenticate your requests to AWS services. Not required parameter, by default value of AWS_ACCESS_KEY_ID env variable is used.

#### Return Value

Volume ID if successful, $False if failed.

### Function EbsGetVolumeStatus

Function to get status of EBS volume.

#### Syntax

~~~
EbsGetVolumeStatus [[-volumeId] <String>] [[-accessKeyId] <String>] [[-secretAccessKey] <String>] [<CommonParameters>]
~~~

#### Parameters

* **volumeId** - AWS ID of the volume.
* **accessKeyId** - The Access Key ID used to authenticate requests to AWS services. Not required parameter, by default value of AWS_ACCESS_KEY_ID env variable is used.
* **secretAccessKey** - The Secret Access Key used to authenticate your requests to AWS services. Not required parameter, by default value of AWS_ACCESS_KEY_ID env variable is used.

#### Return Value

Volume status (e.g. 'available', 'in-use', etc) or $False if failed.

### Function EbsWaitForVolumeStatus

Function to wait for specific status of a volume with a timeout.

#### Syntax

~~~
EbsWaitForVolumeStatus [[-volumeId] <String>] [[-status] <String>] [[-timeout] <Int32>] [[-accessKeyId] <String>] [[-se cretAccessKey] <String>] [<CommonParameters>]
~~~

#### Parameters

* **volumeId** - AWS ID of the volume.
* **status** - Status of the volume to wait for (e.g. 'available', 'in-use').
* **timeout** - Timeout in seconds (default is 30 minutes).
* **accessKeyId** - The Access Key ID used to authenticate requests to AWS services. Not required parameter, by default value of AWS_ACCESS_KEY_ID env variable is used.
* **secretAccessKey** - The Secret Access Key used to authenticate your requests to AWS services. Not required parameter, by default value of AWS_ACCESS_KEY_ID env variable is used.

#### Return Value

$True if volume got specified status, $False if exited by timeout.

* * *

## File rax\CloudFiles.ps1

Functions dealing with Rackspace CloudFiles service.

### Function BackupPolicy

BackupPolicy

#### Syntax

~~~
BackupPolicy [[-container] <String>] [[-Lineage] <String>] [[-NumberBackupsToKeep] <Int32>] [[-username] <String>] [[-a uthKey] <String>] [[-region] <String>] [[-snet] <String>] [<CommonParameters>]
~~~

#### Parameters

* **container** - The name of the container.
* **Lineage** - Array of file names to be uploaded.
* **NumberBackupsToKeep** - The path for backup's downloads.
* **username** - Rackspace username
* **authKey** - Rackspace auth key
* **region** -
* **snet** - This parameter indicates if to use RAX service network or not. If this parameter is true and cloud is rackspace - then Service network will be used for data monipulation.

#### Return Value

Nothing

### Function DeleteItemCloudFiles

This function deletes a storage object in a given container.

#### Syntax

~~~
DeleteItemCloudFiles [[-container] <String>] [[-storageitem] <String>] [[-username] <String>] [[-authKey] <String>] [[- region] <String>] [[-snet] <Boolean>] [<CommonParameters>]
~~~

#### Parameters

* **container** - The name of the container that contains the storage.
* **storageitem** - The name of the storage object to delete.
* **username** - Rackspace username
* **authKey** - Rackspace auth key
* **region** -
* **snet** - This parameter indicates if to use RAX service network or not. If this parameter is true and cloud is rackspace - then Service network will be used for data monipulation.

#### Return Value

Nothing

### Function GetBackupFileFromCloudSpace

This function connects to Cloudfiles and lookig for the last backup.

#### Syntax

~~~
GetBackupFileFromCloudSpace [[-container] <String>] [[-lineagename] <String>] [[-PathDestination] <String>] [[-Timestam p] <String>] [[-username] <String>] [[-authKey] <String>] [[-region] <String>] [[-snet] <Boolean>] [<CommonParameters>]
~~~

#### Parameters

* **container** - The name of the container.
* **lineagename** - Array of file names to be uploaded.
* **PathDestination** - The path for backup's downloads.
* **Timestamp** - Timestamp of backup in format "yyyyMMddhhmmss"
* **username** - Rackspace username
* **authKey** - Rackspace auth key
* **region** -
* **snet** - This parameter indicates if to use RAX service network or not. If this parameter is true and cloud is rackspace - then Service network will be used for data monipulation.

#### Return Value

Nothing

#### Examples

~~~
GetBackupFileFromCloudSpace "TestContainer" "testik" "c:\backup" "20111024095922"
~~~

### Function GetFilesListFromCloudFiles

This function retrieves the objects of a container, excluding folders.

#### Syntax

~~~
GetFilesListFromCloudFiles [[-container] <String>] [[-username] <String>] [[-authKey] <String>] [[-region] <String>] [[-snet] <Boolean>] [<CommonParameters>]
~~~

#### Parameters

* **container** - The name of the container.
* **username** - Rackspace username
* **authKey** - Rackspace auth key
* **region** -
* **snet** - This parameter indicates if to use RAX service network or not. If this parameter is true and cloud is rackspace - then Service network will be used for data monipulation.

#### Return Value

Nothing

### Function GetFromCloudFiles

This function downloads a storage object from Cloud Files.

#### Syntax

~~~
GetFromCloudFiles [[-container] <String>] [[-name] <String>] [[-destPath] <String>] [[-username] <String>] [[-authKey] <String>] [[-region] <String>] [[-snet] <Boolean>] [<CommonParameters>]
~~~

#### Parameters

* **container** - The name of the container.
* **name** - The name of the storage object to retrieve.
* **destPath** - Local path for downloaded item.
* **username** - Rackspace username
* **authKey** - Rackspace auth key
* **region** -
* **snet** - This parameter indicates if to use RAX service network or not. If this parameter is true and cloud is rackspace - then Service network will be used for data monipulation.

#### Return Value

Nothing

### Function GetListFromCloudFilesPrefix

This function retrieves the objects of a container, excluding folders.

#### Syntax

~~~
GetListFromCloudFilesPrefix [[-container] <String>] [[-prefix] <String>] [[-username] <String>] [[-authKey] <String>] [[-region] <String>] [[-snet] <Boolean>] [<CommonParameters>]
~~~

#### Parameters

* **container** - The name of the container.
* **prefix** -
* **username** - Rackspace username
* **authKey** - Rackspace auth key
* **region** -
* **snet** - This parameter indicates if to use RAX service network or not. If this parameter is true and cloud is rackspace - then Service network will be used for data monipulation.

#### Return Value

Nothing

### Function PutListToCloudFiles

This function puts a numeros files to CloudFiles.

#### Syntax

~~~
PutListToCloudFiles [[-LocalFiles] <Array>] [[-container] <String>] [[-username] <String>] [[-authKey] <String>] [[-reg ion] <String>] [[-snet] <Boolean>] [<CommonParameters>]
~~~

#### Parameters

* **LocalFiles** - Array of file names to be uploaded.
* **container** - The name of the container.
* **username** - Rackspace username
* **authKey** - Rackspace auth key
* **region** -
* **snet** - This parameter indicates if to use RAX service network or not. If this parameter is true and cloud is rackspace - then Service network will be used for data monipulation.

#### Return Value

Nothing

### Function PutToCloudFiles

This function uploads a storage object to Cloud Files.

#### Syntax

~~~
PutToCloudFiles [[-localPath] <String>] [[-container] <String>] [[-name] <String>] [[-username] <String>] [[-authKey] < String>] [[-region] <String>] [[-snet] <Boolean>] [<CommonParameters>]
~~~

#### Parameters

* **localPath** - The complete file path of the storage object to be uploaded.
* **container** - The name of the container to put the storage object in.
* **name** - The name of file in container.
* **username** - Rackspace username
* **authKey** - Rackspace auth key
* **region** -
* **snet** - This parameter indicates if to use RAX service network or not. If this parameter is true and cloud is rackspace - then Service network will be used for data monipulation.

* * *

## File ros\Ros.ps1

Functions to deal with ROS in service-independent manner. S3 and Cloud Files are supported now. These functions provide level of abstraction between remote storage services and multicloud functions or RightScripts. General workflow of using these functions is: 1. Create ROS context which basically contains type of remote storage service, access credentials needed to deal with the service and additional information (for example name of S3 bucket). 2. Execute functions (get, put, delete, list, etc).

### Function InitRosContextFromInputs

InitRosContextFromInputs

### Function InitRosContextFromInputsApp

InitRosContextFromInputsApp

### Function RosAuthenticateSoftlayer

#### Syntax

~~~
RosAuthenticateSoftlayer [[-slRegion] <String>] [[-userName] <String>] [[-authKey] <String>] [[-useinternalendpoint] <String>]
~~~

### Function RosDeleteObject

Function to delete a file from remote storage.

#### Syntax

~~~
RosDeleteObject [[-ctx] <Hashtable>] [[-name] <String>] [<CommonParameters>]
~~~

#### Parameters

* **ctx** - Initialized ROS context.
* **name** - Name of the file to delete.

### Function RosGetList

Function to get a list of files stored in the remote storage.

#### Syntax

~~~
RosGetList [[-ctx] <Hashtable>] [<CommonParameters>]
~~~

#### Parameters

* **ctx** - Initialized ROS context.

#### Return Value

List of file names (array of strings).

### Function RosGetListPrefix

Function to get list of files stored in the remote storage with names starting with specified prefix.

#### Syntax

~~~
RosGetListPrefix [[-ctx] <Hashtable>] [[-prefix] <String>] [<CommonParameters>]
~~~

#### Parameters

* **ctx** - Initialized ROS context.
* **prefix** - Prefix to filter file names (string value).

#### Return Value

List of file names (array of strings).

### Function RosGetObject

Function to download a file from remote storage.

#### Syntax

~~~
RosGetObject [[-ctx] <Hashtable>] [[-name] <String>] [[-destPath] <String>] [<CommonParameters>]
~~~

#### Parameters

* **ctx** - Initialized ROS context.
* **name** - Name of the file to download.
* **destPath** - Complete local path to store downloaded file to.

### Function RosGetType

Extracts ROS type for ROS context.

#### Syntax

~~~
RosGetType [[-ctx] <Hashtable>] [<CommonParameters>]
~~~

#### Parameters

* **ctx** - ROS context.

#### Return Value

ROS type ('s3','cloud_files' or 'Azure_Storage' for now).


### Function RosInitAzure_Storage

Function to initialize ROS context for Rackspace Cloud Files.

#### Syntax

~~~
RosInitAzure_Storage [[-container] <String>] [[-userName] <String>] [[-authKey] <String>] [[-parallelThreadCount] <Int3 2>] [[-blockSize] <Int64>] [<CommonParameters>]
~~~

#### Parameters

* **container** - Name of Cloud Files container.
* **userName** - The Rackspace user name that's used to authenticate requests to Rackspace services.
* **authKey** - The Rackspace API key that's used to authenticate requests to Rackspace services. Note that we have to convert block size param from MB to bytes
* **parallelThreadCount** -
* **blockSize** -

#### Return Value

ROS context (hashtable).

### Function RosInitCloudFiles

Function to initialize ROS context for Rackspace Cloud Files.

#### Syntax

~~~
RosInitCloudFiles [[-container] <String>] [[-userName] <String>] [[-authKey] <String>] [[-rax_region] <String>] [[-stor age_servicenet] <String>] [[-is_rax_cloud] <String>] [<CommonParameters>]
~~~

#### Parameters

* **container** - Name of Cloud Files container.
* **userName** - The Rackspace user name that's used to authenticate requests to Rackspace services.
* **authKey** - The Rackspace API key that's used to authenticate requests to Rackspace services.
* **rax_region** -
* **storage_servicenet** - This parameter indicates if to use RAX service network or not. If this parameter is true and cloud is rackspace - then Service network will be used for data monipulation.
* **is_rax_cloud** - This parameter indicates if instance is in Rackspace cloud

#### Return Value

ROS context (hashtable).

### Function RosInitS3

Function to initialize ROS context for AWS S3.

#### Syntax

~~~
RosInitS3 [[-bucket] <String>] [[-accessKeyId] <String>] [[-secretAccessKey] <String>] [[-blockSize] <Object>] [<Common Parameters>]
~~~

#### Parameters

* **bucket** - Name of S3 bucket.
* **accessKeyId** - The Access Key ID used to authenticate requests to AWS services. Not required parameter, by default value of AWS_ACCESS_KEY_ID env variable is used.
* **secretAccessKey** - The Secret Access Key used to authenticate your requests to AWS services. Not required parameter, by default value of AWS_ACCESS_KEY_ID env variable is used.
* **blockSize** -

#### Return Value

ROS context (hashtable).

### Function RosInitSoftlayerStorage

Function to initialize ROS context for Soflayer Storage.

#### Syntax

~~~
RosInitSoftlayerStorage [[-slRegion] <String>] [[-container] <String>] [[-userName] <String>] [[-authKey] <String>] [[- useinternalendpoint] <String>] [<CommonParameters>]
~~~

#### Parameters

* **slRegion** - Name of SoftLayer region (currently supported Softlayer_Dallas, Softlayer_Amsterdam and Softlayer_Singapore).
* **container** - Name of SoftLayer Storage container.
* **userName** - The SoftLayer user name that's used to authenticate requests to SoftLayer storage.
* **authKey** - The SoftLayer auth key that's used to authenticate requests to SoftLayer storage.
* **useinternalendpoint** -

#### Return Value

ROS context (hashtable).

### Function RosInitSwift

Function to initialize ROS context for OpenStack Swift.

#### Syntax

~~~
RosInitSwift [[-authurl] <String>] [[-userid] <String>] [[-password] <String>] [[-container] <String>] [[-blockSize] <I nt64>] [[-useinternalendpoint] <String>] [<CommonParameters>]
~~~

#### Parameters

* **authurl** - Swift authentication endpoint URL
* **userid** - User id of account in format tenantID:username
* **password** - Account password
* **container** - Container name on storage
* **blockSize** - Size of file part upload
* **useinternalendpoint** -

#### Return Value

ROS context (hashtable).

### Function RosIsSupported

Function to determine if ROS service is supported.

#### Syntax

~~~
RosIsSupported [[-rosType] <String>] [<CommonParameters>]
~~~

#### Parameters

* **rosType** - Mnemonic name of the ROS service. Currently supported values are 's3' and 'cloud_files'.

#### Return Value

$True or $False.

### Function RosPutObject

Function to upload a file to remote storage.

#### Syntax

~~~
RosPutObject [[-ctx] <Hashtable>] [[-localPath] <String>] [[-name] <String>] [<CommonParameters>]
~~~

#### Parameters

* **ctx** - Initialized ROS context.
* **localPath** - Complete local path to the file that should be uploaded.
* **name** - Name under which the file will be stored on remote storage.

* * *

## File ros\RosBackups.ps1

This file provides function dealing with SQL Server ROS backups. SQL Server ROS backups are native SQL Server dump files uploaded to remote storage. Currently full, diff and log backups are supported (with full backup containing system databases - master, model, msdb). Restore could be performed from full, full+diff or full+diff+log backups. ROS backups are organized as multiple files named under following naming convention: <lineage name><backup type><timestamp>N.bak, where lineage name – lineage name of your server (DB_LINEAGE_NAME input). backup type – type of the backup (could be full, diff or log). timestamp – UTC date and time of the backup in format YYYYMMDDHHMMSS. N – database index within this backup (starts from 1). .bak – file name extension. Also each backup contains .ini file with the information about the backup. Ini files are named similarly: SQLS_BAK_<lineage name><backup type><timestamp>.ini. Besides storing backup metadata ini file could be considered as a marker that backup is completed successfully.

### Function CheckCanRestoreSysDatabases

Compare SQL Server versions. This function compares SQL Server version used for backup and the version of instance. If versions mismatch throw error with message.

#### Syntax

~~~
CheckCanRestoreSysDatabases [[-backupVersion] <String>] [[-instanceVersion] <String>] [<CommonParameters>]
~~~

#### Parameters

* **backupVersion** -
* **instanceVersion** -

### Function ExtractExtension

Helper function to extract extension from file name.

#### Syntax

~~~
ExtractExtension [[-fileName] <String>] [<CommonParameters>]
~~~

#### Parameters

* **fileName** - File name to extract extension from.

#### Return Value

Extracted extension (string).

### Function ExtractTimestamp

Helper function to extract timestampt from backup file name.

#### Syntax

~~~
ExtractTimestamp [[-fileName] <String>] [<CommonParameters>]
~~~

#### Parameters

* **fileName** - File name to extract timestamp from. assume that last 14 digits in file name followed by '_' is a timestamp

#### Return Value

Timestamp as string in format YYYYMMDDHHMMSS.

### Function RestartMsSqlServer

RestartMsSqlServer

### Function RosCleanBackups

Helper function to perform cleanup on a list of ini files.

#### Syntax

~~~
RosCleanBackups [[-rosCtx] <Hashtable>] [[-iniFiles] <Array>] [[-keepLast] <Int32>] [<CommonParameters>]
~~~

#### Parameters

* **rosCtx** - Initialized ROS context.
* **iniFiles** -
* **keepLast** - Number of backups to keep (positive integer value). Default value is 60.

### Function RosCleanupLineageBackups

Function that performs simple cleanup of backup on the remote storage. This function implements simple retention policy to keep specified number of last backups for given lineage name. Default value is to keep last 60 backups.

#### Syntax

RosCleanupLineageBackups [[-rosCtx] <Hashtable>] [[-lineage] <String>] [[-keepLast] <Int32>] [<CommonParameters>]

#### Parameters

* **rosCtx** - Initialized ROS context.
* **lineage** - Lineage name of backups.
* **keepLast** - Number of backups to keep (positive integer value). Default value is 60.

### Function RosFindBackups

#### Syntax

~~~
RosFindBackups [[-rosCtx] <Hashtable>] [[-lineage] <String>] [[-backupType] <String>] [[-startingFrom] <String>] [[-latestBefore] <String>]
~~~

### Function RosFindLatestBackup

Function to find latest backup for given lineage (globally or before specified timestamp).

#### Syntax

~~~
RosFindLatestBackup [[-rosCtx] <Hashtable>] [[-lineage] <String>] [[-backupType] <String>] [[-latestBefore] <String>] [<CommonParameters>]
~~~

#### Parameters

* **rosCtx** - Initialized ROS context.
* **lineage** - Lineage name of backups.
* **backupType** - Type of backups to search. Currently supported values: full, diff, log.
* **latestBefore** - Timestamp to get the latest backup that is created before a certain date.

#### Return Value

Parsed ini file of the backup found (hashtable). $False if backup was not found.

### Function RosFullLineageRestore

Performs restore of latest backups for given lineage.

#### Syntax

~~~
RosFullLineageRestore [[-rosCtx] <Hashtable>] [[-lineage] <String>] [[-backupDir] <String>] [[-noRecovery] <Boolean>] [[-skipRestoreSystemDatabases] <Boolean>] [[-latestBefore] <String>] [<CommonParameters>]
~~~

#### Parameters

* **rosCtx** - Initialized ROS context.
* **lineage** - Lineage name of backups.
* **backupDir** - Full path to store backup files temporarily on downloading and before restoring in SQL Server.
* **noRecovery** - Flag indicating to restore in NORECOVERY mode (default is $False). Find full backup
* **skipRestoreSystemDatabases** -
* **latestBefore** -

#### Return Value

$False if backup is not found.

### Function RosLineageBackup

Function to perform backup of specified type. This function performs full, diff or log backup of each database of local SQL Server instance(including system databases for full backup) and uploads backup files to remote storage. Note, that no archiving is performed so it's recommended to enable SQL Server backup compression (supported from SQL Server 2008R2). WARNING: if $backupType parameter is 'log' and full backup was not taken previously for a database (LastBackupDate property is empty) this function performs full backup to NUL device to enable creating log backup. Missing this full backup is potentially dangerous because it breaks backup/restore chain. So if you need full backup/restore chain you need to make sure you did full backup before invoking this function with $backupType = 'log'. Note: The use case for doing log backup without full one is using Snapshots method for backups (so data and log files are stored inside snapshots provided by the cloud so full backup is not needed). Performing log backups is needed to enable log truncation and prevent infinite growing of log files.

#### Syntax

~~~
RosLineageBackup [[-rosCtx] <Hashtable>] [[-lineage] <String>] [[-backupDir] <String>] [[-backupType] <String>] [[-iniF ileName] <String>] [[-filterDbNames] <Array>] [[-filterInclusive] <Boolean>] [<CommonParameters>]
~~~

#### Parameters

* **rosCtx** - Initialized ROS context.
* **lineage** - Lineage name of backups.
* **backupDir** - Full path to store backup files temporarily before uploading to ROS.
* **backupType** - Type of backup to perform (string value 'full', 'diff' or 'log'). Full backup is default.
* **iniFileName** - Name of ini file to create (optional). Naming convention is used if not specified: SQLS_BAK_<lineage name><backup type><timestamp>.ini.
* **filterDbNames** - Array of database names to backup or omit (depending on value of filterInclusive parameter).
* **filterInclusive** - Flag indicating whether to backup only databases specified in filterDbNames parameter or skip the mentioned databases. TODO Check params

### Function RosLineageRestore

Performs restore from previously taken backup.

#### Syntax

~~~
RosLineageRestore [[-rosCtx] <Hashtable>] [[-backupIni] <Hashtable>] [[-backupDir] <String>] [[-noRecovery] <Boolean>] [[-filterDbNames] <Array>] [[-filterInclusive] <Boolean>] [<CommonParameters>]
~~~

#### Parameters

* **rosCtx** - Initialized ROS context.
* **backupIni** - Parsed ini file containing information about backup (generally obtained via RosFindLatestBackup function).
* **backupDir** - Full path to store backup files temporarily on downloading and before restoring in SQL Server.
* **noRecovery** - Flag indicating to restore in NORECOVERY mode (default is $False).
* **filterDbNames** - Array of database names to restore or omit (depending on value of filterInclusive parameter).
* **filterInclusive** - Flag indicating whether to restore only databases specified in filterDbNames parameter or skip the mentioned databases.

### Function RosLineageRestoreBackups

Restores list of backups between $firstAfter and $latestBefore timestamps. RosLineageRestore function is used to restore single backup.

#### Syntax

~~~
RosLineageRestoreBackups [[-rosCtx] <Hashtable>] [[-backupDir] <String>] [[-backupsList] <Object>] [[-firstAfter] <Stri ng>] [[-latestBefore] <String>] [<CommonParameters>]
~~~

#### Parameters

* **rosCtx** - Initialized ROS context.
* **backupDir** - Full path to store backup files temporarily on downloading and before restoring in SQL Server.
* **backupsList** - List of backups to restore (array of parsed ini files).
* **firstAfter** - Timestamp to limit backups to be restored after specified in this param.
* **latestBefore** - Timestamp to limit backups to be restored before specified in this param.

### Function RosLineageRestoreSysDatabases

Performs restore of system databases (master, model, msdb) from previously taken backup. It stops SQLSERVERAGENT service, restarts MSSQLSERVER in single user mode, performs a restore, then restarts services in normal mode.

#### Syntax

~~~
RosLineageRestoreSysDatabases [[-rosCtx] <Hashtable>] [[-backupIni] <Hashtable>] [[-backupDir] <String>] [<CommonParame ters>]
~~~

#### Parameters

* **rosCtx** - Initialized ROS context.
* **backupIni** - Parsed ini file containing information about backup (generally obtained via RosFindLatestBackup function). Should be full type of backup.
* **backupDir** - Full path to store backup files temporarily on downloading and before restoring in SQL Server.

* * *

## File rs\RightScripts.ps1

Functions dealing with RightScripts.

### Function RsRunRightScriptTmo

Executes RightScript on instances that have specified list of tags set and waits until specified tag changes its value (generally used to track that RightScript completes).

#### Syntax

~~~
RsRunRightScriptTmo [[-rsName] <Object>] [[-params] <Object>] [[-timeOut] <Object>] [[-tagList] <Object>] [[-returnTag] <Object>] [<CommonParameters>]
~~~

#### Parameters

* **rsName** - Name of the RightScript to run.
* **params** - Params string in format '-p PARAM1=type:VALUE1 -p PARAM2=type:VALUE2 ...' For example: '-p SIZE=text:5 -p AWS_ACCESS_KEY_ID=cred:AWS_ACCESS_KEY_ID -p AWS_SECRET_ACCESS_KEY=cred:AWS_SECRET_ACCES S_KEY'
* **timeOut** - Timeout in seconds to wait for returnTag.
* **tagList** - List of tags to identify instance to run RightScript on.
* **returnTag** - Name of the tag to return its value.

#### Return Value

Value of returnTag or empty string if exited by timeout.

* * *

## File rs\RsApi15.ps1

Functions to perform RightScale API 1.5 calls.

### Function RsApi15_CallWithRetry

Function to do RightScale API 1.5 call with retry.

#### Syntax

~~~
RsApi15_CallWithRetry [[-href] <String>] [[-method] <String>] [[-params] <String>] [[-authCookies] <Object>] [[-maxAtte mpts] <Int32>] [<CommonParameters>]
~~~

#### Parameters

* **href** - Href of the API call to invoke (added to [https://my.rightscale.com](https://my.rightscale.com)).
* **method** - HTTP method of the call, i.e. 'GET', 'POST', 'PUT', etc (string).
* **params** - Parameters of the call.
* **authCookies** - Authentication cookies returned by RsApi15_Login or RsApi15_InstanceLogin functions or $Null ($Null is valid for login calls only). Make full URL adding / if neccessary
* **maxAttempts** -

#### Return Value

Response object or $Null if fails.

### Function RsApi15_CallWithRetryJson

Calls RsApi15_CallWithRetry and parses returned JSON output.

#### Syntax

~~~
RsApi15_CallWithRetryJson [[-href] <String>] [[-method] <String>] [[-params] <String>] [[-authCookies] <Object>] [[-max Attempts] <Int32>] [<CommonParameters>]
~~~

#### Parameters

* **href** - Href of the API call to invoke (added to [https://my.rightscale.com](https://my.rightscale.com)).
* **method** - HTTP method of the call, i.e. 'GET', 'POST', 'PUT', etc (string).
* **params** - Parameters of the call.
* **authCookies** - Authentication cookies returned by RsApi15_Login or RsApi15_InstanceLogin functions or $Null ($Null is valid for login calls only).
* **maxAttempts** -

#### Return Value

Hashtable in the following format (-key: value): -HttpStatusCode: HTTP status code returned -HttpLocation: value of the Location header returned -JSON: parsed content of the response object

### Function RsApi15_Login

Login to RightScale API 1.5 service via instance token.

#### Syntax

~~~
RsApi15_Login [[-acctHref] <String>] [[-email] <String>] [[-password] <String>] [<CommonParameters>]
~~~

#### Parameters

* **acctHref** -
* **email** -
* **password** -

#### Return Value

Set of authentication cookies (System.Net.CookieContainer object) if successful or $Null if failed

* * *

## File rs\RsApi15_Backups.ps1

Backups related functions (API 1.5).

### Function RsApi15_BackupSingleVolume

Performs backup by creating snapshot of specified volume.

#### Syntax

~~~
RsApi15_BackupSingleVolume [[-context] <Object>] [[-volLetter] <String>] [[-lineage] <String>] [<CommonParameters>]
~~~

#### Parameters

* **context** - Instance context returned by RsApi15_GetInstanceContext function.
* **volLetter** - Drive letter the volume (single char).
* **lineage** - Name of backup lineage (string, extracted from env variable DB_LINEAGE_NAME by default).

#### Return Value

Hrefs of the created backup, throws exception if failed.

### Function RsApi15_BackupVolumes

Performs backup by creating snapshots of data and log volumes. Simple and striped volumes are supported. This function creates snapshots of data nd log volumes by invoking /api/backups API 1.5 call. Uses VSS to guarantee consistency of files on data volume. Also commits the created backup.

#### Syntax

~~~
RsApi15_BackupVolumes [[-context] <Object>] [[-dataVolLetter] <String>] [[-logsVolLetter] <String>] [[-lineage] <String >] [[-dataVolDevices] <Array>] [[-logsVolDevices] <Array>] [<CommonParameters>]
~~~

#### Parameters

* **context** - Instance context returned by RsApi15_GetInstanceContext function.
* **dataVolLetter** - Drive letter of data volume (single char). By default is extracted from RS_SQLS_DATA_VOLUME env variable.
* **logsVolLetter** - Drive letter of logs volume (single char). By default is extracted from RS_SQLS_LOGS_VOLUME env variable.
* **lineage** - Name of backup lineage (string, extracted from env variable DB_LINEAGE_NAME by default).
* **dataVolDevices** - Array of device names that make up data volume (required for striped volume, could be omitted for simple volume). If omitted the device name is assumed to be /dev/xvdX, where X is drive letter (e.g /dev/xvde for E:\, etc).
* **logsVolDevices** - The same as dataVolDevices but for logs volume.

#### Return Value

Hrefs of the created backup, throws exception if failed.

### Function RsApi15_CleanupLineage

Performs cleanup of the backups lineage with specified parameters of retention policy.

#### Syntax

~~~
RsApi15_CleanupLineage [[-context] <Object>] [[-lineage] <String>] [[-keepLast] <Int32>] [[-dailies] <Int32>] [[-weekli es] <Int32>] [[-monthlies] <Int32>] [[-yearlies] <Int32>] [<CommonParameters>]
~~~

#### Parameters

* **context** - Instance context returned by RsApi15_GetInstanceContext function.
* **lineage** - Name of backups lineage.
* **keepLast** - Number of last backups to keep (optional, default is 60).
* **dailies** - Number of daily backups to keep (optional, default is 14).
* **weeklies** - Number of weekly backups to keep (optional, default is 6).
* **monthlies** - Number of montly backups to keep (optional, default is 12).
* **yearlies** - Number of yearly backups to keep (optional, default is 2).

### Function RsApi15_CommitBackup

Performs commit of the specified backup (adds committed=true tag).

#### Syntax

~~~
RsApi15_CommitBackup [[-context] <Object>] [[-backupHref] <String>] [<CommonParameters>]
~~~

#### Parameters

* **context** - Instance context returned by RsApi15_GetInstanceContext function.
* **backupHref** - Href of the backup to commit.

### Function RsApi15_FindBackup

Find latest backup for given lineage.

#### Syntax

~~~
RsApi15_FindBackup [[-context] <Object>] [[-lineage] <String>] [[-timestamp] <String>] [<CommonParameters>]
~~~

#### Parameters

* **context** - Instance context returned by RsApi15_GetInstanceContext function
* **lineage** - Name of backups lineage to search in.
* **timestamp** - Timestamp to search for backups latest before that moment of time. Optional.

#### Return Value

Href of found backup or $False if not found.

### Function RsApi15_RestoreSingleVolume

Restores single volume from previously created backup.

#### Syntax

~~~
RsApi15_RestoreSingleVolume [[-context] <Object>] [[-backupHref] <String>] [<CommonParameters>]
~~~

#### Parameters

* **context** - Instance context returned by RsApi15_GetInstanceContext function.
* **backupHref** - Href of the backup to restore volumes from.

#### Return Value

Hrefs of the restored volume, throws exception if failed.

### Function RsApi15_RestoreVolumes

Restores volumes from previously created backup. Simple and striped volumes are supported.

#### Syntax

~~~
RsApi15_RestoreVolumes [[-context] <Object>] [[-backupHref] <String>] [[-volumeType1] <String>] [[-volumeType2] <String >] [<CommonParameters>]
~~~

#### Parameters

- **context** - Instance context returned by RsApi15_GetInstanceContext function.
- **backupHref** - Href of the backup to restore volumes from.
- **volumeType1** - Volume type name for first volume
- **volumeType2** - Volume type name for second volume

### Function RsApi15_WaitBackupCompleted

Waits until specified backup is completed.

#### Syntax

~~~
RsApi15_WaitBackupCompleted [[-context] <Object>] [[-backupHref] <String>] [[-timeout] <Int32>] [<CommonParameters>]
~~~

#### Parameters

* **context** - Instance context returned by RsApi15_GetInstanceContext function.
* **backupHref** - Href of the backup.
* **timeout** - Timeout in seconds.

#### Return Value

$True if successfull, throws exception if failed.

* * *

## File rs\RsApi15_Volumes.ps1

Volumes related functions (API 1.5).

### Function GetVolumeReadyStatus

GetVolumeReadyStatus

### Function RsApi15_AttachVolume

Attach volume to the instance.

#### Syntax

~~~
RsApi15_AttachVolume [[-context] <Object>] [[-volumeHref] <String>] [[-driveLetter] <String>] [[-newVolume] <Boolean>] [[-device] <String>] [[-startDiskpart] <Boolean>] [<CommonParameters>]
~~~

#### Parameters

* **context** - Instance context returned by RsApi15_GetInstanceContext function
* **volumeHref** - Href of the volume to attach.
* **driveLetter** - Drive letter to assign to attached volume.
* **newVolume** - Flag indicating whether to format the volume after attachment.
* **device** - Device name to attach to (optional, /dev/xvd{driveLetter} is used by default).
* **startDiskpart** - Flag indicating whether to start instance of diskpart tool to have stable volume indices.

#### Return Value

Index of disk in the system (to be used to select disk in diskpart tool).

### Function RsApi15_CreateAttachStripedVolume

Creates specified number of volumes, attaches to the current instance, creates striped volume, formats and assigns drive letter for that striped volume.

#### Syntax

~~~
RsApi15_CreateAttachStripedVolume [[-context] <Object>] [[-numberStripes] <Int32>] [[-stripeSize] <String>] [[-driveLet ter] <String>] [[-reservedLetters] <Array>] [[-volumeType] <String>] [<CommonParameters>]
~~~

#### Parameters

* **context** - Instance context returned by RsApi15_GetInstanceContext function
* **numberStripes** - Number of stripes that make up striped volume.
* **stripeSize** - Size of each stripe in GB (positive integer) or name of the volume type.
* **driveLetter** - Drive letter to assign to new striped volume.
* **reservedLetters** - Array of last letters of device names that should not be used when attaching stripes (e.g. @('e') means not to use 'xvde' so xvde device will be available to attach another volume after this function completes).
* **volumeType** -

### Function RsApi15_CreateAttachVolume

Create and attach volume.

#### Syntax

~~~
RsApi15_CreateAttachVolume [[-context] <Object>] [[-size] <String>] [[-driveLetter] <String>] [[-volumeType] <String>] [<CommonParameters>]
~~~

#### Parameters

* **context** - Instance context returned by RsApi15_GetInstanceContext function
* **size** - Size of the volume to be created. This could be integer value specifying size in GB or name of the volume type that exist in the cloud.
* **driveLetter** - Drive letter to assign to the new volume.
* **volumeType** - Name of the volume type

#### Return Value

Href of the created volume attachment.

### Function RsApi15_CreateVolume

Creates new volume from scratch or restores from snapshot.\

#### Syntax

~~~
RsApi15_CreateVolume [[-context] <Object>] [[-size] <String>] [[-snapshotHref] <String>] [[-name] <String>] [[-volumeTy pe] <String>] [<CommonParameters>]
~~~

#### Parameters

* **context** - Instance context returned by RsApi15_GetInstanceContext function
* **size** - Size of the volume to be created. This could be integer value specifying size in GB or name of the volume type that exist in the cloud.
* **snapshotHref** - Href of the snapshot to restore volume from.
* **name** - Name of the new volume.
* **volumeType** - Name of the volume type

#### Return Value

Href of the created volume, throws eexception if failed.

### Function RsApi15_DeleteVolume

Deletes the volume.

#### Syntax

RsApi15_DeleteVolume [[-context] <Object>] [[-volHref] <String>] [<CommonParameters>]

#### Parameters

* **context** - Instance context returned by RsApi15_GetInstanceContext function
* **volHref** - Href of the volume to delete. Single attempt to delete volume on rackspace-ng because volumes with existing snapshot cannot be deleted

#### Return Value

$True if successful, throws exception if failed.

### Function RsApi15_DetachVolume

Detach volume from the instance.

#### Syntax

~~~
RsApi15_DetachVolume [[-context] <Object>] [[-volHref] <String>] [[-driveLettersSync] <String>] [<CommonParameters>]
~~~

#### Parameters

* **context** - Instance context returned by RsApi15_GetInstanceContext function
* **volHref** - Href of the volume to detach.
* **driveLettersSync** - Comma separated list of drive letters to flush disk cache. Flushing is performed using sync utility (should be installed already).

#### Return Value

$True if successful, throws exception if failed.

### Function RsApi15_DeviceIdToDriveLetter

#### Syntax

~~~
RsApi15_DeviceIdToDriveLetter [[-deviceId] <String>] [[-cloudProvider] <String>]
~~~

### Function RsApi15_DeviceIdToSuffix

#### Syntax

~~~
RsApi15_DeviceIdToSuffix [[-deviceId] <String>]
~~~

### Function RsApi15_DriveLetterToDeviceId

#### Syntax

~~~
RsApi15_DriveLetterToDeviceId [[-driveLetter] <String>] [[-cloudProvider] <String>]
~~~

### Function RsApi15_GetAttachedVolumes

Get list of all volumes attched to the instance.

#### Syntax

~~~
RsApi15_GetAttachedVolumes [[-context] <Object>] [[-deviceStartsWith] <String>] [[-skipDevice] <String>] [<CommonParame ters>]
~~~

#### Parameters

* **context** - Instance context returned by RsApi15_GetInstanceContext function
* **deviceStartsWith** - Use this param to return only volumes which attachment device name starts with specified string.
* **skipDevice** -

#### Return Value

Array of hrefs of volumes attached to the current instance (array of strings).

### Function RsApi15_WaitVolumeStatus

Function to wait for specific status of a volume with a timeout.

#### Syntax

~~~
RsApi15_WaitVolumeStatus [[-context] <Object>] [[-volHref] <String>] [[-status] <String>] [[-timeout] <Int32>] [<Common Parameters>]
~~~

#### Parameters

* **context** - Instance context returned by RsApi15_GetInstanceContext function
* **volHref** - Href of the volume to check status.
* **status** - Status of the volume to wait for (e.g. 'available', 'in-use').
* **timeout** - Timeout in seconds (default is 30 minutes).

#### Return Value

$True if volume got specified status, throws an exception if exited by timeout.

### Function RsCreateVolumeName

#### Syntax

~~~
RsCreateVolumeName [[-serverName] <String>] [[-driveLetter] <String>] [[-stripeNumber] <Int32>]
~~~

* * *

## File rs\RsApiCallWithRetry.ps1

Functions to perform RightScale API 1.0 calls.

### Function RsApiCallWithRetry

Function to do RightScale API 1.0 call with retry.

#### Syntax

~~~
RsApiCallWithRetry [[-subPath] <Object>] [[-method] <Object>] [[-params] <Object>] [<CommonParameters>]
~~~

#### Parameters

* **subPath** - Subpath of the API URL to call (string). Base path is extracted from RS_API_URL env variable.
* **method** - HTTP method of the call, i.e. 'GET', 'POST', 'PUT', etc (string).
* **params** - Parameters of the call (string).

#### Return Value

Response object if successful, $False if failed.

### Function RsApiCallWithRetryJson

Function that call RsApiCallWithRetry and parses JSON output into PowerShell objects (strings, arrays, hashtables, etc).

#### Syntax

~~~
RsApiCallWithRetryJson [[-subPath] <Object>] [[-method] <Object>] [[-params] <Object>] [<CommonParameters>]
~~~

#### Parameters

* **subPath** - Subpath of the API URL to call (string). Base path is extracted from RS_API_URL env variable.
* **method** - HTTP method of the call, i.e. 'GET', 'POST', 'PUT', etc (string).
* **params** - Parameters of the call (string).

#### Return Value

Parsed object (System.Collections.IDictionary) if successfull, $False if failed.

* * *

## File rs\RsInstanceApi15.ps1

Helper functions for instance-facing login.

### Function RsApi15_GetInstanceContext

Function to get instance information to be used for next API calls.

#### Syntax

~~~
RsApi15_GetInstanceContext [[-authCookies] <Object>] [<CommonParameters>]
~~~

#### Parameters

* **authCookies** - Authentication cookies returned by RsApi15_InstanceLogin function.

#### Return Value

Hashtable containing following elements (-key: value): -name: name of the instance, -auth: authentication cookies (copy of input parameter) -cloud_href: href of the cloud, -datacenter_href: href of the datacenter, -instance_href: href of the instance itself.

### Function RsApi15_InstanceLogin

Login to RightScale API 1.5 service via instance token.

#### Syntax

~~~
RsApi15_InstanceLogin [[-apiToken] <String>] [<CommonParameters>]
~~~

#### Parameters

* **apiToken** - API token to be used for login. Defaults to RS_API_TOKEN env variable.

#### Return Value

Set of authentication cookies (System.Net.CookieContainer object) if successful or $Null if failed

* * *

## File rs\RsTag.ps1

Functions dealing with tags (using rs_tag utility).

### Function RsTag_GetCountAll

#### Syntax

~~~
RsTag_GetCountAll [[-tagList] <Object>]
~~~

### Function RsTag_GetValue


#### Syntax

~~~
RsTag_GetValue [[-tagList] <Object>] [[-returnTag] <Object>]
~~~

### Function RsTag_GetValues

Returns array of values of the specified tag on instaces having all tags from the specified list.

#### Syntax

~~~
RsTag_GetValues [[-tagList] <Object>] [[-returnTag] <String>] [<CommonParameters>]
~~~

#### Parameters

* **tagList** - List of tags to look for (array of strings or space-separated string).
* **returnTag** - Name of the tag to return value.

#### Return Value

Array of values of the returnTag tag on discovered instance, empty array if not found.

* * *

## File sqls\Certificate.ps1

Certificate functions.

### Function CreateCertFromString

Restore certificate and private key (protected by password) from base64 encoded string (input - credential) and save its to local path.

#### Syntax

~~~
CreateCertFromString [[-Ip] <String>] [[-server] <Server>] [[-cert] <String>] [[-KeyPassword] <String>] [<CommonParamet ers>]
~~~

#### Parameters

* **Ip** - Ip addres of partner. Used to create cert names/filenames
* **server** - Server object (instance of Microsoft.SqlServer.Management.Smo.Server).
* **cert** - Base64 encoded value. Contains certificate and private key.
* **KeyPassword** - Password to decript private key

### Function DisplayCertAsString

Displays certificate and private key as base64 encoded strings

#### Syntax

~~~
DisplayCertAsString [[-certPath] <String>] [[-pkPath] <String>] [<CommonParameters>]
~~~

#### Parameters

* **certPath** - Path to certificate file
* **pkPath** - Path to private key file

### Function SqlsCreateAndSaveCert

Creates certificate with specified name and saves it to local file. Drops one with the same name if exists.

#### Syntax

~~~
SqlsCreateAndSaveCert [[-server] <Server>] [[-certName] <String>] [[-localCertPath] <String>] [<CommonParameters>]
~~~

#### Parameters

* **server** - Server object (instance of Microsoft.SqlServer.Management.Smo.Server).
* **certName** - Name of the certificate to be created.
* **localCertPath** - Complete path to file to save certificate as.

### Function SqlsCreateCertificate

Creates SQL Server certificate for given database.

#### Syntax

~~~
SqlsCreateCertificate [[-server] <Server>] [[-dbName] <String>] [[-certName] <String>] [[-subject] <String>] [[-passwor d] <String>] [<CommonParameters>]
~~~

#### Parameters

* **server** - Server object (instance of Microsoft.SqlServer.Management.Smo.Server).
* **dbName** - Database name.
* **certName** - Certificate name.
* **subject** - Certificate subject.
* **password** - Certificate password.

### Function SqlsCreateCertificateMaster

Creates SQL Server certificate for master database.

#### Syntax

~~~
SqlsCreateCertificateMaster [[-server] <Server>] [[-certName] <String>] [[-subject] <String>] [[-password] <String>] [< CommonParameters>]
~~~

#### Parameters

* **server** - Server object (instance of Microsoft.SqlServer.Management.Smo.Server).
* **certName** - Certificate name.
* **subject** - Certificate subject.
* **password** - Certificate password.

### Function SqlsDisplayCert

Creates certificate with specified name, encode it using base64 algorithm and saves it to local file. Drops one with the same name if exists.

#### Syntax

~~~
SqlsDisplayCert [[-server] <Server>] [[-privateKeyPassword] <String>] [<CommonParameters>]
~~~

#### Parameters

* **server** - Server object (instance of Microsoft.SqlServer.Management.Smo.Server).
* **privateKeyPassword** - Password which will be used to encrypt private key.

### Function SqlsDropAllCertMasterPrefix

Erases all certificates with preffix "SQLS_CERT"

#### Syntax

~~~
SqlsDropAllCertMasterPrefix [[-server] <Server>] [[-preffix] <String>] [<CommonParameters>]
~~~

#### Parameters

* **server** - Server object (instance of Microsoft.SqlServer.Management.Smo.Server).
* **preffix** -

### Function SqlsSaveCert

Saves certificate with specified name to local file.

#### Syntax

~~~
SqlsSaveCert [[-server] <Server>] [[-certName] <String>] [[-localCertPath] <String>] [<CommonParameters>]
~~~

#### Parameters

* **server** - Server object (instance of Microsoft.SqlServer.Management.Smo.Server).
* **certName** - Name of the certificate to be saved.
* **localCertPath** - Complete path to file to save certificate as.

* * *

## File sqls\Mirroring.ps1

Utility functions for setting up mirroring.

### Function SqlsConfigurePartnerCertAuth

Configures SQL Server instance to act as partner in mirroring configuration (principal or mirror).

#### Syntax

~~~
SqlsConfigurePartnerCertAuth [[-server] <Server>] [[-partnerIp] <String>] [[-certName] <String>] [[-certPath] <String>] [<CommonParameters>]
~~~

#### Parameters

* **server** - Server object (instance of Microsoft.SqlServer.Management.Smo.Server).
* **partnerIp** - IP address of another partner.
* **certName** - Certificate name used for authentication.
* **certPath** - Certificate file used for authentication.

### Function SqlsConnectToPartner

Starts mirroring session for all non-system databases.

#### Syntax

~~~
SqlsConnectToPartner [[-server] <Server>] [[-partnerIp] <String>] [[-tcpPort] <Int32>] [<CommonParameters>]
~~~

#### Parameters

* **server** - Server object (instance of Microsoft.SqlServer.Management.Smo.Server).
* **partnerIp** - IP address of another partner.
* **tcpPort** - TCP port number to be used for mirroring data transfer (integer).

### Function SqlsCreateMirroringEndpointCert

Creates mirroring endpoint with certificate authentication on specified TCP port. Drops one with the same name if exists.

#### Syntax

~~~
SqlsCreateMirroringEndpointCert [[-server] <Server>] [[-tcpPort] <Int32>] [[-certName] <String>] [[-role] <String>] [<C ommonParameters>]
~~~

#### Parameters

* **server** - Server object (instance of Microsoft.SqlServer.Management.Smo.Server).
* **tcpPort** - TCP port number to be used for mirroring data transfer (integer).
* **certName** - Certificate name to be used for authentication.
* **role** - ROLE = { WITNESS | PARTNER | ALL }

### Function SqlsCreateMirroringStateChangeAlert

Creates mirroring state change Alert object to supply mirroring state graph.

#### Syntax

~~~
SqlsCreateMirroringStateChangeAlert [[-server] <Server>] [<CommonParameters>]
~~~

#### Parameters

* **server** - Server object (instance of Microsoft.SqlServer.Management.Smo.Server).

### Function SqlsCreateMirroringStateChangeJob

Creates mirroring state change Job object to supply mirroring state graph.

#### Syntax

~~~
SqlsCreateMirroringStateChangeJob [[-server] <Server>] [[-adm_pwd] <String>] [<CommonParameters>]
~~~

#### Parameters

* **server** - Server object (instance of Microsoft.SqlServer.Management.Smo.Server).
* **adm_pwd** -

### Function SqlsDeleteMirroringEndpoint

Deletes mirroring endpoint.

#### Syntax

~~~
SqlsDeleteMirroringEndpoint [[-server] <Server>] [<CommonParameters>]
~~~

#### Parameters

* **server** - Server object (instance of Microsoft.SqlServer.Management.Smo.Server).

### Function SqlsDeleteMirroringStateChangeAlertAndJob

Clean up RightScale Objects in SQL Server

#### Syntax

~~~
SqlsDeleteMirroringStateChangeAlertAndJob [[-server] <Server>] [<CommonParameters>]
~~~

#### Parameters

* **server** - Server object (instance of Microsoft.SqlServer.Management.Smo.Server).

### Function SqlsGetPartnerTag

Gets value of specified tag for mirroring partner server.

#### Syntax

~~~
SqlsGetPartnerTag [[-lineage] <String>] [[-role] <String>] [[-tag] <String>] [<CommonParameters>]
~~~

#### Parameters

* **lineage** - Lineage name.
* **role** - Mirroring role ('principal', 'mirror' or 'witness')
* **tag** - Name of the tag to get value of.

#### Return Value

Value of the tag, $false is unable to get tag.

### Function SqlsRemoveLogin

Removes certificate, user and login for specified IP

#### Syntax

~~~
SqlsRemoveLogin [[-server] <Server>] [[-ip] <String>] [<CommonParameters>]
~~~

#### Parameters

* **server** - Server object (instance of Microsoft.SqlServer.Management.Smo.Server).
* **ip** - IP address of partner.

### Function SqlsStartBroker

Enable Service Broker on msdb.

#### Syntax

~~~
SqlsStartBroker [[-server] <Server>] [<CommonParameters>]
~~~

#### Parameters

* **server** -

### Function SqlsWaitForPartner

Waits until specified status of mirroring partner. Uses RightScale tags for status tracking.

#### Syntax

~~~
SqlsWaitForPartner [[-lineage] <String>] [[-role] <String>] [[-status] <String>] [<CommonParameters>]
~~~

* * *

## File sqls\MoveSysDatabases.ps1

Utitlity function to move system databases.

### Function SqlsMoveSysDatabases

Moves data and log files of SQL Server system databases (master, model, msdb, tempdb) to other locations. Supports both copying files to new locations or just "switching" to existing files. Function stops SQL Server service if running but doesn't start it again.

#### Syntax

~~~
SqlsMoveSysDatabases [[-dataPath] <String>] [[-logsPath] <String>] [[-copyFiles] <Boolean>] [<CommonParameters>]
~~~

* * *

## File sqls\Query.ps1

Functions to perform queries on SQL Server instance.

### Function SqlsExecNonQuery

Executes query against specified database.

#### Syntax

~~~
SqlsExecNonQuery [[-server] <Server>] [[-dbName] <String>] [[-query] <String>] [<CommonParameters>]
~~~

### Function SqlsExecNonQueryMaster

Executes query against master database.

#### Syntax

~~~
SqlsExecNonQueryMaster [[-server] <Server>] [[-query] <String>] [<CommonParameters>]
~~~

### Function SqlsSelectValue

Executes SELECT query on specified database and returns the first column of the first row of the result set.

#### Syntax

~~~
SqlsSelectValue [[-server] <Server>] [[-dbName] <String>] [[-query] <String>] [<CommonParameters>]
~~~

#### Return Value

Value of the column of the first row of the result set or $Null if the query produces empty result set.

* * *

## File sqls\SqlServer.ps1

General SQL Server functions.

### Function CreateMasterKeyPassword

#### Syntax

~~~
CreateMasterKeyPassword [[-server] <Server>] [[-password] <String>]
~~~

### Function GetSqlServer

#### Syntax

~~~
GetSqlServer [[-name] <String>]
~~~

### Function GetSQLServerVersion

#### Syntax

~~~
GetSQLServerVersion [[-server] <Object>] [<CommonParameters>]
~~~

#### Return Value

'2012' or '2008R2'

### Function LoadSqlsAssemblies

Version-agnostic Function to load SMO assemblies.

#### Syntax

~~~
LoadSqlsAssemblies [<CommonParameters>]
~~~

### Function OpenOrCreateMasterKey

#### Syntax

~~~
OpenOrCreateMasterKey [[-server] <Server>] [[-password] <String>]
~~~

### Function SetSQLAgentProperty

#### Syntax

~~~
SetSQLAgentProperty [[-propertyName] <String>] [[-propertyValue] <String>]
~~~

### Function SqlsHasMirroring

#### Syntax

~~~
SqlsHasMirroring [[-server] <Server>]
~~~

* * *

## File sqls\SqlsUtils.ps1

SQL Server utility functions.

### Function SqlsCanDoDiffBackup

Check whether full backup was already performed for a given database so there is a base to do diff backup.

#### Syntax

~~~
SqlsCanDoDiffBackup [[-server] <Server>] [[-dbName] <String>] [<CommonParameters>]
~~~

#### Return Value

$True or $False.

### Function SqlsEnableTcp

SqlsEnableTcp

### Function SqlsForceDatabasesRecovery

Performs restore with recovery for all databases in 'Restoring' state.

#### Syntax

SqlsForceDatabasesRecovery [[-server] <Server>] [<CommonParameters>]

### Function SqlsSetSingleUserMode

#### Syntax

~~~
SqlsSetSingleUserMode [-singleUserMode]
~~~

### Function SqlsWaitDbStatus

Waits until specified database has specified status.

#### Syntax

~~~
SqlsWaitDbStatus [[-server] <Server>] [[-dbName] <String>] [[-status] <String>] [<CommonParameters>]
~~~

### Function SqlsWaitServerStatus

Waits until SQL Server has specified status.

#### Syntax

~~~
SqlsWaitServerStatus [[-status] <String>] [<CommonParameters>]
~~~

* * *

## File tools\Archive.ps1

Functions to deal with archives.

### Function Archive

This function archives a folder or a file.

#### Syntax

~~~
Archive [[-Source] <String>] [[-PathTo7Zip] <String>] [[-ArchName] <String>] [[-ArchiveDestination] <String>] [[-ArchFi leSize] <String>] [<CommonParameters>]
~~~

#### Return Value

Return a list of archvived files (array of file names) or throws exception if failed.

### Function UnzipFile

Unzips file from a specified location.

#### Syntax

~~~
UnzipFile [[-SourcePath] <String>] [[-PathTo7Zip] <String>] [[-DestinationPath] <String>] [<CommonParameters>]
~~~

* * *

## File tools\Checks.ps1

Functions to check values and inputs.

### Function CheckChar

Checks if a value is a character from specified array.

#### Syntax

~~~
CheckChar [[-value] <String>] [[-values] <Array>] [[-errorMessage] <String>] [<CommonParameters>]
~~~

#### Return Value

$True if the value is correct otherwize throws an exception.

### Function CheckInputChar

Checks if a input of a RightScript is a character from specified array.

#### Syntax

~~~
CheckInputChar [[-inputName] <String>] [[-optional] <Boolean>] [[-values] <Array>] [<CommonParameters>]
~~~

#### Return Value

$True if the value is correct otherwize throws an exception.

### Function CheckInputInt

Checks if a input of a RightScript is an integer within specified range.

#### Syntax

~~~
CheckInputInt [[-inputName] <String>] [[-optional] <Boolean>] [[-minValue] <Int32>] [[-maxValue] <Int32>] [<CommonParam eters>]
~~~

#### Return Value

$True if the value is correct otherwize throws an exception.

### Function CheckInputNotEmpty

Checks if input of a RightScript is not empty.

#### Syntax

~~~
CheckInputNotEmpty [[-inputName] <String>] [<CommonParameters>]
~~~

#### Return Value

$True if value is not empty, throws exception if empty

### Function CheckInt

Checks if a value is an integer within specified range.

#### Syntax

~~~
CheckInt [[-value] <String>] [[-minValue] <Int32>] [[-maxValue] <Int32>] [[-errorMessage] <String>] [<CommonParameters>]
~~~

#### Return Value

$True if the value is correct otherwize throws an exception.

### Function CheckNotEmpty

Checks if value is not empty.

#### Syntax

~~~
CheckNotEmpty [[-value] <String>] [[-errorMessage] <String>] [<CommonParameters>]
~~~

#### Return Value

$True if value is not empty, throws exception if empty

* * *

## File tools\ExtractReturn.ps1

Functions to extract returned value (useful for cmdlets/functions that write something to console during execution).

### Function ExtractReturn

Extracts last value from pipeline output of a cmdlet or a function.

#### Syntax

~~~
ExtractReturn [<CommonParameters>]
~~~

#### Return Value

Last items in the pipeline (value actually returned by prev function/cmdlet).

### Function GetExtractReturn

Returns last item from its parameter.

#### Syntax

~~~
GetExtractReturn [[-value] <Object>] [<CommonParameters>]
~~~

* * *

## File tools\GenHtmlHelp.ps1

Helper functions to generate simple HTML help for .ps1 files in a directory.

### Function GetFunctions

Helper function to get all functions declared in .ps1 file in a directory.

#### Syntax

~~~
GetFunctions [[-path] <Object>] [<CommonParameters>]
~~~

### Function Help_GetDescription

#### Syntax

~~~
Help_GetDescription [[-help] <Object>]
~~~

### Function Help_GetNotes

#### Syntax

Help_GetNotes [[-help] <Object>]

### Function Help_GetReturnValues

#### Syntax

~~~
Help_GetReturnValues [[-help] <Object>]
~~~

### Function Help_GetSynopsis

#### Syntax

~~~
Help_GetSynopsis [[-help] <Object>]
~~~

### Function Help_GetSyntax

#### Syntax

~~~
Help_GetSyntax [[-help] <Object>]
~~~

### Function ToHtmlSafe

#### Syntax

~~~
ToHtmlSafe [[-in] <Object>]
~~~

* * *

## File tools\IniFiles.ps1

Functions to work with .ini files.

### Function ParseIniFile

Function to parse .ini file.

#### Syntax

~~~
ParseIniFile [[-file] <Object>] [<CommonParameters>]
~~~

#### Return Value

Contents of .ini file as nested hashtable.

### Function WriteIniFile

Function to save .ini file.

#### Syntax

~~~
WriteIniFile [[-ini] <Hashtable>] [[-file] <String>] [<CommonParameters>]
~~~

* * *

## File tools\LoadAssembly.ps1

Wrapper function to load assembly.

### Function LoadAssembly

Wrapper function to load assembly. Now using [System.Reflection.Assembly]::LoadWithPartialName. To be reimplemented when LoadWithPartialName becomes deprecated.

#### Syntax

~~~
LoadAssembly [[-partialName] <Object>] [<CommonParameters>]
~~~

* * *

## File tools\NewGenericObject.ps1

Function to create generic object (no built-in one in PowerShell).

### Function NewGenericObject

Creates an object of a generic type (PowerShell lacks built-in function for that).

#### Syntax

~~~
NewGenericObject [[-typeName] <String>] [[-typeParameters] <String[]>] [[-constructorParameters] <Object[]>] [<CommonPa rameters>]
~~~

#### Return Value

Created object or throws exception if fails.

* * *

## File tools\Passwords.ps1

Helper functions dealing with passwords.

### Function GenRandomPassword

Generates random password of specified length. Only alphanumeric characters are used. Also the functions ensures the password contains at least one upper case letter, one lower case letter and one digit.

#### Syntax

GenRandomPassword [[-len] <Int32>] [<CommonParameters>]

#### Return Value

Generated password as string value.

* * *

## File tools\RepartitionDisk.ps1

Repartition disk utility function.

### Function RepartitionDisk

#### Syntax

~~~
RepartitionDisk [[-size1] <String>] [[-letter1] <Char>] [[-size2] <String>] [[-letter2] <Char>]
~~~

* * *

## File tools\ResolveError.ps1

Function to provide extended error description.

### Function ResolveError

Provides extended error description (writes to console). Useful in troubleshooting.

#### Syntax

~~~
ResolveError [[-errorRecord] <Object>] [<CommonParameters>]
~~~

#### Parameters

* * *

## File tools\Sample.ps1

Sample PS1 file.

### Function Sample

#### Syntax

~~~
Sample [[-a] <Object>] [<CommonParameters>]
~~~

### Function Sample2

#### Syntax

~~~
Smaple2 [[-a] <Object>]
~~~

* * *

## File tools\Text.ps1

Functions dealing with text files.

### Function FilesSearchReplace

Function to search and replace string in text files.

#### Syntax

~~~
FilesSearchReplace [[-files] <Object>] [[-search_for] <Object>] [[-replace_to] <Object>] [<CommonParameters>]
~~~

* * *

## File tools\tools.ps1

Other utility functions.

### Function Check_Process_Exist

Checks if process exist.

#### Syntax

~~~
Check_Process_Exist [[-process_name] <Object>] [<CommonParameters>]
~~~

#### Return Value

$True or $False.

### Function LoadSnapin

Load a PowerShell snapin

#### Syntax

~~~
LoadSnapin [[-SnapinName] <String>] [<CommonParameters>]
~~~

* * *

## File tools\Unzip.ps1

Unzip function.

### Function UnzipFiles

Unzips a folder or a file.

#### Syntax

~~~
UnzipFiles [[-Source] <String>] [[-PathTo7Zip] <String>] [[-ArchiveDestination] <String>] [<CommonParameters>]
~~~

#### Return Value

List of archvived files (array of strings).

* * *

## File waz\WazStorage.ps1

Functions dealing with Azure Storage service.

### Function DeleteItemAzureStorage

This function deletes a storage object in a given container.

#### Syntax

~~~
DeleteItemAzureStorage [[-container] <String>] [[-storageitem] <String>] [[-accountname] <String>] [[-accountkey] <Stri ng>] [<CommonParameters>]
~~~

#### Return Value

Nothing

### Function GetFilesListFromAzureStorage

This function retrieves the objects of a container, excluding folders.

#### Syntax

~~~
GetFilesListFromAzureStorage [[-container] <String>] [[-accountname] <String>] [[-accountkey] <String>] [<CommonParamet ers>]
~~~

#### Return Value

Nothing

### Function GetFilesListFromAzureStoragePrefix

This function retrieves the objects of a container, excluding folders.

#### Syntax

~~~
GetFilesListFromAzureStoragePrefix [[-container] <String>] [[-prefix] <String>] [[-accountname] <String>] [[-accountkey] <String>] [<CommonParameters>]
~~~

#### Return Value

Nothing

### Function GetFromAzureStorage

This function downloads a storage object from Azure Storage.

#### Syntax

~~~
GetFromAzureStorage [[-container] <String>] [[-name] <String>] [[-destPath] <String>] [[-accountname] <String>] [[-acco untkey] <String>] [<CommonParameters>]
~~~

#### Return Value

Nothing

### Function PutListToAzureStorage

This function puts a numeros files to CloudFiles.

#### Syntax

~~~
PutListToAzureStorage [[-LocalFiles] <Array>] [[-container] <String>] [[-accountname] <String>] [[-accountkey] <String> ] [<CommonParameters>]
~~~

#### Return Value

Nothing

### Function PutToAzureStorage

This function uploads a storage object to Azure Files.

#### Syntax

~~~
PutToAzureStorage [[-localPath] <String>] [[-container] <String>] [[-name] <String>] [[-accountname] <String>] [[-accou ntkey] <String>] [[-parallelThreadCount] <Int32>] [[-blockSiziInBytes] <Int64>] [<CommonParameters>]
~~~

#### Return Value

Nothing

* * *

## File win\Acl.ps1

Functions to deal with NTFS permissions.

### Function AclAllowInheritanceFiles

Allow inheritance to files in specified directory

#### Syntax

~~~
AclAllowInheritanceFiles [[-dir] <String>] [[-filter] <String>] [<CommonParameters>]
~~~

### Function AclGrantFullControl

Grants full control permissions to specified directory including files and subdirectories.

#### Syntax

~~~
AclGrantFullControl [[-dir] <String>] [[-acctName] <String>] [<CommonParameters>]
~~~

* * *

## File win\Firewall.ps1

Functions to deal with Windows firewall.

### Function OpenTcpPort

Function to allow inbound connection on specified port and optionally for specified IP address.

#### Syntax

~~~
OpenTcpPort [[-port] <Int32>] [[-ip] <String>] [<CommonParameters>]
~~~

#### Return Value

$True or $False.

* * *

## File win\Hosts.ps1

Hosts.ps1

### Function Set-HostsEntry

#### Syntax

~~~
Set-HostsEntry [-IPAddress] <String> [-HostName] <String> [-Verbose] [-Debug] [-ErrorAction <ActionPreference>] [-WarningAction <ActionPreference>] [-ErrorVariable <String>] [-WarningVariable <String>] [-OutVariable <String>] [-OutBuffer <Int32>] [-WhatIf] [-Confirm]
~~~

* * *

## File win\IIS.ps1

Functions dealing with IIS server.

### Function CheckAppPoolStatus

This function returns status for application pool in IIS Web server.

#### Syntax

~~~
CheckAppPoolStatus [[-AppName] <String>] [[-ServerName] <Object>] [<CommonParameters>]
~~~

#### Return Value

App pool status as string, possible values are "Starting", "Started", "Stopping", "Stopped".

### Function StartAppPool

This function starts application pool in IIS Web server.

#### Syntax

~~~
StartAppPool [[-AppName] <String>] [[-ServerName] <Object>] [<CommonParameters>]
~~~

* * *

## File win\IpSettings.ps1

Functions to deal with network settings.

### Function AddFirewallRule

Adds firewall rule.

#### Syntax

~~~
AddFirewallRule [[-Name] <Object>] [[-Ports] <Object>] [[-Protocol] <Object>] [[-RemoteAddress] <Object>] [<CommonParam eters>]
~~~

### Function CheckIpValid

This function checks if provided ip address is valid

#### Syntax

~~~
CheckIpValid [[-IpAddress] <String>] [<CommonParameters>]
~~~

### Function GetAllIPv4IPAddresses

Returns array of all IP addresses for all network adapters.

#### Syntax

~~~
GetAllIPv4IPAddresses [<CommonParameters>]
~~~

#### Return Value

Array of IP addresses (array of strings).

### Function ResolveDNSName

#### Syntax

~~~
ResolveDNSName [[-DnsName] <String>]
~~~

### Function Set_Dynamic_IP

Enables DHCP on all network adapters.

#### Syntax

~~~
Set_Dynamic_IP [<CommonParameters>]
~~~

### Function Set_Static_IP

Sets static IP mode for all network adapters.

#### Syntax

~~~
Set_Static_IP [<CommonParameters>]
~~~

* * *

## File win\Registry.ps1

Registry.ps1

### Function addRegKey

Used to add reg key.

#### Syntax

~~~
addRegKey [[-regFullPath] <String>] [[-regKey] <String>] [[-regValue] <String>] [[-regtype] <String>] [<CommonParameter s>]
~~~

#### Return Value

$True or $False.

### Function changeRegKey

Changes value of existing reg key.

#### Syntax

~~~
changeRegKey [[-regFullPath] <String>] [[-regKey] <String>] [[-regValue] <String>] [<CommonParameters>]
~~~

#### Return Value

$True or $False.

### Function CheckRegKey

Check if reg key exist.

#### Syntax

~~~
CheckRegKey [[-regFullPath] <String>] [[-regKey] <String>] [<CommonParameters>]
~~~

#### Return Value

$True or $False.

### Function removeRegKey

Removes reg key.

#### Syntax

~~~
removeRegKey [[-regFullPath] <String>] [[-regKey] <String>] [<CommonParameters>]
~~~

#### Return Value

$True or $False.

* * *

## File win\SchTasks.ps1

Functions to deal with scheduled tasks.

### Function CreateScheduledTask

Creates scheduled task with specified name, command, frequesncy that runs on behalf of specified user (user account is optionally created and added to specified group).

#### Syntax

~~~
CreateScheduledTask [-taskName] <String> [-command] <String> [[-frequencyHours] <Int32>] [[-userName] <String>] [[-grou pName] <String>] [[-password] <String>] [[-createUser] <Boolean>] [-delayHours <Int32>] [-delayMinutes <Int32>] [-delet eExisting <Boolean>] [<CommonParameters>]
~~~

### Function DeleteScheduledTask

Deletes Scheduled Windows task. If user on behalf of which name scheduled task is running exists and specifyed it will be also deleted.

#### Syntax

~~~
DeleteScheduledTask [[-taskName] <String>] [[-userName] <String>] [<CommonParameters>]
~~~

### Function ScheduledTaskExists

Checks if scheduled task with specified name exists on local computer.

#### Syntax

~~~
ScheduledTaskExists [[-taskName] <String>] [<CommonParameters>]
~~~

#### Return Value

$True if scheduled task exists, $False if it doesn't exist

* * *

## File win\Services.ps1

Functions dealing with Windows services.

### Function RestartService

Restarts service snd checks if it's restarted within specified timeout.

#### Syntax

~~~
RestartService [[-serviceName] <String>] [[-timeOutSec] <Int32>] [<CommonParameters>]
~~~

#### Return Value

$True or $False.

### Function StartService

Starts service snd checks if it's started within specified timeout.

#### Syntax

~~~
StartService [[-serviceName] <String>] [[-timeOutSec] <Int32>] [<CommonParameters>]
~~~

#### Return Value

$True or $False.

### Function StopService

Stops service snd checks if it's stopped within specified timeout.

#### Syntax

~~~
StopService [[-serviceName] <String>] [[-timeOutSec] <Int32>] [<CommonParameters>]
~~~

#### Return Value

$True or $False.

* * *

## File win\Users.ps1

Functions to deal with users and groups.

### Function CreateUser

Creates user on local computer and puts it into specifyed group.

#### Syntax

~~~
CreateUser [[-userName] <String>] [[-groupName] <String>] [[-password] <String>] [<CommonParameters>]
~~~

### Function DeleteUser

Deletes Specifyed user.

#### Syntax

~~~
DeleteUser [[-userName] <String>] [<CommonParameters>]
~~~

### Function UserExists

Checks if specifued user exists on computer.

#### Syntax

~~~
UserExists [[-userName] <String>] [<CommonParameters>]
~~~

#### Return Value

$True if user exists, $False if it doesn't exist

* * *

## File win\Version.ps1

Helper functions to get Windows version and bitness.

### Function GetOSType

This function gets type of operating system.

#### Syntax

~~~
GetOSType [<CommonParameters>]
~~~

#### Return Value

Hashtable @{"type" = <version>; "Architecture" = <bitness>}

### Function Is32Bit

This function checks if operating system is 32 bit.

#### Syntax

~~~
Is32Bit [<CommonParameters>]
~~~

#### Return Value

$True or $False.

### Function Is64Bit

This function checks if operating system is 64 bit.

#### Syntax

~~~
Is64Bit [<CommonParameters>]
~~~

#### Return Value

$True or $False.

### Function IsServer2003

This function checks if operating system is Windows Server 2003.

#### Syntax

~~~
IsServer2003 [<CommonParameters>]
~~~

#### Return Value

$True or $False.

### Function IsServer2008

This function checks if operating system is Windows Server 2008.

#### Syntax

~~~
IsServer2008 [<CommonParameters>]
~~~

#### Return Value

$True or $False.

### Function IsServer2008R2

This function checks if operating system is Windows Server 2008R2.

#### Syntax

~~~
IsServer2008R2 [<CommonParameters>]
~~~

#### Return Value

$True or $False.

### Function IsServer2012

This function checks if operating system is Windows Server 2012.

#### Syntax

~~~
IsServer2012 [<CommonParameters>]
~~~

#### Return Value

$True or $False.
