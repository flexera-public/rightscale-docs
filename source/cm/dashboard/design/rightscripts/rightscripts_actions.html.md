---
title: RightScripts Actions
layout: cm_layout
description: Common procedures for working with RightScripts in the RightScale Cloud Management Dashboard.
---
## Add a RightScript or Recipe to a ServerTemplate

You have the ability to add RightScripts and recipes to ServerTemplates. In the API, RightScripts and recipes are viewed as the same object and referred to as "runnables".

### Prerequisites

* The 'designer' user role
* An editable ServerTemplate (a HEAD revision)

### Steps for Adding RightScripts

Use the following steps to add a RightScript to a ServerTemplate and place it in the proper sequence.

1. Go to **Design** > **ServerTemplates** and click the ServerTemplate that you are adding the RightScript to. You can use the "Filter by" search box to help if you have many ServerTemplates in the list.  
  ![cm-servertemplates.png](/img/cm-servertemplates.png)  
  *Hint*: Click the **Help** action button to toggle the context sensitive Help Text built into the RightScale Dashboard. The Help Text contains useful overview information to assist you wherever you are within the Dashboard. If you are not yet familiar with ServerTemplates and the MultiCloud Marketplace, please take a minute to read the Help Text.
2. Click the ServerTemplate's Scripts tab.  
RightScripts can be added to ServerTemplates as either a Boot Sequence, Operational, or Decommission Sequence scripts.
3. Click **Modify**. The Script Selection window opens.
  * Select **RightScripts**.
  * Find the RightScript that you want to add. Use the **Filter Recipes and RightScripts** field to narrow your search.
  * Drag and drop the desired RightScript into place in the desired category. You can drag RightScripts up or down in the list to change the order in which they will run.

![cm-drag-and-drop-scripts.png](/img/cm-drag-and-drop-scripts.png)

The RightScript is now listed with the other scripts of the same type (Boot Sequence, Operational, or Decomission Sequence).

!!info*Note:* Operational Scripts can be manually run when a server is operational, whereas Decommission Scripts are executed during the shutdown phase in order to provide a more graceful server termination.

### Steps for Adding Recipes

Use the following steps to add a recipe to a ServerTemplate and place it in the proper sequence.

1. Go to **Design** > **ServerTemplates** and click the ServerTemplate that you are adding the recipe to. You can use the "Filter by" search box to help if you have many ServerTemplates in the list. *Hint*: Click the **Help** action button to toggle the context sensitive Help Text built into the RightScale Dashboard. The Help Text contains useful overview information to assist you wherever you are within the Dashboard. If you are not yet familiar with ServerTemplates and the MultiCloud Marketplace, please take a minute to read the Help Text.  
  ![cm-servertemplates.png](/img/cm-servertemplates.png)
2. Click the ServerTemplate's Scripts tab.  
Recipes can be added to ServerTemplates as either an Operational Script, Boot or Decommission Sequence.
3. Click **Modify**. The Recipe Selection window appears in the right pane.
  * All the cookbooks that are attached to your ServerTemplate are listed. Select a cookbook to view its recipes. Then drag and drop recipes into the ServerTemplate. If the cookbook that you're looking for is not in the list, use the **Attach Cookbooks** button to view all the cookbooks in your account and select which cookbooks you would like to attach to the ServerTemplate so their recipes are available to add.

!!info*Note:* As always, you can only make these changes on a HEAD revision.

![cm-add-recipe-to-st.png](/img/cm-add-recipe-to-st.png)

The recipe is now listed with the others of the same type (boot, operational, or decommission).

!!info*Note:* Operational Scripts can be manually run when a server is operational, whereas Decommission Sequence recipes are executed during the shutdown phase in order to provide a more graceful server termination.

## Clone a RightScript

You can clone a RightScript so that it becomes your own (Private) RightScript that you can customize to suit your needs. Note that you cannot edit a committed revision of a RightScript. You must clone it in order to create an editable version under **Design** > **RightScripts**.

### Steps

