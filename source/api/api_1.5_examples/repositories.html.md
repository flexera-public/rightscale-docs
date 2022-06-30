---
title: Repositories
layout: general.slim
---

## Create Repository

Creates a repository in an account.

### Curl

**Prerequisite** : Example assumes you have previously [authenticated](/api/api_1.5_examples/authentication.html), and your valid session cookie is in 'mycookie'.

#### Example Call

The following example creates a repository in your account and fetches the assets from the repository. It takes a couple moments for the repository assets to be fetched. You can perform a [Show Repository](/api/api_1.5_examples/repositories.html) to view the fetch_status and check if the fetch has successfully completed.

**Note** :

- When adding a git repository, you need to need to use the repository[credentials][ssh_key] parameter. This value cannot be left blank. If the git repository is public and does not need an SSH Key, set the value to text:. If it is private, paste in text:<your SSH Key>. The source_type needs to be set to git. If you are using credentials, use cred:<SSH credential>.
- When adding an svn repository, you need to use the repository[credentials][username] and repository[credentials][password] parameters. If these values are blank, use text:. If it is private, specify text:<svn username> and text:<svn password> for the values of the parameters. The source_type needs to be set to svn. You can also use cred:<SVN username credential> and cred:<SVN password credential>.
- When uploading a compressed file, use the same parameters as you would with an svn repository. The source_type needs to be set to download.

~~~
    #!/bin/sh -e
    curl -i -H X_API_VERSION:1.5 -b mycookie -X POST \
    -d repository[name]=MyGitRepository \
    -d repository[source]=https://github.com/rightscale/rightscale_cookbooks.git \
    -d repository[source_type]=git \
    -d repository[credentials][ssh_key]=text: \
    https://my.rightscale.com/api/repositories.xml
~~~

#### Sample Output

~~~
    HTTP/1.1 201 Created
    Server: nginx/1.0.14
    Date: Wed, 04 Sep 2013 21:21:35 GMT
    Content-Type: text/html; charset=utf-8
    Transfer-Encoding: chunked
    Connection: keep-alive
    Status: 201 Created
    Location: /api/repositories/239933001
    X-Runtime: 371
    X-Request-Uuid: 03c157ff325b4c28bde370f5a46ce79e
    Set-Cookie:
    Cache-Control: no-cache
~~~

## List Repositories

List all repositories of an account.

### Curl

**Prerequisite** : Example assumes you have previously [authenticated](/api/api_1.5_examples/authentication.html), and your valid session cookie is in 'mycookie'.

#### Example Call

The following example will list all repositories added in an account. If you are looking for a specific repository, you can list all the repositories to locate the repository ID and perform a [Show Repository](/api/api_1.5_examples/repositories.html).

~~~
    #!/bin/sh -e
    curl -i -H X_API_VERSION:1.5 -b mycookie -X GET https://my.rightscale.com/api/repositories.xml
~~~

#### Sample Output

**Note** : Truncated XML output without headers included (to save space).

~~~
    <?xml version="1.0" encoding="UTF-8"?>
    <repositories>
      <repository>
        <links>
          <link rel="self" href="/api/repositories/13"/>
        </links>
        <updated_at>2013/08/29 05:37:44 +0000</updated_at>
        <source_type>git</source_type>
        <read_only>false</read_only>
        <credentials>
          <ssh_key></ssh_key>
        </credentials>
        <asset_paths>
          <cookbooks>
            <cookbook>cookbooks</cookbook>
          </cookbooks>
        </asset_paths>
        <source>git://github.com/rightscale/cookbooks_public.git</source>
        <created_at>2009/09/16 05:28:40 +0000</created_at>
        <commit_reference></commit_reference>
        <description>From JohnDoe - RightScale</description>
        <name>GitHub - rightscale/cookbooks_public</name>
        <fetch_status>
          <succeeded_at>2013/08/29 05:37:44 +0000</succeeded_at>
          <succeeded_commit>0f255c3877210f6ece0a9cc8fc410c9c4f974055</succeeded_commit>
        </fetch_status>
        <id>13</id>
        <actions>
          <action rel="cookbook_import_preview"/>
          <action rel="cookbook_import"/>
          <action rel="refetch"/>
          <action rel="resolve"/>
        </actions>
      </repository>
      <repository>
        <links>
          <link rel="self" href="/api/repositories/120"/>
        </links>
        <updated_at>2013/05/24 03:15:34 +0000</updated_at>
        <source_type>svn</source_type>
        <read_only>false</read_only>
        <credentials>
          <username>text:jondoe</username>
          <password>text:password1</password>
        </credentials>
    . . .
