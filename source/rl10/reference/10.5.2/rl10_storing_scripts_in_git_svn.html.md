---
title: Storing Scripts in Git, Subversion, or other VCS
description: RightLink 10 RightScripts can be stored in a Git or SVN version control system instead of in the Design > RightScripts section of the RightScale Cloud Management Dashboard.
version_number: 10.5.2
versions:
  - name: 10.6.3
    link: /rl10/reference/10.6.3/rl10_storing_scripts_in_git_svn.html
  - name: 10.6.2
    link: /rl10/reference/10.6.2/rl10_storing_scripts_in_git_svn.html
  - name: 10.6.1
    link: /rl10/reference/10.6.1/rl10_storing_scripts_in_git_svn.html
  - name: 10.6.0
    link: /rl10/reference/10.6.0/rl10_storing_scripts_in_git_svn.html
  - name: 10.5.3
    link: /rl10/reference/10.5.3/rl10_storing_scripts_in_git_svn.html
  - name: 10.5.2
    link: /rl10/reference/10.5.2/rl10_storing_scripts_in_git_svn.html
  - name: 10.5.1
    link: /rl10/reference/10.5.1/rl10_storing_scripts_in_git_svn.html
---

## Overview

In addition to just storing RightScripts and ServerTemplates in the RightScale Cloud Management system, you may wish to
store them in your own version control system such as Git or Subversion. There are two methods of achieving this:

* Using the [Right ST] tool to push RightScripts or whole ServerTemplates into the RightScale CM system
* Laying out your Git or Subversion repository like a Chef cookbook and using RightScale's "repository fetcher"

The [Right ST] tool method is recommended because it is both simpler and more flexible.

[Right ST]: https://github.com/rightscale/right_st

## Right ST Tool Method

[Right ST] is an open source tool maintained by RightScale's RightLink team. We provide [pre-compiled binaries] for
Linux, Mac OS X, and Windows. Right ST works with scripts using [RightScript Metadata Comments] and thus supports
specifying default and possible values for inputs supporting all RightScale input types. It also supports specifying
attachments in the metadata comments and will use file checksums to determine if a file needs to be uploaded to the
platform when uploading.

Right ST is a command line tool so it can be used directly as part of the development process, in a shell script, as
part of a post-commit hook, or in a continuous integration system such as [Travis CI], [AppVeyor], or [Jenkins].

[Travis CI]: https://travis-ci.org/
[AppVeyor]: https://www.appveyor.com/
[Jenkins]: https://jenkins-ci.org/

### RightScript Usage

You can read about Right ST's support for RightScripts in its documentation for [Managing RightScripts]. The RightScript
related commands are:

[Managing RightScripts]: https://github.com/rightscale/right_st#managing-rightscripts

```
right_st rightscript show <name|href|id>
  Show a single RightScript and its attachments.

right_st rightscript upload [<flags>] <path>...
  Upload a RightScript
  Flags:
    -f, --force: Force upload of RightScript despite lack of Metadata comments
    -x, --prefix: Append a prefix to RightScript's name when uploading. For
                  creating dev/test versions of scripts.

right_st rightscript download <name|href|id> [<path>]
  Download a RightScript to a file. Metadata comments will automatically be
   inserted into RightScripts that don't have it.

right_st rightscript scaffold [<flags>] <path>...
  Add RightScript YAML metadata comments to a file or files

right_st rightscript validate <path>...
  Validate RightScript YAML metadata comments in a file or files
```

### ServerTemplate Usage

You can read about Right ST's support for ServerTemplates in its documentation for [Managing ServerTemplates]. The
ServerTemplate related commands are:

[Managing ServerTemplates]: https://github.com/rightscale/right_st#managing-servertemplates

```
right_st st show <name|href|id>
  Show a single ServerTemplate

right_st st upload <path>...
  Upload a ServerTemplate specified by a YAML document
  Flags:
    -x, --prefix: Append a prefix to ServerTemplate and RightScript names when
                  uploading. For creating dev/test versions of ServerTemplates.

right_st st download <name|href|id> [<path>]
  Download a ServerTemplate and all associated RightScripts/Attachments to disk

right_st st validate <path>...
  Validate a ServerTemplate YAML document
```

[pre-compiled binaries]: https://github.com/rightscale/right_st#installation
[RightScript Metadata Comments]: /cm/dashboard/design/rightscripts/rightscripts_metadata_comments.html

## Chef Cookbook Style Method

RightLink 10 scripts ("RightScripts") can be stored in a Git or SVN version control system instead of in the **Design > RightScripts** section of the RightScale Cloud Management dashboard. The implementation hijacks the machinery originally built for Chef in the RightScale platform to support placing RightScripts into git (or svn) repositories and adding them to ServerTemplates (Note that RightLink 10 does not have any built-in support for true Chef cookbooks). The mechanics for using this are:

* place RightScripts into a git repository accessible by the RightScale platform
* create a metadata.rb file that describes the scripts in Chef terms so the RightScale's "repository fetcher" can index the content of the repository
* let RightScale fetch the repository
* drag the scripts into the ServerTemplate as if they were recipes
* let RightLink 10 do the rest

The quickest way to get started is to fork the [github](https://github.com/rightscale/rightlink_scripts) repository that contains the scripts for the base ServerTemplate. The README.md has most of the information you need.

### Repository structure

**Requirements/limitations**:

* the repository top-level must consist of cookbook directories (other directories are allowed, top-level cookbooks are not supported)
* each cookbook directory must have a metadata.rb file
* each cookbook directory must have all the RightScripts at the top-level (subdirectories may contain supplementary files)
* each RightScript must have a filename extension (such as .sh, .rb, .ps1, ...)
* for Linux, each RightScript must contain a "#! /path/to/executable" header (note the space between ! and /)

**Sample directory tree**:

  ~~~
  rightlink_scripts (repo)
  +- rll (cookbook)
  |   +- init.sh (recipe)
  |   +- collectd.sh (recipe)
  |   +- metadata.rb
  |   +- templates (directory)
  |       +- collectd.conf (random file)
  +- mysql (cookbook)
  |   +- metadata.rb
  |   +- install.sh (recipe)
  ...
  ~~~

#### Limitations on Cookbook Directories

* each cookbook directory must be stand-alone, that is, there must be no "../" type of references to "sister" cookbooks within scripts
* each cookbook directory and subtree is downloaded in its entirety, so templates or similar files can be placed anywhere
* all files are given read-write permissions and only recipes to be executed are given execute permissions, any additional necessary permissions must be set explicitly in a script (permissions set by checking files into git/svn are not honored)
* RightLink 10 will add execute permissions to RightScripts just before executing them

### Script Execution Environment

(see also RightLink 10 [Script Execution](rl10_script_execution.html))

* Scripts will be executed with the current working directory (CWD) set to the cookbook's directory (i.e. also the directory where the script lives)
* Scripts will be executed as the user that RightLink 10 runs as, typically root
* The script's environment variables will be set to include: HOME, SHELL, USER, PATH, client_id, account, and api_hostname, http_proxy, no_proxy, plus all global environment variables set in RightLink 10, plus all arguments specified in the metadata.rb for the script/recipe. The later sources in this list override prior sources if a variable is defined multiple times.

#### Metadata.rb

* The metadata.rb must follow enough of the Chef conventions to "pass" the RightScale metadata scraper to produce cookbooks, recipes, and attributes in the core
* the recipe statement must name the recipe without the filename extension (e.g. rll::init for the script called init.sh in the rll cookbook)
* the attributes must be of type string
* the default values may refer to environmental variables by using a value such as `env:RS_SKETCHY`
