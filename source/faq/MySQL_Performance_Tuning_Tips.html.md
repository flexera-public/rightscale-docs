---
title: MySQL Performance Tuning Tips
category: general
description: Performance testing is both art and science and finding the right combination of performance parameters needs some trial and error.
---

## Overview

Performance testing is both art and science and finding the right combination of performance parameters needs some trial and error. The easiest tool to use for performance testing is the apache bench load testing tool, referred to as 'AB'. This will allow you to quickly simulate load on your servers and test performance changes.

## Performance Tuning Example

For the following we assume you have your deployment all configured and running (Load balancers, array, database, etc) in a simulated production environment:

<ol>
  <li>First, you need to determine a baseline of performance with AB only one server in your array and one load balancer. I would disable the array & manually launch 1 array server. This will help establish the number of connections a single web server can handle and simplify the testing process along with easing the debugging process.

  ~~~
  ab -n 1000 -c 5 http://yourwebsite.com/index.html >> results.txt
  ab -n 1000 -c 10 http://yourwebsite.com/index.html >> results.txt
  ab -n 1000 -c 50 http://yourwebsite.com/index.html >> results.txt
  ~~~

  This will generate some statistics on how many page requests per second and time per page. Save this information for later reference.

  * Check the monitoring graphs in the RightScale dashboard for information on CPU load especially.
  * Run these tests with a single array server to see how many connections your application can handle.
  * You may want to vary the -n <number> -c <number> parameters to suit your needs

  <li>Verify the performance in these areas of your deployments after test #1.

  * Load Balancer performance graphs ( CPU Load ) - should be very low.
  * MySQL Master Database graphs (transactions per second, cpu load, reads & writes)
  * Application (web) server graphs (cpu load)

  <li>Verify MySQL Performance

  * Check mysql slow log: (usually) /var/log/mysqlslow.log. You should not have lots of slow queries. Slow queries usually mean poor database indexing.
  * Check to make sure have added indexes to your tables where possible.
  * After running your DB for a while download mysqltuner and run the script on the master. It provides valuable advice on MySQL performance.
  * Some items that usually need adjusting: Maxmimum number of concurrent MySQL connections, Thread_cache_size.

  <li>Check Application Server

  * It is always a good idea to check the http (Apache) logs in /var/logs on the application server
  * Look for any errors for apache, in /var/log/messages

  <li>Adjustments

  * Start making adjustments based on the results from Apache Bench results, MySQLTuner information & the RightScale monitoring graphs.
  * This may require some custom tuning of MySQL my.cnf file, the database schema itself, database indexes and/or your web application code itself.
  * After making changes to the RightScale Inputs, tuning the DB, etc, start the tests over again at Step 1 above.
  * Look into caching solutions such as: memcached, apc or other caching solutions to improve php & database performance.

  <li>Testing the array and real performance.

  * After you have successfully tuned your deployment with 1 Load Balancer, 1 App Server and the database you can now start testing with a production type environment.
  * Enable your array & verify the scale_up & scale_down parameters. You may want to set the scale_up threshold to be something simple to start such as "cpu.idle < 50 for > 2 minutes"
  * Run AB again, this time trying to test the array scaling features. Keep monitoring the graphs to spot any new problems.
  * After the array scales up, let AB finish and depending on your settings the array should eventually scale back down.

  <li>Final checks

  * Go through the deployment one last time: check mysqlslow & mysql logs, apache logs, all the graphs for your servers.
  * Re-run MySQLTuner on the Master DB to spot tuning ideas.
  * Double-check your Deployment Inputs.
  * Update your Array scale_up & scale_down settings.
  * Make sure both your Load Balancers are up and running.
  * Check your DNS entries are pointing to the Load Balancers.
  * Verify MySQL backups.
  * Rerun AB to simulate real-world conditions.
  * Go to Step 1 if problems arise.

  <li>Helpful Links

  * Generic MySQL Tuning: [LINK](http://rudd-o.com/en/linux-and-free-software/tuning-a-mysql-server-in-5-minutes)
  * Memcached: [LINK](http://www.danga.com/memcached/)
