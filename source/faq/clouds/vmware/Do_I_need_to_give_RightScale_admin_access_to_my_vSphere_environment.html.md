---
title: Do I need to give RightScale admin access to my vSphere environment?
category: vmware
description: Some users are hesitant about installing the RightScale Cloud Appliance for vSphere (RCA-V) because they do not want to grant 'admin' access to their existing vSphere environment.
---

## Background Information

Some users are hesitant about installing the RightScale Cloud Appliance for vSphere (RCA-V) because they do not want to grant 'admin' access to their existing vSphere environment.

## Answer

Although you can grant the RightScale platform administrative access to your vSphere environment, it is NOT required.  

However, if you want your vSphere environment to be fully supported via the RightScale Dashboard/API, you will need to grant RightScale the minimum set of permissions to access your environment by creating a role in the vSphere Client that the RightScale platform will use to access your environment. Follow the instructions below to create a role with the minimum set of access permissions. For more detailed information, see Prepare the vSphere environment for RightScale Connectivity.
Create a RightScale Role

1. The first step is to create a new Role. Open the vSphere Client application and go to **View > Administration > Roles**.
2. Click **Add Role** and name it accordingly. (e.g. RightScaleRole)
3. Make sure the role has the following privileges (at a minimum):

* **Datastore**: All
* **Datastore Cluster**
* **Folder**: Create, Delete
* **Global**: Cancel task
* **Host > Local operations**: Create virtual machine, Delete virtual machine, Reconfigure virtual machine
* **(vSphere 5.5 only) Profile-driven storage**: Profile-driven storage view
* **Network**: Assign network
* **Resource**: Apply recommendation, Assign virtual machine to resource pool, Create resource pool, Modify resource pool, Move resource pool, Remove resource pool
* **vApp**: Import
* **Virtual machine**: All
