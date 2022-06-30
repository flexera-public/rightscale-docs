---
title: Developing RightScripts - Tutorial
layout: cm_layout
description: In this RightScale tutorial we cover creating a basic RightScript, layering on complexity using Inputs, and developing more advanced RightScripts.
---
The focus of this section is understanding and developing RightScripts, not Chef Cookbooks. Although many of our ServerTemplates come with fully functioning RightScripts (that we encourage using "as is"), we realize the need for customization or even writing your own from scratch. If you can work through this tutorial from end to end, you will have a solid foundation for developing your own RightScripts.<br>
In this tutorial we cover creating a basic RightScript, layering on complexity using *Inputs*, and developing more advanced RightScripts touching on most of the features used within the Dashboard. Several best practices are also covered along the way.

## Prerequisites

An operational Linux based Server and basic understanding of bash scripting. The examples in this tutorial use the Unix shell (bash), but you could develop similar scripts in a different scripting language. (For example, Perl, Ruby, or a different shell such as Bourne, csh or ksh.)

### Create a Basic RightScript

* Go to **Design** > **RightScripts** > **New**
* Fill out the following fields:
  * **Name** - Hello World
  * **Description** - Fill out a basic description
  * **Script** - Use the following example to start your basic Hello World RightScript
  * **Packages** - OK to leave this blank

~~~
    #!/bin/bash -ex
    echo "Hello World!"
    exit 0 # Graceful exit
~~~

* Click the **Save** action button when ready
* *Tip*: If any of this does not make sense, see the Dashboard Help Text.

You now have the most basic of RightScripts. This RightScript can be added to a ServerTemplate and run in any one of the three phases (boot, operational or decommission). More on this later...

### Add a Standard Environment Input

Recall that Inputs are environment variables in all CAPS that are parsed out of RightScripts. Before adding one, test the Identify action button.

* Click the **Edit** action button for the RightScript you saved earlier
* Click the **Identify** action button. You should receive a message similar to the following:

There are no environment variables in the script.

* Run your RightScript
  * From your running Server's Script tab, select the Any Script pull-down
  * Select your Hello World script from the "private RightScript" drop-down
  * Click the **Run Script** action button
  * Monitor progress in your Events pane
  * You can look at the Audit Entries. (Nothing too interesting yet.)
* Add the following echo statement just before your "exit 0" statement. In the Bash example below, FIRSTNAME is the input variable. The syntax

~~~
    echo "Nice to be here, my name is $FIRSTNAME"
~~~

* Proper syntax for declaring standard environment inputs:
  * Bash $MYINPUT
  * Perl $ENV{‘MYINPUT’}
  * Ruby ENV[‘MYINPUT’]
  * Powershell $env:MYINPUT
  * Python environ[‘MYINPUT’]
     * Also place $MYINPUT (i.e. the Python variable name with a leading dollar sign) in a comment so the Identify action below will discover the input.
* Select the **Identify** action button. This will force a parsing of the RightScript. The Input, FIRSTNAME, should be identified.
  * Enter a basic Description of your Input. (e.g. First name of the user)
  * Leave the Value Type as the default "any"
* Save your changes and run your RightScript again
  * This time, you should be asked for a value for the FIRSTNAME Input. Enter your name as text then click the **Continue** action button.
  * View the audit entries for this run. You should notice the correct value for FIRSTNAME displayed in the Audit Entries.

!!info*Tip:* During the development process, you will be spending a lot of time editing your RightScript, and then running it. You may want to use the Bookmark feature in the left window pane to bookmark the Scripts tab of your running Server.

### Add a Cloud Environment Input

This example uses AWS EC2 Input values.

* Open up a window and navigate to the RightScale Support Portal (/)
  * Navigate to **Cloud Management** > **Reference Information** > [Environment Inputs](/cm/ref/environment_inputs.html)
  * Read over the type of environment information you have access to within a RightScript
* Add the following lines to your RightScript (again, place them just prior to the "exit 0" statement) *Note*: Feel free to use different Cloud Inputs that interest you.

~~~
    echo "Instance Size: $EC2_INSTANCE_TYPE"
    echo "Public IP addr: $EC2_PUBLIC_IPV4"
~~~

* Run your RightScript again
* View your Audit Entries. The "success" entry should have something like this, with valid values for EC2 Environment Inputs:

