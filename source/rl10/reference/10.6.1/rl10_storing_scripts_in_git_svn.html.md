---
title: Storing Scripts in Git, Subversion, or other VCS
description: RightLink 10 RightScripts can be stored in a Git or SVN version control system instead of in the Design > RightScripts section of the RightScale Cloud Management Dashboard.
version_number: 10.6.1
versions:
  - name: 10.6.4
    link: /rl10/reference/10.6.4/rl10_storing_scripts_in_git_svn.html
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
store them in your own version control system such as Git or Subversion. The easiest way to achieve this is using the
[Right ST] tool. This tool simplifies pushing RightScripts or whole ServerTemplates into the RightScale CM system.

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

