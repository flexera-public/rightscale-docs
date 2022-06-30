---
title: Terminal error after an upgrade to OS X 10.10 Yosemite
category: general
description: RightScale has exhausted all efforts to fix the terminal error observed after an upgrade to OS X 10.10 Yosemite.
---

## Overview

RightScale has exhausted all efforts to fix the terminal error observed after an upgrade to OS X 10.10 Yosemite. The error is currently with AppleScript itself hence this behavior may only be fixed if Apple release a patch for it later.

**Errors Observed:**

* **Error 10810**
* **Error 1719**

## Resolution

1. Download iterm2 from iterm2.com website which works the same as the Apple Terminal.
2. Open iterm2 after the download process is done and go to your Server.
3. Open an SSH session and click Launch OpenSSH from the Java Applet window.
4. SSH window should open just like the Apple Terminal before without error.
