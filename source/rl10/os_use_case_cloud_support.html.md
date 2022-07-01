---
title: Operating System, Use Case, and Cloud Support
alias: [rl/reference/rl10_os_use_case_cloud_support.html, rl10/reference/rl10_os_use_case_cloud_support.html, rl/os_use_case_cloud_support.html]
description: Comprehensive table listing the operating systems, use cases, and clouds currently supported by RightScale's RightLink 10 agent.
---

<div class="table-responsive">
  <table class="table" style="font-size:12px">
    <!-- Table Main Header -->
    <tr class="active">
      <th>Operating System</th>
      <th>Use Case</th>
      <th>AWS</th>
      <th>Azure<sup><a href="#fn1">[1]</a></sup></th>
      <th>AzureRM<sup><a href="#fn6">[6]</a></sup></th>
      <th>GCE</th>
      <th>RCA-V<sup><a href="#fn2">[2]</a></sup></th>
      <th>OpenStack</th>
      <th>SoftLayer</th>
    </tr>
  <tr>
    <!-- Operating System CentOS 7-->
    <td rowspan="3">CentOS 7</td>
    <!-- Use Case -->
    <td>Enable-running</td>
    <!-- AWS -->
    <td class="success">10.1.0</td>
    <!-- Azure -->
    <td class="success">10.3.0</td>
    <!-- AzureRM -->
    <td class="success">10.5.1</td>
    <!-- Google -->
    <td class="success">10.2.1</td>
    <!-- RCA-V -->
    <td class="success">10.1.4</td>
    <!-- OpenStack -->
    <td class="success">10.1.4/10.5.2<sup><a href="#fn7">[7]</a></sup></td>
    <!-- SoftLayer -->
    <td class="success">10.1.4</td>
  </tr>
  <tr>
    <!-- Use Case -->
    <td>Install-at-boot</td>
    <!-- AWS -->
    <td class="success">10.1.4</td>
    <!-- Azure -->
    <td class="danger">ns</td>
    <!-- AzureRM -->
    <td class="success">10.5.1<sup><a href="#fn5">[5]</a></sup></td>
    <!-- Google -->
    <td class="success">10.2.1<sup><a href="#fn5">[5]</a></sup></td>
    <!-- RCA-V -->
    <td class="success">10.1.4<sup><a href="#fn5">[5]</a></sup></td>
    <!-- OpenStack -->
    <td class="success">10.1.4<sup><a href="#fn5">[5]</a></sup></td>
    <!-- SoftLayer -->
    <td class="success">10.1.4</td>
  </tr>
  <tr>
    <!-- Use Case -->
    <td>Install-on-image</td>
    <!-- AWS -->
    <td class="success">10.1.4</td>
    <!-- Azure -->
    <td class="danger">ns</td>
    <!-- AzureRM -->
    <td class="success">10.5.1<sup><a href="#fn5">[5]</a></sup></td>
    <!-- Google -->
    <td class="success">10.2.1<sup><a href="#fn5">[5]</a></sup></td>
    <!-- RCA-V -->
    <td class="success">10.2.1<sup><a href="#fn5">[5]</a></sup></td>
    <!-- OpenStack -->
    <td class="success">10.1.4<sup><a href="#fn5">[5]</a></sup></td>
    <!-- SoftLayer -->
    <td class="success">10.1.4</td>
  </tr>

  <tr>
    <!-- Operating System CentOS 6-->
    <td rowspan="3">CentOS 6<sup><a href="#fn4">[4]</a></sup></td>
    <!-- Use Case -->
    <td>Enable-running</td>
    <!-- AWS -->
    <td class="success">10.1.0</td>
    <!-- Azure -->
    <td class="success">10.3.0</td>
    <!-- AzureRM -->
    <td class="success">10.5.1</td>
    <!-- Google -->
    <td class="success">10.2.1</td>
    <!-- RCA-V -->
    <td class="success">10.1.4</td>
    <!-- OpenStack -->
    <td class="success">10.1.4/10.5.2<sup><a href="#fn7">[7]</a></sup></td>
    <!-- SoftLayer -->
    <td class="success">10.1.4</td>
  </tr>
  <tr>
    <!-- Use Case -->
    <td>Install-at-boot</td>
    <!-- AWS -->
    <td class="success">10.1.4</td>
    <!-- Azure -->
    <td class="danger">ns</td>
    <!-- AzureRM -->
    <td class="success">10.5.1<sup><a href="#fn5">[5]</a></sup></td>
    <!-- Google -->
    <td class="success">10.2.1<sup><a href="#fn5">[5]</a></sup></td>
    <!-- RCA-V -->
    <td class="success">10.1.4<sup><a href="#fn5">[5]</a></sup></td>
    <!-- OpenStack -->
    <td class="success">10.1.4<sup><a href="#fn5">[5]</a></sup></td>
    <!-- SoftLayer -->
    <td class="success">10.1.4</td>
  </tr>
  <tr>
    <!-- Use Case -->
    <td>Install-on-image</td>
    <!-- AWS -->
    <td class="success">10.1.4</td>
    <!-- Azure -->
    <td class="danger">ns</td>
    <!-- AzureRM -->
    <td class="success">10.5.1<sup><a href="#fn5">[5]</a></sup></td>
    <!-- Google -->
    <td class="success">10.2.1<sup><a href="#fn5">[5]</a></sup></td>
    <!-- RCA-V -->
    <td class="success">10.2.1<sup><a href="#fn5">[5]</a></sup></td>
    <!-- OpenStack -->
    <td class="success">10.1.4<sup><a href="#fn5">[5]</a></sup></td>
    <!-- SoftLayer -->
    <td class="success">10.1.4</td>
  </tr>
  <tr>
    <!-- Operating System -->
    <td rowspan="3">CoreOS</td>
    <!-- Use Case -->
    <td>Enable-running</td>
    <!-- AWS -->
    <td class="success">10.3.0</td>
    <!-- Azure -->
    <td class="success">10.3.0</td>
    <!-- AzureRM -->
    <td class="success">10.5.1</td>
    <!-- Google -->
    <td class="success">10.3.0</td>
    <!-- RCA-V -->
    <td class="success">10.3.0</td>
    <!-- OpenStack -->
    <td class="success">10.3.0/10.5.2<sup><a href="#fn7">[7]</a></sup></td>
    <!-- SoftLayer -->
    <td class="success">10.3.0</td>
  </tr>
  <tr>
    <!-- Use Case -->
    <td>Install-at-boot</td>
    <!-- AWS -->
    <td class="success">10.3.0</td>
    <!-- Azure -->
    <td class="success">10.3.0</td>
    <!-- AzureRM -->
    <td class="success">10.5.1</td>
    <!-- Google -->
    <td class="success">10.3.0</td>
    <!-- RCA-V -->
    <td class="success">10.3.0<sup><a href="#fn3">[3]</a></sup><sup><a href="#fn5">[5]</a></sup></td>
    <!-- OpenStack -->
    <td class="success">10.3.0<sup><a href="#fn5">[5]</a></sup></td>
    <!-- SoftLayer -->
    <td class="danger">ns</td>
  </tr>
  <tr>
    <!-- Use Case -->
    <td>Install-on-image</td>
    <!-- AWS -->
    <td class="success">10.3.0</td>
    <!-- Azure -->
    <td class="success">10.3.0</td>
    <!-- AzureRM -->
    <td class="success">10.5.1</td>
    <!-- Google -->
    <td class="success">10.3.0</td>
    <!-- RCA-V -->
    <td class="success">10.3.0<sup><a href="#fn3">[3]</a></sup><sup><a href="#fn5">[5]</a></sup></td>
    <!-- OpenStack -->
    <td class="success">10.3.0<sup><a href="#fn5">[5]</a></sup></td>
    <!-- SoftLayer -->
    <td class="danger">ns</td>
  </tr>
  <tr>
    <!-- Operating System RHEL 7-->
    <td rowspan="3">RHEL 7</td>
    <!-- Use Case -->
    <td>Enable-running</td>
    <!-- AWS -->
    <td class="success">10.5.3</td>
    <!-- Azure -->
    <td class="danger">ns</td>
    <!-- AzureRM -->
    <td class="success">10.5.3</td>
    <!-- Google -->
    <td class="success">10.5.3</td>
    <!-- RCA-V -->
    <td class="success">10.5.3</td>
    <!-- OpenStack -->
    <td class="success">10.5.3</td>
    <!-- SoftLayer -->
    <td class="danger">ns</td>
  </tr>
  <tr>
    <!-- Use Case -->
    <td>Install-at-boot</td>
    <!-- AWS -->
    <td class="success">10.5.3</td>
    <!-- Azure -->
    <td class="danger">ns</td>
    <!-- AzureRM -->
    <td class="success">10.5.3<sup><a href="#fn5">[5]</a></sup></td>
    <!-- Google -->
    <td class="success">10.5.3<sup><a href="#fn5">[5]</a></sup></td>
    <!-- RCA-V -->
    <td class="success">10.5.3<sup><a href="#fn5">[5]</a></sup></td>
    <!-- OpenStack -->
    <td class="success">10.5.3<sup><a href="#fn5">[5]</a></sup></td>
    <!-- SoftLayer -->
    <td class="danger">ns</td>
  </tr>
  <tr>
    <!-- Use Case -->
    <td>Install-on-image</td>
    <!-- AWS -->
    <td class="success">10.5.3</td>
    <!-- Azure -->
    <td class="danger">ns</td>
    <!-- AzureRM -->
    <td class="success">10.5.3<sup><a href="#fn5">[5]</a></sup></td>
    <!-- Google -->
    <td class="success">10.5.3<sup><a href="#fn5">[5]</a></sup></td>
    <!-- RCA-V -->
    <td class="success">10.5.3<sup><a href="#fn5">[5]</a></sup></td>
    <!-- OpenStack -->
    <td class="success">10.5.3<sup><a href="#fn5">[5]</a></sup></td>
    <!-- SoftLayer -->
    <td class="danger">ns</td>
  </tr>

  <tr>
    <!-- Operating System RHEL 6-->
    <td rowspan="3">RHEL 6<sup><a href="#fn4">[4]</a></sup></td>
    <!-- Use Case -->
    <td>Enable-running</td>
    <!-- AWS -->
    <td class="success">10.5.3</td>
    <!-- Azure -->
    <td class="danger">ns</td>
    <!-- AzureRM -->
    <td class="success">10.5.3</td>
    <!-- Google -->
    <td class="success">10.5.3</td>
    <!-- RCA-V -->
    <td class="success">10.5.3</td>
    <!-- OpenStack -->
    <td class="success">10.5.3</td>
    <!-- SoftLayer -->
    <td class="danger">ns</td>
  </tr>
  <tr>
    <!-- Use Case -->
    <td>Install-at-boot</td>
    <!-- AWS -->
    <td class="success">10.5.3</td>
    <!-- Azure -->
    <td class="danger">ns</td>
    <!-- AzureRM -->
    <td class="success">10.5.3<sup><a href="#fn5">[5]</a></sup></td>
    <!-- Google -->
    <td class="success">10.5.3<sup><a href="#fn5">[5]</a></sup></td>
    <!-- RCA-V -->
    <td class="success">10.5.3<sup><a href="#fn5">[5]</a></sup></td>
    <!-- OpenStack -->
    <td class="success">10.5.3<sup><a href="#fn5">[5]</a></sup></td>
    <!-- SoftLayer -->
    <td class="danger">ns</td>
  </tr>
  <tr>
    <!-- Use Case -->
    <td>Install-on-image</td>
    <!-- AWS -->
    <td class="success">10.5.3</td>
    <!-- Azure -->
    <td class="danger">ns</td>
    <!-- AzureRM -->
    <td class="success">10.5.3<sup><a href="#fn5">[5]</a></sup></td>
    <!-- Google -->
    <td class="success">10.5.3<sup><a href="#fn5">[5]</a></sup></td>
    <!-- RCA-V -->
    <td class="success">10.5.3<sup><a href="#fn5">[5]</a></sup></td>
    <!-- OpenStack -->
    <td class="success">10.5.3<sup><a href="#fn5">[5]</a></sup></td>
    <!-- SoftLayer -->
    <td class="danger">ns</td>
  </tr>
  <tr>
    <!-- Operating System Ubuntu 16.04-->
    <td rowspan="3">Ubuntu 16.04</td>
    <!-- Use Case -->
    <td>Enable-running</td>
    <!-- AWS -->
    <td class="success">10.6.0</td>
    <!-- Azure -->
    <td class="success">10.6.0</td>
    <!-- AzureRM -->
    <td class="success">10.6.0</td>
    <!-- Google -->
    <td class="success">10.6.0</td>
    <!-- RCA-V -->
    <td class="success">10.6.0</td>
    <!-- OpenStack -->
    <td class="success">10.6.0</td>
    <!-- SoftLayer -->
    <td class="warning">nt</td>
  </tr>
  <tr>
    <!-- Use Case -->
    <td>Install-at-boot</td>
    <!-- AWS -->
    <td class="success">10.6.0</td>
    <!-- Azure -->
    <td class="success">10.6.0</td>
    <!-- AzureRM -->
    <td class="success">10.6.0</td>
    <!-- Google -->
    <td class="success">10.6.0</td>
    <!-- RCA-V -->
    <td class="success">10.6.0<sup><a href="#fn5">[5]</a></sup></td>
    <!-- OpenStack -->
    <td class="success">10.6.0<sup><a href="#fn5">[5]</a></sup></td>
    <!-- SoftLayer -->
    <td class="warning">nt</td>
  </tr>
  <tr>
    <!-- Use Case -->
    <td>Install-on-image</td>
    <!-- AWS -->
    <td class="success">10.6.0</td>
    <!-- Azure -->
    <td class="success">10.6.0</td>
    <!-- AzureRM -->
    <td class="success">10.6.0</td>
    <!-- Google -->
    <td class="success">10.6.0</td>
    <!-- RCA-V -->
    <td class="success">10.6.0<sup><a href="#fn5">[5]</a></sup></td>
    <!-- OpenStack -->
    <td class="success">10.6.0<sup><a href="#fn5">[5]</a></sup></td>
    <!-- SoftLayer -->
    <td class="warning">nt</td>
  </tr>
  <tr>
    <!-- Operating System Ubuntu 14.04-->
    <td rowspan="3">Ubuntu 14.04</td>
    <!-- Use Case -->
    <td>Enable-running</td>
    <!-- AWS -->
    <td class="success">10.1.0</td>
    <!-- Azure -->
    <td class="success">10.3.0</td>
    <!-- AzureRM -->
    <td class="success">10.5.1</td>
    <!-- Google -->
    <td class="success">10.2.1</td>
    <!-- RCA-V -->
    <td class="success">10.1.4</td>
    <!-- OpenStack -->
    <td class="success">10.1.4/10.5.2<sup><a href="#fn7">[7]</a></sup></td>
    <!-- SoftLayer -->
    <td class="success">10.1.4</td>
  </tr>
  <tr>
    <!-- Use Case -->
    <td>Install-at-boot</td>
    <!-- AWS -->
    <td class="success">10.1.0</td>
    <!-- Azure -->
    <td class="success">10.3.0</td>
    <!-- AzureRM -->
    <td class="success">10.5.1</td>
    <!-- Google -->
    <td class="success">10.2.1</td>
    <!-- RCA-V -->
    <td class="success">10.1.4<sup><a href="#fn5">[5]</a></sup></td>
    <!-- OpenStack -->
    <td class="success">10.1.4<sup><a href="#fn5">[5]</a></sup></td>
    <!-- SoftLayer -->
    <td class="success">10.1.4</td>
  </tr>
  <tr>
    <!-- Use Case -->
    <td>Install-on-image</td>
    <!-- AWS -->
    <td class="success">10.1.0</td>
    <!-- Azure -->
    <td class="success">10.3.0</td>
    <!-- AzureRM -->
    <td class="success">10.5.1</td>
    <!-- Google -->
    <td class="success">10.2.1</td>
    <!-- RCA-V -->
    <td class="success">10.2.1<sup><a href="#fn5">[5]</a></sup></td>
    <!-- OpenStack -->
    <td class="success">10.1.4<sup><a href="#fn5">[5]</a></sup></td>
    <!-- SoftLayer -->
    <td class="success">10.1.4</td>
  </tr>
  <tr>
    <!-- Operating System Ubuntu 12.04-->
    <td rowspan="3">Ubuntu 12.04</td>
    <!-- Use Case -->
    <td>Enable-running</td>
    <!-- AWS -->
    <td class="success">10.1.0</td>
    <!-- Azure -->
    <td class="success">10.3.0</td>
    <!-- AzureRM -->
    <td class="success">10.5.1</td>
    <!-- Google -->
    <td class="success">10.2.1</td>
    <!-- RCA-V -->
    <td class="success">10.1.4</td>
    <!-- OpenStack -->
    <td class="success">10.1.4/10.5.2<sup><a href="#fn7">[7]</a></sup></td>
    <!-- SoftLayer -->
    <td class="success">10.1.4</td>
  </tr>
  <tr>
    <!-- Use Case -->
    <td>Install-at-boot</td>
    <!-- AWS -->
    <td class="success">10.1.0</td>
    <!-- Azure -->
    <td class="success">10.3.0</td>
    <!-- AzureRM -->
    <td class="success">10.5.1</td>
    <!-- Google -->
    <td class="success">10.2.1</td>
    <!-- RCA-V -->
    <td class="success">10.1.4<sup><a href="#fn5">[5]</a></sup></td>
    <!-- OpenStack -->
    <td class="success">10.1.4<sup><a href="#fn5">[5]</a></sup></td>
    <!-- SoftLayer -->
    <td class="success">10.1.4</td>
  </tr>
  <tr>
    <!-- Use Case -->
    <td>Install-on-image</td>
    <!-- AWS -->
    <td class="success">10.1.4</td>
    <!-- Azure -->
    <td class="success">10.3.0</td>
    <!-- AzureRM -->
    <td class="success">10.5.1</td>
    <!-- Google -->
    <td class="success">10.2.1</td>
    <!-- RCA-V -->
    <td class="success">10.2.1<sup><a href="#fn5">[5]</a></sup></td>
    <!-- OpenStack -->
    <td class="success">10.1.4<sup><a href="#fn5">[5]</a></sup></td>
    <!-- SoftLayer -->
    <td class="success">10.1.4</td>
  </tr>
  <tr>
    <!-- Operating System Windows Server 2012R2-->
    <td rowspan="3">Windows Server 2012R2</td>
    <!-- Use Case -->
    <td>Enable-running</td>
    <!-- AWS -->
    <td class="success">10.2.1</td>
    <!-- Azure -->
    <td class="success">10.3.0</td>
    <!-- AzureRM -->
    <td class="success">10.5.1</td>
    <!-- Google -->
    <td class="success">10.3.1<sup><a href="#fn8">[8]</a></sup></td>
    <!-- RCA-V -->
    <td class="success">10.2.1</td>
    <!-- OpenStack -->
    <td class="success">10.2.1/10.5.2<sup><a href="#fn7">[7]</a></sup></td>
    <!-- SoftLayer -->
    <td class="success">10.2.1</td>
  </tr>
  <tr>
    <!-- Use Case -->
    <td>Install-at-boot</td>
    <!-- AWS -->
    <td class="success">10.6.0</td>
    <!-- Azure -->
    <td class="danger">ns</td>
    <!-- AzureRM -->
    <td class="success">10.6.0</td>
    <!-- Google -->
    <td class="success">10.6.0<sup><a href="#fn8">[8]</a></sup></td>
    <!-- RCA-V -->
    <td class="danger">ns</td>
    <!-- OpenStack -->
    <td class="danger">ns</td>
    <!-- SoftLayer -->
    <td class="danger">ns</td>
  </tr>
  <tr>
    <!-- Use Case -->
    <td>Install-on-image</td>
    <!-- AWS -->
    <td class="success">10.2.1</td>
    <!-- Azure -->
    <td class="success">10.3.0</td>
    <!-- AzureRM -->
    <td class="success">10.5.1</td>
    <!-- Google -->
    <td class="success">10.3.1<sup><a href="#fn8">[8]</a></sup></td>
    <!-- RCA-V -->
    <td class="success">10.2.1</td>
    <!-- OpenStack -->
    <td class="success">10.2.1</td>
    <!-- SoftLayer -->
    <td class="success">10.2.1</td>
  </tr>
  <tr>
    <!-- Operating System Windows Server 2012 -->
    <td rowspan="3">Windows Server 2012</td>
    <!-- Use Case -->
    <td>Enable-running</td>
    <!-- AWS -->
    <td class="success">10.2.1</td>
    <!-- Azure -->
    <td class="success">10.3.0</td>
    <!-- AzureRM -->
    <td class="success">10.5.1</td>
    <!-- Google -->
    <td class="warning">nt</td>
    <!-- RCA-V -->
    <td class="success">10.2.1</td>
    <!-- OpenStack -->
    <td class="success">10.2.1/10.5.2<sup><a href="#fn7">[7]</a></sup></td>
    <!-- SoftLayer -->
    <td class="success">10.2.1</td>
  </tr>
  <tr>
    <!-- Use Case -->
    <td>Install-at-boot</td>
    <!-- AWS -->
    <td class="success">10.6.0</td>
    <!-- Azure -->
    <td class="danger">ns</td>
    <!-- AzureRM -->
    <td class="success">10.6.0</td>
    <!-- Google -->
    <td class="success">10.6.0<sup><a href="#fn8">[8]</a></sup></td>
    <!-- RCA-V -->
    <td class="danger">ns</td>
    <!-- OpenStack -->
    <td class="danger">ns</td>
    <!-- SoftLayer -->
    <td class="danger">ns</td>
  </tr>
  <tr>
    <!-- Use Case -->
    <td>Install-on-image</td>
    <!-- AWS -->
    <td class="success">10.2.1</td>
    <!-- Azure -->
    <td class="success">10.3.0</td>
    <!-- AzureRM -->
    <td class="success">10.5.1</td>
    <!-- Google -->
    <td class="warning">nt</td>
    <!-- RCA-V -->
    <td class="success">10.2.1</td>
    <!-- OpenStack -->
    <td class="success">10.2.1</td>
    <!-- SoftLayer -->
    <td class="success">10.2.1</td>
  </tr>
  <tr>
    <!-- Operating System Windows Server 2008R2 -->
    <td rowspan="3">Windows Server 2008R2</td>
    <!-- Use Case -->
    <td>Enable-running</td>
    <!-- AWS -->
    <td class="success">10.2.1</td>
    <!-- Azure -->
    <td class="success">10.3.0</td>
    <!-- AzureRM -->
    <td class="success">10.5.1</td>
    <!-- Google -->
    <td class="success">10.3.1<sup><a href="#fn8">[8]</a></sup></td>
    <!-- RCA-V -->
    <td class="success">10.2.1</td>
    <!-- OpenStack -->
    <td class="success">10.2.1/10.5.2<sup><a href="#fn7">[7]</a></sup></td>
    <!-- SoftLayer -->
    <td class="success">10.2.1</td>
  </tr>
  <tr>
    <!-- Use Case -->
    <td>Install-at-boot</td>
    <!-- AWS -->
    <td class="success">10.6.0</td>
    <!-- Azure -->
    <td class="danger">ns</td>
    <!-- AzureRM -->
    <td class="success">10.6.0</td>
    <!-- Google -->
    <td class="success">10.6.0<sup><a href="#fn8">[8]</a></sup></td>
    <!-- RCA-V -->
    <td class="danger">ns</td>
    <!-- OpenStack -->
    <td class="danger">ns</td>
    <!-- SoftLayer -->
    <td class="danger">ns</td>
  </tr>
  <tr>
    <!-- Use Case -->
    <td>Install-on-image</td>
    <!-- AWS -->
    <td class="success">10.2.1</td>
    <!-- Azure -->
    <td class="success">10.3.0</td>
    <!-- AzureRM -->
    <td class="success">10.5.1</td>
    <!-- Google -->
    <td class="success">10.3.1<sup><a href="#fn8">[8]</a></sup></td>
    <!-- RCA-V -->
    <td class="success">10.2.1</td>
    <!-- OpenStack -->
    <td class="success">10.2.1</td>
    <!-- SoftLayer -->
    <td class="success">10.2.1</td>
  </tr>

