---
title: Use of RSC tool in RightScripts
alias: [rl/migration/rl10_rightscript_rsc_tool.html, rl10/migration/rl10_rightscript_rsc_tool.html]
description: Use of the RSC tool in RightScripts.
---

The [RSC tool](https://github.com/rightscale/rsc/blob/master/README.md) is installed with RightLink 10 which provides a command line interface for interacting with RightScale's [instance facing APIs](https://github.com/rightscale/rsc/blob/master/README.md#instance-facing-apis). The following are examples that can be added to a RightScript:

## Volume management

Following bash script example executed on Google instances will create a 10GB volume named 'Volume1' and attach it to the instance:
```bash
#!/bin/bash
# ---
# RightScript Name: Volume Create and Attach
# Description: Creates and attaches a volume
# Inputs: {}
# ...

volume_name="Volume1"
volume_size="10"
device_location="persistent-disk-1"

retry_args="--retry=5 --timeout=60"

# Obtain instance information, making a single request to RightScale
instance_info=$(rsc $retry_args --rl10 cm15 index_instance_session /api/sessions/instance)

# Instance HREF
instance_href=$(rsc --x1 ':has(.rel:val("self")).href' json <<< $instance_info)

# Datacenter HREF
datacenter_href=$(rsc --x1 ':has(.rel:val("datacenter")).href' json <<< $instance_info)

# Cloud HREF
cloud_href=$(rsc --x1 ':has(.rel:val("cloud")).href' json <<< $instance_info)

# Create new volume
newvol_href=$(rsc $retry_args --xh=Location --rl10 cm15 create $cloud_href/volumes \
  "volume[name]=$volume_name" \
  "volume[size]=$volume_size" \
  "volume[datacenter_href]=$datacenter_href")

# Wait for volume to become available
until [ "$(rsc --rl10 cm15 show $newvol_href --x1 .status)" == "available" ]; do
  echo "waiting for volume to become available"
  sleep 2
done

# Attach volume to instance
rsc $retry_args --rl10 cm15 create $cloud_href/volume_attachments \
  "volume_attachment[instance_href]=$instance_href" \
  "volume_attachment[volume_href]=$newvol_href" \
  "volume_attachment[device]=$device_location"
```

## Volume snapshot management

Following bash script example executed on Google instances will take a snapshot of all attached volumes on the instance:

```bash
#!/bin/bash
# ---
# RightScript Name: Volume Create Snapshot
# Description: Takes a snapshot of all attached volumes
# Inputs: {}
# ...

retry_args="--retry=5 --timeout=60"

# Obtain instance HREF
instance_href=$(rsc $retry_args --rl10 cm15 index_instance_session /api/sessions/instance \
  --x1 ':has(.rel:val("self")).href')

# Obtain all attached volumes
attached_volumes_hrefs=$(rsc $retry_args --rl10 cm15 index $instance_href/volume_attachments \
  --xm ':has(.rel:val("volume")).href')

# Request snapshot for each attached volume
for volume_href in $attached_volumes_hrefs; do
  volume_href=$(tr -d \" <<< $volume_href)
  volume_name=$(rsc $retry_args --rl10 cm15 show $volume_href --x1 .name)
  rsc $retry_args --rl10 cm15 create $volume_href/volume_snapshots \
    "volume_snapshot[name]=$volume_name"
done
```

Following bash script example executed on Google instances will keep the 10 latest snapshots and deleting the others:

```bash
#!/bin/bash
# ---
# RightScript Name: Volume Snapshot Cleanup
# Description: Deletes older snapshots, keeping the 10 most recent
# Inputs: {}
# ...

snapshots_retained=10

# Obtain cloud HREF
cloud_href=$(rsc --retry=5 --timeout=60 --rl10 cm15 \
  index_instance_session /api/sessions/instance --x1 ':has(.rel:val("cloud")).href')

# Obtain instance HREF
instance_href=$(rsc --retry=5 --timeout=60 --rl10 cm15 \
  index_instance_session /api/sessions/instance --x1 ':has(.rel:val("self")).href')

# Obtain all attached volumes
attached_volumes_hrefs=$(rsc --retry=5 --timeout=60 --rl10 cm15 \
  index $instance_href/volume_attachments --xm ':has(.rel:val("volume")).href')

# Delete old snapshots for each attached volumes
for volume_href in $attached_volumes_hrefs; do
  volume_href=$(tr -d \" <<< $volume_href)
  snapshots=$(rsc --retry=5 --timeout=60 --rl10 cm15 index $cloud_href/volume_snapshots \
    "filter[]=parent_volume_href==$volume_href")
  delete_dates=$(rsc --xm .created_at json <<< $snapshots | sort -r | \
    tail -n +$((snapshots_retained+1)))
  IFS=$'\n'
  for delete_date in $delete_dates; do
    delete_date=$(tr -d \" <<< $delete_date)
    snapshot_href=$(rsc --xm ":has(.created_at:val(\"$delete_date\"))" json <<< $snapshots | \
      rsc --x1 ':has(.rel:val("self")).href' json)
    rsc --retry=5 --timeout=60 --rl10 cm15 destroy $snapshot_href
  done
  unset IFS
done
```

## Machine tag management

Following bash script examples executed on Google instances will add, list, and remove tags from an instance:

```bash
#!/bin/bash
# ---
# RightScript Name: Tags Add
# Description: Adds a machine tag
# Inputs: {}
# ...

tag="rightscale:tag=example"

# Obtain instance HREF
instance_href=$(rsc --retry=5 --timeout=60 --rl10 cm15 \
  index_instance_session /api/sessions/instance --x1 ':has(.rel:val("self")).href')

# Adding tag
rsc --retry=5 --timeout=60 --rl10 cm15 multi_add /api/tags/multi_add \
  "resource_hrefs[]=$instance_href" \
  "tags[]=$tag"
```

```bash
#!/bin/bash
# ---
# RightScript Name: Tags List
# Description: List all machine tags
# Inputs: {}
# ...

# Obtain instance HREF
instance_href=$(rsc --retry=5 --timeout=60 --rl10 cm15 \
  index_instance_session /api/sessions/instance --x1 ':has(.rel:val("self")).href')

# List tags
rsc --retry=5 --timeout=60 --rl10 cm15 by_resource /api/tags/by_resource \
  "resource_hrefs[]=$instance_href" --xm .name\
```

```bash
#!/bin/bash
# ---
# RightScript Name: Tags Remove
# Description: Removes a machine tag
# Inputs: {}
# ...

tag="rightscale:tag=example"

# Obtain instance HREF
instance_href=$(rsc --retry=5 --timeout=60 --rl10 cm15 \
  index_instance_session /api/sessions/instance --x1 ':has(.rel:val("self")).href')

# Delete tag
rsc --retry=5 --timeout=60 --rl10 cm15 multi_delete /api/tags/multi_delete \
  "resource_hrefs[]=$instance_href" \
  "tags[]=$tag"
```
