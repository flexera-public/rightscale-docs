---
title: Tips for Using API Examples
layout: general.slim
---

This document contains helpful tips and tricks that are global in nature, applying to most every API 1.5 example. Although the examples in this document are Unix shell specific, the principles apply in general as well.

_**Disclaimer:**_  Although [OAuth](/api/api_1.5_examples/oauth.html) is preferred for production environments, the _Examples_ section of the RightScale API Guide uses primarily standard user/pass authentication for simplicity sake.

## General Information

### Example Formats

The top of each API example provides an actionable page table of contents (TOC) that lists the specific example formats available.

- **Shell/curl** - Ideal for learning, exploring and quick tests. (Unix users.)
- **right_api_client** - RightScale developed Ruby API client that is easy to use, and often preferred by Ruby developers.
- **PowerShell** - Ideal for learning, exploring and quick tests. (Windows Users)
- **POST** MAN - Chrome browser plugin is a more graphical, visual tool. Ideal for those who have little to no development experience.
- **Supplemental** - Some examples may contain a _Supplemental_ section. Supplemental information is typically a filter, view, or simply additional thoughts for triggering new ideas.

### API Endpoints and Redirects

If you make an API call to an endpoint that doesn't match that of the account you're operating on, you may receive a 301 Redirect response.

**Important!**_  Be sure to use the correct API endpoint in accord with your account when using the API. If your Account is located in US-3, then you use US-3 API endpoint. Same applies when your account is in US-4.

### Obtaining Account and Other (non Cloud Resource) Information

When learning and exploring using the API, the simplest way to obtain resource ID's for account, deployment, servers, etc. is simply to log into the RightScale Dashboard and navigate about gaining information of interest from the URL. For example, navigating to the Info tab of an operational server within one of your deployments, your URL will look similar to:

https://us-3.rightscale.com/acct/**411**/servers/**527725001**

From this example URL you know that:

- Account ID is **411**
- Server ID is **527725001**

### Obtaining Cloud Resource Information

_**Important!**_ Some information must be queried from the API, you cannot discover it by navigating in the Dashboard. _All_ Cloud resource information is this way. That is, _don't_ use the URL information when navigating to **Clouds > _CloudName_ > _CloudResource_** (where _CloudResource_ is any resource supported by that cloud, such as Instances, Instance Types, Security Groups, etc.) Cloud resource ID's must be obtained from the API. Either write your own API calls, or use/leverage the various examples provided in this guide. (_Note_: See List Deployments, List Servers, List Inputs, etc.)

### Using Multiple Accounts and Session Cookies

Because the API is account based, not user based, you can establish multiple sessions for more than one account at a time. For example, if your RightScale User ( [gregdoe@example.com](mailto:gregdoe@example.com)) has been invited to several accounts (such as Test with account ID 1234 and Dev with account ID 5678), you can establish a session with each account, at the same time. For example:

- Authenticate with the Test account and save your session cookie in a file: mycookie.1234
- Authenticate with the Dev account and save your session cookie in a file : mycookie.5678
- Then run various scripts specifying the correct version of "mycookie" and setting your environment variables appropriately, etc.
- The output from your API requests will reflect the specified account. For example, the Deployment Listing will show all deployments for either the Test or Dev accounts, depending on the session cookie used.

See the [Authentication](/api/api_1.5_examples/authentication.html) example for more information.

### JSON Viewer