~~~
    ********************************************************************************
    *RS> Running RightScript <GD: Hello World> ****
    *RS> script starting at: Mon May 10 19:59:45 -0400 2010
    + echo 'Hello World!'
    Hello World!
    + echo 'Nice to be here, my name is GregDoe'
    Nice to be here, my name is GregDoe
    + echo 'Instance Size: m1.small'
    Instance Size: m1.small
    + echo 'Public IP addr: 184.73.100.71'
    Public IP addr: 184.73.100.71
    + exit 0
    *RS> script duration: 0.005064 seconds
~~~

### Add a RightScale Environment Input

* View the RightScale [Environment Inputs](/cm/ref/environment_inputs.html) further down in the same Support Portal document. Read the footnote. Notice that RS_SERVER_NAME, RS_DEPLOYMENT_NAME and RS_SERVER_TEMPLATE_NAME *are not* directly accessible on your running instance (like other RS and EC2 environment Inputs are). For example, if you simply echo or evaluate any of these three Inputs you will get null values. However, you can use the following example in order to access this important environment information.
* Click the **Edit** action button for your Hello World RIghtScript
* Add the following line to the script (just above the "exit 0" statement)

~~~
    echo "RightScale Server Name: $RS_SERVER_NAME"
~~~

* Click the **Identify** action button and fill out a basic description for your new Input
* Click the **Save** action button and then run your RightScript again. This time when the Inputs are flagged, for RSSERVERNAME select the following three choices from the drop-down menus:
  * Select Env in the drop down as the Input type
  * Select RS_SERVER_NAME as the RightScale environment Input to assign RSSERVERNAME to
  * Finally, select your Server name (from the list of all Servers in the Deployment)
* Click the **Continue** action button when ready to run your RightScript
* View the "success" Audit Entry for your RightScript run. You should see valid values for all of your environment Inputs. That is, for the standard, Cloud and RightScale Inputs you have created thus far in the tutorial.

Again, you would have seen a "null" value for RS_SERVER_NAME *unless* it was evaluated as part of a RightScript, which is accomplished by mapping a standard Input to an RightScale environment Input. The same behavior holds true for RS_DEPLOYMENT_NAME and RS_SERVER_TEMPLATE_NAME as well.

### Develop a More Practical and Advanced RightScript

In this part of the tutorial you will develop a more practical RightScript that checks port status, using various types of Inputs. You will also learn more about RightScript descriptions (which support Markdown) and Input descriptions.

!!info*Note:* This section of the tutorial is less verbose, unless covering a new step that merits additional explanation. Refer to the Basic RightScript section if you forget any step details.

!!info*Tip:* Until now, we have developed the RightScript within the RightScale Dashboard. Those familiar with a Unix editor such as vi may want to develop RightScripts by SSHing into the instance and working through the development process there. (Or SSH into the instance and use that in concert with development straight in the Dashboard.) Use what process works best for you, but be careful not to get confused if you let your RightScripts get out of sync with each other (instance version versus the Dashboard version).

!!warning*Important!* If you do any development on the instance itself (for example, creating and working in /tmp/test.sh) if you terminate the instance your work will be lost. Make sure you save anything you need by transferring the file elsewhere, or copy/pasting into a RightScript within the Dashboard.

### Create the Basics of a RightScript

* Create a new RightScript named "Port State Checker" (or something similar).
* Add the following to the RightScript body:

~~~
    #!/bin/bash -ex
    echo ""
    lsof -P -i | grep -i "$STATE"
    echo "Done (port state)."
    exit 0
~~~

* Run the RightScript, setting the Input STATE to "listen" when you run it. This will instruct the script to display all port connections in a listen state.
* As always, check the Audit Entries to observe what happens during the run.

### Add a Credential Verification Check

Recall that Credentials are essentially secure key/value pairs stored within the RightScale Dashboard (database).

Now you will create a new Credential in the RightScale Credential store, and verify against that credential before the core of your port checker RightScript is executed.

* Create a new Credential called "MYCREDS" in the RightScale Credential store. Note whatever you set the MYCREDS value to. (In our example, it is set to "GregDoe".)
* Add to your RightScript so it now looks similar to the following:

