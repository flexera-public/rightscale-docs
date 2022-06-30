# Using the fix-line-endings.sh Script

## Overview

All source files for the docs.rightscale.com project need to have linux-style line endings (\n) in order to function properly. In the event the line ending treatment for one or more source files gets inadvertently changed to a non-Linux style (i.e., Windows or Mac OSX), you can use the `fix-line-endings.sh` shell script to repair the lines endings and return them to proper Linux style.

## Usage

1. Copy the script and place it in the directory that contains the files that you want to convert line endings for.
2. Open a terminal session, navigate to the directory you wish to process and execute the script as follows: `./fix-line-endings.sh`

### Notes

* The script will recurse all subdirectories from it's current location.
* Currently will not handle filenames with spaces.
