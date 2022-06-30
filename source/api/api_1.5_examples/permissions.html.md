---
title: Permissions
layout: general.slim
---

## Create Permission

Create a permission record for the account the user is logged in to.

### Curl

**Prerequisite** : Example assumes you have previously [authenticated](/api/api_1.5_examples/authentication.html), and your valid session cookie is in 'mycookie'.

#### Example Call

~~~
    curl -i -H X_API_VERSION:1.5 -b mycookie -X POST -d permission[user_href]=/api/users/49052 -d permission[role_title]=observer https://my.rightscale.com/api/permissions
~~~

#### Sample Output

**Note** : Requires 'admin' role, as stated in the [Permissions online reference information](http://reference.rightscale.com/api1.5/resources/ResourcePermissions.html#index). Without 'admin' you will get an _"HTTP 403 Forbidden"_ message.

~~~
    HTTP/1.1 201 Created.
    Server: nginx/0.7.67
    Date: Wed, 24 Aug 2011 21:53:30 GMT
    Content-Type: text/html; charset=utf-8
    Transfer-Encoding: chunked
    Connection: keep-alive
    Status: 201 Created
    Location: /api/permissions/11
    X-Runtime: 213
    X-Request-Uuid: 7d1f40f69a5a451b8833b8f537498c83
    Set-Cookie: _session_id=3c6e155612b283b6e24a8e972839c257; path=/; Secure; HttpOnly
    Cache-Control: no-cache
~~~

## Delete Permission

Delete a permission record (i.e. user role) for the account a user is logged in to.

### Curl

#### Example Call

**Note:**

- You must remove the 'observer' permission last or you will receive an error. The observer role allows a user to login and view the RightScale Dashboard.
- Permissions can only be deleted one at a time since you are removing the permission ID associated to the user role.

~~~
    curl -i -H X_API_VERSION:1.5 -b mycookie -X DELETE https://my.rightscale.com/api/permissions/590220.xml
~~~

#### Sample Output

**Note:**

- Requires 'admin' role, as stated in the [Permissions online reference information](http://reference.rightscale.com/api1.5/resources/ResourcePermissions.html#index). Without 'admin' you will get an "_HTTP 403 Forbidden_" message.
- There is no XML/JSON content, just headers.

~~~
    HTTP/1.1 204 No Content
    Server: nginx/1.0.15
    Date: Wed, 24 Aug 2011 21:53:30 GMT
    Connection: keep-alive
    Status: 204 No Content
    X-Runtime: 427
    X-Request-Uuid: 26c1ff4fbeb943f78c72a7df91c91253
    Set-Cookie: _session_id=f6e055cbb4c26287221ab0a881c3ac26; path=/; Secure; HttpOnly
    Cache-Control: no-cache
~~~

## List Permissions

List all the permissions for all the users of the account the user is logged in to. That is, list all permissions for all users of the current account.

### Curl

#### Example Call

**Prerequisite** : Example assumes you have previously [authenticated](/api/api_1.5_examples/authentication.html), and your valid session cookie is in 'mycookie'.

~~~
    curl -i -H X_API_VERSION:1.5 -b mycookie -X GET https://my.rightscale.com/api/permissions.xml
~~~

#### Sample Output

**Note** :

- Truncated XML output without headers included (to save space).
- Requires 'admin' role, as stated in the [Permissions online reference information](http://reference.rightscale.com/api1.5/resources/ResourcePermissions.html#index). Without 'admin' you will get an "HTTP 403 Forbidden" message.

~~~
    <?xml version="1.0" encoding="UTF-8"?>
    <permissions>
      <permission>
        <links>
          <link href="/api/permissions/590220" rel="self"/>
          <link href="/api/accounts/7960" rel="account"/>
          <link href="/api/users/49052" rel="user"/>
        </links>
        <created_at>2012/10/04 19:25:29 +0000</created_at>
        <role_title>actor</role_title>
        <actions></actions>
      </permission>
      <permission>
        <links>
          <link href="/api/permissions/590221" rel="self"/>
          <link href="/api/accounts/7960" rel="account"/>
          <link href="/api/users/49052" rel="user"/>
        </links>
        <created_at>2012/10/04 19:25:32 +0000</created_at>
        <role_title>observer</role_title>
        <actions></actions>
      </permission>
    </permissions>
~~~
