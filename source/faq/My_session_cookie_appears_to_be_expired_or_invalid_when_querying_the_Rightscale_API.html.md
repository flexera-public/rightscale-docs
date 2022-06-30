---
title: My session cookie appears to be expired or invalid when querying the RightScale API.
category: general
description: We currently have a policy in place to expire the session after two hours of nonuse with no exceptions.
---

## Background Information

When querying the API, you may see an error indicating that the session cookie has expired or is invalid.

* * *

## Answer

This is by design. We currently have a policy in place to expire the session after two hours of nonuse with no exceptions.

In addition, the session is renewed hourly, as opposed to being renewed after every request.

To remedy this issue, simply use the Login API calls to log in and reset the cookie.
