---
title: "Hosted Private VIF"
linkTitle: "Hosted Private VIF"
weight: 3
description: >
 How to connect an Amazon Direct Connect - Hosted Private VIF to VMware Cloud on AWS 
---

## Overview

In this guide we will be connecting your on-prem data center to your VMware Cloud on AWS SDDC

![Overview](https://vmc-onboarding-images.s3-us-west-2.amazonaws.com/2.Connect-SDDC/direct-connect/hosted-private-vif/overview.png)

## Login to [vmc.vmware.com](https://vmc.vmware.com) and click to open your SDDC

![Select SDDC](https://vmc-onboarding-images.s3-us-west-2.amazonaws.com/2.Connect-SDDC/direct-connect/hosted-private-vif/selectsddc.png)

## Now open another window and login to your partner portal

![Login to both](https://vmc-onboarding-images.s3-us-west-2.amazonaws.com/2.Connect-SDDC/direct-connect/hosted-private-vif/logintoboth.png)

## Via the Direct Connect partner portal, build the DX service from the source (On-Premises) to the destination (VMware Cloud on AWS SDDC).  

![Build DX](https://vmc-onboarding-images.s3-us-west-2.amazonaws.com/2.Connect-SDDC/direct-connect/hosted-private-vif/builddx.png)
{{< notice info >}}

**Additional work may be required**\
There may be a need to build a “Last Mile” connection from the On-Premises location to the DX Partner service location (Point-of-Presence/PoP).
{{< /notice >}}

## Most DX Partner portals will require some or all of the following information:

![Select SDDC](https://vmc-onboarding-images.s3-us-west-2.amazonaws.com/2.Connect-SDDC/direct-connect/hosted-private-vif/configurepartnerdx.png)



###	Direct Connection Service Type

-	Public VIF – Leverages Public IP Addresses / Public BGP Autonomous System Number (ASN) since it is traditionally used to connect to AWS’ publicly accessible services (i.e. Amazon S3 Simple Storage Service).
- Private VIF – Leverages Private IP Addresses / Private BGP Autonomous System Number (ASN) to connect to a Virtual Private Cloud (VPC) environment.

###	AWS Connection Name 
- Arbitrary name for the DX connection being deployed; this will be displayed in the VMware Cloud on AWS Console.
### AWS Account ID 
- This is a numerical account identification that is associated with the AWS Account that VMware owns and uses to support the customer’s VMware Cloud on AWS SDDC environment:


## Click on Networking and Security Tab, then go to Direct Connect in the left menu. 

Copy the AWS Account ID 

![AWS Account id and ASN number](https://vmc-onboarding-images.s3-us-west-2.amazonaws.com/2.Connect-SDDC/direct-connect/hosted-private-vif/awsaccountid.jpg)

## Enter the account ID in the partner portal direct connect configuration and click save

![Enter Account ID](https://vmc-onboarding-images.s3-us-west-2.amazonaws.com/2.Connect-SDDC/direct-connect/hosted-private-vif/pasteaccountid.png)

## Now go back to the VMware Cloud on AWS portal and you will see the connection ready to accept. Click accept. 

![Hosted VIF attach](https://vmc-onboarding-images.s3-us-west-2.amazonaws.com/2.Connect-SDDC/direct-connect/hosted-private-vif/hostedvifattach.png)

## On the pop up screen 
1. Check that you understand the terms of the connection
2. Click attach virtual interface

![Hosted VIF Confirm](https://vmc-onboarding-images.s3-us-west-2.amazonaws.com/2.Connect-SDDC/direct-connect/hosted-private-vif/hostedvifconfirm.png)

## You will see the new connection as down for a few minutes. 

![Hosted VIF attaching](https://vmc-onboarding-images.s3-us-west-2.amazonaws.com/2.Connect-SDDC/direct-connect/hosted-private-vif/hostedvifattaching.png)

## Click the refresh button until you see the connection as up with a green circle. 

![Hosted VIF Up](https://vmc-onboarding-images.s3-us-west-2.amazonaws.com/2.Connect-SDDC/direct-connect/hosted-private-vif/hostedvifup.png)