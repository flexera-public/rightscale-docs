---
title: How secure is a websocket tunnel?
category: vmware
description: The RightScale platform communicates with the RCA-V in your vSphere environment using a secure WebSocket tunnel connection.
---

## Background Information

The RightScale platform communicates with the RCA-V in your vSphere environment using a secure WebSocket tunnel connection.

## Answer

* A WebSocket connection begins as an HTTP handshake and then upgrades in-place to speak the WebSocket wire protocol.  As such, many existing HTTP security mechanisms also apply to a WebSocket connection. [https://tools.ietf.org/html/rfc64550](https://tools.ietf.org/html/rfc6455)
* The RCA-V Websocket tunnel is configured over TLS/SSL HTTPS port 443 and enables bi-directional communications.
* The Websocket tunnel does not require enterprises to open additional ports in their firewalls.
* The WebSocket endpoint is defined by a URL, which means origin-based security can be applied.
* Client-to-server masking – Each WebSocket frame, with a frame containing a message, is automatically masked to prevent old or badly-implemented intermediaries ("man-in-the-middle" scenarios) from accidentally or deliberately causing issues based on bytes in the payload. Each frame contains the masking key so WebSocket-aware intermediaries can unmask the messages for protocol or packet inspection, or to enforce security policies, etc.
