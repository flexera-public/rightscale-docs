---
title: Supported Graphs Types
layout: cm_layout
description: A listing of the graph types supported by Time Series Storage (TSS) in the RightScale Cloud Management Platform.
---

The following graph types are supported by Time Series Storage (TSS). TSS can only draw graphs if one of the following graph types is specified. For graphing custom plug-ins, RightScale supports COUNTER or GAUGE Data Source Types (DST).

## Generic Graph Types

* :blank
* :countr
* :bytes_txrx
* :recv_sent
* :requests
* :cache

## Plugin-specific Graph Types

* :haproxy_sessions
* :haproxy_traffic
* :haproxy_status
* :apache_bytes
* :apache_requests
* :apache_scoreboard
* charge
* charge_percent
* cpu
* current
* df
* disk
* disk_octets
* disk_merged
* disk_ops
* disk_time
* dns_opscode
* dns_qtype
* dns_rcode
* dns_octets
* email
* email_size
* spam_score
* spam_check
* entropy
* fanspeed
* frequency
* frequency_offset
* gauge
* hddtemp
* if_errors
* if_packets
* irq
* load
* load_percent
* mails
* memory
* old_memory
* memcached_connections
* memcached_items
* memcached_octets
* memcached_ops
* mysql_commands
* mysql_handler
* mysql_octets
* mysql_qcache
* mysql_threads
* nfs_procedure
* nfs3_procedures
* nginx_connections
* nginx_requests
* opcode
* operations
* partition
* passenger_instances
* passenger_processes
* passenger_queued
* passenger_requests
* percent
* ping
* processes
* ps_rss
* ps_cputime
* ps_count
* ps_pagefaults
* ps_state
* queue_length
* qtype
* rcode
* swap
* ols_swap
* temperature
* timeleft
* time_offset
* if_octets
* cpufreq
* multimeter
* users
* voltage
* vs_threads
* vs_memory
* vs_processes
