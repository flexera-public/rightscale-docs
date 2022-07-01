---
title: How do I run Ruby or Python scripts on Windows servers?
category: general
description: By using RightScript Attachments, you can install and run scripts for other interpreters or binaries such as Ruby or Python.
---

## Background

You have one or more Ruby or Python scripts that you would like to run on RightScale-managed Windows Servers.

## Answer

By using RightScript Attachments, you can install and run scripts for other interpreters or binaries such as Ruby or Python.  
Create a RightScript and attach your Ruby or Python script as a standard attachment, then in your RightScript use a Powershell statement to run the attached script.

### Ruby Example

The script below will run the attached script, hello\_world.rb with Ruby, provided that the ruby binary is in PATH.

`Invoke-Expression "ruby $env:RS_ATTACH_DIR\hello_world.rb"`

### Python Example

Below is an example where you install Python in a specific location (PATH) and then run the attached Python script.

`[System.Environment]::SetEnvironmentVariable("PATH", "$env:path;C:\Python31", "machine")`
`Invoke-Expression "python $env:RS_ATTACH_DIR\hello_world.py"`