~~~

## Refetch Repository

Scrapes a repository for cookbooks and other RepositoryAssets.

### Curl

**Prerequisite** : Example assumes you have previously [authenticated](/api/api_1.5_examples/authentication.html), and your valid session cookie is in 'mycookie'.

#### Example Call

Refetching performs a scrape to see if any changes have been made to the source repository. This action will pull in assets from a repository added to an account. You can then perform an [Import Cookbooks from a Repository](/api/api_1.5_examples/repositories.html) to bring cookbooks into your account and attach them when modifying a ServerTemplate. You can perform a [Show Repository](/api/api_1.5_examples/repositories.html) to view the fetch_status to see if the refetch completed successfully.

~~~
    #!/bin/sh -e
    curl -i -H X_API_VERSION:1.5 -b mycookie -X POST https://my.rightscale.com/api/repositories/248925001/refetch.xml
~~~

#### Sample Output

~~~
    HTTP/1.1 204 No Content
    Server: nginx/1.0.15
    Date: Thu, 05 Sep 2013 20:30:23 GMT
    Connection: keep-alive
    Status: 204 No Content
    X-Runtime: 341
    X-Request-Uuid: 0c3909a2c4ad4c47930d2df4aed2caee
    Set-Cookie:
    Cache-Control: no-cache
~~~

## Show Repository

Shows a single repository that has been added to an account.

### Curl

**Prerequisite** : Example assumes you have previously [authenticated](/api/api_1.5_examples/authentication.html), and your valid session cookie is in 'mycookie'.

#### Example Call

After performing a [List Repositories](/api/api_1.5_examples/repositories.html), you can get the repository ID and view the information of an individual repository. This can be beneficial when checking if a fetch has successfully completed after a repository has been created.

~~~
    #!/bin/sh -e
    curl -i -H X_API_VERSION:1.5 -b mycookie -X GET https://my.rightscale.com/api/repositories.xml
~~~

#### Sample Output

The output below displays a repository that has not yet performed a fetch after its creation. Note the blank fetch_status.

**Note** : The XML output does not have headers (to save space).

~~~
    <?xml version="1.0" encoding="UTF-8"?>
    <repository>
      <links>
        <link rel="self" href="/api/repositories/239957001"/>
      </links>
      <updated_at>2013/09/05 21:31:30 +0000</updated_at>
      <source_type>git</source_type>
      <read_only>false</read_only>
      <credentials>
        <ssh_key>text:</ssh_key>
      </credentials>
      <asset_paths>
        <cookbooks></cookbooks>
      </asset_paths>
      <source>https://github.com/rightscale/rightscale_cookbooks.git</source>
      <created_at>2013/09/05 21:31:30 +0000</created_at>
      <name>GitRepositoryAPIExample</name>
      <fetch_status></fetch_status>
      <id>239957001</id>
      <actions>
        <action rel="cookbook_import_preview"/>
        <action rel="cookbook_import"/>
        <action rel="refetch"/>
        <action rel="resolve"/>
      </actions>
    </repository>
~~~

The output below displays a repository that has successfully performed a fetch moments after the repository was added. Note the information in fetch_status.

**Note** : The XML output does not have headers (to save space).

~~~
    <?xml version="1.0" encoding="UTF-8"?>
    <repository>
      <links>
        <link rel="self" href="/api/repositories/239957001"/>
      </links>
      <updated_at>2013/09/05 21:33:07 +0000</updated_at>
      <source_type>git</source_type>
      <read_only>false</read_only>
      <credentials>
        <ssh_key>text:</ssh_key>
      </credentials>
      <asset_paths>
        <cookbooks></cookbooks>
      </asset_paths>
      <source>https://github.com/rightscale/rightscale_cookbooks.git</source>
      <created_at>2013/09/05 21:31:30 +0000</created_at>
      <name>GitRepositoryAPIExample</name>
      <fetch_status>
        <output>
    Cookbooks refresh for GitRepositoryAPIExample completed successfully.

    Saved results
    </output>
        <succeeded_at>2013/09/05 21:33:07 +0000</succeeded_at>
        <succeeded_commit>9b6855d69fb0847e925c4747129c552c8c7971d8</succeeded_commit>
      </fetch_status>
      <id>239957001</id>
      <actions>
        <action rel="cookbook_import_preview"/>
        <action rel="cookbook_import"/>
        <action rel="refetch"/>
        <action rel="resolve"/>
      </actions>
    </repository>
~~~