If you have difficulties viewing the response back directly, you will find the XML format more readable. However, if testing JSON format you can copy/paste the response and view using the following web based JSON viewing tool: [http://jsonviewer.stack.hu/](http://jsonviewer.stack.hu/)

- Copy the JSON output from the RightScale API
- Visit the [jsonviewer](http://jsonviewer.stack.hu/) website
- Paste the JSON into the **Text** tab (everything including and in between the begin/end square brackets "[" . . . "]")
- Switch to the **Viewer** tab
- Expand and view as needed...

**Note** : There are many JSON viewers freely available on the web. This one is listed as a matter of example only. Use which ever one you like the most. For example, if you have a new enough version of Python installed (2.6 or newer), you can try formatting the text based output of your shell script based on Python's JSON toolkit/library:

~~~
    YourAPIscript | python -mjson.tool
~~~

## Curl

### Help Pages

_Tip_: Don't forget the manual pages! If not familiar with any Unix commands contained in this document, most every Unix/Linux installation includes "manual pages". For example, if interested in setting up an optional alias for the "curl" command (discussed below), yet you are unfamiliar with the alias command, try the following command to learn more: **man alias**

Similarly, to learn more about the "curl" command used in so many examples, type: **man curl**

### Authenticating and (optionally) Setting up a Curl Alias

Remember you must be authenticated first before using the API. Many might find it useful to authenticate, save the authentication cookie in a file (such as "mycookie") then setting an alias for the curl command. For example:

- [Authenticate](/api/api_1.5_examples/authentication.html) and save your cookie
- Set an alias for "curl" when using API 1.5 similar to the command shown below. (_Note_: Setting up an alias is _optional_.)

~~~
    alias mycurl='curl -i -H X_API_VERSION:1.5 -b mycookie -X'
~~~

- Then use the alias similar to:

~~~
    mycurl GET https://us-3.rightscale.com/api/...
~~~

**Notes:**

- The TTL (time to live) for a session cookie is 2 hours. If your authentication expires, you will get HTTP "403 Forbidden" error and a message "Session cookie is expired or invalid".
- There are different ways to set up and implement an alias. You can set it up in each script and simply use the alias, or set it up in your Unix shell environment and export it such that is is "known" to all of your scripts. Details depend on personal preferences and what shell you are using.

### Curl Examples

Curl examples are wrapped in a basic Unix shell script which includes environment variables for specifying critical information, such as account, deployment and server numbers. Feel free to copy, paste and set environment variable values tied to your cloud assets. Its an easy entry point for using the RightScale API. For example (after authentication saved a cookie to the file "mycookie"), list all Servers within a specific Deployment:

~~~
    #!/bin/sh -e

    DEPLOYMENT="123456789" # Set the Deployment to "12346789"



    curl -i -H X_API_VERSION:1.5 -b mycookie -X GET https://us-3.rightscale.com/api/deployments/$DEPLOYMENT/servers
~~~

You can copy, paste, and set your own value for the DEPLOYMENT variable. From there, experiment with different filters, views, etc. by manipulating the URL in accord with the [API 1.5 Reference](http://reference.rightscale.com/api1.5/index.html) information.

### Response Format

By default, output is JSON. Add a ".xml" suffix to the URL in your request for XML output. Example URL:

~~~
    GET https://us-3.rightscale.com/api/deployments.xml
~~~

Follow this simple trick for an easy method to switch back and forth between XML and JSON format. Don't specify either ".xml" or ".json" in your URL, rather append "$1" to the end of the URL string in your script. For example the URL from the previous example above:

~~~
    GET https://us-3.rightscale.com/api/deployments$1
~~~

Then invoke the script ('myscript') with or without a command line parameter specifying the output type you want. For example:

~~~
    $ myscript # Will default to JSON output

    $ myscript .json # Also JSON output, explicit in the URL based on the command line parameter ($1)

    $ myscript .xml # Output in XML format
~~~

## right_api_client

### Installing right_api_client

Basic installation instructions for the RightScale REST API client (right_api_client).

~~~
    # sudo -i # switch to root user for installing the Ruby gem

    # gem install right_api_client

    Building native extensions. This could take a while...

    Successfully installed json-1.7.3

    Successfully installed mime-types-1.18

    Successfully installed rest-client-1.6.7

    Successfully installed right_api_client-1.5.9

    4 gems installed

    Installing ri documentation for json-1.7.3...

    Installing ri documentation for mime-types-1.18...

    Installing ri documentation for rest-client-1.6.7...

    Installing ri documentation for right_api_client-1.5.9...

    Installing RDoc documentation for json-1.7.3...

    Installing RDoc documentation for mime-types-1.18...

    Installing RDoc documentation for rest-client-1.6.7...

    Installing RDoc documentation for right_api_client-1.5.9...



    $ exit # logout from root user, create/run ruby scripts using right_api_client from a non-root user login.
~~~

**Note** : make sure you have the appropriate server permissions to perform these actions. For more information, see [Server Login Control](/cm/rs101/server_login_control.html).

#### Installation on Mac OSX

When installing the right_api_client on Mac OSX, it also installs the rest-client gem. This gem includes "ruby extents" which is low level code written in 'C' language to interface with time-critical functions in the host OS (such as networking). The 'extent' code is compiled during installation through calls to the 'make' and 'gcc' commands from the command line by the installation package.

For this reason, installation on Mac OSX will commonly fail. The solution is to download XCode from the Apple Developer site, however this does not install the XCode Command Line Tools, which are also needed. In order to download the XCode Command Line Tools, you will need to:

1. Create an account at <a nocheck href="[https://developer.apple.com">https://developer.apple.com</a> and login to that account
2. Navigate to the free Apple Developer download center. This can usually be found here:
  - <a nocheck href="https://developer.apple.com/downloads/index.action">https://developer.apple.com/downloads/index.action</a>
3. Once you land there, filter by the term 'xcode' to locate the XCode Command Line Tools for your particular version of XCode and/or OSX:

![api_apple_xcode_cltools.png](/img/api_apple_xcode_cltools.png)

Once these command line tools are downloaded and installed, the right_api_client gem should now successfully install.

### Logging

There are two ways to setup logging when using the right_api_client.

1. Log to a file
2. Log to STDOUT (Standard output. That is, log to the screen)

When logging to a specified file, simply add a line similar to the following after creating your client object:

`@client.log('/tmp/right_api_client.log')`

In the [List Servers right_api_client example](/api/api_1.5_examples/servers.html), placing this line after the "@client = RightApi::Client.new . . . " line results in HTTP response information being logged to the /tmp/right_api_client.log file. (Assuming you have permissions to write to the /tmp directory.) Example output after runing the List Servers script:

~~~
RestClient.get " [https://us-3.rightscale.com/api/servers](https://us-3.rightscale.com/api/servers)", "Accept"=>"application/json",
"Accept-Encoding"=>"gzip, deflate",  
"Cookie"=>"_session_id=deadbeef0badf00dfeedfacec0ffee24; domain=.rightscale.com; rs_gbl=eNo1kEFvgAARBYW . . . ", "X_API_VERSION"=>"1.5" # => 200 OK | application/vnd.rightscale.server+json 254379 bytes
 ~~~

_Note_: Above output truncated and partially formatted for readability.

To log to standard output, a slightly different line of code is placed below the "@client = RightAPI . . . " call. For example:

`@client.log(STDOUT)`

## PowerShell

### Getting Started

Using Windows PowerShell is another excellent way to learn and explore using the RightScale API. Its best suited for those familiar with Windows or don't have access to a Linux box (and don't wish to spin one up in the cloud in order to get started using the RS API). In some ways its like the "Windows" equivalent of the http/curl Linux examples - Get started using the API quickly without requiring additional installations. In other ways, its a bit more like the right_api_client. Authentication is closer related to the right_api_client than http/curl, and PowerShell is a more full-featured object oriented language, unlike Unix shell scripts.

Windows PowerShell ships native to the 32-bit (x86) and 64-bit operating system from Windows 2008 and on. It can be installed on some earlier versions of Windows 2003 as well. Select one of the following in order to start Windows PowerShell.

For 64-bit Windows operating systems:

1. **Command line based** - Start > All Programs > Accessories > Windows PowerShell > **Windows PowerShell**
2. **GUI (Integrated Scripting Environment (ISE))** - Start > All Programs > Accessories > Windows PowerShell > **Windows PowerShell ISE**

For 32-bit Windows operating systems:

1. **Command line based** - Start > All Programs > Accessories > Windows PowerShell > **Windows PowerShell (x86)**
2. **GUI** - Start > All Programs > Accessories > Windows PowerShell > **Windows PowerShell ISE (x86)**

_**Important!**_ Although you can invoke the x86 version on a 64-bit Windows installation, when running PowerShell scripts you may receive incorrect responses and errors, including ugly timeouts. (It could appear that the API is non-responsive when actually it is fully operational.)

_Note_: From a PowerShell window you can also start the ISE by simply typing: ise

### Getting Help

- PowerShell Window (text based help), type: get-help
- PowerShell ISE (Windows compiled help format): F1 _or_ Help > Windows PowerShell Help

### Authentication

Authentication credentials are stored in an in-memory container for subsequent use. (Note this is different than when using http/curl which saves credentials in a cookie file.) You can include authentication explicitly within each of your PowerShell scripts. However, those learning and exploring on the fly will find this basic method helpful:

- Invoke the PowerShell ISE
- [Authenticate](/api/api_1.5_examples/authentication.html) (in one tab)
- Use a additional tabs (^N) to create and explore other API operations. Additional tabs will not need to authenticate because the first tab properly authenticated and the credentials are used for subsequent API requests.

### Checking a Variable or Authentication

It can be helpful for troubleshooting efforts to check the value of a variable in your PowerShell script. For example, to make sure authentication related variables are "set" correctly. As a quick check, for the email setting on your Authentication script, type in the ISE bottom window:

~~~
    PS C:\Users\GregD> $emailgreg.doe@example.com
~~~

Similarly, to check your in-memory authentication container:

~~~
    PS C:\Users\GregD> $cookieContainerCapacity Count MaxCookieSize PerDomainCapacity

    -------- ----- ------------- -----------------

    300 2 4096 20
~~~

_**Important!**_ If the "Count" is zero, authentication has failed hence subsequent API invocations will fail too. In the above example, the Count correctly equals two.

### Script Execution and Security

Once you have a working tab you can save that as a PowerShell script. For example, save your Authentication, List Clouds, etc. as scripts so you can use them again without having to determine account numbers, deployment ID's, ... Simply click the disk icon in the upper left and save the .ps1 file with a descriptive name.

Important! If you do save PowerShell scripts to your local drive and then try to run them, you will receive a security related error similar to the following:

~~~
    PS C:\Users\GregDoe> C:\Users\GregDoe\...\RS API PowerShell\Auth.ps1

    File C:\Users\GregDoe\...\RS API PowerShell\Auth.ps1 cannot be loaded because the execution of scripts is disabled

    on this system. Please see "get-help about_signing" for more details.

    At line:0 char:0
~~~

Issue the "get-help about_signing" command from your PowerShell window which details how to set privileges such that you can run your script one time, many times, etc.

_Note_: As a work-around, you can simply copy/paste the contents of your script into a new tab (^N) and execute that.

## Postman

Postman is a free Google Chrome browser plugin. This is the easiest way to get started learning the RightScale API, especially suited for those with little to no development experience, who are more "visual" learners. With Postman, a basic understanding of the RightScale platform and the online reference documentation you can get started using our API!

## Common HTTP Errors

Although HTTP errors are not specific to a specific operating system or API format, most of the following are more likely to occur when running under Linux... hence that is the context provided in the examples.

### Unprocessible Entity

Wrong cloud! Don't forget, API 1.5 supports non EC2 clouds only! If trying to query cloud assets in AWS EC2 you will get a response similar to:

~~~
    HTTP/1.1 422 Unprocessable Entity

    . . .

    UnsupportedResource: The current api version does not support resources belonging to aws cloud
~~~

### Unauthorized

When authenticating, if using a shell script with a basic variable for your user password and it includes a "$" it will get interpreted by the shell and produce undesired results (HTTP 401 Unauthorized). However, you can escape the meaning of the "$" by preceding it with a "\". For example, if your password is literally "John$Doe":

~~~
    PASS="John$Doe" # Will fail later in the script when trying to authenticate via your curl command

    PASS="John\$Doe" # Will work in subsequent curl command when using variable substitution for $PASS.
~~~

### Internal Server Error

Although a HTTP 500 Internal Server error can mean many things, some of which requiring reaching Support at RightScale.com, there is a benign circumstance that is easily remedied that can result in this error. For example, similar to the Unauthorized section above, a "$%" sign in your password will cause this error as the variable substitution in the shell thinks you are attempting to work with job control (background/foreground jobs). You can attempt to fix this by preceding both characters with a "\" (e.g. "\$\%") or making sure the special characters are not run together. (_Note_: Password generators can run these characters together, resulting with the HTTP 500 error if the password is not changed or characters escaped correctly.)

### Permission Denied

"Permission Denied" when running a script means it does not have executable permissions set on the file. When creating various scripts to run against the API, its common to forget to set the script so it is executable. If its not executable you will receive a "Permission denied" message. For example, use the change mode (chmod) command to configure proper permissions before you run a Unix shell script named 'myscript':

~~~
    chmod 755 myscript
~~~

Then re-run your script and it should execute fine. (_Note_: The command "ls -l" shows a long listing of all files in the current directory. A long listing includes (r)ead, (w)rite and e(x)ecute permissions for the owner, group and world (everybody else) on each file.)

_Tip_: The above chmod command uses a binary format to set the permissions on the 'myscript' file so it is executable. Some may prefer to use a different format. For example: $ chmod +x myscript To learn more about chmod: $ man chmod

### Command not Found

Another common mistake is trying to run your script when the current directory is not in your executable path. If the command "echo $PATH" does not show a "." in it you need to either add it or run your script and include the current directly implicitly. For example:

~~~
    ./myscript
~~~
