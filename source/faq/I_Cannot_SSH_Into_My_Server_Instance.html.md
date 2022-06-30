---
title: I cannot SSH into my server instance
category: general
description: This article provides some troubleshooting tips for using SSH to access your server instance.
---

1. Verify that port 22 is open and the OpenSSH Daemon (sshd) is running:  

    ~~~
    telnet servername 22  
    ~~~   

    You should see something like:

    ~~~
    [root@ip-10-250-18-70:~] telnet ec2-75-101-152-27.compute-1.amazonaws.com 22
    Trying 10.250.18.70...
    Connected to ec2-75-101-152-27.compute-1.amazonaws.com (10.250.18.70).
    Escape character is '^]'.
    SSH-2.0-OpenSSH_4.3
    ~~~

    If the connection times out, it is likely that the server is not listening on the port and/or a firewall is blocking access.&nbsp;&nbsp;

2. Check your security group setup and make sure it looks like this:

    | Permissions |
    | ----------- |
    | TCP IPs:any port:22 |
    | TCP IPs:any port:80 |

    And not:

    | Permissions |
    | ----------- |
    | TCP IPs:0.0.0.0/32 port:22 |
    | TCP IPs:0.0.0.0/32 port:80 |

    In the incorrect example above, the IP address range is restricted to a single address: 0.0.0.0/32. You need&nbsp;to set it to 0.0.0.0/0 to allow _any_ IP address access.

3. Verify that your selected SSH client is working properly. Try a different SSH client like PuTTY, or try from a different browser or computer.

4. If it is apparent that your private SSH key is not working, you can restore the key using the following steps. (Note that this requires a server reboot.)

**Important!** The follwing steps should *not* be needed if you launch your SSH sessions via the SSH icon in the RightScale Dashboard, as described in the article titled [How do I configure my native SSH client to work with RightScale?](http://support.rightscale.com/06-FAQs/FAQ_0062-_How_do_I_configure_my_native_SSH_Client%3F). They are only intended for users who need to access their servers via SSH outside of the RightScale Dashboard.

1. Create a RightScript with this content:

    ~~~
    #!/bin/bash -ex


    echo "$NEW_PRIVATE_SSH_KEY" > /root/.ssh/private_key
    chown 600 /root/.ssh/private_key
    authkeys="/root/.ssh/authorized_keys"


    if [-e ${authkeys}]; then
        cp ${authkeys} ${authkeys}.orig
    fi


    # Generate the public key from the private key
    ssh-keygen -y -f /root/.ssh/private_key > ${authkeys}


    rm -f /root/.ssh/private_key
    ~~~

2. Edit the ServerTemplate used by the server.

3. Add the script to the Boot Scripts section of the ServerTemplate.

4. Edit the "current" inputs for the server. Assign the private key that the server is using to the "NEW_PRIVATE_SSH_KEY" input.

5. Reboot the instance from the Dashboard.

6. Wait for the server to become operational, then attempt to SSH into the box.

7. When you have successfully initiated an SSH connection to the server, remove the script from the ServerTemplate.
