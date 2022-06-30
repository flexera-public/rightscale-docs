---
title: Example memory_buffers collectd exec plugin
layout: cm_layout
description: Here is an example of a memory_buffers collectd exec plugin for the RightScale Cloud Management Platform.
---

The following custom collectd exec plugin uses Bash and the used/free buffers values from the Linux command, `free`.

### RightScript: Install memory_buffers collectd plugin

Create a RightScript with the following code and ensure that you set SERVER_UUID as an input with a dropdown default value of RS_INSTANCE_UUID.

~~~
#!/bin/bash -e



interval=20



# Determine the collectd plugin path, based on the architecture of the machine.

collectd_dir="/usr/lib/collectd"

["$(uname -m)" == "x86_64"] && collectd_dir="/usr/lib64/collectd"



# Create the plugin directory if needed, and copy the script into it.

mkdir -p "$collectd_dir"/plugins

cp -f "$RS_ATTACH_DIR"/memory_buffers.bash "$collectd_dir"/plugins/memory_buffers.bash

chmod +x "$collectd_dir"/plugins/memory_buffers.bash

chmod 775 "$collectd_dir"/plugins/memory_buffers.bash



if ["$RS_DISTRO" = 'ubuntu']; then

    config="/etc/collectd/collectd.conf"

    plugin_dir="/etc/collectd/conf"

elif ["$RS_DISTRO" = 'centos']; then

    config="/etc/collectd.conf"

    plugin_dir="/etc/collectd.d"

fi

exec_plugin_conf="$plugin_dir/memory_buffers.conf"



if ! grep memory_buffers "$exec_plugin_conf" >/dev/null 2>&1; then

cat <<EOF>> $exec_plugin_conf

<Plugin exec>

  # userid plugin executable plugin args

  Exec "nobody" "$collectd_dir/plugins/memory_buffers.bash" "$SERVER_UUID" "$interval"

</Plugin>

EOF

fi



/etc/init.d/collectd restart



echo 'Done.'
~~~

### memory_buffers.bash

Copy and paste the following into a new text file on your computer. Save it as memory_buffers.bash and upload it as an attachment to the RightScript.

~~~
: ${id:="$SERVER_UUID"}

: ${id:="$1"}

: ${id:=$(< /var/spool/ec2/meta-data/instance-id)}



while true; do

    start_run=$(date +%s)

    data_used=$(free | grep "buffers/cache" | awk '{ print $3 }')

    data_free=$(free | grep "buffers/cache" | awk '{ print $4 }')

    echo 'PUTVAL '"$id"'/memory_buffers/gauge-used '"$start_run"':'"$data_used"

    echo 'PUTVAL '"$id"'/memory_buffers/gauge-free '"$start_run"':'"$data_free"

    sleep 10

done
~~~

### Example Output of Plugin

After you running the RightScript on the server successfully, its also possible to test it manually within shell:

~~~
root@sandbox:~# "/usr/lib/collectd/plugins/memory_buffers.bash" "00-0BIJPUB"PUTVAL 00-0BIJPUB/memory_buffers/gauge-used 1299043002:99288PUTVAL 00-0BIJPUB/memory_buffers/gauge-free 1299043002:1606424PUTVAL 00-0BIJPUB/memory_buffers/gauge-used 1299043012:99380PUTVAL 00-0BIJPUB/memory_buffers/gauge-free 1299043012:1606292PUTVAL 00-0BIJPUB/memory_buffers/gauge-used 1299043022:99364PUTVAL 00-0BIJPUB/memory_buffers/gauge-free 1299043022:1606308
~~~

### Example Alert Specification

Add an alert to your ServerTemplate, such as:

~~~
if memory_buffers/gauge-free.value < '100' for 1 min then escalate to 'critical'
~~~
