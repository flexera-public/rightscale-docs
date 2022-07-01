---
title: How can i run basic API Curl Queries in Self-Service Manager?
category: general
description: Running API queries in Self-Service Manager
---

## Background Information

If you want to know the basics of running API queries via curl in Self-Service Manager, follow the steps below.

## Answer:

1. You can Authenticate first following the query below. You can substitute the correct value for your RightScale Credentials such as the Email, Password, Account ID and the shard where your account belongs (either US-3 or US-4)

	~~~
	curl -vsi –S -H X_API_VERSION:1.5 -c cookie -X POST -d email='me@rightscale.com' -d password='my_password' -d account_href=/api/accounts/Account_ID https://us-3.rightscale.com/api/session
	~~~

2. After you are authenticated, you may now run a simple API query to get started. To view all your CloudApps, you can run the following query.

	~~~
	curl -v -G  https://selfservice-3.rightscale.com/api/manager/projects/7911/executions -H "X-Api-Version:1.0" -b cookie
	~~~

3. To view a specific CloudApp, you can run the following query.

	~~~
	curl -v -G  https://selfservice-3.rightscale.com/api/manager/projects/7900/executions/57035ebf1e0dfb00670b1111 -H "X-Api-Version:1.0" -b cookie
	~~~

See [Self-Service API Reference Here](http://reference.rightscale.com/selfservice/manager/index.html#/1.0/controller/V1::Controller::Execution)