* Go to **Design** > **RightScripts**. Select one of the available RightScripts that you would like to clone.
* When you click the **Clone** action button, an editable copy (HEAD version) of that RightScript will be created.
* You may notice a warning message that the cloned object will have its usage reported to RightScale. This message is meant to convey the fact that RightScale is able to track the lineage of an object even if it's cloned.

By default, the version of a RightScript will be incremented. For example, if you clone "Script v8" the new cloned version will be named "Script v9". Therefore, we recommend changing the name of the RightScript to help better distinguish the cloned script from its ancestor. Under the Info tab, notice that we always show where a script was cloned from.

![cm-clone-rightscript.png](/img/cm-clone-rightscript.png)

## Create a New RightScript

RightScripts, along with the role they play in ServerTemplates are in many ways the heart of the RightScale Cloud Management Platform. Customers and Partners are free to use our RightScripts "as is", clone and customize existing RightScripts to suit their specific needs, or create new RightScripts from scratch. This tutorial shows you how to create a basic RightScript.

### Steps

* Go to **Design** > **RightScripts** and click **New**.

![cm-new-rightscript.png](/img/cm-new-rightscript.png)

Provide the following information:

* **Name** - A short nickname that helps you recognize the script.
* **Description** - Describe the purpose of the script and any required inputs parameters that need to be defined. The description field is optional and does not affect the script's behavior.
* **Packages** - A space-separated list of packages to install on the server. (ex: "mysql-server mysql-devel perl-DBD-MySQL mysqlclient14") At boot time, the package lists of all RightScripts attached to the server are linked together and installed in one invocation of the package manager (typically yum).
* **Inputs** - A RightScript can be parameterized by specifying a number of inputs that need to be provided to the script for its operation. These inputs can come from a number of sources: user, server template, meta-data about the server or other servers, and the credentials attached to the account. The inputs are passed to the script as environment variables.
  * **Identify** - Click the Identify button to detect any environment variables that were declared in the Script field below. For Linux, all references of the form **$ALL_CAPS** are automatically identified as potential input parameters. For Windows, all references of the form **$env:ALL_CAPS** are automatically identified as potential input parameters.
* **Script** - The script is typically a Bash, Perl, Ruby or Powershell script. It's best to keep the code short. Long and complex programs should be defined as an attachment and placed into a library. If the script starts with '#!' the named executable will be invoked (standard Unix convention). For Windows, Powershell will be used. In Linux, if no '#!' is provided, then "/bin/bash -e" is used. Note that scripts should signal a failure by using a non-zero exit code, which will stop the application and cause the server to be marked as "stranded" in the server state. Any subsequent scripts that are supposed to be executed after the current script (in the case of boot or decommission scripts) will not be executed so that an operator can take corrective action. Be sure to the check the server's audit entries to troubleshoot a script that failed to execute.

## Create Reboot-safe RightScripts

In the RightScale Dashboard, you can manually reboot an active server by selecting Reboot from the **More actions** drop-down (*ServerName* > **More actions** > **Reboot**). In order for your servers to reboot properly, you need to make sure that your scripts are configured correctly. We are working hard to make sure that all of our RightScripts are reboot-safe. However, you are responsible for ensuring that your own custom scripts are reboot-safe. Follow the instructions below to make sure that your own RightScripts reboot-safe.

### Things to Consider

* You cannot "patch" a program twice; it may not work if it's patched on reboot.
* Most scripts that use mkdir to create a directory will fail the second time if you forget the -p option.
* Updates on REBOOT are up to you and your application because you may want to skip updates when you reboot a server.
* Database restores are not needed if the information was on /mnt because this data is automatically remounted on REBOOT.

As you can see, there are several details associated with performing a successful reboot.

To help you make sure that your RightScripts are reboot-safe, we've provided a template below that you can follow as an example.

### Example: Reboot-safe RightScript

