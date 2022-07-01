---
title: How do I set up a health check page for HAProxy?
category: general
description: This article explains how to create a health-check page that HAProxy will use to check the status of a web server or application.
---

## Background

This document explains how to create a health-check page that HAProxy will use to check the status of a web server or application.

While the exact contents of your health-check page are not important, its name should be unique (e.g. including a random number). The same page is used for _all_ application servers to determine whether the server is running (_up_). While you are not prevented from using index.html as the health-check page, this is not recommended. This is because most web sites have an index.html page and, thus, there is a risk that your load balancer will direct client traffic to a web site other than your own in the cloud. For this reason, you should always use a health-check URI with a unique file name.

*Example:* The Amazon EC2 cloud recycles IP addresses; so, if one server was terminated and another launched for a different site—with the same IP address and page name as your health-check page name (specified in your HEALTH\_CHECK\_URI RightScript input)—HAProxy could consider the server to be running and part of the load-balancer pool even though it is someone else's, and direct traffic to it.

## Answer

Follow the steps below to set up a Health Check Page for HAProxy for your application (Tomcat, Rails, PHP).

When following the below examples, substitute occurrences of _<######>_ or _######_ with your own unique, random numeric string.

*Warning:* When specifying a HEALTH\_CHECK\_URI RightScript input, remember to include the health-check file in your application bundle. For example, in the case of Apache Tomcat, if you set HEALTH\_CHECK\_URI to "/health\_check378923.jsp", remember to include _health\_check378923.jsp_ in your WAR file.

### Set up a Health Check Page

#### Apache Tomcat

1. Create a file named _health\_check<######>.jsp_ in your application with the following contents.  

    ~~~
    <HTML>
      <HEAD>
        <TITLE>Hello World</TITLE>
      </HEAD>
      <BODY>
        <H1>Hello World</H1>
        Today is: <%= new java.util.Date().toString() %>
      </BODY>
    </HTML>
    ~~~

2. Set your HEALTH\_CHECK\_URI script input to:

    `/health\_check_<######>_.jsp`

#### Ruby on Rails/Mongrel

1. Create a file named _mongrel\_health\_check.rb_ with the below contents, and add it to your server or repository.  

    ~~~
    ####
    # Copyright (c) 2011 RightScale, Inc, All Rights Reserved Worldwide.
    #
    # THIS PROGRAM IS CONFIDENTIAL AND PROPRIETARY TO RIGHTSCALE
    # AND CONSTITUTES A VALUABLE TRADE SECRET. Any unauthorized use,
    # reproduction, modification, or disclosure of this program is
    # strictly prohibited. Any use of this program by an authorized
    # licensee is strictly subject to the terms and conditions,
    # including confidentiality obligations, set forth in the applicable
    # License Agreement between RightScale.com, Inc. and
    # the licensee.
    #
    # Handler for status/health checks.
    # Load balancers (or other machines for that matter) will be able to monitor the health of
    # each mongrel by retrieving a successful response from this handler
    # This file can be included in the configuration of the mongrels (i.e., mongrel_cluster.yml)
    # config_script: lib/mongrel_health_check_handler.rb

    # This must be called from a Mongrel configuration...
    class MongrelHealthCheckHandler < Mongrel::HttpHandler
      def initialize
        #Make sure it's expired by the time we process the first request
        @DB_OK_at= Time.at(0)
        @freshness= 30
        @error_msg=""
      end
      def process(request,response)


        # Write down if it's time to do a more heavyweight check
        db_stale=true if( (Time.now()-@DB_OK_at).to_i > @freshness )


        check_db if db_stale


        code = ( (Time.now()-@DB_OK_at).to_i > @freshness )? 500:200
        # Return OK if ActiveRecord is not connected yet (i.e., test mongrel only)
        code = 200 unless ActiveRecord::Base.connected?


        response.start(code) do |head,out|
          head["Content-Type"] = "text/html"


          t = Time.now()
          out.write "Now: #{t} , DB OK #{(t-@DB_OK_at).to_i}s ago\n"
          out.write "ERROR:#{@error_msg}" if @error_msg != ""
        end
      end


      # Check health of DB, and update the @DB_OK_at timestamp if it succeeds
      def check_db
        if ActiveRecord::Base.connected?
          begin      
            ActiveRecord::Base.connection.verify!(0) #verify now (and reconnect if necessary)
            ActiveRecord::Base.connection.select_value("SELECT NOW()")
            @DB_OK_at = Time.now
            @error_msg = ""
          rescue Exception => e
            # Do your logging/error handling here
            @error_msg = e.inspect
          end
        end
      end
    end


    uri "/mongrel-status######", :handler => MongrelHealthCheckHandler.new, :in_front => true
    ~~~


2. Modify the last line in the above file so that the page can be uniquely identified with your application (e.g. change "mongrel-status_######_" to "mongrel-status1234089").

3. Add the following to /etc/mongrel\_cluster/mongrel\_cluster.yml:  
`config\_script:&nbsp; _<PathToFile>_/mongrel\_health\_check.rb`
 Or, alternatively, set your OPT\_MONGREL\_CONFIG\_SCRIPT input to the path where you saved the above file. Be sure to specify the full path to the file from the base directory of your Rails application; e.g. `lib/mongrel\_health\_check\_handler.rb`.

4. Set HEALTH\_CHECK\_URI to the value you specified at the end of the file above: /mongrel-status_<######>_

#### PHP

1. Create a file named health\_check_<######>_.php in your application with the following contents.  

    ~~~
    <?php
    phpinfo();
    ?>
    ~~~

2. Set&nbsp; OPT\_HEALTH\_CHECK\_URI to: /health\_check_<######>_.php

### Verify Health Check Pages

If your site's permissions allow it (and assuming that your script input OPT\_LB\_STATS\_URI is set to `haproxy-status`) you can simply add `/haproxy-status` to your load-balancer hostname URL to display an HAProxy status report in a tabular HTML format:

*Example:* http://www.mysite.com/haproxy-status

![faq-HAProxyStatus.png](/img/faq-HAProxyStatus.png)
