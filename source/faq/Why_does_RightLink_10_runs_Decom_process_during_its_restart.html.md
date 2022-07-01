---
title: Why does RightLink 10 run decommission sequence during its restart?
category: general
description: Explains RightLink 10 decommission (decom) behavior during restart
---

## Background Information

RightLink 10 is the latest of the RightLink Agent family and its built totally from scratch. Being different from the previous version, during the restart of the agent, the process triggers the decommission (decom) sequence. If you don't want this behavior, follow the steps below.

## Answer

You may skip the decom sequence by putting the following line on top of any of your decommission scripts.

`[[ $DECOM_REASON != "terminate" ]] && echo "Server is not terminating. Skipping." && exit 0`

If you desire to use the script as ad-hoc, you can try the following:

```
if ([ ! -z "$DECOM_REASON" ] && [ "$DECOM_REASON" != 'terminate' ]); then 
echo 'server is not terminating, skipping.' 
exit 0 
fi
```

<br>
More info about the [Decommission Sequence](/st/rl10/base_linux/#sts=Decommission)