~~~
    #!/bin/bash
    #
    # Description:
    #
    # Simple BASH RightScript that skips a portion of the code on REBOOT
    #

    #
    # This code runs each time the server Boots or REBOOTS
    #
    set # Display all of the Environment Variables to the Audit file

    #
    # Test for a reboot, if this is a reboot just skip this script.
    #
    if test "$RS_REBOOT" = "true" ; then
      echo "Skip Example script on reboot."
      logger -t ExampleScript "Skip Example script on reboot."
      exit 0 # Leave with a smile ...
    fi

    #
    # This portion of the RightScript runs only on first Launch boot.
    #
    date
    echo "This server just launched for the first time"
    logger -t ExampleScript "This server just launched for the first time"

    exit 0 # Leave with a smile...
~~~

### Example Breakdown

Now we'll explain all of the features of this script above:

~~~
    #/bin/bash
~~~

* Informs the shell that is is a BASH script

~~~
    set
~~~

* Displays all of the Environment Variables to the Audit FIle in the RightScale Dashboard and on the server in the `/var/log/install` file. This is a nice way to see which variables you need to work with in your scripts.

!!warning*Warning!* Remember that any code you "yum" install may add or delete variables later. For example, when java is installed, it adds several variables to the environment.

~~~
    if test "$RS_REBOOT" = "true" ; then
      echo "Skip Example script on reboot."
      logger -t ExampleScript "Skip Example script on reboot."
      exit 0 # Leave with a smile ...
    fi
~~~

* This short bash code example will exit the script at this point in the code when it's run for the second time on REBOOT. You could also place code inside the "if" for scripts that ONLY run on reboot.

~~~
    logger -t Example "your text here"
~~~

* The "logger" program adds lines of text to the `/var/log/messages` file and sends them to the RightScale Dashboard. The "-t" token helps you "grep" for these lines. Be sure to make it unique.

~~~
    exit 0 # Leave with a smile...
~~~

* Never leave the exit code to chance. This last line in every script sets the value to "good" or "operational." Some Linux commands leave behind a value in "$?" that can give you problems. The "Leave with a smile..." line is just for fun.

### Ruby Example

In your ruby scripts, the following example will provide a way to skip code that should not be done on reboot.

~~~
    if ENV['RS_REBOOT'] == 'true'
      system("logger -t ExampleScript Skipping Yada yada yada.")
      exit(0) # Leave with a smile ...
    end
~~~

## Declare an Environment Variable in a RightScript

A RightScript can be parameterized by specifying a number of inputs that need to be provided to the script for its successful operation. Proper syntax for declaring standard environment variable inputs will vary depending on the type of scripting language.

!!warning*Warning:* If a script contains [RightScript Metadata Comments](/cm/dashboard/design/rightscripts/rightscripts_metadata_comments.html), this input detection will not work and the input definitions in the comments will be used instead.

| Language | Environment Variable Declaration |
| -------- | -------------------------------- |
| Bash | $MYINPUT |
| Perl | $ENV{‘MYINPUT’} |  
| Ruby | ENV[‘MYINPUT’] |
| Python | environ[‘MYINPUT’] |  
| Powershell | $env:MYINPUT<br> Because Powershell variable names are not case sensitive, you can use all lower case letters to prevent system environment variables from being identified as user-defined inputs. (e.g. $env:my_sys_input) |

### Steps

* Go to the **Scripts** tab of an editable (HEAD) RightScript.

Based on the language of the script, use the appropriate syntax format for declaring your environment variable. Remember to provide a helpful description for each environment variable that's identified. A few examples are shown below.

#### Bash

~~~
    #!/bin/bash -ex
    echo "Hello my name is $FIRST_NAME"
~~~

#### Perl

~~~
    #! /usr/bin/perl
    print "Hi my name is $ENV{‘FIRST_NAME’}";
~~~

## Diff RightScripts

The Dashboard supports a versioning feature for RightScripts that allows for the comparison of different RightScript revisions. When a diff is performed it will not only compare the code body itself, but also the descriptions, attachments, and Inputs.

#### Common Uses for Diff

* Compare two different revisions of the same RightScript. ex: RightScript-A [rev 1] vs. RightScript-A [rev 2] -or- RightScript-A [rev 1] vs. RightScript-A [HEAD]
* Compare two arbitrary RightScripts. ex: RightScript-A vs. RightScript-B

#### Common Scenario

