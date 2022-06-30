# Using the markdown-to-word Conversion Utility

## Overview

The simple `markdown-to-word.rb` ruby script allows you to process a directory containing markdown files and convert them into MS Word files.

## Usage

1. Copy the directory containing the markdown files you want to convert into the same folder where the `markdown-to-word.rb` script resides.
2. Open a terminal session, navigate to the directory where the script is located and execute the following command:

~~~
ruby markdown-to-word.rb <directory name>
where <directory name> is the name of the directory you want to process.
~~~

The script will create a folder called `word-output` and deposit the converted files there.

## Notes:

* Links to image files will skipped and not converted if they are outside the directory being processed.
* Requires the [Pandoc](http://pandoc.org/) utility be installed on your system.
