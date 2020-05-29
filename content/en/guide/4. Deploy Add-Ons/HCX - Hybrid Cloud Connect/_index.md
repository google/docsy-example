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

