---
title: "Cloud Gateway"
linkTitle: "Cloud Gateway"
weight: 2
description: >
  How to configure Cloud Gateway for VMware Cloud on AWS 
---
In this guide we will be configuring the Cloud Gateway Appliance to setup Hybrid Linked Mode

![CGW Overview](https://vmc-onboarding-images.s3-us-west-2.amazonaws.com/3.Configure-SDDC/hybrid-linked-mode/cloud-gateway/cgwoverview.png)

## Pre-Reqs:
- Your on-prem vCenter needs to be:
  - vSphere 6.0 Updatge 3 patch c or later
  - vSphere 6.5 patch d or later

- NTP: Tolerate a time skew of up to 10 minuets
- A VPN or a Direct Connect exists
- Max Latency: 100 msec roundtrip
- An On-Prem AD group which will be assigned Cloud Administrator Permmisions
- Login credentials for a user who has a minimum of read-only access to the Based DN for uses and groups in your AD
- On-premises DNS server configured
- Cloud vCenter resolution should be set to resolve Private IP
- On-Premises Firewall allows required ports 
- Management Firewall on the cloud side allows required ports
- Ensure that you have the admin credentials for your on-premises vSphere SSO domain 

The following are the ports that you will need opened on both your Management Gateway Firewall in VMware Cloud on AWS and you on-prem Firewall. 

![CGW Port Diagram](https://vmc-onboarding-images.s3-us-west-2.amazonaws.com/3.Configure-SDDC/hybrid-linked-mode/cloud-gateway/cgwportdiagram.png)

## Login to the VMC <a href="https://vmc.vmware.com" target="_blank">portal</a> 

Then go to the VMware Cloud on AWS Service then click tools, and click to download the Cloud Gateway Appliance

![CGW Download](https://vmc-onboarding-images.s3-us-west-2.amazonaws.com/3.Configure-SDDC/hybrid-linked-mode/cloud-gateway/cgwdownload.png)

## Download the appliance to a machine that has access to your local vCenter

![CGW Download Portal](https://vmc-onboarding-images.s3-us-west-2.amazonaws.com/3.Configure-SDDC/hybrid-linked-mode/cloud-gateway/cgwdownload2.png)

## Browse to the installer and run as administrator

![CGW Installer](https://vmc-onboarding-images.s3-us-west-2.amazonaws.com/3.Configure-SDDC/hybrid-linked-mode/cloud-gateway/cgwinstall.png)

## Click start

![CGW Deploy Part 1](https://vmc-onboarding-images.s3-us-west-2.amazonaws.com/3.Configure-SDDC/hybrid-linked-mode/cloud-gateway/cgwdeploy.png)

## Enter vCenter information

1. Enter your vCenter FQDN, user and password
2. Click next

![CGW Deploy Part 2](https://vmc-onboarding-images.s3-us-west-2.amazonaws.com/3.Configure-SDDC/hybrid-linked-mode/cloud-gateway/cgwdeploy2.png)

## Select vCenter Folder for the appliance

![CGW Deploy Part 3](https://vmc-onboarding-images.s3-us-west-2.amazonaws.com/3.Configure-SDDC/hybrid-linked-mode/cloud-gateway/cgwdeploy3.png)

## Select Compute Resource 

![CGW Deploy Part 4](https://vmc-onboarding-images.s3-us-west-2.amazonaws.com/3.Configure-SDDC/hybrid-linked-mode/cloud-gateway/cgwdeploy4.png)

## Setup Target appliance VM

1. Enter a name and root password for the appliance
2. Click next 

![CGW Deploy Part 5](https://vmc-onboarding-images.s3-us-west-2.amazonaws.com/3.Configure-SDDC/hybrid-linked-mode/cloud-gateway/cgwdeploy5.png)

## Select Storage Location

1. Choose a datastore
2. Enable thin disk mode
3. Click next 

![CGW Deploy Part 6](https://vmc-onboarding-images.s3-us-west-2.amazonaws.com/3.Configure-SDDC/hybrid-linked-mode/cloud-gateway/cgwdeploy6.png)

## Enter Network Settings and click next

![CGW Deploy Part 7](https://vmc-onboarding-images.s3-us-west-2.amazonaws.com/3.Configure-SDDC/hybrid-linked-mode/cloud-gateway/cgwdeploy7.png)

## Configure NTP server and click next

![CGW Deploy Part 8](https://vmc-onboarding-images.s3-us-west-2.amazonaws.com/3.Configure-SDDC/hybrid-linked-mode/cloud-gateway/cgwdeploy8.png)

## Enter single Sign-On settings and click next

![CGW Deploy Part 9](https://vmc-onboarding-images.s3-us-west-2.amazonaws.com/3.Configure-SDDC/hybrid-linked-mode/cloud-gateway/cgwdeploy9.png)

## Join AD Domain

1. Select to join AD domain
2. Enter Domain and credentials
3. Click Finish

![CGW Deploy Part 10](https://vmc-onboarding-images.s3-us-west-2.amazonaws.com/3.Configure-SDDC/hybrid-linked-mode/cloud-gateway/cgwdeploy10.png)

## Monitor Appliance deployment in vCenter

![CGW Deploy Part 11](https://vmc-onboarding-images.s3-us-west-2.amazonaws.com/3.Configure-SDDC/hybrid-linked-mode/cloud-gateway/cgwdeploy11.png)

## Go back to installer and click start

![CGW Deployed](https://vmc-onboarding-images.s3-us-west-2.amazonaws.com/3.Configure-SDDC/hybrid-linked-mode/cloud-gateway/cgwdeployed.png)

## Link Cloud Gatway to VMC 

1. Enter the VMware Cloud on AWS FQDN, user and password
2. Click Finish

![CGW Configure](https://vmc-onboarding-images.s3-us-west-2.amazonaws.com/3.Configure-SDDC/hybrid-linked-mode/cloud-gateway/cgwconfigure.png)

## Launch vCenter Client

![CGW Linked](https://vmc-onboarding-images.s3-us-west-2.amazonaws.com/3.Configure-SDDC/hybrid-linked-mode/cloud-gateway/cgwlinksuccess.png)

## Login to Cloud Gateway

1. Enter you local SSO credentials 
2. Click Login

![CGW Login](https://vmc-onboarding-images.s3-us-west-2.amazonaws.com/3.Configure-SDDC/hybrid-linked-mode/cloud-gateway/cgwlogin.png)

## Now you can view both your local vCenter objects and VMware Cloud on AWS onjects in the same client

![CGW Setup Complete](https://vmc-onboarding-images.s3-us-west-2.amazonaws.com/3.Configure-SDDC/hybrid-linked-mode/cloud-gateway/cgwtreeview.png)