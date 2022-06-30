---
title: How do I set up auto-failover on MySQL databases?
category: general
description: RightScale does not recommend or provide autofailover for MySQL databases. There are too many variables in implementing autofailover to recommend it as a viable solution.
---

## Background Information

Is it possible to set up auto-failover for MySQL databases? What is involved in setting it up?

* * *

## Answer

RightScale does not recommend or provide autofailover for MySQL databases for a number of reasons. Let's begin by looking at some of the possible causes of database failure:

1. The application has a bad MySQL query that causes the server to become slow and unresponsive.
2. Mysqld crashes due to a bug in the code.
3. The Master server is out of hard drive space.
4. There is a memory leak caused by some modifications or application installed on the server.
5. There is a problem with the cloud infrastructure that the server is on that causes the instance to become unresponsive.
6. The data on the master gets corrupted.

Of course, there could also be a problem with the monitoring system that could have caused it to not receive data (for example, collectd dies or the monitoring server or monitoring daemons are not running or running slow).

With so many possible causes of database failure it is difficult to pinpoint a cure that will solve all of them. For example if mysqld dies because the server ran out of hard drive space then a new slave will get promoted to master with the same issue. So a chain of slaves will get promoted one after the other. If collectd dies, it may fix the problem for that server but if it's a problem with the monitoring servers themselves or a configuration issue then again, a chain of slaves will be promoted. In no case can autofailover fix the problem with a bad query. The same query will be in the application and the new master will again be brought down when the query is executed again. Remember, if data is corrupted on the master, it will propagate to the slave and will still be there in the new master. Given all of these possible causes for database failure, autofailover is not rendering a cure (at best) and could possibly make things worse.

Now it comes down to detecting a few specific cases where one could use autofailure such as item 5 - a problem with the cloud causing an unresponsive server. The real question is how to distinguish this from any of the other issues. And what if you are getting a false positive where the server is running fine, but there is a communication problem between the server and the monitoring system? Now you are blindly promoting slaves one after the other on a false positive when in fact there is nothing wrong with the database.

So even if you were able to predict all of the possible outcomes and the cases where autofailover would work and a new slave is launched correctly, it still does not resolve the underlying problem if there is a false positive by the monitoring server. And even if you had a perfect monitoring server that never failed and could predict all possible outcomes, it could still not tell you if your slave is worth promoting. What if your only good database is your master and your slave is not replicating or is corrupted?&nbsp; In this case, you would blindly promote the slave and possibly lose your good master database that has your good, uncorrupted data.

In summary, there are too many variables in implementing autofailover to recommend it as a solution to the age old problem of the database going down at 3am. And even if you did autofailover, you could not trust that it fixed the problem so the DBA would still have to get up and look into the situation to be sure things were working. It is far more prudent to look at the causes and facts before blindly promoting a slave.
