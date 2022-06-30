---
title: Why do old HAProxy processes fail to exit?
category: general
description: HAProxy remains running as long as there is a live connection (i.e. it will not terminate an established connection).
---

## Background Information

Sometimes you may find that old HAProxy processes persist even after restarting the HAProxy service.

* * *

## Answer

HAProxy remains running as long as there is a live connection (i.e. it will not terminate an established connection). This is by design as it allows for a graceful restart of HAProxy where existing connections continue to be serviced by the old process so they don't receive errors while new ones get serviced by the new HAProxy process with the new configuration. If you want to forcibly terminate existing connections, you must stop and then start HAProxy.

You can determine what is preventing HAProxy from exiting completely using the **netstat** or **lsof** commands. If you have Apache running, sometimes turning off the KeepAlive directive will help solve the problem. (According to the HAProxy documentation, keep-alive should be turned **off**.)