Let's say you decide to use a published RightScript that you imported from the MultiCloud Marketplace in one of your Server Templates. In order to customize this RightScript to fit your needs you must first clone it. After making any necessary changes to your private copy, you add it to your Server Template. A few weeks later, a RightScale engineer publishes a new revision of the original RightScript that includes an additional security feature. You want to see what has changed between your customized copy and the newly released revision. After reviewing the changes, you then decide to incorporate them into your script. Your customized RightScript is now up-to-date with what RightScale currently provides.  

### Steps

To compare two RightScripts, go to **Design** > **RightScripts**. Select the revision in the History bar that you want to perform a diff from and click the Diff button.

The next window allows you to select which script you would like to compare against. You can select any RightScript that you want, including any revision of that script. By default, the Dashboard will display the previous revision(s) of the script (if available). If you perform a diff from the HEAD version of a script and there are no previously committed revisions, its parent RightScript (that it was cloned from) and its revisions will be selectable. In this example, we will compare the customized draft with the original version to see what has changed. Additionally, this functionality can be used to compare two arbitrary scripts by selecting them from the dropdown menus.

Click the **Diff** button.

![cm-diff-rightscript.png](/img/cm-diff-rightscript.png)

Results are displayed that highlight all of the changes between the two scripts.

Colored highlights denote the sections that changed. After inspecting the changes, you may close the window.

## Edit RightScript Attachments

You can edit RightScript attachments directly from within the Dashboard for performing quick edits and modifications. This feature is especially helpful for making small changes and fixes to simple text files that are attached to your RightScripts. You should only edit simple text files (e.g. config files) or scripts.

### Prerequisites

* A RightScript that has a text based attachment

### Steps

1. Under the Attachments tab of a RightScript, click the Edit icon.  
  ![cm-edit-attachment.png](/img/cm-edit-attachment.png)  
2. The built-in text editor will allow you to make simple changes to the attachment.  
  ![cm-edit-attachment-code.png](/img/cm-edit-attachment-code.png)  
3. Remember to press the **save** action button to save your edits. *Note*: A new md5sum is generated each time you save a change.

!!info*Note:* There is no validation for your edits, so you should always test your changes. For example, if you edit an HTML file attachment, the HTML code will not be checked for any syntax errors.

## Pass Expected Input to Ruby RightScripts

In some instances, the booting of a Server may hang if any commands executed within a boot script expect Input from the user. For instance, if your svn server requires a user to manually accept an SSL certificate for any reason (i.e. if you have a cert for www.oursite.com, but your SVN URL is svn.oursite.com), the RB rails svn code update & db config RightScript will hang with the following message:

~~~
Error validating server certificate for 'https://svn.oursite.com:443':<br>  - The certificate hostname does not match.<br> Certificate information:<br>  - Hostname: www.oursite.com<br>  - Valid: from Feb 12 00:00:00 2008 GMT until Feb 17 23:59:59 2009 GMT<br>  - Issuer: www.digicert.com, DigiCert Inc, US<br>  - Fingerprint: 3c:c5:u3:83:46:87:fc:7e:14:47:30:c9:1d:49:83:f7:fd:eb:kf:9e<br> (R)eject or accept (t)emporarily?
~~~

### Prerequisites

This procedure uses the Ruby "expect" package, so it will not work for other scripting languages such as bash.

### Steps

