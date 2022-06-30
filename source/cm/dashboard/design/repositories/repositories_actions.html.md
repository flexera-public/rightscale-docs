---
title: Repositories - Actions and Procedures
layout: cm_layout
description: Common procedures for working with Repositories in the RightScale Cloud Management Dashboard.
---

## Add a Repository

### Overview

This allows you to enter all the information necessary to add a new repository to your account.

### Steps

1. Go to **Design** > **Repositories**.
2. Select **Add Repository**.  
    ![cm-add-repository.png](/img/cm-add-repository.png)
3. A screen will display with the fields that define your repository information.  
    ![cm-add-repository-2.png](/img/cm-add-repository-2.png)  
4. Select the **Type** to choose the repository you would like to use. Select *just one* of the following depending on the repository you are using:
    * **Add a Git Repository**
    * **Add a Subversion Repository**
    * **Add a Compressed File** (this is for .tar, .gzip, and .tgz files that contain your cookbooks)
5. Once the information has been entered, click **OK**.
6. Once added, RightScale will fetch the information from the repository and the cookbooks from that repository will appear when you refresh the page.

!!info*Note:* If you notice the cookbooks are not appearing after a few minutes, you can click on the repository and go to the Info tab. The Last fetch output section will notify you if there were errors occurred during the fetch.

## Add a Compressed File to Repositories

### Overview

You can upload a compressed file of a cookbook to your Repositories section. As an example, if there is a cookbook that you see in RightScale, you can download it, and make changes to that file and upload it back to RightScale so you can use those cookbook recipes with a ServerTemplate.

### Prerequisites

* For additional information about adding repositories to RightScale, see the Add a Repository section above.

### Steps

When you select compressed file as the **Type**, you will need to enter the following information:

![cm-add-a-compressed-file-to-repository.png](/img/cm-add-a-compressed-file-to-repository.png)

* **Name** - The name that will display for your repository.
* **Description** - (Optional) The description for your repository.
* **Type** - This is the type of repository you would like to create. Select Subversion
* **URL** - The URL where the repository is located. In the example above, the compressed file is being pulled from an S3 bucket.
* **Username** - Select the username to access your compressed file. This is if you require a username and password combination to access the location of the file. You can use your credentials or you can enter the information. In the example above, since we're pulling from an S3 bucket, a credential that contains the AWS Access Key ID is being used.
* **Password** - Select the password to access your compressed file. This is if you require a username and password combination to access the location of the file. You can use your credentials or you can enter the information. In the example above, since we're pulling from an S3 bucket, a credential that contains the AWS Secret Access Key is being used.
* **Cookbooks Paths** - The path (URL) to the cookbooks in your compressed file. You can add multiple paths.
* **Automatically import cookbooks to the primary namespace** - This is checked automatically. When selected, it will automatically import your cookbooks into the primary namespace so you can easily attach them to your ServerTemplates.

## Add a Git Repository

### Overview

Git is a free, open source version control system. Git is a structured with a lot of repositories belonging to individual clients. This makes it easier to keep track of changes and allows users to keep track of their code locally without having to push code to an individual server.  
If you are using a git repository, you can add that repository and have RightScale fetch the cookbooks that are contained in that repository. If the git repository you are using is private, you will need to enter an SSH Key.  

!!info*Note:* Since GitHub is a widely used git web service, it is commonly used in documentation examples.

!!warning*Note:* Repositories only support the PEM key format. Newer versions of openssh generate keys in the RFC4716 format. Use `-m PEM` on the command-line with `ssh-keygen` to use the PEM key format.

### Prerequisites

* For additional information about adding repositories to RightScale, see the Add a Repository section above.

### Steps

When you select git as the **Type**, you will need to enter the following information:

![cm-add-a-git-repository.png](/img/cm-add-a-git-repository.png)

* **Name** - The name that will display for your repository.
* **Description** - (Optional) The description for your repository.
* **Type** - This is the type of repository you would like to create.
* **Tags/Branch** - The branch of the repository which contains the cookbooks.
* **URL** - The URL where the repository is located.
  * Examples
    * Public Repository: https://github.com/username/acme -or- https://github.com/username/acme.git
    * Private Repository: git@github.com/username/acme.git
* **Git SSH Key** - Select your Git SSH Key from the list of credentials, or enter a new SSH Key. If the repository you are connecting to is public, you do not need an SSH Key. Please see the note above about supported key formats.
* **Cookbooks Paths** - The path (URL) to the cookbooks in your repository. You can add multiple paths.

