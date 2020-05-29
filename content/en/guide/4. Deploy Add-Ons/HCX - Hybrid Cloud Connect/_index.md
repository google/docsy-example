---
title: "HCX - Hybrid Cloud Connect"
linkTitle: "HCX - Hybrid Cloud Connect"
weight: 2
description: >
  How to install HCX for VMware Cloud on AWS 
---

## Introduction

## What is VMware Hybrid Cloud Extension (HCX)?

VMware HCX®, an application mobility platform, simplifies application migration, workload rebalancing and business continuity across data centers and clouds. HCX enables high-performance, large-scale app mobility across VMware vSphere® and non-vSphere cloud and on-premises environments to accelerate data center modernization and cloud transformation. HCX automates the creation of an optimized network interconnect and extension, and facilitates interoperability across KVM, Hyper-V and vSphere 5.0+ to current vSphere versions. This delivers live and bulk migration capabilities without redesigning the application or re-architecting networks.

![What is HCX](https://vmc-onboarding-images.s3-us-west-2.amazonaws.com/HCX/HCX1.jpg)

### Why VMware HCX?

As organizations adopt hybrid and multi-cloud architectures leveraging VMware infrastructure, they stand up new environments locally and in the cloud to simplify operations and increase business agility. However, the promise of a modern data center or hybrid cloud can’t be realized until applications and workloads exist in these new environments. VMware HCX enables data center and cloud transformations by simplifying the process of populating and continually optimizing application placement on modern VMware infrastructure.

HCX unlocks the potential of new environments based on vSphere by building  an abstraction layer that links on-premises data centers and clouds. This hybrid interconnect tethers sites so networks can automatically stretch securely across  sites, enabling seamless mobility of virtual machines (VMs). HCX enables hybrid capabilities in VMware vCenter® to allow for application migration to populate  newly available infrastructure, workload rebalancing for ongoing optimization of  cloud and local resources, and simplified disaster recovery by eliminating the  need for network provisioning and configuration.

### Use Cases

#### Application Migration

Accelerate data center modernization with VMware HCX. Automatically create  a hybrid interconnect to easily migrate thousands of vSphere and non-vSphere  VMs within and across data centers and clouds without requiring reboot. Once migrated, swing networks without any retrofit/redesign.

#### Workload Rebalancing

Move workloads at any time to meet scale, cost management, compliance and  vendor neutrality goals. Actively rebalance your cloud and on-premises application footprint with HCX as an always-on, secure, high-throughput, WAN-optimized,  hybrid interconnect that tethers cloud to on-premises estates for on-demand migration, data center extension and cloud bursting.

#### Business Continuity and Disaster Protection

Leverage the HCX hybrid interconnect and rapid migration capabilities to protect workloads by replicating data across common VMware infrastructure in two or more places. Back up critical workloads on demand, or schedule for disaster recovery planning seamlessly and securely with no reconfiguration of IPs. HCX now integrates with VMware Site Recovery Manager™ for advanced use cases.

## HCX with VMware Cloud on AWS

### HCX Activation in VMware Cloud on AWS

![Activation of HCX in SDDC](https://vmc-onboarding-images.s3-us-west-2.amazonaws.com/HCX/HCX2.jpg)

#### Log In to VMC SDDC/Deploy HCX

![Add Ons Tab](https://vmc-onboarding-images.s3-us-west-2.amazonaws.com/HCX/HCX3.jpg)

1. Log in to your VMware Cloud on AWS SDDC.
2. Click on Add Ons tab.

![Open HCX](https://vmc-onboarding-images.s3-us-west-2.amazonaws.com/HCX/HCX4.jpg)

1. Click on Open HCX.

![Deploy HCX](https://vmc-onboarding-images.s3-us-west-2.amazonaws.com/HCX/HCX5.jpg)

A new browser tab opens.

1. Click on Deploy HCX.

Deployment takes a few minutes to complete.

![Deployment Complete](https://vmc-onboarding-images.s3-us-west-2.amazonaws.com/HCX/HCX6.jpg)

Once HCX completes deployment you should see a message pop up in your SDDC that Deployment is complete and see the options to Open HCX and Undeploy HCX.

#### Allow HCX Traffic In

![HCX Traffic In](https://vmc-onboarding-images.s3-us-west-2.amazonaws.com/HCX/HCX7.jpg)

1. Go to Networking & Security tab.
2. Click on Gateway Firewall.
3. Click on Add Rule.
4. Name your Rule.
5. Set your sources.
6. Set destination as HCX.
7. Select all Services.
8. Publish.

![Log in to HCX Cloud URL](https://vmc-onboarding-images.s3-us-west-2.amazonaws.com/HCX/HCX8.jpg)

1. Click on HCX URL from Settings tab.
2. Login with cloudadmin credentials.

![Successful Log in to HCX Cloud URL](https://vmc-onboarding-images.s3-us-west-2.amazonaws.com/HCX/HCX9.jpg)

You have successfully deployed HCX in your VMware Cloud on AWS SDDC.

#### Collect Information

The following information is needed to be collected in order to deploy HCX in your on-premises vCenter.

![Public IPs for HCX Fleet](https://vmc-onboarding-images.s3-us-west-2.amazonaws.com/HCX/HCX10.jpg)

1. Go to Networking & Security tab.
2. Public IPs.
3. Take note of Public IPs assigned to HCX Fleet.

![Credentials and URL](https://vmc-onboarding-images.s3-us-west-2.amazonaws.com/HCX/HCX11.jpg)

1. Go to Settings tab.
2. Note cloudadmin User Name.
3. Note cloudadmin Password.
4. Take note of HCX URL.

![HCX OVA Download](https://vmc-onboarding-images.s3-us-west-2.amazonaws.com/HCX/HCX12.jpg)

1. Login to HCX Cloud URL with cloudadmin user and click on System Updates.
2. Click Request Download Link.
3. Either download HCX OVA or Copy Link and take note.

### On-premises HCX Installation

![HCX On-premises Install](https://vmc-onboarding-images.s3-us-west-2.amazonaws.com/HCX/HCX13.jpg)

#### HCX Pre-requisites for on-premises installation

![HCX Pre-requisites](https://vmc-onboarding-images.s3-us-west-2.amazonaws.com/HCX/HCX14.jpg)

#### Deployment of HCX OVA Template, Activation, Configuration

![Deploy OVA](https://vmc-onboarding-images.s3-us-west-2.amazonaws.com/HCX/HCX15.jpg)

1. Select downloaded OVA template for deployment.
2. Select name and folder to place VM.
3. Select Compute Resource.
4. Accept License Agreements.
5. Select Storage.
6. Select Networks.
7. Customize template:
   - admin and root user passwords
   - Hostname
   - IP address
   - Prefix length
   - Default gateway
   - DNS Server
   - Domain Search List
   - NTP Server

![HCX 9443](https://vmc-onboarding-images.s3-us-west-2.amazonaws.com/HCX/HCX16.jpg)

1. In a browser tab go to: https://fqdn-or-ip-hcx:9443.
2. Login with user admin and appropriate password.
3. Enter License Key obtained from VMC portal.
4. Click Activate.

![Activation](https://vmc-onboarding-images.s3-us-west-2.amazonaws.com/HCX/HCX17.jpg)

In the follow up screens enter:
1. Location of your datacenter.
2. System Name for HCX Appliance.
3. vCenter information (Ensure user with admin rights is entered).
4. SSO/PSC Information.
5. Click Restart button.

![Complete Config](https://vmc-onboarding-images.s3-us-west-2.amazonaws.com/HCX/HCX18.jpg)

After services are restarted, you may want to ensure appropriate vCenter User Groups have access to HCX:
1. Click Configuration.
2. Click vSphere Role Mapping.
3. Click Edit.
4. Enter the group(s) as necessary.

#### Pair Sites

![Pair Sites](https://vmc-onboarding-images.s3-us-west-2.amazonaws.com/HCX/HCX19.jpg)

1. From the HCX interface, click on Site Pairing.
2. Click Connect to Remote Site button.
3. Enter:
   - HCX Cloud URL
   - User Name
   - Password
   - Click Connect

#### Create Compute Profile

![Compute Profile](https://vmc-onboarding-images.s3-us-west-2.amazonaws.com/HCX/HCX20.jpg)

1. Click on Interconnect.
2. Click Compute Profile.
3. Click Create Compute Profile.
4. Name your Compute Profile.

![Compute Profile 2](https://vmc-onboarding-images.s3-us-west-2.amazonaws.com/HCX/HCX21.jpg)

1. Select HCX Services to be enabled.
2. Select Service Resources (Resources that HCX Service should access for Migrations/Operations).
3. Select Deployment Resources (Resources where HCX appliances will be placed).
   - Cluster
   - Datastore
   - Folders

![Compute Profile 3](https://vmc-onboarding-images.s3-us-west-2.amazonaws.com/HCX/HCX22.jpg)

1. Select Management Network Profile (should be from Management Network on-premises preferably).
2. If Network Profiles have not been created, 2 Network Profiles at a minimum are needed:
   - Management Network Profile
   - vMotion Network Profile
3. Uplink Network Profile (should be Management Network unless it's different).
4. vMotion Network Profile.
5. vSphere Replication Network Profile (usually Management Network).
6. Select vDS for Network Extensions.

#### Create Service Mesh

![Service Mesh](https://vmc-onboarding-images.s3-us-west-2.amazonaws.com/HCX/HCX23.jpg)

1. Click Interconnect.
2. Click Service Mesh.
3. Click Create Service Mesh button.

![Service Mesh 2](https://vmc-onboarding-images.s3-us-west-2.amazonaws.com/HCX/HCX24.jpg)

1. Select Compute Profiles on Source and VMC side (VMC profile is created when HCX is enabled in your SDDC).
2. Select HCX Services to be enabled.
3. Select Uplink Network Profiles:
   - externalNetwork if using public internet on VMC side
   - directConnectNetwork1 if using Direct Connect
4. Network Extension Appliance Scale Out (If more than one NE appliance is needed).
5. Review Topology.
6. Provide a name for your Service Mesh.

![Service Mesh 3](https://vmc-onboarding-images.s3-us-west-2.amazonaws.com/HCX/HCX25.jpg)

Service Mesh starts deploying.

At this point appliances are being deployed in pairs, both at the Source Site as well as at the Destination (VMC).

You can click  on Tasks to follow the progress of the deployments.

![Service Mesh 4](https://vmc-onboarding-images.s3-us-west-2.amazonaws.com/HCX/HCX26.jpg)

Once Service Mesh completes deployment, it takes a few minutes while the 2 tunnels come up:

- Interconnect (IX) Tunnel - Handles migration traffic.
- Network Extension (NE) Tunnel - Handles L2 Network Extensions communications.

### HCX with Direct Connect (DX) in VMware Cloud on AWS

#### Introduction

By default when HCX is deployed in a VMware Cloud on AWS SDDC, it automatically provisions public IP addresses for the traffic to transverse through the public internet.

If a company decides to use an AWS Direct Connect line, this may not be the preferred method for traffic to flow. HCX traffic can be re-directed over a Direct Connect private line for a more secure, more private way of migration and L2 traffic to flow through.

#### Pre-requisites

- An AWS Direct Connect must be ordered and deployed.
- HCX must be activated from the VMC SDDC console.
- An additional private subnet (internal RFC 1918, non-overlapping subnet).
  - Size of subnet is dependent of how many appliances will need to be deployed.
  - For a typical deployemnt, 2 IP addresses are needed, or a minimum of a /29 or /28 or greater is recommended.

#### Change HCX Cloud Resolution

![DX 1](https://vmc-onboarding-images.s3-us-west-2.amazonaws.com/HCX/HCX27.jpg)

1. Click on Settings tab.
2. Under HCX Information click Edit.

![DX 2](https://vmc-onboarding-images.s3-us-west-2.amazonaws.com/HCX/HCX28.jpg)

1. Change Resolution to Private IP.
2. Click SAVE.

![DX 3](https://vmc-onboarding-images.s3-us-west-2.amazonaws.com/HCX/HCX29.jpg)

1. Click Interconnect.
2. Click Network Profiles.
3. Click EDIT on directConnectNetwork1 Network Profile.

![DX 4](https://vmc-onboarding-images.s3-us-west-2.amazonaws.com/HCX/HCX30.jpg)

1. Enter IP range to use.
2. Enter prefix length.
3. Enter Default Gateway.
4. Click UPDATE button.

After a few minutes, validate that this new segment is advertised over the Direct Connect in VMC SDDC Console. Networking & Security tab -> System -> Direct Connect. The subnet should be visible under Advertised BGP Routes.

Once the new subnet is visible under Advertised BGP Routes, you may need to accept the route advertisement on your on-premises BGP peer.

Ensure that if any Firewall is in between, port UDP 4500 will be needed to be opened between on-premises appliances and this new CIDR range.

When creating your Service Mesh on-premises, you should select this Network Profile (directConnectNetwork1) as the Destination Site Uplink Network Profile.
