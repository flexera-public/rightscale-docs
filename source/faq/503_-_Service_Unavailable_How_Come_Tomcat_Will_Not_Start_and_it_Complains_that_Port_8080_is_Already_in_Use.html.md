---
title: 503 - Service Unavailable - How come Tomcat will not start and it complains that port 8080 is already in use?
category: general
description: Tomcat will not start and complains that port 8080 is already in use. When accessing the site via a web browser you get a '503 - Service Unavailable' error.
---

## Background Information

Tomcat will not start and complains that port 8080 is already in use. When accessing the site via a web browser you get a '503 - Service Unavailable' error.

* * *

## Answer

Be sure that the `APP_SERVER_PORT` input variable on your template is set to 8000 (the default) and not 8080. Tomcat uses port 8080, but the `APP_SERVER_PORT` is the port that HA PROXY forwards traffic to and should be set to 8000.
