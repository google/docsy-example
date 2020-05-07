---
title: "AWS VPC Setup"
linkTitle: "AWS VPC Setup"
weight: 1
description: >
  How to setup and configure the AWS VPC
---

## Overview

In this guide we will be setting up your AWS account with a VPC so that you can on-board your SDDC. To avoid cross AZ traffic charges from your SDDC to Native AWS EC2 instances, make sure you deploy your SDDC in the Same AZ where those instances are or whe you plan to run them.

![Overview](https://vmc-onboarding-images.s3.amazonaws.com/1.Onboarding-SDDC/aws-vpc-setup/awsvpcoverview.png)

## Pre-Reqs

Amazon account with rights to create a VPC in the region you would like to deploy your VMware SDDC and rights to run a cloud formation template. [VMware Cloud on AWS Documentation concerning AWS Account Roles and Permissions](https://docs.vmware.com/en/VMware-Cloud-on-AWS/services/com.vmware.vmc-aws-operations/GUID-DE8E80A3-5EED-474C-AECD-D30534926615.html)

## Login to the AWS Console

![Login to AWS](https://vmc-onboarding-images.s3.amazonaws.com/1.Onboarding-SDDC/aws-vpc-setup/logintoaws.png)

## Search for the VPC service and click it

![Find VPC Service](https://vmc-onboarding-images.s3.amazonaws.com/1.Onboarding-SDDC/aws-vpc-setup/findvpcservice.png)

## Now click on VPC's

![Click VPCs](https://vmc-onboarding-images.s3.amazonaws.com/1.Onboarding-SDDC/aws-vpc-setup/clickvpcs.png)

## Click create VPC

![Find VPC Service](https://vmc-onboarding-images.s3.amazonaws.com/1.Onboarding-SDDC/aws-vpc-setup/createvpc.png)

## Enter VPC details

1. Enter a name for the VPC
2. Enter a CIDR block (Must not overlap with what you intend to use for SDDC!)
3. Keep default as No IPv6 CIDR Block
4. Leave Tenancy as default
5. Click create

![VPC Details](https://vmc-onboarding-images.s3.amazonaws.com/1.Onboarding-SDDC/aws-vpc-setup/vpcdetails.png)

## VPC is created

![VPC Created](https://vmc-onboarding-images.s3.amazonaws.com/1.Onboarding-SDDC/aws-vpc-setup/vpccreated.png)

## Now we need to add subnets to the VPC, we will be adding 3 subnets in different Availability Zones. 

1. Click Subnets

![Click Subnets](https://vmc-onboarding-images.s3.amazonaws.com/1.Onboarding-SDDC/aws-vpc-setup/clicksubnets.png)

## Click Create Subnet

![Create Subnet](https://vmc-onboarding-images.s3.amazonaws.com/1.Onboarding-SDDC/aws-vpc-setup/createsubnet1.png)

## Enter Subnet Details

1. Enter a name for the subnet
2. Select the VPC we just created
3. Select an Availability Zone
4. Enter a CIDR block

![Subnet1Details](https://vmc-onboarding-images.s3.amazonaws.com/1.Onboarding-SDDC/aws-vpc-setup/subnet1details.png)

## Your first Subnet is Created

1. Click Close

![Close](https://vmc-onboarding-images.s3.amazonaws.com/1.Onboarding-SDDC/aws-vpc-setup/subnet1created.png)

## Click Create Subnet

![Create Subnet](https://vmc-onboarding-images.s3.amazonaws.com/1.Onboarding-SDDC/aws-vpc-setup/createsubnet2.png)

## Enter Subnet Details for your second subnet

1. Enter a name for the subnet
2. Select the VPC we created earlier
3. Select a different Availability Zone than the one you selected for the first subnet
4. Enter a CIDR block

![Subnet1Details](https://vmc-onboarding-images.s3.amazonaws.com/1.Onboarding-SDDC/aws-vpc-setup/subnet2details.png)

## Your second Subnet is Created

1. Click Close

![Close](https://vmc-onboarding-images.s3.amazonaws.com/1.Onboarding-SDDC/aws-vpc-setup/subnet2created.png)

## Click Create Subnet

![Create Subnet](https://vmc-onboarding-images.s3.amazonaws.com/1.Onboarding-SDDC/aws-vpc-setup/createsubnet3.png)

## Enter Subnet Details for your third subnet

1. Enter a name for the subnet
2. Select the VPC we created earlier
3. Select a different Availability Zone than one you choose for the other subnets
4. Enter a CIDR block

![Subnet1Details](https://vmc-onboarding-images.s3.amazonaws.com/1.Onboarding-SDDC/aws-vpc-setup/subnet3details.png)

## Your third Subnet is Created

1. Click Close

![Close](https://vmc-onboarding-images.s3.amazonaws.com/1.Onboarding-SDDC/aws-vpc-setup/subnet3created.png)

## You should now have 3 subnetes attached to your VPC

![SubnetsCreated](https://vmc-onboarding-images.s3.amazonaws.com/1.Onboarding-SDDC/aws-vpc-setup/subnetscreated.png)

## You are now ready to go to the VMware portal and deploy your SDDC

Open another tab to  <a href="https://vmc.vmware.com" target="_blank">vmc.vmware.com</a>

![Login to AWS and VMC](https://vmc-onboarding-images.s3.amazonaws.com/2.Connect-SDDC/direct-connect/aws-with-private-vif/opentabs.png)

Follow steps to: [Deploy your SDDC](/guide/1.-on-boarding-sddc/deploy-sddc)
