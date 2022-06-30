---
title: Accounts
layout: general.slim
---

## Create

Creates an Account after authenticating as your master account.

### Curl

#### Example Call

**Prerequisite** : Example assumes you have previously [authenticated](/api/api_1.5_examples/authentication.html), and your valid session cookie is in 'mycookie'.

**Note:**

- Command must be run by a user who has the 'enterprise_manager' role within the Enterprise account.
- <Location> header returned by Curl gives an API HREF for the created account, which includes the RightScale account ID. This account will automatically be added to your RightScale organization.
- All users in your organization will be given a base set of permissions to the new account. The "owner" of the organization will be granted the 'enterprise_manager' role, and can proceed to grant additional users this role on the new account if needed.
- An optional parameter is the ability to set which cluster you would like the account to be created in. If not specified, will default to one of these possible values:
  - "/api/clusters/3" - for US-3 (UCP)
  - "/api/clusters/4" - for US-4 (UCP)

~~~
    #!/bin/bash
    child_account_name='My_Child_Account_Name' #Change to the desired name for your child account
    cluster='/api/clusters/3' #(Optional) The cluster you would like the child account to be created in.

    curl -i -H x-api-version:1.5 -b mycookie -X POST \
     -d "child_account[name]=$child_account_name" \
     -d "child_account[cluster_href]=$cluster" \
    https://my.rightscale.com/api/child_accounts
~~~

#### Sample Output

**Note:**

- Output is from Curl using the -v verbose switch, and the original Curl command is included at the top.
- Parts of output are omitted to keep it brief and relevant.

~~~
    curl -v -X POST -H 'X-API-VERSION:1.5' -b myCookie -d "child_account[name]=My_Child"  https://my.rightscale.com/api/child_accounts
    ...
    * About to connect() to my.rightscale.com port 443 (#0)
    *   Trying 174.129.230.90...
    * Connected to my.rightscale.com (174.129.230.90) port 443 (#0)
    ...
    > POST /api/child_accounts HTTP/1.1
    ...
    < HTTP/1.1 201 Created
    ...
    < Location: /api/accounts/72312
~~~

### Right_api_client

#### Example Call

**Prerequisite** : Example assumes you have previously [authenticated](/api/api_1.5_examples/authentication.html), and your valid session cookie is in 'mycookie'.

**Note:**

- Command must be run by a user who has the 'enterprise_manager' role within the Enterprise account.
- All users in your organization will be given a base set of permissions to the new account. The "owner" of the organization will be granted the 'enterprise_manager' role, and can proceed to grant additional users this role on the new account if needed.

~~~
    ## Replace 'Child-Account-Nickname' with desired child account name
    child_account = @client.child_accounts.create(:child_account =>
      {:name => 'Child-Account-Nickname', :child_account[cluster_href] => '/api/clusters/3'})
~~~

#### Sample Output

**Note:**

- Sample output comes from a Ruby interactive shell (Pry).
- New account info is stored in a variable named 'child_account' (per the example above). Additional commands can be run against this object after it's creation.
- Output includes original example as originally issued within IRB.

~~~
    [7] pry(main)> child_account = @client.child_accounts.create(:child_account =>
    [8] pry(main)> {:name => 'Child-Account-Nickname', :child_account[cluster_href] => '/api/clusters/3'})
    => #<RightApi::Resource resource_type="account">

    ## Use .api_methods method to show additional available methods for child account manipulation

    [10] pry(main)> child_account.show.api_methods
    => [:links,
    :owner,
    :cluster,
    :updated_at,
    :created_at,
    :name,
    :href,
    :destroy,
    :update,
    :show]

    ## Show newly created child account ID

    [13] pry(main)> child_account.show.href
    => "/api/accounts/72315"
~~~
