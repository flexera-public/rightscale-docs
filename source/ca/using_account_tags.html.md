---
title: Use Account Tags
---

!!danger*Warning*The features described on this page will soon be deprecated. Refer to the [latest documentation](https://helpnet.flexerasoftware.com/Optima) for information on the latest features.

## In RightScale Optima

RightScale Optima uses account tags in two places:

1. **On the Instant Analyzer**. Account tags are available alongside instance and deployment tags ([read more about tagging][tagging]). Applying an account tag filter will restrict the instances displayed to RightScale accounts which have the tag selected. This filter can be used to create budget alerts, scenarios, and scheduled reports.
2. **In the CSV export feature of the Dashboard**. The downloaded CSV will contain a column for each account tag key present on the accounts in the file, with the tag value for the account being in each row. For example, if you have the accounts and tags below:

    Account ID | Tags
    --- | ---
    1 | org:businessunit=sales, org:location=ny
    2 | org:businessunit=marketing, org:location=ny
    3 | org:businessunit=product, org:location=ca
    4 | org:businessunit=it, org:location=ca

    Then the exported CSV would have these values, along with the other data:

    ... | RightScale Account ID | ... | Cost ($) | org:businessunit | org:location
    --- | --- | --- | --- | --- | ---
    | | 1 | | 200 | sales | ny
    | | 2 | | 300 | marketing | ny
    | | 3 | | 100 | product | ca
    | | 4 | | 500 | it | ca

## Managing Account Tags with Cloud Management

The Cloud Management UI supports tagging accounts that are part of an organization ([read more about RightScale Organization][ee]). To add and remove tags for the organization, first connect to the master account, then go to **Settings** -> **Organization** -> **Accounts**. You should see this screen:

<div class="media">
  <img src="/img/ca-using-account-tags-enterprise-ui.png" alt="">
  <div class="media-caption">
    <small>The enterprise accounts screen. Click on the checkboxes to select accounts, choose an operator (add or remove tags), and click apply</small>
  </div>
</div>

This will then allow you to add or remove multiple tags for the selected accounts at a time:

<div class="media">
  <img src="/img/ca-using-account-tags-add-tags.png" alt="">
  <div class="media-caption">
    <small>Click on the add button to add a tag, and apply to save your changes</small>
  </div>
</div>

Clicking submit will add the tags to the accounts selected:

<div class="media">
  <img src="/img/ca-using-account-tags-tag-added.png" alt="">
  <div class="media-caption">
    <small>The tag <code>demo:tag=master</code> has been applied to the Enterprise Test Master Account</small>
  </div>
</div>

## Managing Account Tags with RightScale API 1.5

RightScale API 1.5 supports tagging accounts through the [Tags resource][api15]. Account tags can be added and removed as for any other resource, with the `resource_href` for an account being `/api/accounts/$account_id`.

!!info*Note:* Although RightScale API 1.5's tagging actions may all operate on or return a list of resources, they can only do so with a single account at a time, because RightScale API 1.5 is scoped by account. To add tags to multiple accounts, you will need to make multiple API calls.

For this example, first generate a `rightscalecookies` file as described at the [Analytics API reference][aapi]. (In general, you can authenticate however you normally do.) This [`multi_add`][ma] call will tag the account ID 62909 with the tag `demo:tag=master` (the call does not return a response body):

```shell
curl https://us-4.rightscale.com/api/tags/multi_add \
      -b rightscalecookies \
      -H 'Content-Type: application/json' \
      -H 'X-Api-Version: 1.5' \
      -H 'X-Account: 62909' \
      -d '{"resource_hrefs": ["/api/accounts/62909"], "tags": ["demo:tag=master"]}'
```

Filtering [`by_resource`][br] by the account HREF then shows the newly-added tag:

[[[
### Request (using curl)
```shell
curl https://us-4.rightscale.com/api/tags/by_resource \
      -b rightscalecookies \
      -H 'Content-Type: application/json' \
      -H 'X-Api-Version: 1.5' \
      -H 'X-Account: 62909' \
      -d '{"resource_hrefs": ["/api/accounts/62909"]}'
```
###

### Response
```json
[
  {
    "tags": [
      {
        "name": "demo:tag=master"
      }
    ],
    "links": [
      {
        "rel": "resource",
        "href": "/api/accounts/62909"
      }
    ],
    "actions": []
  }
]
```
###
]]]

And calling [`multi_delete`][md] removes it (this also has no response body):

```shell
curl https://us-4.rightscale.com/api/tags/multi_delete \
      -b rightscalecookies \
      -H 'Content-Type: application/json' \
      -H 'X-Api-Version: 1.5' \
      -H 'X-Account: 62909' \
      -d '{"resource_hrefs": ["/api/accounts/62909"], "tags": ["demo:tag=master"]}'
```

[tagging]: /cm/rs101/tagging.html
[ee]: /cm/dashboard/settings/enterprise/index.html
[api15]: http://reference.rightscale.com/api1.5/resources/ResourceTags.html
[aapi]: http://reference.rightscale.com/cloud_analytics/analytics_api/index.html#/
[ma]: http://reference.rightscale.com/api1.5/resources/ResourceTags.html#multi_add
[br]: http://reference.rightscale.com/api1.5/resources/ResourceTags.html#by_resource
[md]: http://reference.rightscale.com/api1.5/resources/ResourceTags.html#multi_delete
