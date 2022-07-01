---
title: Migration of RightScripts to work with RightLink 10
alias: [rl/migration/rl10_rightscript_migration.html, rl10/migration/rl10_rightscript_migration.html, rl/reference/rl10_rightscript_migration.html, rl10/reference/rl10_rightscript_migration.html, rl10/reference/10.6.0/rl10_rightscript_migration.html, rl10/reference/10.5.3/rl10_rightscript_migration.html]
description: Provide steps to enable RightScripts used with older versions of RightLink to work with RightLink 10.
---

RightScripts used with RightLink 5 and 6 may not work with RightLink 10 due to [incompatibilities](/rl10/reference/rl10_incompatibilities_with_rl6.html). Below are common issues and suggested steps to alter your code to work with RightLink 10. The recommended workflow is to develop on a separate copy of your existing RightScripts specifically for RightLink 10. Updating a single set of RightScripts to work in both RightLink 6 and RightLink 10 is *not* recommended. Lastly, use of the [right_st](/rl10/reference/rl10_storing_scripts_in_git_svn.html#right-st-tool-method) tool is recommended.

### RightScripts run as non-root
 If a command in your script requires root privileges, you can add `sudo` to the front of that command. If the whole script requires root privileges, you can alter the hashbang line by adding sudo to it, ie `#!/usr/bin/sudo /bin/bash`.

### 'Packages' field does not install packages
 The "Packages" field for RightScripts in the RightScale dashboard is no longer used to install packages. This field is used to set the `RS_PACKAGES` environment variable with a space-separated list. *RightLink 10 does no actions with the `RS_PACKAGES` environment variable.* It is suggested that RightScripts install any required packages, avoiding the use of the "Packages" field.  If use of the "Packages" field is desired, the RightScale provided [example script](https://github.com/rightscale/rightlink_scripts/blob/master/rll-examples/install-packages.sh) implements some suggested semantics using `RS_PACKAGES` to install packages.

### Reduced number of predefined environment variables
 Pre-defined environment variables have been reduced to `RS_ATTACH_DIR`, `RS_SELF_HREF`, and `RS_PACKAGES`. It is suggested to write idempotent scripts to replace use of `RS_REBOOT` and using operating system provided resources to replace `RS_DISTRO` and `RS_ARCH` such as the `/etc/os-release` file and `uname` command.

### No frozen software repositories
 Use of [frozen software repositories](/cm/rs101/freezing_software_repositories.html) are ignored as RightLink 10 does not setup OS mirrors. It is strongly recommended to follow best practices by using the current software repositories provided by the OS, as they are often updated based on security and dependability concerns. If a frozen software repository is required, this must be done in a RightScript. The RightScale provided [example script](https://github.com/rightscale/rightlink_scripts/blob/master/rll-examples/rightscale-mirrors.sh) shows how to implement a frozen software repository.  Another method would be to attach the specific package file to the RightScript and update the code to install from `RS_ATTACH_DIR`.
!!info*Please note:*RightScale provided frozen software repositories will be deprecated in the future.

### No hiding of credentials in audit entries
STDOUT and STDERR from RightScripts are sent to audit entries and are NOT filtered to hide credentials. It is strongly suggested to review the scripts and verify that credentials are not sent to STDOUT or STDERR.

### 'rs_*' commands are no longer used
`rs_*` commands are no longer used.  RightLink 10 ships with [`rsc`, a RightScale Client command line tool](https://github.com/rightscale/rsc/blob/master/README.md), and should be used instead to make API calls through [local and proxied HTTP requests](/rl10/reference/rl10_local_and_proxied_http_requests.html). Following is an example function to add to your bash scripts to replicate `rs_tag`:
~~~bash
function rs_tag() {
  case $1 in
  "--list"|"-l")
    action="by_resource"
    options="--xm .name"
    ;;
  "--add"|"-a")
    action="multi_add"
    options="tags[]=$2"
    ;;
  "--remove"|"-r")
    action="multi_delete"
    options="tags[]=$2"
    ;;
  *)
    echo "$1 UNSUPPORTED OPTION"
    return 1
    ;;
  esac
  rsc --retry=5 --timeout=60 --rl10 cm15 $action /api/tags/$action \
    resource_hrefs[]=$RS_SELF_HREF \
    $options
}
~~~

### No Private Sandbox
RightLink 6 used commands and software packages installed in a private sandbox located at `/opt/rightscale/sandbox` for Linux and `%ProgramFiles(x86)%\RightScale\sandbox` for Windows. This was the location where Ruby, Rubygems, and `rs_*` commands were installed to be used by RightScripts. With RightLink 10, the private sandbox does not exist and commands and packages installed on the OS are exclusively used.

