---
title: How do I address RequestLimitExceed errors when using the AWS API?
category: aws
---

## Background Information

When you make AWS API requests through the RightScale Gateway we attempt retries following the decorrelated jitter strategy described in [https://www.awsarchitectureblog.com/2015/03/backoff.html](https://www.awsarchitectureblog.com/2015/03/backoff.html). We use a base sleep time of 1.0s and allow up to 7 retries or a total of 30s of retries before we stop retrying.

* * *

## Answer

If you are still seeing `RequestLimitExceed` errors on your AWS API calls we advise you to contact AWS to have your Request Limit increased.