~~~
    #!/bin/bash -ex
    echo ""
    if ["$MYCREDS" = "GregDoe"]
    then
       echo "Credentials validated. Port states are:"
       lsof -P -i | grep -i "$STATE"
       echo "Done (port state)."
       exit 0 # Graceful exit
    fi
    echo ">>> Credential AUTHORIZATION FAILED! <<<"
    exit 1 # Ungraceful exit, Credential check failed
~~~

!!info*Note:* If the Credential check fails the RightScript will exit. If it passes, the port status is displayed.

* Run the RightScript again
  * For MYCREDS, select CRED as the Input type. Select the Credential you created earlier (e.g. MYCREDS)
  * Set the STATE to "listen" again
  * Select the **Continue** action button to run the RightScript
* The success Audit Entry should include a line stating "Credentials validated" along with output from the lsof command.
* To test that your Credential Input validation is indeed working  
  * Run the RightScript again. This time, fill out a valid STATE (e.g. "listen"), but enter an incorrect Credential or type in something incorrect.
  * The Audit Entry should reveal: ">>> Credential AUTHORIZATION FAILED! <<<"

### Use a RightScript Attachment to Configure the Port number

First, lets simply add the port logic and hard code the port number to check for. Once satisfied, we'll create a configuration file, attach it to our script so it gets its port value from an external file when the script runs.

* Add the following two lines of code to your RightScript above the "exit 0" statement in the code block where the Credential validation succeeded:

~~~
    lsof -P -i | grep $PORT
    echo "Done (port connection status)."
~~~

* Run your RightScript again  
  * Fill out the MYCREDS and STATE with correct values like you did before.
  * For PORT, enter an integer. For example, enter 22 to see if sshd is listening on port 22, or 25 to see if there is an SMTP process listening on standard SMTP port 25.
  * You should see two valid executions of lsof, the first for the state, the second for a specific port number.

Assuming all has gone well, you are now ready to include the port number to check connection status on as a value in a RightScript Attachment.

* Create a standard text file on your local computer.
  * Name it "port.conf"
  * Add the contents "22" to the file. You will check for SSH port 22 the next time you run the RightScript.
  * Close and save the file.
* Navigate to the Attachments tab of your port status RightScript
  * **Browse** to your "port.conf" file and **upload** it
  * Select the **pencil** action icon to verify your uploaded configuration file has the correct contents in it