### Remotely Running RightScripts
As stated earlier, ['rs_*' commands are no longer used](#--rs_*--commands-are-no-longer-used), including `rs_run_right_script` and `rs_run_recipe`. These commands used with the `--recipient_tags` option could remotely execute RightScripts on servers in the same deployment. If these commands were used for automation and orchestration, [Self-Service](/ss/about.html) is the recommended method to do so with RightLink 10.

Alternatively, [`rsc`](https://github.com/rightscale/rsc/blob/master/README.md) can be used to replicate this function, provided an [API Refresh Token](/cm/dashboard/settings/account/enable_oauth.html). Please be careful! This is a user-specific OAuth 2.0 refresh token representing a grant with unrestricted scope. Anyone who possesses it can login to RightScale's API and perform requests on any account with all of your permissions. For more information, including how to enable and obtain the API Refresh Token, consult the [OAuth documentation](/cm/dashboard/settings/account/enable_oauth). Following is an example Bash RightScript that uses `rsc` to remotely run `LB_Attach_Application_Server` RightScript on all instances in the local deployment with the tag `load_balancer:active=true`:

~~~bash
#!/bin/bash -e
# ---
# RightScript Name: APP Remote Request LB Attach
# Description: |
#   Remotely runs the RightScript 'LB Attach Application Server' on all servers in the local
#   deployment with the tag 'load_balancer:active=true'
# Inputs:
#   REFRESH_TOKEN:
#     Input Type: single
#     Category: RightScale
#     Description: API Refresh Token
#     Required: true
#     Advanced: false
#     Default: cred:REFRESH_TOKEN
#   TOKEN_ENDPOINT:
#     Input Type: single
#     Category: RightScale
#     Description: API Token Endpoint
#     Required: true
#     Advanced: false
#     Default: cred:TOKEN_ENDPOINT
# Attachments: []
# ...

desired_tag="load_balancer:active=true"
rightscript_name="LB Attach Application Server"

retry_args="--retry=5 --timeout=60"

# REFRESH_TOKEN and TOKEN_ENDPOINT should be cred inputs
auth_args="--refreshToken=$REFRESH_TOKEN --host=$TOKEN_ENDPOINT"

# Obtain deployment_href current instances is in
deployment_href=$(
  rsc $retry_args \
  --rl10 cm15 index_instance_session /api/sessions/instance \
  --x1 ':has(.rel:val("deployment")).href'
)

# Obtain all instance_hrefs from servers in deployment
deployment_instance_hrefs=$(
  rsc $retry_args $auth_args \
  cm15 servers $deployment_href \
  --xm ':has(.rel:val("current_instance")).href'
)

# Obtain all instance_hrefs from servers with desired tag
tagged_instance_hrefs=$(
  rsc $retry_args $auth_args \
  cm15 by_tag /api/tags/by_tag resource_type=instances "tags[]=$desired_tag" \
  --xm ':has(.rel:val("resource")).href'
)

# Find union of servers in deployment with desired tag
tagged_in_deployment_instance_hrefs=$(
  printf '%s\n' $deployment_instance_hrefs $tagged_instance_hrefs | sort | uniq -d | tr -d '"'
)

# Run remote RightScript on discovered servers
for instance_href in $tagged_in_deployment_instance_hrefs; do
  # Obtain resource_uid from instance to be used to specify where to run RightScript
  instance_ruid=$(
    rsc $retry_args $auth_args \
    cm15 show $instance_href \
    --x1 '.resource_uid' | tr -d '"'
  )
  cloud_attribute=$(echo $instance_href | cut --delimiter='/' --fields=-5)

  # Obtain rightscript_id specific to ST attached to instance
  st_href=$(
    rsc $retry_args $auth_args \
    cm15 show $instance_href \
    --x1 ':has(.rel:val("server_template")).href'
  )
  rightscript_id=$(
    rsc $retry_args $auth_args \
    cm15 index $st_href/runnable_bindings \
    --x1 ":has(.sequence:val(\"operational\")):has(.name:val(\"$rightscript_name\")).id"
  )

  # Run remote RightScript
  rsc $retry_args $auth_args \
  cm15 multi_run_executable ${cloud_attribute}/multi_run_executable \
  "right_script_href=/api/right_scripts/$rightscript_id" \
  "filter[]=resource_uid==$instance_ruid"
done
~~~
