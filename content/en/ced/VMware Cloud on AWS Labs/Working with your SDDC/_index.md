---
title: "Working with your SDDC"
linkTitle: "Working with your SDDC"
weight: 10
description: >
 In this lab we are going to start with looking at the basic tasks which you will perform in the VMware Cloud on AWS user interface when you are administering the platform.
---

## Viewing your SDDC

![SDDC-Network-Login](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/working-with-sddc-lab/sddc-login.jpg)

Access VMware Cloud on AWS console using <https://vmc.vmware.com> and use your assigned login credentials **ced##@vmware-hol.com**.

After you login, you should see two single-node SDDC's in the user interface following the naming format Student-##. An SDDC is a fully deployed environment including vSphere, NSX, vSAN and vCenter Server. Deployment of a fully configured SDDC takes about 90 minutes so for the purposes of this lab, we have already deployed it for you.

This SDDC is in the same state it would be if you have deployed it.

Let's take a look at the SDDC properties.

![SDDC-Network-01](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/working-with-sddc-lab/sddc01.jpg)

1. First identify your SDDC that is assigned to you (Student-##).
2. Click on **View Details** to open the SDDC properties.

![SDDC-Network-02](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/working-with-sddc-lab/sddc02.jpg)

You will start with the Summary of the SDDC. There are a number of other tabs available as follows:

1. **Support**: You can contact Support with your SDDC ID, Org ID, vCenter Private and Public IPs and the date of your SDDC Deployment.
2. **Settings**: Gives you access to your vSphere Client (HTML5), vCenter Server API, PowerCLI Connect, vCenter Server and reviews your Authentication information.
3. **Troubleshooting**: Allows you to run network connectivity tests to ensure all necessary access is available to perform select use cases.
4. **Add Ons**: Here you will find Add On services for your VMware Cloud on AWS environment like Hybrid Cloud Extension and VMware Site Recovery.
5. **Networking & Security**: Provides a full diagram of the Management and Compute Gateways.  This is where you can configuration locgical networks, VPN's and firewall rules. We will cover this in more detail later. Click on **Networking & Security** to proceed to the next article to learn more about VMware Cloud on AWS Network and Security Configuration.

## Create a Logical Network

![SDDC-Network-03](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/working-with-sddc-lab/sddc03.jpg)

From the previous article, you should see the **Network & Security** information for the SDDC.
VMware Cloud on AWS allows you to quickly and easily create new logical network segments on demand. Let's create a new network segment in the SDDC.

1. Click the **Networking & Security** tab, then click on **Segments** to show all of the existing network segments.
2. Click on **Add Segments** to create a new network segment.
3. Enter **Demo-Net** for the Name of the new network segment.
4. For the Gateway/Prefix Length enter **10.10.xx.1/24** (xx depicts your student number). This represents the default gateway of the network and the prefix length of the network. For more details on IP addressing see below.
5. For **DHCP**, click the down arrow and select **Enabled** to enable DHCP on the network.
6. Enter **10.10.xx.10-10.10.xx.200** for the **DHCP IP Range**. This is the range of IP addresses the DHCP server will grant to workloads attached to the network.
7. Click **Save** to save the logical network.

**Note: Make sure you leave the default of Routed for Type and do not enter anything for the DNS suffix.**

{{< alert title="Note - CIDR Notation" >}}

CIDR notation is a compact representation of an IP address and its associated routing prefix. The notation is constructed from an IP address, a slash('/') character, and a decimal number. The number is the count of leading bits in the routing mask, traditionally called the network mask.  The IP address is expressed according to the standards of IPv4 or IPv6.

The address may denote a single, distinct interface address or the beginning address of an entire network. The maximum size of the network is given by the number of addresses that are possible with the remaining, least-significant bits below the prefix.  The aggregation of these bits is often called the host identifier.

For example:

* 192.168.100.14/24 represents the IPV4 address 192.168.100.14 and its associated routing prefix 192.168.100.0, or equivalently, its subnet mask 255.255.255.0, which has 24 leading 1-bits.
* The IPV4 block 192.168.100.0/22 represents the 1024 IPV4 addresses from 192.168.100.0 to 192.168.103.255.
{{< /alert >}}

## Verify Network Segment Configuration

![SDDC-Network-04](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/working-with-sddc-lab/sddc04.jpg)

1. Verify the network segment was added correctly.  Your information should match the highlighted area above.

## Configure Firewall Rule for vCenter Access

![SDDC-Network-05](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/working-with-sddc-lab/sddc05.jpg)

By default, all inbound firewall rules are set to Deny in VMware Cloud on AWS. In order to access vCenter server, we will need to configure a firewall rule allowing inbound access.

**Note: In most enterprise environments, you would create VPN or Direct Connect VIF to allow limited access firewall rules to vCenter. In this environment, we will open it to any IP address on the internet which is not recommended.**

1. Click on **Gateway Firewall** on the lefthand side of the screen.
2. If it is not already selected, click on **Management Gateway** to create a firewall rules that allow access to management components in the SDDC.
3. Click **Add New Rule** to add a new rule to the edge gateway.
4. For the **Name** enter **vCenter Inbound Rule**.
5. Click **Set Source** to define the source for the firewall rule.

### Select the Firewall Rule Source

![SDDC-Network-06](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/working-with-sddc-lab/sddc06.jpg)

1. Click the radio button next to **Any**.
2. Click **Save** to save the source information in the rule.

### Configure Firewall Rule for vCenter Access (Continued)

![SDDC-Network-07](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/working-with-sddc-lab/sddc07.jpg)

1. Click **Set Destination** to launch a new window to set the destination for the rule.

### Select the Firewall Rule Destination

![SDDC-Network-08](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/working-with-sddc-lab/sddc08.jpg)

1. Click the radio button next to **System Defined Groups**.
2. Select the checkbox next to **vCenter**.
3. Click **Save** to save the destination information in the rule.

### Configure Firewall rule for vCenter Access (Contined)

![SDDC-Network-09](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/working-with-sddc-lab/sddc09.jpg)

Continue configuring the vCenter Inbound Rule:

1. Click box below **Services** and select **HTTPS (TCP 443)** to allow SSL access to the vCenter server.
2. Publish the rules by clicking **Publish** button to activate the firewall rule.

vCenter should now be accessible from anywhere in the internet.  in the next section, we will access vCenter HTML5 client to being configuring virtual machines.

## Log into VMware Cloud on AWS vCenter

![SDDC-vcenter-010](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/working-with-sddc-lab/sddc010.jpg)

The settings to connect to the vCenter server associated with the SDDC is available on the setting tab for the SDDC. Let's connect to the vCenter server and login.

1. Click on the **Settings** tab for the SDDC we configured in the last lesson.
2. Click the **arrow** next to Default vCenter User Account to expose the login details. In this lab we will use the default cloudadmin@vmc.local user.
3. Copy the **password** by clicking the two squares next to the password. This will copy it to the consoles clipboard.
4. Click the **arrow** next to **vSphere Client (HTML5)** to expose the URL for vCenter.
5. Click the **URL** link to **open** the vSphere Client in another tab.

**NOTE: If you experience any login issues below, you can click the two boxes next to the URL below to paste the URL into an incognito window. This should not be needed normally.**

### Login to the vSphere Client (HTML5)

To login to the vSphere Client (HTML5):

![SDDC-vcenter-011](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/working-with-sddc-lab/sddc011.jpg)

1. In the User name field enter **cloudadmin@vmc.local**
2. Right-click in the **Password** field and paste the password copied in the previous step.
3. Click **Login**.

### vSphere Client (HTML5)

![SDDC012](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/working-with-sddc-lab/sddc012.jpg)

You are now logged in to your VMware Cloud on AWS vCenter Server as cloudadmin@vmc.local user.

## Create Content Library

Content libraries are container objects for VM templates, vApp templates, and other types of files like ISO images.

You can create a content library in the vSphere Client (HTML5), and populate it with templates, which you can use to deploy virtual machines or vApps in your VMware Cloud on AWS environment or if you already have a Content Library in your on-premises data center, you can use the Content Library to import content into your SDDC.

You can create two types of libraries: local or subscribed library.

### Local Libraries

You use a local library to store items in a single vCenter Server instance. You can publish the local library so that users from other vCenter Server systems can subscribe to it. When you publish a content library externally, you can configure a password for authentication.

VM templates and vApps templates are stored as OVF file formats in the content library. You can also upload other file types, such as ISO images, text files, and so on, in a content library.

### Subscribed Libraries

You subscribe to a published library by creating a subscribed library. You can create the subscribed library in the same vCenter Server instance where the published library is, or in a different vCenter Server system. In the Create Library wizard you have the option to download all the contents of the published library immediately after the subscribed library is created, or to download only metadata for the items from the published library and later to download the full content of only the items you intend to use.

To ensure the contents of a subscribed library are up-to-date, the subscribed library automatically synchronizes to the source published library on regular intervals. You can also manually synchronize subscribed libraries.

You can use the option to download content from the source published library immediately or only when needed to manage your storage space.

Synchronization of a subscribed library that is set with the option to download all the contents of the published library immediately, synchronizes both the item metadata and the item contents. During the synchronisation the library items that are new for the subscribed library are fully downloaded to the storage location of the subscribed library.

Synchronization of a subscribed library that is set with the option to download contents only when needed synchronizes only the metadata for the library items from the published library, and does not download the contents of the items. This saves storage space. If you need to use a library item you need to synchronize that item. After you are done using the item, you can delete the item contents to free space on the storage. For subscribed libraries that are set with the option to download contents only when needed, synchronizing the subscribed library downloads only the metadata of all the items in the source published library, while synchronizing a library item downloads the full content of that item to your storage.

If you use a subscribed library, you can only utilize the content, but cannot contribute with content. Only the administrator of the published library can manage the templates and files.

### Access Content Libraries in the vSphere Client

![SDDC013](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/working-with-sddc-lab/sddc013.jpg)

1. Click on **Menu**
2. Click on **Content Libraries**

### Subscribe to an existing Content Library

![SDDC014](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/working-with-sddc-lab/sddc014.jpg)

1. In your Content Library window, click the **+ (plus)** sign to add a new Content Library.

![SDDC015](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/working-with-sddc-lab/sddc015.jpg)

1. Enter **VMC Content Library** for the Name of the library.
2. Click the **Next** button.

![SDDC016](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/working-with-sddc-lab/sddc016.jpg)

1. Select the radio button next to **Subscribed content library.**
2. Under **Subscription URL** enter the following: <https://vmc-elw-vms.s3-accelerate.amazonaws.com/lib.json>
3. Leave the checkbox **unchecked** next to **Enable Authentication**.
4. Make sure **Download content** is set to **immediately**.
5. Click **Next** to continue.

![SDDC017](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/working-with-sddc-lab/sddc017.jpg)

1. Click on **WorkloadDatastore** for content library storage.
2. Click the **Next** button.

![SDDC018](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/working-with-sddc-lab/sddc018.jpg)

1. Click the **Finish** button.

**Note:  Depending the size and number of templates it can take a while to sync the content.  This content library should only take a few minutes to synchronize.**

## Create Linux Customization Specification

When you clone a virtual machine or deploy a virtual machine from a template, you can customize the guest operating system of the virtual machine to change properties such as the computer name, network settings, and license settings.

Customizing guest operating systems can help prevent conflicts that can result if virtual machines with identical settings are deployed, such as conflicts due to duplicate computer names.

You can specify the customization settings by launching the Guest Customization wizard during the cloning or deployment process. Alternatively, you can create customization specifications, which are customization settings stored in the vCenter Server database. During the cloning or deployment process, you can select a customization specification to apply to the new virtual machine.

Use the Customization Specification Manager to manage customization specifications you create with the Guest Customization wizard.

### Navigate to Customization Specifications

![SDDC019](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/working-with-sddc-lab/sddc019.jpg)

1. Click **Menu**.
2. Click on **Policies and Profiles**.

### Add a new VM Customization Specification

![SDDC020](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/working-with-sddc-lab/sddc020.jpg)

1. Click on **+ New** to add a new Linux Customization Specification.

### Define Customization Specification Details

![SDDC021](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/working-with-sddc-lab/sddc021.jpg)

1. Enter a **Name** for the Linux Customization Specification (**LinuxSpec** in this example).
2. Optionally enter a **Description**.
3. Select the radio button for **Linux** next to **Target guest OS**.
4. Click the **Next** button to continue.

### Define Specification Naming Standard

![SDDC022](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/working-with-sddc-lab/sddc022.jpg)

1. Click the radio button next to **Use the virtual machine name**.
2. For **Domain name** enter **corp.local**.
3. Click the **Next** button to continue.

### Select Time Zone

![SDDC023](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/working-with-sddc-lab/sddc023.jpg)

1. Select the appropriate **Area** by clicking on the arrow next to the dropdown field.
2. Select the appropriate **Location**.
3. Click the **Next** button to continue.

### Select Network Settings

![SDDC024](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/working-with-sddc-lab/sddc024.jpg)

1. Ensure the radio button next to **Use standard network settings for the guest operating system, including enabling DHCP in all network interfaces** is selected.
2. Click **Next** to continue.

### Enter DNS Settings

![SDDC025](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/working-with-sddc-lab/sddc025.jpg)

1. Enter **8.8.8.8** for the Primary DNS server.
2. Enter **8.8.4.4** for the Secondary DNS server.
3. For the DNS Search paths enter **corp.local**.
4. Click the **Add** button to add the corp.local domain to the DNS search path.
5. Click **Next** to continue.

### Finish Creating the Customization Spec

![SDDC026](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/working-with-sddc-lab/sddc026.jpg)

1. Review your entries and click on the **Finish** button.

### Customization Spec Created

![SDDC027](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/working-with-sddc-lab/sddc027.jpg)

Congratulations!  You have successfully created your VM Customization Spec for your Linux VM's.  You can also Export (Duplicate), Edit, Import, and Export a VM Customization Spec.

## Deploy a Virtual Machine

![SDDC-deploy-vm-013](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/working-with-sddc-lab/sddc013.jpg)

In the vSphere client window already opened, deploy a template from the content library:

1. Click **Menu**.
2. Click on **Content Libraries**.

### Select Content Library

![SDDC-deploy-vm-028](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/working-with-sddc-lab/sddc028.jpg)

1. Click on the **VMC Content Library** that was previously synchronized.

### Deploy a New Virtual Machine from Template

![SDDC-deploy-vm-029](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/working-with-sddc-lab/sddc029.jpg)

1. Click the **Templates** tab to access the template synchronized in the content library.
2. Right-click on the **photoapp-u**  template to expose the Actions menu.
3. Click on **New VM from This Template** to deploy a virtual machine from template.

### Choose Virtual Machine Name and Location

![SDDC-deploy-vm-030](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/working-with-sddc-lab/sddc030.jpg)

{% capture notice--custspec1 %}
**Note:**
Please skip adding the customization specification by not checking the box next to **Customize the operating system**
{% endcapture %}

<div class="notice--info">
  {{ notice--custspec1 | markdownify }}
</div>

1. Enter **webserver01** for the virtual machine name.
2. Click the **arrow** next to SDDC-Datacenter to expose the folders available.
3. In VMware Cloud on AWS customer workloadds should be placed in the Workloads folder (or subfolder).  Click the **Workloads** folder.
4. Select the checkbox next to  **Customize the operating system**.
5. Click **Next** to continue.

### Choose Virtual Machine Customization Specification

![SDDC-deploy-vm-031](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/working-with-sddc-lab/sddc031.jpg)

We will utilize the customization specification created in a previous module to customize the operating system.

1. Click to select the **LinuxSpec** customization specification.
2. Click **next** to continue.

### Select Resource Pool

![SDDC-deploy-vm-032](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/working-with-sddc-lab/sddc032.jpg)

1. Click the arrow next to **Cluster-1** to expose the resource pools available.
2. In VMware Cloud on AWS customer workloads should be placed in the **Compute-ResourcePool** (or subpool).  Click **Compute-ResourcePool**.
3. Click **Next** to continue.

### Review the Template Details

![SDDC-deploy-vm-033](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/working-with-sddc-lab/sddc033.jpg)

Review the details of the template to be deployed.  There may be a security warning displayed, but you can safely ignore that for the purpose of this lab.

1. Click **Next** to continue.

### Select Storage

![SDDC-deploy-vm-034](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/working-with-sddc-lab/sddc034.jpg)

Each VMware Cloud on AWS SDDC will include two datastores in order to separate management and customer workloads.  All customer workloads should be placed in the datastore named WorkloadDatastore.

1. Click **WorkloadDatastore** to select the datastore where the virtual machine will be provisioned.
2. Click **Next** to continue.

### Select the Network for the Virtual Machine

![SDDC-deploy-vm-035](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/working-with-sddc-lab/sddc035.jpg)

We will use the logical network created in a previous exercise for these virtual machines.

1. Click the arrow below **Destination Network** to select the network for the virtual machine.
2. Click **Demo-Net** to select the network previously created.
3. Click **Next** to continue.

### Complete the Virtual Machine Deployment

![SDDC-deploy-vm-036](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/working-with-sddc-lab/sddc036.jpg)

1. Review the information for accuracy and click **Finish** to deploy the virtual machine

It should take a couple of minutes for the virtual machine to deploy.  Continue to the next exercise to clone this virtual machine in order to create a second webserver.

## Clone a Virtual Machine

In this exercise, you will clone the virtual machine created in the previous exercise in order to create a second webserver.

### Navigate to VMs and Templates

![SDDC-clone-vm-037](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/working-with-sddc-lab/sddc037.jpg)

1. Validate the virtual machine deployment completed in the previous exercise by looking for the **Deploy OVF Template** task and verifying it is **Complete**.
2. If complete, click on **Menu**.
3. Click **VMs and Templates** to navigate to the VMs and Templates view.

### Select and Power On Webserver01

![SDDC-clone-vm-038](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/working-with-sddc-lab/sddc038.jpg)

Before we can clone the web server, we will first need to power the VM on so the customization specification can execute:

1. Click the **arrow** next to **SDDC-Datacenter** to expose the sub-folders.
2. Click the **arrow** next to workloads to expose **webserver01**
3. Click on the virtual machine **webserver01**
4. Click the **green arrow** in the top center of the screen to execte the power on operation.

**Note: Please wait until the virtual machine is fully powered on before proceeding to the next step.**

{% capture notice-3 %}
If the webserver doesn't connect to the network and does not receive an IP address from DHCP. Ensure the NIC is connected by right-clicking on **webserver01** and then **Edit Settings** and make sure the checkbox next to **Connected** is selected. You may need to repeat this step for the cloned VM **webserver02**
{% endcapture %}
<div class="notice--info">
  {{ notice-3 | markdownify }}
</div>

### Initiate Cloning of the Virtual Machine

![SDDC-clone-vm-039](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/working-with-sddc-lab/sddc039.jpg)

We will now begin the process of cloning this virtual machine.

1. Right-click on **webserver01** to expose the Actions menu.
2. Click on **Clone** to expose a secondary menu of options.
3. Click **Clone to Virtual Machine** to initiate the cloning wizard.

### Select Virtual Machine Name and Folder

![SDDC-clone-vm-040](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/working-with-sddc-lab/sddc040.jpg)

1. Next to **Virtual machine name** enter **webserver02**.
2. Click the **Workloads** folder for the virtual machine location.
3. Click **Next** to continue.

### Select Virtual Machine Compute Resource

![SDDC-clone-vm-041](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/working-with-sddc-lab/sddc041.jpg)

1. Click on **Compute-ResourcePool** to ensure it is selected for the target virtual machine.
2. Click **Next** to continue.

### Select Virtual Machine Datastore

![SDDC-clone-vm-042](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/working-with-sddc-lab/sddc042.jpg)

1. Click on **WorkloadDatastore** to ensure it is selected as the destination for the virtual machine.
2. Click **Next** to continue.

{% capture notice--custspec %}
**Note:**
Please skip adding the customization specification by not checking the box next to **Customize the operating system**
{% endcapture %}

<div class="notice--info">
  {{ notice--custspec | markdownify }}
</div>

### Select Cloning Options

![SDDC-clone-vm-043](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/working-with-sddc-lab/sddc043.jpg)

We will now set the options for cloning.  We will need to customize the operating system to change the server name and als power on the virtual machine after cloning is complete.

1. Click the checkbox next to **Customize the operating system**.
2. Click the checkbox next to **Power on virtual machine after creation**.
3. Click **Next** to continue.

### Choose the Virtual Machine Customization Specification

![SDDC-clone-vm-044](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/working-with-sddc-lab/sddc044.jpg)

We will utilize the customization specification created in a previous exercise to customize the operating system.

1. Click to select the **LinuxSpec** customization specification.
2. Click **Next** to continue.

### Complete a Virtual Machine Deployment

![SDDC-clone-vm-045](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/working-with-sddc-lab/sddc045.jpg)

1. Review the information for accuracy and click **Finish** to clone the virtual machine.

It should take a couple of minutes fort the virtual machine to clone.  Continue to the next exercise to learn about securing workloads in VMware Cloud on AWS.

{% capture notice-4 %}
If the webserver doesn't connect to the network and does not receive an IP address from DHCP. Ensure the NIC is connected by right-clicking on **webserver01** and then **Edit Settings** and make sure the checkbox next to **Connected** is selected. You may need to repeat this step for the cloned VM **webserver02**
{% endcapture %}
<div class="notice--info">
  {{ notice-4 | markdownify }}
</div>

## Testing connectivity between the Virtual Machines

In this exercise we will test the connectivity between webserver01 and webserver02, which we created in the previous exercises.

### Open Console to Webserver01

![SDDC-test-vm-046](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/working-with-sddc-lab/sddc046.jpg)

We need to open a console session to webserver01 to validate it can communicate with webserver02.

1. In the vSphere Client (HTML5) click on Webserver01 to bring it into focus.
2. Click the black box below Summary in the middle of the screen. This will attempt to launch a console session but it may fail because the pop-up was blocked. If this occurs follow steps 3-6, otherwise proceed to the next section.
3. Click the icon with the small red x in the Chrome address bar to launch to pop-up blocker dialog.
4. Click the radio button next to Always allow pop-ups from <https://vcenter.sddc-xx-xx-xxxx.vmwarevmc.com>
5. Click the Done button.
6. Return to the black box below the Summary and click it again. The console session should launch in a new tab.

### Find the IP Address for Webserver02

![SDDC-test-vm-047](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/working-with-sddc-lab/sddc047.jpg)

Before we can test connectivity between the two servers, we need to find the IP address of webserver02.

1. Click the **Chrome Tab** of the vSphere Client (HTML5) to bring it back into focus.
2. Click on the virtual machine **webserver02**.
3. Take note of the **IP Address** for webserver02 in the middle of the screen. This will be needed in the next step.
4. Click the **Chrome Tab** of the console session for webserver01 to bring it back into focus.

### Login and Ping Webserver02

![SDDC-test-vm-048](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/working-with-sddc-lab/sddc048.jpg)

Now that we have to IP address for Webserver02 let's setup a continuous ping to the server to verify communication.

Before beginning click anywhere inside the console window to bring it into focus

1. At the login prompt enter **root** and press Enter.
2. At the password prompt enter **VMware1!** and press Enter.
3. At the console prompt, enter **ping 10.10.xx.xxx** and press Enter.  The third octet is based on student number and the last octet of the IP address in most cases it will be 101, but verify this in your configuration.
4. Verify the pings are successful.

**NOTE: Please leave this ping and console Window open for the next lesson. We will revisit it to verify the web servers can no longer communicate.**

Congratulations! You have now deployed two web servers in VMware Cloud on AWS SDDC and verified they can communicate with each other. In the next lesson we will create firewall rules to block the servers from communicating with each other and also make webserver02 accessible from the internet.

## Configuring VMware Cloud on AWS Advanced Network Services

VMware Cloud on AWS Advanced Network Services is now available for new SDDC deployments.

### Distributed Firewall in VMware Cloud on AWS Advanced Network Services

![DFW-01](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/working-with-sddc-lab/dfw01.jpg)

Using VMware Cloud on AWS Advanced Network Services, users have the capability to implement micro-segmentation with Distributed Firewall. Granular security policies can be applied at the VM-level allowing for segmentation within the same L2 network or across separate L3 networks. This is shown in the diagram above.

All networking and security configuration is now done through the VMware Cloud on AWS console via the Networking & Security tab, including creating network segments. This provides ease of operations and management by having all networking and security access through the console.

### Distributed Firewall

![DFW-02](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/working-with-sddc-lab/dfw02.jpg)

From the above screenshot, you can see, in addition to the ability to create multiple sections, users can organize Distributed Firewall rules into groups (Emergency Rules, Infrastructure Rules, Environment Rules, and Application Rules. The rules are hit from the top-down.

### Security Groups

![DFW-03](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/working-with-sddc-lab/dfw03.jpg)

In addition to the new Distributed Firewall capabilities, grouping objects can now be leveraged within security policies. Security groups support the following grouping criteria/constructs:

* IP Address
* VM Instance
* Matching criteria of VM Name
* Matching Criteria of Security Tag

As shown above, Security Groups can be created under Workload Groups or Management Groups. Workload Groups can be used in DFW and CGW firewall policies and Management Groups can be used under MGW firewall policies. Management Groups only support IP addresses as these groups are infrastructure based. Predefined Management Groups groups already exist for vCenter, ESXi hosts, and NSX Manager. Users can also create groups here based on IP address for on-prem ESXi hosts, vCenter, and other management appliances.

### View VM's in a Security Group

![DFW-04](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/working-with-sddc-lab/dfw04.jpg)

Here you can see we have deployed some VMs in vCenter and you can see the VMs in inventory within the console. Additionally, we have tagged the VMs with Web, App, and DB Security Tags respectively.

### Tagging Virtual Machines

![DFW-tag-05](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/working-with-sddc-lab/dfw05.jpg)

Through the VMware Cloud on AWS console we can apply security tags to virtual machines and then group them.

We will now switch back to the VMware Cloud on AWS console.

1. Click on the **VMware Cloud on AWS Chrome tab** and login with the information you were provided if your session has expired.
2. Click on **View Details** to access the details for the SDDC.

### Edit Tags for Webserver01

We will now begin tagging the virtual machines with security tags.

![DFW-tag-06](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/working-with-sddc-lab/dfw06.jpg)

1. Click on the **Networking & Security** tab to access the networking configuration.
2. On the left-hand side of the screen click on **Groups**.
3. Under Groups, click on **Virtual Machines** to access the virtual machines that are part of the SDDC.
4. Locate **webserver01** and click the three vertical dots and click **Edit**.

### Add Security Tag for Web

![DFW-tag-07](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/working-with-sddc-lab/dfw07.jpg)

1. Under Tags, enter **Web** for webserver01.
2. Click **Save** to commit the changes.

### Edit Tags for Webserver02

![DFW-tag-08](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/working-with-sddc-lab/dfw08.jpg)

We will now tag Webserver02 with the same Web tag. We will use this to create a group for both web servers.

1. Locate **webserver02** and click the three vertical dots and click **Edit**.

### Add Security Tag for Webserver02

![DFW-tag-09](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/working-with-sddc-lab/dfw09.jpg)

1. Under Tags, Enter **Web** for webserver02.
2. Click **Save** to commit the changes.

### Creating a Dynamic Group

![DFW-tag-010](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/working-with-sddc-lab/dfw010.jpg)

Groups can be used in VMware Cloud on AWS Advanced Network Services to group virtual machines and simplify rulebase configuration. In this exercise we will group the two webservers into a group and then create a firewall rule to block communication between them. In a properly architected traditional application there is usually no need for servers in the web tier to communicate.

We will now create a group of web servers based on the dynamic security tag we applied earlier.

1. Click on **Workload Groups**.
2. Click on **Add Group**.
3. Under Name enter **Web** for the name of the group.
4. Under Member Type, click the **drop down** and select **Membership Criteria**.
5. Under Members click **Set Membership Criteria**.

### Add Membership Criteria

![DFW-tag-011](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/working-with-sddc-lab/dfw011.jpg)

We will now add the criteria to group machines based on security tag.

1. Click on **+ Add Criteria**.
2. Under Property, click the **drop-down** and select **Tag**.
3. Under Value, enter **Web**.
4. Click **Save** to continue.

### Save Workload Group Changes

![DFW-tag-012](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/working-with-sddc-lab/dfw012.jpg)

1. Click **Save** to commit the changes.

### View Members

![DFW-tag-013](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/working-with-sddc-lab/dfw013.jpg)

We can now validate the group membership is working as expected.

1. Click the **three vertical** dots next to the Web group.
2. Click on **View Members** to show the current members of the dynamic group.

### Validate Group Members

![DFW-tag-014](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/working-with-sddc-lab/dfw014.jpg)

1. Validate that both **webserver01** and **webserver02** appear in the group membership. If they do not, go back and verify there are no typos.
2. Click **Close**.

Now that this group is created, you can easily add new members by simply applying a security tag.

### Create a Firewall Rule Section

![DFW-tag-015](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/working-with-sddc-lab/dfw015.jpg)

Now that we have created our dynamic group, let's create a firewall rule to block access between the web servers.

1. Click **Distributed Firewall** on the left-hand side of the screen.
2. Click **Application Rules**.
3. Click **Add New Section** to create a new section for the rule. This functionality allows you to group rules logically to make operating the environment simpler.
4. Under Name, enter **Web Tier**.
5. Click **Publish** to commit the changes.

### Add Firewall Rule

![DFW-tag-016](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/working-with-sddc-lab/dfw016.jpg)

Now that we have the section created, we can now add a firewall rule.

1. Click the **arrow** next to the Web Tier section.
2. Click **Add New Rule** in the menu above the rules.
3. Under Name, enter **Block Web To Web**.
4. Under Action, click the **drop-down** and select **Drop**.
5. Under Sources click **Any**.

### Select Source

![DFW-tag-017](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/working-with-sddc-lab/dfw017.jpg)

1. Click the **checkbox** next to Web.
2. click **Save** to commit the changes to the rule.

### Add Destination

![DFW-tag-018](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/working-with-sddc-lab/dfw018.jpg)

1. Under Destinations click **Any**.

### Select Destination

![DFW-tag-019](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/working-with-sddc-lab/dfw019.jpg)

1. Click the **checkbox** next to Web.
2. click **Save** to commit the changes to the rule.

### Publish Firewall Rule

![DFW-tag-020](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/working-with-sddc-lab/dfw020.jpg)

1. Click **Publish** to commit the rule and begin blocking traffic between the web servers.

### Testing the Distributed Firewall Rule

![DFW-tag-021](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/working-with-sddc-lab/dfw021.jpg)

You should still have the console session opened from the previous exercise to webserver01 and it should be running a ping command.

1. Click the Chrome Tab for **webserver01**.
2. Ping webserver02 IP address 10.10.xx.xxx.

The pings should have stopped responding meaning that the distributed firewall rules have been correctly applied. This simple demonstration should give you an idea of the power of the distributed firewall.

## Conclusion

In this module, we explored the setup of configuration of a VMware Cloud on AWS SDDC including utilizing the content library, deploying virtual machines, modifying firewall rules and working with virtual machines.

## Single Host SDDC

If you like the Lab and want to continue experiment and test the VMware Cloud on AWS capabilities, please scan the QR Code below to start your 1-Host experience.

![DFW-tag-022](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/working-with-sddc-lab/dfw022.jpg)

You have completed this module.

Please add comments below if you would like to give feedback on this exercise.