* Modify the contents of your RightScript.
  * First, either delete or comment out the hardcoding of the lsof that checks for the port status. (That is, delete or prepend a "#" to the line: "# lsof -P -i |grep $PORT"
  * Add the following code snippet in its place (previous lsof) and re-run your RightScript.

~~~
    port=$(<"$RS_ATTACH_DIR"/port.conf)
    echo Port "$port" connection status:
    lsof -P -i | grep :"$port" | grep -i "$STATE"
~~~

This will assign the value "22" from your attached port.conf file to the variable "port", and parse out any and all occurrences of ":22" in the output of your lsof command.

!!warning*Important!* Notice that the first part of this section uses $PORT in your RightScript. Later, that is replaced with $port, which is read in from an external file attachment. RightScript Input naming conventions mandate Inputs be in all CAPS. Hence $PORT is an Input and you will be prompted for a value when you run the RightScript. Later, when reading the value for "port" from the port.conf file, you will not be prompted for a value. "port" is simply a variable in your RightScript, that is populated from an external file, not an actual RightScript Input.

### Summary

This may not be the most helpful RightScript ever written, but layer upon layer it touches most of the main points you must learn in order to develop RightScripts, work with various types of Inputs, Credentials and Attachments. Of course the example configuration file was as basic as it could be, but it could have been a more complex configuration file, or perhaps an Apache httpd.conf file that you run sed against in order to change a default configuration setting, etc. Read the Post Tutorial Steps for a list of additional tasks you may want to perform in order to continue your learning curve.

## Post Tutorial Steps

The focus of this tutorial was to touch on many areas with respect to *developing* RightScripts and learning more about how they work. Once you have finished active development, there are several post tutorial steps described below that are considered *best practice*.

!!info*Note:* In addition to the method of defining inputs mentioned here, there are also [RightScript Metadata Comments](/cm/dashboard/design/rightscripts/rightscripts_metadata_comments.html) which allow you to fully specify the RightScript Inputs, their default values, type, and other settings with in the script itself. This is useful if you want to store your RightScript outside of RightScale in your own source control system such as Git or Subversion.

### Make Your RightScript Reboot Safe

RightScripts that we publish in the MultiCloud Marketplace are considered "reboot safe". Towards the top of the script they contain a code block similar to the one shown below. To understand why this is important, note that if you reboot a Server and an installation/configuration script runs again, you can end up with undesired results. In most cases, you will want to make your scripts reboot safe.

!!info*Note:* Under most circumstances we consider it best practice to relaunch Servers rather than reboot them. In this instance, being reboot safe is moot.

~~~
    #
    # Test for a reboot, if this is a reboot just skip this script.
    #
    if test "$RS_REBOOT" = "true" ; then
        echo "Skip HTTPERF installation on REBOOT."
        logger -t RightScale "Skip HTTPERF installation on REBOOT."
        exit 0     # Leave with a smile ...
    fi
~~~

### Document Your RightScript and its Inputs

As a best practice, in addition to any in-line documentation, you should document the RightScript and any Inputs as well. Note that [markdown](http://en.wikipedia.org/wiki/Markdown) is supported, and is encourged to make your RightScript description more readable.

[Click here](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet) to see a good *cheat sheet* for common markdown syntax.

### Documenting the RightScript Description

* Navigate to the Info tab of your RightScript
* Click the **edit** action button
* The following is an example including a brief description of the scripts purpose, and a bulleted list of key Inputs:

~~~
    Purpose - Uses standard Unix utility lsof (list system open files) to check port state and connection status based on several supplied Inputs:
    * MYCREDS - If MYCREDS is not validated, then exit gracefully with a no-op.
    * STATE - User supplied standard Input to check all port states against.
    * port - Specific port to check status on. Note: port is a variable (not Input) supplied from within the attached configuration file.
~~~

* Click the **save** action button. The above example looks like the following in the Dashboard display:

![cm-rightscript-descriptions.png](/img/cm-rightscript-descriptions.png)

### Documenting the RightScript Inputs Description

* Navigate to the Script tab of your RightScript
* Click the **edit** action button
* Enter a Description for each of the identified Inputs. Whenever possible, include appropriate examples. Example descriptions:
  * MYCREDS - RightStore Credential store value to confirm before running script.
  * STATE \* - State of the port to check for. Examples: "listen" or "close_wait"
* Click the **save** action button when you are done

\* If you have a finite set of options for legal values, you can make the Input Value Type "drop-down" not "any". Then fill out all legal values for the Input.

The next time you run your RightScript, when filling out the missing Inputs, notice your Input description will be displayed when your mouse hovers over the blue information icon. (This is sometimes referred to as "hover text"). For example:

![cm-inputs-descriptions.png](/img/cm-inputs-descriptions.png)

### Turn Down Verbosity

Once your debugging efforts are complete, you may want to turn off the scripts verbosity. This trims up what is saved in your Audit Entries. Change the preamble so it does not contain the "-x" option to bash. For example:

~~~
\#!/bin/bash –e
~~~

!!info*Note:* The "-e" command line option to bash causes an exit if something goes wrong in a RightScript. This is generally considered a best practice, particularly with boot phase RightScripts. When a Server boots up and runs various installation and configuration RightScripts, if one fails miserably, it is best to exit than continue attempting to install other packages, modify configuration files, etc. You do have the option to force an non-operational Server to be Operational, and attempt to debug the boot phase RightScripts manually/iteratively.

### Rename Your RightScript

Name your RightScript something descriptive. For example, "Acme Co - Port State Checker" is better than simply "Port State".

### Add Your RightScript to a ServerTemplate

In this tutorial we developed several RightScripts from scratch. Although RightScripts can be used in "stand-alone" fasion, they are usually created to work within a ServerTemplate. Normally, you would add the RightScript to a ServerTemplate that is used to configure a Server or Servers in a Deployment, etc.

### Commit Your RightScript

Commit your RightScript. ServerTemplates and the RightScripts in them should be commited. Working on a HEAD revision is recommended only during development, and it is considered a best practice to use our version control capabilities. See the [ServerTemplate Versioning](/cm/dashboard/design/server_templates/servertemplates_concepts.html#servertemplate-versioning) section of our *ServerTemplate Developer Guide* for more information.