</table>
</div>
<b>Legend:</b><br>
green = minimum RightLink 10 version required<br>
ns = not supported<br>
nt = not tested<br>
<b>Known Limitations:</b><br>
<sup><a name="fn1">[1]</a></sup> Command line based stop requests will result in an "allocated" stop in the Windows Azure cloud. This is type of stopped state is not supported by RightScale so the server will stay in the "Operational" state in RightScale as opposed to transitioning to the stopped state as expected.<br>
<sup><a name="fn2">[2]</a></sup> Static and Dynamic IP addressing not currently supported with Liquid userdata.<br>
<sup><a name="fn3">[3]</a></sup> Requires RCA-V version 2.0_20160415_21 or above.<br>
<sup><a name="fn4">[4]</a></sup> Docker integration not supported due to kernel version not matching minimum requirements.<br>
<sup><a name="fn5">[5]</a></sup> cloud-init is not installed by default on some Linux distributions. In order to use the install-at-boot or install-on-image use-cases cloud-init must be installed and baked into the image per these instructions: [cloud-init Installation](reference/rl10_cloud_init_installation.html).<br>
<sup><a name="fn6">[6]</a></sup> Please see the list of [Known Limitations](/clouds/azure_resource_manager/reference/limitations.html) for the initial release of RightScale support for Azure Resource Manager.<br>
<sup><a name="fn7">[7]</a></sup> Openstack Liberty requires enablement support for the open_stack_v3 cloud type which was added to the enablement scripts for Linux and Windows in RightLink v10.5.2 and above.<br>
<sup><a name="fn8">[8]</a></sup> Private Windows images are not supported on Google Cloud Platform
