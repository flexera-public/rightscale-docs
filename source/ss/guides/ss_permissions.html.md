---
title: CloudApp Permissions in Self-Service
description: This page describes a change to how permissions are handled and how to upgrade your RightScale Self-Service CloudApps from the "legacy" model to the new one.
---

## Introduction

When a CloudApp is launched, or is operated on during its lifecycle, it is interacting with any number of APIs. Most commonly the CloudApp interacts with the RightScale CM API, but it can also interact with other APIs through HTTP functions or, in the future, with Plugins (coming soon).

When a CloudApp interacts with an API, it must use credentials to do so and those credentials are associated with a set of permissions on the external system. For example, if you were to launch a CloudApp, the API calls to RightScale CM API would, historically, be authenticated with your personal account and therefore CM would enforce the permissions that you have.

This page describes a change to how permissions are handled and how to upgrade your CloudApps from the "legacy" model to the new one.

## CloudApp Permission Strategies

There are two types of permission strategies in use in Self-Service:

### Impersonation

The system **impersonates** the user when making API calls. By impersonating the user, that user's permissions are enforced by the other system (such as Cloud Management).

**Applies To**
- Any launch from the Designer UI
- Any launch from the Manager API using [`Execution.create`](http://reference.rightscale.com/selfservice/manager/index.html#/1.0/controller/V1::Controller::Execution/create)

### Delegation

Upon *publishing to the Catalog*, the requisite permissions are "delegated" to the CloudApp and any user launching that CloudApp will inherit those permissions _only in the scope of operating on that CloudApp_. This capability allows you to publish CloudApps to the Catalog that any user can launch without giving the user the requisite permissions in Cloud Management (or other systems).

**Applies To**
- Any launch from the Catalog UI
- Any launch from the Catalog API ([`Application.launch`](http://reference.rightscale.com/selfservice/catalog/index.html#/1.0/controller/V1::Controller::Application/launch))

### How Delegation Works

There are two primary components to delegation: the permissions required by the CloudApp, and the permissions that the "publisher" of the CloudApp has.

#### CloudApp Permissions

Permissions for a given CloudApp fall into two categories: implicit and explicit.

**Implicit** permissions are those that are generated automatically by Self-Service based on the declarations defined in the CloudApp. For example, if a CloudApp has a Server resource declaration, the system will automatically infer that certain permissions are required on the `Server` resource in Cloud Management (in this case, specifically: `create`, `launch`, `show`, `index`, `terminate`, `destroy`). Other types of resources may require different sets of actions. All CloudApps are required to have permissions on the `Deployment` resource, since that is what is created for every CloudApp launch.

**Explicit** permissions are those that are created using [the permissions declaration](../reference/ss_CAT_file_language.html#permissions) in the CAT file itself. These permissions must be defined by the Designer if any RCL code is used that interacts with resources in addition to those defined as resource declarations. For example, if the CAT contains RCL code that reads and writes `Credential` objects, a permisison declaration must exist that specifies the CAT requires read/write from the `Credentials` resource or else some users may fail to launch the CloudApp.

All of the permissions are shown when publishing a CloudApp to the Catalog for your convenience. Explicit permissions are shown based on the declaration names created in the CAT, while implicit permissions are shown on a per-resource basis using a system-generated name (for example a `volume` resource declaration will generate an implicit permission called `volume_permissions`).

#### Permissions Required for Publishing

In order for a Designer to publish a CloudApp to the Catalog, she must have all of the permissions specified in the CAT (both implicit and explicit). If the Designer does not have all of the required permissions, she will not be permitted to publish the CloudApp to the Catalog.

Note that although the system does log the source of delegated permissions, it is not required that the "publisher" maintain those permissions throughout the lifecycle of the CloudApp. The check is made during the publish step only - once the user has been verified to have the required permissions, the permissions are then delegated to the CloudApp in the Catalog as long as it exists there.

#### Granting a User Delegated Permissions

When a CloudApp is launched from the Catalog, the system performs a "union" of the permissions delegated to the CloudApp and the permissions the user has and uses that union as the permission set for all of the following API calls to the Cloud Management API. For example, if a user has `actor` role in Cloud Management, and the CloudApp permissions contain an explicit permission declaration to `read` the `Credentials` resource (which would require `admin` role in Cloud Management), the user's session contains both the `actor` and `admin` role only in the context of operating on the CloudApp through Self-Service.

#### Delegated Permissions and CM Roles

Today, Cloud Management permissions are managed not at the resource level, but at the Role level. For example, in CM you can't grant someone "write access to Security Groups", instead you grant them "security_manager" role, which allows not only write access to Security Groups, but also a set of other related permissions. When using permissions with CloudApps, the system is able to grant the appropriate roles based on the resources being used. For example, if a `security_group` resource declaration exists in the CAT, the system will know to grant the `security_manager` role. Similarly, if a permissions declaration contains read access for `credentials`, the system will know to grant the `admin` role for Cloud Management.

## Updating Legacy CloudApps

Any CloudApp uploaded to Self-Service and published to the Catalog prior to June 24 will not contain "delegation" capabilities. For your convenience, you can locate these CloudApps by navigating to the Catalog and selecting "card view". The cards will show a "Legacy permissions" indicator to Designers and Admins only so that you can re-upload and re-publish the CloudApp.

  ![Legacy Permissions Indicator](/img/ss-legacy-permissions-indicator.png)

In order to get the benefit of delegated permissions, CATs must be re-uploaded to Self-Service and re-published to the Catalog. Note that if the CAT contains RCL code that interacts with other resources, you may also need to add [permissions declarations](../reference/ss_CAT_file_language.html#permissions) in order to capture all of the required permissions.  