!!info*Note:* If your cookbooks are in the root of the repository, leave this field blank.

* **Automatically import cookbooks to the primary namespace** - This is checked automatically. When selected, it will automatically import your cookbooks into the primary namespace so you can easily attach them to your ServerTemplates.

## Add a Subversion (SVN) Repository

### Overview

Subversion (SVN), like git, is a version control system. But, unlike git, it is designed to be more centralized. So instead of having a repository for each client, there is one repository for a lot of clients. SVN is set up so users can track their own edits locally and then push those changes to a server.

### Prerequisites

* For additional information about adding repositories to RightScale, see the Add a Repository section above.

### Steps

When you select the subversion as **Type**, you will need to enter the following information:  

![cm-add-a-subversion-repository.png](/img/cm-add-a-subversion-repository.png)

* **Name** - The name that will display for your repository.
* **Description** - (Optional) The description for your repository.
* **Type** - This is the type of repository you would like to create. Select Subversion
* **Tags/Branch** - The branch of the repository which contains the cookbooks.
* **URL** - The URL where the repository is located.
* **Username** - Select the SVN username to access your repository from the list of credentials. You can also add a new username.
* **Password** - Select the SVN password to access your repository from the list of credentials. You can also add a new password.
* **Cookbooks Paths** - The path (URL) to the cookbooks in your repository. You can add multiple paths.

!!info*Note:* If your cookbooks are in the root of the repository, leave this field blank.

* **Automatically import cookbooks to the primary namespace** - This is checked automatically. When selected, it will automatically import your cookbooks into the primary namespace so you can easily attach them to your ServerTemplates.

## Edit a Repository

### Overview

Editing a repository allows you to modify various information about a repository, such as the repository type or location of the repository.

### Steps

1. Go go **Design** > **Repositories** and select the repository you would like to edit.
2. Go to the **Info** tab and click **Edit**.
![cm-edit-repository.png](/img/cm-edit-repository.png)
3. The fields you can edit depend the repository type you select. You can edit the following fields:
  * **Name** - The name of the repository.
  * **Description** - (Optional) A user-supplied description of the repository.
  * **Type** - The type of repository being added. RightScale supports git, svn or a compressed file (tgz, gzip, or tar).
  * **Tag/Branch** - (Git only) The branch of the repository which contains the cookbooks.
  * **Revision** - (Subversion only) The revision of the repository which contains the cookbooks.
  * **URL** - The URL where the repository is located.
  * **Git SSH Key** - (Git only) Select your Git SSH key from the list of credentials, or enter a new SSH key.
  * **Username** - (Subversion or compressed file) Select the username to access your repository from the list of credentials. You can also add a new username.
  * **Password** - (Subversion or compressed file) Select the password to access your repository from the list of credentials. You can also add a new password.
  * **Cookbook Paths** - The path (URL) to the cookbooks in your repository. You can add multiple paths.
4. Make the changes you would lick and click **Save**.

## Import Cookbooks from a Repository

### Overview

Importing a cookbook or cookbooks from a repository is a more granular and advanced way to import cookbooks into RightScale. From this view, you can see the name of all the cookbooks you are importing, the dependencies of the cookbooks, and select which namespace you would like to import to. You can also choose if you want to import dependencies.

!!info*Note:* You can have a cookbook automatically imported into your primary namespace with the Refetch and Import button.

### Steps

1. Go to **Design** > **Repositories**.
2. Click on a repository.
3. Select the cookbooks in the repository. From the **Action** drop-down, select Import.  
![cm-import-a-cookbook-repository.png](/img/cm-import-a-cookbook-repository.png)
4. From here you can choose to:
  * **Import to a Primary or Alternate namespace** - We recommend that if you use your own cookbooks that you import them to the primary namespace, but if you want to use an alternate namespace you can. When you select an alternate namespace, you can choose to follow the cookbook. When you follow a cookbook, the new or updated versions of that cookbook that are refetched into the repositories section will automatically get imported.
  * **Import Dependencies** - If the cookbook relies on other cookbooks to run recipes, they will have dependencies. You can select this option so the cookbooks that the other cookbooks rely on will be imported. If the dependencies are missing, you will not be able to import them.
5. When your options are selected, click **Import**.

## Refetch and Import a Repository

### Overview

