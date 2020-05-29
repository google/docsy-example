---
title: "VMC vCenter"
linkTitle: "VMC vCenter"
weight: 2
description: >
  How to configure hybrid Linked Mode in VMware Cloud on AWS 
---

In this guide we will be connecting your on-prem vCenter to your vCenter in your VMware Cloud on AWS SDDC


![HLM Overview](https://vmc-onboarding-images.s3-us-west-2.amazonaws.com/3.Configure-SDDC/hybrid-linked-mode/vmc-vcenter/hlmoverview.png)

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

## Port Diagram for Hybrid Linked Mode Communication

![HLM Port Diagram](https://vmc-onboarding-images.s3-us-west-2.amazonaws.com/3.Configure-SDDC/hybrid-linked-mode/vmc-vcenter/hlmportdiagram.png)

## Test connectivity

Login to the Cloud Console and click on your SDDC and go to the settings tab: 

1. Select Hybrid Linked Mode
2. Enter information for your on-prem servers 
3. Click Run all tests 

If successful you can move on to next step, if you have errors check to make sure your VPN or Direct Connect are setup correctly and check firewall ports are open in VMC and on your local firewall

![HLM test connectivity](https://vmc-onboarding-images.s3-us-west-2.amazonaws.com/3.Configure-SDDC/hybrid-linked-mode/vmc-vcenter/testhlmconnectivity.png)

## Login to your SDDC vCenter in VMware Cloud on AWS

In the upper right, click on Open vCenter

![HLM Open vCenter](https://vmc-onboarding-images.s3-us-west-2.amazonaws.com/3.Configure-SDDC/hybrid-linked-mode/vmc-vcenter/hlmopenvcenter.png)

Now click on Show Credentials

![HLM show vCenter Credentials](https://vmc-onboarding-images.s3-us-west-2.amazonaws.com/3.Configure-SDDC/hybrid-linked-mode/vmc-vcenter/hlmshowcreds.png)

1. Click to copy the password to the clipboard
2. Click Open vCenter

![HLM copy vCenter Credentials](https://vmc-onboarding-images.s3-us-west-2.amazonaws.com/3.Configure-SDDC/hybrid-linked-mode/vmc-vcenter/hlmcopypassword.png)

Use the cloudadmin@vmclocal account and the credentials you just copied

![HLM Login to vCenter ](https://vmc-onboarding-images.s3-us-west-2.amazonaws.com/3.Configure-SDDC/hybrid-linked-mode/vmc-vcenter/hlmlogintovcenter.png)

## Navigate to Administration

1. Click Menu
2. Click Administration

![HLM Menu Navigation](https://vmc-onboarding-images.s3-us-west-2.amazonaws.com/3.Configure-SDDC/hybrid-linked-mode/vmc-vcenter/hlmmenunav.png)

## Configure Hybrid Linked Mode

1. Click Linked Domains
2. Click add identity source

![HLM Setup ID Source](https://vmc-onboarding-images.s3-us-west-2.amazonaws.com/3.Configure-SDDC/hybrid-linked-mode/vmc-vcenter/hlmsetupidsource.png)

## Enter Identity Source inforamtion and credentials

1. Select source type and enter required infromation
2. Browse to SSL certificates 
3. Click Add

![HLM enter ID souce information](https://vmc-onboarding-images.s3-us-west-2.amazonaws.com/3.Configure-SDDC/hybrid-linked-mode/vmc-vcenter/hlmsetupidsource2.png)

## Click Configuration and Verify indentity source added 

![HLM view id source](https://vmc-onboarding-images.s3-us-west-2.amazonaws.com/3.Configure-SDDC/hybrid-linked-mode/vmc-vcenter/hlmviewidsource.png)

## Go back to linked domains

1. Enter your On-Prem PSC FQDN and user name and password
2. Click Link

![HLM Connect vCenter](https://vmc-onboarding-images.s3-us-west-2.amazonaws.com/3.Configure-SDDC/hybrid-linked-mode/vmc-vcenter/hlmconnectvcenter.png)

## Domain Successfully linked

Click OK

![HLM link success](https://vmc-onboarding-images.s3-us-west-2.amazonaws.com/3.Configure-SDDC/hybrid-linked-mode/vmc-vcenter/hlmlinksuccess.png)

## On-prem and VMC vCenter now linked

![HLM linked vCenters](https://vmc-onboarding-images.s3-us-west-2.amazonaws.com/3.Configure-SDDC/hybrid-linked-mode/vmc-vcenter/hlmlinkedvcenters.png)

## Logout of vCenter 

![HLM vCenter Logout](https://vmc-onboarding-images.s3-us-west-2.amazonaws.com/3.Configure-SDDC/hybrid-linked-mode/vmc-vcenter/hlmlogout.png)

#Login back into your VMC SDDC vCenter with an On-prem domain account

![HLM Login](https://vmc-onboarding-images.s3-us-west-2.amazonaws.com/3.Configure-SDDC/hybrid-linked-mode/vmc-vcenter/hlmlogin.png)

## Verify you can browse local vCenter and your VMC SDDC vCenter

![HLM tree view](https://vmc-onboarding-images.s3-us-west-2.amazonaws.com/3.Configure-SDDC/hybrid-linked-mode/vmc-vcenter/hlmtreeview.png)
 

