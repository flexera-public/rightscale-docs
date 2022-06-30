---
title: Tags
layout: general.slim
---

## Search for Tag Resources

Search for resources that have a list of tags in a specific resource_type.

### Curl

#### Example Call

**Prerequisite** : Example assumes you have previously [authenticated](/api/api_1.5_examples/authentication.html), and your valid session cookie is in 'mycookie'. Requires 'admin' role.

~~~
    curl -i -H X_API_Version:1.5 -b mycookie -X POST \
     -d resource_type=instances \
     -d tags[]=database:active=true \
     -d tags[]=rs_monitoring:state=active \
     -d match_all=true \ #This is an optional parameter
    https://my.rightscale.com/api/tags/by_tag.xml
~~~

#### Sample Output

**Note** :

- Truncated XML output without headers included (to save space).
- If the parameter match_all is "false," then the search performed is an "OR" operation (resources having any of the tags are returned). If the parameter match_all is "true," then only resources having all the tags are returned. If match_all is not used at all, it will be similar to setting the value to "false."

~~~
    <?xml version="1.0" encoding="UTF-8"?>
    <resource_tags>
      <resource_tag>
        <actions></actions>
        <tags></tags>
        <links>
          <link href="/api/clouds/2354/instances/4RUUKTF408BH3" rel="resource"/>
          <link href="/api/clouds/232/instances/AQL2EQGBME2FB" rel="resource"/>
          <link href="/api/clouds/2354/instances/FP4GMGUNPITI8" rel="resource"/>
          <link href="/api/clouds/1829/instances/653G974B4M0B4" rel="resource"/>
          <link href="/api/clouds/2354/instances/1LP9P2NRFBHM5" rel="resource"/>
          <link href="/api/clouds/2354/instances/6TQJ9OVJOPPBN" rel="resource"/>
          <link href="/api/clouds/2356/instances/CIVMM4POCO2L0" rel="resource"/>
          <link href="/api/clouds/2354/instances/ENTV3C091RQ0H" rel="resource"/>
          <link href="/api/clouds/232/instances/FPDNFAIIUT8RP" rel="resource"/>
        </links>
      </resource_tag>
    </resource_tags>
~~~
