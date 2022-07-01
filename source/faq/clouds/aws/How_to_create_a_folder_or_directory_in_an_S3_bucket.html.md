---
title: How do I create a folder or directory in an S3 bucket?
category: aws
description: This article provides a couple different ways to create a new folder in an S3 Bucket.
---

## Background Information

I can upload files to my S3 bucket, but I can't figure out how to create new folders/directories inside of my S3 bucket so I can better organize items in my bucket.

* * *

## Answer

Currently, there is no "create new folder" button in the Dashboard's S3 Browser (Clouds -> AWS Global -> S3 Browser). However, there are a couple different ways to accomplish this task.

* Download a Firefox plug-in such as "S3 Fox" [Amazon S3 Firefox Organizer](https://aws.amazon.com/blogs/aws/s3fox_organizer/) (Firefox) to organize your S3 bucket and create subfolders.
* Move a dummy file in the Dashboard


### Move a dummy file in the Dashboard

The only way to create a new folder/directory within an S3 bucket is to move a dummy file to a directory that doesn't exist. When you move the file, the directory that you specified that didn't exist will be created.

### Steps

1. Navigate to your S3 bucket and upload a dummy file. The type of file/size does not matter. You simply need an item in your S3 bucket that you can move for the purposes of creating a new folder.
2. Select the dummy file (check the box) and select "Move" from the dropdown menu and click the **Apply** button.
3. In the destination path, specify the folder name (e.g. newfolder) that you would like to create. If you only specify the folder and do not include the dummy file, you will rename the dummy file ("test.png" will be renamed "newfolder" without a defined file type).
 ![faq-MoveItem.png](/img/faq-MoveItem.png)
4. Click Move. When you return to your S3 bucket, you will see the newly created folder with the dummy file inside.
5. Add other items to that folder. NOTE: You cannot delete the dummy file (so that the folder is empty) before adding new files. If an empty folder is present in your S3 bucket, it will not be shown in the Dashboard, however you will be able to see it in S3 Fox.
6. Delete the dummy file.

### Using S3Fox

If you create a new folder within an S3 bucket, you will need to add at least one file into the folder in order for the Dashboard to see it as a valid directory. If an empty folder is created, the Dashboard will display an odd reference file (Ex: NewFolderContent\_$folder$) until you add a file. Once you add a file into the new folder, the Dashboard will display it as a browseable directory.  Later you can delete the odd reference files.

![faq-NewFolderEmpty.png](/img/faq-NewFolderEmpty.png)