Since many RightScripts are written in Ruby, we can utilize the Ruby [expect](http://svn.ruby-lang.org/repos/ruby/trunk/ext/pty/) package to both detect these prompts and pass input to them. We first need to determine which RightScript is hanging on boot. Go to **Manage** > **Servers** and click on the name of one of the Servers that has stopped booting. Then click on the **Audit Entries** tab and click on the name of the last script to run successfully. At the bottom of the audit entry you should see lines that look like this:

~~~
* script completed successfully
>>>>> NEXT: RightScript <RB rails svn code update & db config v3>
~~~

If there is no audit entry regarding the **RB rails svn code update & db config script** (or whatever script happens to be hanging), then that script is most likely causing the error. Now click on the **SSH Console** button and type the following at the prompt:

~~~
$ tail /var/log/install. [PRESS TAB AND THEN RETURN]
~~~

You should now see the offending prompt at the bottom of the file (as in the svn example at the top of the article). Now we know what we need to automate.

Following with the svn example, we will need to clone the **RB rails svn code update & db config** script in order to alter it. Navigate to **Manage** > **Deployments** and click on the name of the deployment that is giving you trouble. From this screen, click on the name of one of the offending servers. Click on the Actions tab for the server and find the name of the hanging script. From the script page, click on the Clone button. Now navigate to **Design** > **RightScripts** and click on the name of the script you've just cloned. Be sure to click on its title at the top of the page and add '(clone)' to the end of its name so you can later recognize that this is a clone of an official RightScript. Now click the Edit link and let's get to work.

This is the part that's going to require a bit of digging. We need to determine which part of script is making the call to svn checkout. In our example, this can be found in the following section of code:

~~~
res=`svn #{auth_params} --quiet co #{ENV['SVN_APP_REPOSITORY']} #{canonicalized_app_dir}`
~~~

This is making the 'svn co' call that we are interested in. We need to refactor this section thusly:

~~~
    require 'pty'

    PTY.spawn("svn #{auth_params} --quiet co #{ENV['SVN_APP_REPOSITORY']} #{canonicalized_app_dir}") do |r_f,w_f,pid|
      w_f.sync = true

      $expect_verbose = false

      # Instruct SVN to accept the SVN cert temporarily.
      r_f.expect("(R)eject or accept (t)emporarily?") do
        w_f.print("t\n")
        begin
          while(line = r_f.gets)
            puts line
          end
        rescue
          puts "SVN checkout completed successfully."
        end
      end
    end
~~~

If you dig through the [expect documentation](http://svn.ruby-lang.org/repos/ruby/trunk/ext/pty/) a bit, you'll see that the call to `PTY.spawn` opens a PTY and executes the specified command. The block gives us access to three variables:

* **r_f**: read from the terminal
* **w_f**: write to the terminal (with w_f.puts)
* **pid**: the process id of the command

After executing the command, we make a call to `r_f.expect`, which takes either a string or a regex as an argument representing the prompt that we are looking for. When the prompt is reached, we pass the 't' option with a call to `w_f.print`. The `begin...rescue...end` block merely prints the output of the command, thus waiting for the checkout command to finish.

Now we need to associate this script with the appropriate server template. Navigate to **Design** > **ServerTemplates**, and click on the name of the appropriate template ('Rails FrontEnd v1 clone', in this example). Click on the **Scripts** tab. Scroll to the bottom of the page and add the private RightScript that we just created ('RB rails svn code update & db config v1 (clone)') as a boot script. Now delete any Rails FrontEnd instances in your deployment and replace them with new instances of your template to make sure that the RightScript is updated (be sure to reset the DNS_ID appropriately for each new instance).

Now drag the script to just below the original in the list of the boot scripts, and delete the original. Restart the servers, cross your fingers, and wait. Hopefully, you should be all set up.

## Publish and Share a RightScript

Typically RightScripts are published and shared in the context of a ServerTemplate, however they can be published and shared individually. You can only publish a private component that was originally created in your RightScale account. (i.e. It was either created from scratch or cloned.) You cannot publish a component that you imported from the MultiCloud Marketplace (MCM). A particular version can only be published once.

!!info*Note:* Although you can publish a HEAD version, it's not a recommended best practice unless you're an advanced user that's actively developing and testing it across multiple RightScale accounts. It's recommended that you only publish and share committed revisions of a component.

### Prerequisites

* 'publisher' user role privileges

### Steps

1. Navigate to **Design** > **RightScripts** in the CM Dashboard.
2. Select the RightScript that you want to share.
3. Select the committed revision that you want to share in the History Timeline Bar. (e.g. Rev 1)
4. Click the **Publish to MultiCloud Marketplace** action button. For details on how to use the publishing wizard to complete the sharing process.

## Run a RightScript on a Server

One of the more common tasks when managing a running server is modifying its Inputs and then executing (running) a RightScript that passes the new Input parameters to the server. You also have the ability to run a RunScript on multiple servers at the deployment level.

A RightScript can be run at different levels:

* **Server** - Run a script on a single running server
* **Deployment** - Run a script on multiple/all running servers in a deployment
* **Server Array** - Run a script on the oldest server or all servers in the array

A RightScript can either be run automatically or manually:

* **automatically** - Boot and decommission scripts are run in sequential order when a server is launched or terminated, respectively. A RightScript can also be executed using the 'run_rightscript' action of an Alert Escalation when an alert is triggered.
* **manually** - There are several different ways to manually execute a script (on-demand) on a running server.
  * Run a boot/operational/decommission script
  * Run a RightScript using the 'Any Script' option
  * Run a RightScript from the command line ('rs_run_right_script')

Notes: You cannot run a RightScript on an inactive or "stranded" server. You can only run a RightScript on an instance that was launched using the ServerTemplates model.

### Prerequisites

An operational instance that was launched and configured with a ServerTemplate.

### Steps

#### Run a boot/operational/decommission script

Any script listed under the boot/operational/decomission script list can be manually run on-demand.Go to a running server's Scripts tab. (Manage -> Servers -> Active tab)

Execute (run) one of the listed boot/operational/decommission RightScripts by clicking the 'Run' action icon. A server will inherit its list of available RightScripts from its ServerTemplate.

![cm-run-rightscript.png](/img/cm-run-rightscript.png)

You can track the status of the executed action under the server's Audit Entries tab.

#### Run a RightScript using the 'Any Script' option

You also have the ability to use the 'Any Script' option to run any RightScript in the RightScale account on the running server that is not listed in its ServerTemplate.

#### Run a RightScript from the command line ('rs_run_right_script')

You can also SSH into an instance and run a RightScript from the command line of a server using the 'rs_run_right_script' command, although it is not a recommended best practice. This option may be useful for users who are developing or testing RightScripts or ServerTemplates, but it should only be performed by advanced users.

!!info*Note:* If you use rs_run_right_script with the -p option, you must pass a COMPLETE set of input values in which case the input values that are defined on the server are not merged. If you omit any inputs, e.g. do not use -p, then the values defined on the server are used. However we do not provide a way to mix and match

You can SSH into an instance and run the following command to manually run a script.

!!info*Note:* You will only be able to run a script that is currently listed in the server's ServerTemplate. You cannot use this command to run any script in the RightScale account.

~~~
    # rs_run_right_script --name 'WEB Apache (re)start - 11H1'"
~~~

One of the problems with using this option to run a script is that a complete audit entry will not be generated. When a script is run using this method an audit entry is created and displayed in the dashboard, however the user who executed the script cannot be absolutely identified. Notice in the example screenshot below that the user who executed the script from the command line is listed as N/A.

![cm-run-rightscript-audit-entry.png](/img/cm-run-rightscript-audit-entry.png)

You might argue that the user who ran the script is obviously the last person to SSH into the server, however it is possible to SSH into an instance outside of the RightScale system especially if a user has the right authentication information and the instance's firewall permissions are not set up to prevent it. Therefore, in such cases it's often impossible to positively identify who actually ran the script.

Remember, one of the key benefits of using the RightScale cloud management platform is that fact that user actions are properly tracked and recorded. Therefore, as a best practice you should always perform manual actions from within the dashboard so that all user actions can be properly tracked and recorded.

## Run a RightScript on Multiple Servers

There may be situations where you want to run the same RightScript on more than one running server in a Deployment. Instead of going to each server and running the same operational RightScript manually, you now have the ability to run the same script on all operational servers from one window.

### Prerequisites

Multiple running Server instances in the same Deployment that use the same RightScript.

### Steps

* Go to **Manage** > **Deployments** and select a Deployment.

* Click the Scripts tab. Find the RightScript that you would like to run on multiple Servers and click the Run action icon.

!!info*Note:* If no instances are running, you will see an info icon instead of a run icon.

![cm-run-rightscript-deployment.png](/img/cm-run-rightscript-deployment.png)

Next, you will see a list of all active servers in your Deployment that use the selected RightScript. Put a checkmark next to each server that you would like to run the RightScript on and click the Run Script action link.

![cm-run-rightscript-deployment-select.png](/img/cm-run-rightscript-deployment-select.png)

## Search RightScripts

The **Search** action button (Design -> RightScripts) allows you to specify a pattern to match against throughout many RightScripts. For example, perhaps you are working on your own RightScript and are having difficulties with using "curl" or are considering using "wget" instead. You can search through all of the imported RightScripts for example usages of the curl utility. The Steps below use this example to help explain how this feature works.

### Steps

#### Search for

You enter the search criteria in the "Search for" field:

* Alphanumeric text pattern to match against
* The search is case-sensitive
* Wild cards and regular expressions are *not* supported
* The content of the RightScripts themselves is searched, *not* the names of the RightScripts (use the filter by name feature)

#### Search in

The "Search in" field allows you to expand or contract the category of RightScripts you search within. Simply check which of the script types you want to search in (multiple checkboxes are supported).

* Private (default)
* Imported

![cm-search-rightscript.png](/img/cm-search-rightscript.png)

#### Output

The output of your search is displayed in a separate window. It is pretty self explanatory, but here are a few more points for clarity sake:

* A summary of how many scripts and matches found and displayed at the top

~~~
    Found a total of 11 script(s) containing "curl"  
    Displaying 11 script(s), 11 matching line(s) and 11 occurence(s)
~~~

* The pattern match is highlighted in red

~~~
    res=`curl -S -s -o - -f https://www.dnsmadeeasy.com/servlet/updateip?username=$DNSMADEEASY_USER\&password=$DNSMADEEASY_PASSWORD\&id=$DNS_ID\&ip=$ipaddr`
~~~

* Although there is no context included in the output (e.g. lines above and/or below the matched line), the line number is included, as well as a hyperlink to view the script itself. *Hint*: Right click the script hyperlink and you can open it up in a new window, or a new tab

* If your pattern is matched many times, not all occurrences will necessarily be displayed. Once the 10th match is recorded, the search is completed for the current line, and then it moves on looking for matches in the next RightScript.

## Update Imported RightScripts

You can compare and/or import a newer revision of a RightScript that is available in the MultiCloud Marketplace (MCM). If you are using a RightScript that was imported from the MultiCloud Marketplace (or a slightly modified version that you created by cloning it), you may want to update the RightScript when a newer revision becomes available in the MCM.

### Prerequisites

* 'designer' user role privileges
* 'library' user role privileges are required to import a newer revision from the MCM.

### Steps

The steps required to update an imported ServerTemplate, RightScript, or MultiCloud Image are very similar.

!!info*Note:* The most common way to import the most recent revision of a RightScript is from the context of a ServerTemplate.

## Update RightScripts across Multiple ServerTemplates

You can update RightScript revisions for multiple ServerTemplates (HEAD versions) at a time. The Update Xref tab cross-references and displays all cases were the RightScript is being used by ServerTemplates. You have the ability to view all ServerTemplates using the HEAD version of this RightScript and select which ServerTemplates you would like to updated to which revision of the RightScript.

### Steps

* Navigate to Design > ServerTemplates.
* Select a ServerTemplate.
* Select a RightScript you would like to update. RightScripts with newer revisions available will be highlighted in orange.

![cm-update-rightscript.png](/img/cm-update-rightscript.png)

* After selecting a RightScript, click the 'Update Xref' tab.

![cm-update-rightscript-xref.png](/img/cm-update-rightscript-xref.png)

* Shown are all the ServerTeamplates using this RightScript. Select the ServerTemplates where you wish to update the RightScript. You have the option of selecting 'All shown'.

* Click **Update Selected** and the following window will appear:

![cm-update-rightscript-revision.png](/img/cm-update-rightscript-revision.png)

* Shown are the ServerTemplates you selected that are using this RightScript. Select a revision for RightScript to update.
* Click **Update.**

## Update to latest RightScripts in a ServerTemplate

You can update RightScripts to newer versions within a HEAD ServerTemplate. Upon completion of this procedure, you should:

* Know how to recognize when there are newer RightScripts available for your ServerTemplate
* Update the version of the RightScript within the ServerTemplate, on either a individual or group (e.g. all newer RightScripts) basis

If you are modifying a ServerTemplate, you may want to update its list of RightScripts to use the most recent committed revisions of those scripts. To help you know when a newer revision is available, colored notification balls are displayed. If a newer committed revision of a RightScript is available within the RightScale account or in the MultiCloud Marketplace (MCM), a yellow-orange sphere icon will appear next to the script under the HEAD ServerTemplate's Scripts tab.

It's your responsibility to determine whether or not you should update the highlighted RightScripts.

Orange ball notifications are only displayed if a newer committed revision of a RightScript (with the same lineage) is available. If a RightScript is cloned, it's a new object with a different lineage. The diagram below demonstrates the most common user scenarios.

![cm-update-rightscripts.png](/img/cm-update-rightscripts.png)

Depending on which RightScript revision a ServerTemplate is currently using, the following script notifications will be shown.

| **Which RightScript is in the HEAD ServerTemplate?** | **Conditions** | **Notification Results** |
| ---------------------------------------------------- | -------------- | ------------------------ |
| Rev 7 | Rev 9 is not available in the MultiCloud Marketplace | No icons |
| Rev 7 | Rev 9 is available in the MultiCloud Marketplace | Orange icon |
| Rev 1 | Rev 2 is available | Orange icon |
| Rev 2 | No newer committed revision is available | No icons |

### Prerequisites

The following are prerequisites for completing this tutorial:

* You should know how to run a diff (comparison) on RightScripts
* You should know how to commit RightScripts
* 'designer' user role privileges

### Steps

#### Navigate to one of your ServerTemplates

* Go to **Design** > **ServerTemplates** > *[ServerTemplateName]* > Scripts tab
* Go to the editable HEAD version of the ServerTemplate. If no HEAD version exists, you can clone it to create an editable copy.

#### Check for newer versions

Under the **Scripts** tab of a HEAD version of a ServerTemplate, you may see yellow sphere icons, which denote that a newer revision of that script is available. RightScale will check within your RightScale account for a newer revision as well as in the MultiCloud Marketplace. The yellow sphere icons are only designed to serve as a notification. If a RightScript has a higlighted rev number in orange, it does not mean that you must update its revision. The actual content of the scripts is *not* checked, just the revision numbers. The orange highlight will only be displayed for HEAD versions of a ServerTemplate and not committed revisions because only HEAD versions are editable.

![cm-orange-diff-rightscript.png](/img/cm-orange-diff-rightscript.png)

If you click on the icon, you will perform a differential (diff) between the current revision and the most recently committed revision that's available. Use the diff to compare the differences between the two revisions to determine whether or not you want to update the script to a different revision. In the example below, the differences between the revisions are highlighted for your convenience.

![cm-view-diff.png](/img/cm-view-diff.png)

Next, you will need to determine whether or not you want to update the current RightScript revision.

#### Update RightScripts within a ServerTemplate

Once you have performed a differential between the two RightScripts and determined that you want to update the revision of a RightScript revision, you can update a single RightScript by clicking the highlighted rev for the RightScript and select the RightScript you would like to update to.

![cm-update-rightscript-rev.png](/img/cm-update-rightscript-rev.png)

## Upload an Attachment to a RightScript

You can upload a file as an attachment to a RightScript. Attachments to a RightScript can be conveniently called by the script's code using an 'RS_ATTACH_DIR' environment variable.

### Prerequisites

* "Designer" user role
* Editable HEAD RightScript

### Steps

Go to **Design** > **RightScripts**. Select the RightScript to which you're going to attach a file. Under the **Attachments** tab of a HEAD version, click the **Choose File** action button. (If you do not see a HEAD version of the script, you will need to clone it to create an editable copy.)

Select the file from your local directory and click **Upload**.

 ![cm-upload-attachment.png](/img/cm-upload-attachment.png)
