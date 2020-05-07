---
title: "Deploy SDDC"
linkTitle: "Deploy SDDC"
weight: 2
description: >
  How to connect to your AWS account and deploy your SDDC
---

## Overview

In this guide we will be deploying your VMware SDDC to Amazon

![Overview](https://vmc-onboarding-images.s3.amazonaws.com/1.Onboarding-SDDC/deploy-sddc/sddcoverview.png)

## Pre-Reqs

- You have purchased a VMware Cloud on AWS Subscription
- A MyVMware account created and you have completed the following: <a href="https://docs.vmware.com/en/VMware-Cloud-on-AWS/services/com.vmware.vmc-aws.getting-started/GUID-924D58AB-ABBE-48B1-B009-63A16C7DE5B0.html" target="_blank">On-Boarding Checklist</a>  

## Login to the VMware Cloud Services Portal

With the AWS Console open and logged in from previous step open a new tab to <a href="https://vmc.vmware.com" target="_blank">vmc.vmware.com</a>

![Login to VMC](https://vmc-onboarding-images.s3.amazonaws.com/1.Onboarding-SDDC/deploy-sddc/vmclogin.png)

## Select the VMware Cloud on AWS Service

![Select VMC](https://vmc-onboarding-images.s3.amazonaws.com/1.Onboarding-SDDC/deploy-sddc/selectvmc.png)

## Click to Create SDDC

![Create New SDDC](https://vmc-onboarding-images.s3.amazonaws.com/1.Onboarding-SDDC/deploy-sddc/createsddc.png)

## Enter SDDC Properties

1. Select the region where you created the VPC in earlier
2. Select Multi-Host
3. Enter a display name for your SDDC (NOTE: this is just a display name, not the cluster or vCenter name)
4. Select the number of hosts you want
5. Click Next

![Enter SDDC Properties](https://vmc-onboarding-images.s3.amazonaws.com/1.Onboarding-SDDC/deploy-sddc/sddcproperties.png)

## Click to open the AWS Console with CloudFormation Template

![Open AWS Console](https://vmc-onboarding-images.s3.amazonaws.com/1.Onboarding-SDDC/deploy-sddc/openawsconsole.png)

## Run the Cloud Formation Template

1. Check box to acknowledge
2. Click Create

![Run CloudFormation](https://vmc-onboarding-images.s3.amazonaws.com/1.Onboarding-SDDC/deploy-sddc/runcloudformation.png)

## Close the AWS Console

Few, were all done with the AWS side for now!

![Close AWS Console](https://vmc-onboarding-images.s3.amazonaws.com/1.Onboarding-SDDC/deploy-sddc/closeawsconsole.png)

## Click next

It may take up to 10 minutes to complete before you can click next

![Connect AWS Account](https://vmc-onboarding-images.s3.amazonaws.com/1.Onboarding-SDDC/deploy-sddc/awsconnectclicknext.png)

## Enter VPC and Subnet

1. Select the VPC we created in the previous guide
2. Select a subnet, choose the same AZ if you intened to connect to EC2 instances in that VPC
3. Click Next

![VPC and Subnet](https://vmc-onboarding-images.s3.amazonaws.com/1.Onboarding-SDDC/deploy-sddc/vpcandsubnet.png)

## Configure Management Network

1. Enter a CIDR block for the management components i.e vCenter, esxi hosts, NSX Manager, etc.
2. Click Next  

![Management Network](https://vmc-onboarding-images.s3.amazonaws.com/1.Onboarding-SDDC/deploy-sddc/configurenetwork.png)

## Agree and Deploy

1. Check mark you agree to charges
2. Check mark you understand pricing
3. Click Deploy SDDC

![Agree and Deploy](https://vmc-onboarding-images.s3.amazonaws.com/1.Onboarding-SDDC/deploy-sddc/agreeanddeploy.png)

## Demploying SDDC

This can take up to 2 hours, take a break or go take a <a href="https://hol.vmware.com" target="_blank">VMware Hands on Lab</a> !

![Deploying SDDC](https://vmc-onboarding-images.s3.amazonaws.com/1.Onboarding-SDDC/deploy-sddc/deployingsddc.png)

## SDDC Deployed
Congratulations, you just deployed your first SDDC!

![SDDC Deployed](https://vmc-onboarding-images.s3.amazonaws.com/1.Onboarding-SDDC/deploy-sddc/sddcdeployed.png)

Now let's get your SDDC Connected

Follow the next steps to: [Connect your SDDC](/guide/2.-connect-sddc/)