Refetch and importing performs a scrape to see if any changes have been made to repository or repositories added to RightScale and then imports the cookbooks into a primary namespace. If you have recently made changes to cookbooks in a git or subversion repository that you added to RightScale, you can perform a refetch and import to get the repository information into RightScale so you can use your own recipes with ServerTemplates.

!!info*Note:* This is similar to the Refect a Repository procedure, but with this option you are automatically importing the cookbooks into a primary namespace.

### Steps

1. Go to **Design** > **Repositories**.
2. Select the repository or repositories you would like to refetch and import.
3. Select the **Actions** drop-down and click Refetch and Import.  
![cm-refetch-and-import.png](/img/cm-refetch-and-import.png)  
4. This will scrape your repositories for updated information and then import that information into the Cookbooks section. It may take a minute or two to complete. You can click on a repository, go to **Info** tab, and see the **Last fetch output** section to see if errors occurred during the fetch.
5. You can refresh the page or select the refresh icon next to **Add Repository** to update the page.
6. Once feteched, you can go to the Cookbooks section to see the cookbooks imported into RightScale. The cookbook will automatically be imported into a primary namespace.

## Refetch a Repository

### Overview

Refetching performs a scrape to see if any changes have been made to the source repository. If you have recently made changes to cookbooks in a git or subversion repository that you added to RightScale, you can use this option to update your repositories. You can either perform a **Refetch** to update the information or you can perform a **Refetch and Import** which will refetch your repository information and import your repository cookbooks into RightScale.

### Steps

1. Go to **Design** > **Repositories**.
2. Select the repository or repositories you would like to refetch.
3. Select the **Actions** drop-down and click Refetch.
![cm-refetch-a-repository.png](/img/cm-refetch-a-repository.png)
4. This will scrape your repositories for updated information. It may take a minute or two to complete. You can click on a repository, select the **Info** tab, and see the **Last fetch output** section to see if errors occurred during the fetch.
5. You can refresh the page or select the refresh icon next to **Add Repository** to update the page.
6. Once feteched, you can Import a Cookbook from a Repository as described above. This allows you to perform advanced options, such as importing your own cookbooks as alternate namespaces instead of primary namespaces.

## Remove a Repository

### Overview

You may want to clean-up a RightScale account by removing Repository objects that link to software repositories that you no longer use. However, if you decide to remove a Repository object, you will no longer be able to refetch cookbooks from the referenced software repository.

!!info*Note:* If you remove a Repository object none of the previously imported cookbooks from that repository will be removed.

### Prerequisites

* 'designer' user role privileges

### Steps

1. Go to **Design** > **Repositories**.
2. Select the repository or repositories you would like to remove.
3. Click the **Action** drop-down and select Remove.
![cm-remove-a-repository.png](/img/cm-remove-a-repository.png)  
4. A confirmation will appear asking if you want to remove the repository. When you remove a repository, it will not remove any of the cookbooks that were previously imported into the RightScale account.
5. Click **Ok**.

## View a Repository

### Overview

This allows you to view various information of your repository. Viewing a repository can helpful in seeing if a repository has successfully been added or refetched.

### Steps

1. Go to **Design** > **Repositories** and select your repository.
2. You will be taken to the **Cookbooks** tab and a list of all the cookbooks in the repository will display.
3. Click on the **Info** tab.  
![cm-view-repository.png](/img/cm-view-repository.png)
4. The information of the Repository will display:
  * **Name** - The name of the repository.
  * **Description** (optional) - A user-supplied description of the repository.
  * **Last fetched at (UCT)** - The time at which the repository was last fetched.
  * **Last fetched revision** - Revision of the repository that was last fetched.
  * **Last fetch output** - Additional details on the result of the last fetch.
  * **Type** - The type of repository being added. RightScale supports git, svn or a compressed file (tgz, gzip, or tar).
  * **Tag/Branch** - The branch of the repository which contains the cookbooks.
  * **URL** - The URL where the repository is located.
  * **Git SSH Key** - The Git SSH key to access your repository.
  * **Username** - The user name to access your repository. This field will not display if your repository is of type git.
  * **Password** - The password to access your repository. This field will not display if your repository is of type git.
  * **Cookbook Paths** - The path (URL) to the cookbooks in your repository. You can add multiple paths.
5. From this tab, you can edit, refetch, or refetch and import the repository. *Note*: You can see the same information in the right-navigation window when you select a repository from the repositories section (**Design** > **Repositories**).
