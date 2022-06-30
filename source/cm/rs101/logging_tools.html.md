---
title: Logging Tools
layout: cm_layout
description: A number of additional configuration options have been added to help you send syslog information to a destination of your choice. This guide provides information around how to configure syslog in your RightScale environment.
---

## Overview

The v12.11.x LTS and v12.11 and above ServerTemplates no longer support the built-in logging functionality that has historically been provided by RightScale-hosted lumberjack servers. In its place, we have added additional configuration options to help you send syslog information to a destination of your choice. This guide provides information around how to configure syslog in your environment.

## Clients

Each ServerTemplate published by RightScale includes a syslog client cookbook that allows you to specify the destination for the logs from that server. There is one input in the Logging category of the ServerTemplate called Remote Server (logging/remote_server) where you can enter a FQDN or IP address of a syslog server that will receive logs from this server. Currently only the default syslog configuration is supported (unencrypted, UDP port 514).

## Syslog Servers

A basic syslog server can be configured to receive log information.

## Coming Soon

Future ServerTemplate releases will have much more full-featured syslog support, including configuration options for protocol, port, encryption, and even a standalone Syslog ServerTemplate that you can run in your RightScale account to capture logs from your servers.
