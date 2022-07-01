######
#!/bin/sh
find . -type f -name "*" -exec perl -pi -e 's/\r/\n/g' \{\} \;
#######
