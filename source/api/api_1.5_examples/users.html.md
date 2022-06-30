---
title: Users
layout: general.slim
---

## Create User

The following creates a new user in the RightScale Cloud Mangement Platform.

### Curl

#### Example Call

**Prerequisite** : Example assumes you have previously [authenticated](/api/api_1.5_examples/authentication.html), and your valid session cookie is in 'mycookie'.

**Note** : A "\" has been added as a line-break for readability. The actual curl command must be interpreted by the shell as a single line/command.

~~~
    #!/bin/sh -e
    curl -i -H X_API_VERSION:1.5 -b mycookie -X POST \
    -d user[email]='gregdoe@example.com' \
    -d user[password]='SomePassword' \
    -d user[company]=RightDoe \
    -d user[phone]=8051234567 \
    -d user[first_name]=Greg \
    -d user[last_name]=Doe \
    https://my.rightscale.com/api/users
~~~

#### Sample Output

~~~
    HTTP/1.1 201 Created
    Server: nginx/0.7.67
    Date: Wed, 24 Aug 2011 21:53:30 GMT
    Content-Type: text/html; charset=utf-8
    Transfer-Encoding: chunked
    Connection: keep-alive
    Status: 201 Created
    Location: /api/users/11
    X-Runtime: 213
    X-Request-Uuid: 7d1f40f69a5a451b8833b8f537498c83
    Set-Cookie: _session_id=3c6e155612b283b6e24a8e972839c257; path=/; Secure; HttpOnly
    Cache-Control: no-cache
~~~

## List Users

List users available to the account the user is logged into.

### Curl

#### Example Call

**Prerequisite** : Example assumes you have previously [authenticated](/api/api_1.5_examples/authentication.html), and your valid session cookie is in 'mycookie'. Requires 'admin' role.

~~~
    curl -i -H X_API_VERSION:1.5 -b mycookie -X GET https://my.rightscale.com/api/users.xml
~~~

#### Sample Output

**Note** : Truncated XML output without headers included (to save space).

~~~
    <?xml version="1.0" encoding="UTF-8"?>
    <users>
      <user>
        <last_name>lastname_520081487</last_name>
        <links>
          <link href="/api/users/726395087" rel="self"/>
        </links>
        <first_name>firstname_622638519</first_name>
        <created_at>2012/10/04 19:25:26 +0000</created_at>
        <email>myemail_3000676324@rightscale.com</email>
        <company></company>
        <updated_at>2012/10/04 19:25:26 +0000</updated_at>
        <actions></actions>
        <phone></phone>
      </user>
      <user>
        <last_name>lastname_520081487</last_name>
        <links>
          <link href="/api/users/726395087" rel="self"/>
        </links>
        <first_name>firstname_622638519</first_name>
        <created_at>2012/10/04 19:25:26 +0000</created_at>
        <email>myemail_3000676324@rightscale.com</email>
        <company></company>
        <updated_at>2012/10/04 19:25:26 +0000</updated_at>
        <actions></actions>
        <phone></phone>
      </user>
    </users>
~~~

**Note** : Without 'admin' role you will receive an "HTTP 403 Forbidden" and "Permission Denied" message.

### Supplemental

You can apply a fliter when listing users to help narrow your search. You can filter by first name, last name, or email.

~~~
    curl -i -H X_API_VERSION:1.5 -b mycookie -X GET https://my.rightscale.com/api/users.xml -d filter[]="email==john.doe@example.com"
~~~

## Update User

The following examples update an existing user record. Note that the authorization logic is substantially different between SAML-based and password-based users; please consult the example that is most relevant to your use case.

### Curl

#### Update a password-based user

**Prerequisite** : Example assumes you have previously [authenticated](/api/api_1.5_examples/authentication.html), and your valid session cookie is in 'mycookie'.

- One of the following must be true:
  - You are logged in as the user being updated
  - You provide the current_password of the user being updated (as evidence that you could login as that user)

**Note** : A "\" has been added as a line-break for readability. The actual curl command must be interpreted by the shell as a single line/command.

~~~
    #!/bin/sh -e
    USER_ID="2112"
    CURRENT_PASSWORD="734PUMJGR7QNF"
    curl -i -H X_API_VERSION:1.5 -b mycookie \
    -d user[email]='gregdoe@example.com' \
    -d user[current_password]=$CURRENT_PASSWORD \
    -d user[new_password]='SomeNewPassword' \
    -d user[company]=RightDoe \
    -d user[phone]=8051234567 \
    -d user[first_name]=Greg \
    -d user[last_name]=Doe
    -X PUT https://my.rightscale.com/api/users/$USER_ID
~~~

#### Sample Output

~~~
    HTTP/1.1 200 OK
    Server: nginx/0.7.67
    Date: Wed, 24 Aug 2011 21:53:30 GMT
    Content-Type: text/html; charset=utf-8
    Transfer-Encoding: chunked
    Connection: keep-alive
    Status: 200 OK
~~~

#### Update a SAML User

**Prerequisites** :

- You must have 'admin' permission on the account.
- The user whose information you are updating must currently be linked to (via identity_provider_href) to one of your organizaiton's SAML providers. For more information, see the [SAML Provisioning API End to End Tutorial](/api/api_1.5_examples/end-to-end_examples.html)
- If updating a user's SAML principal_uid (also known as "NameID" or "SAML subject,") you must know the value that your SAML provider will transmit to RightScale for this person.</font>

~~~
    user_id="7825"
    curl -i -H X_API_Version:1.5 -b mycookie -X PUT \
     -d user[current_email]=john.smith@example.com \
     -d user[company]='New Company' \
     -d user[phone]=1234567890 \
     -d user[first_name]=John \
     -d user[last_name]=Doe \
     -d user[identity_provider_href]='/api/identity_providers/76' \
     -d user[principal_uid]='john.smith@example.com' \
    https://my.rightscale.com/api/users/$user_id
~~~

#### Sample Output

~~~
    HTTP/1.1 200 OK
    Server: nginx/0.7.67
    Date: Wed, 24 Aug 2011 21:53:30 GMT
    Content-Type: text/html; charset=utf-8
    Transfer-Encoding: chunked
    Connection: keep-alive
    Status: 200 OK
~~~
