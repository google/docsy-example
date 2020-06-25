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

## Most DX Partner portals will require some or all of the following information:

![Select SDDC](https://vmc-onboarding-images.s3-us-west-2.amazonaws.com/2.Connect-SDDC/direct-connect/hosted-private-vif/configurepartnerdx.png)

## Click on Networking and Security Tab, then go to Direct Connect. 

Copy the AWS Account ID 

![AWS Account id and ASN number](https://vmc-onboarding-images.s3-us-west-2.amazonaws.com/2.Connect-SDDC/direct-connect/hosted-private-vif/awsaccountid.jpg)

## Enter the account ID in the partner portal direct connect configuration and click save

![Enter Account ID](https://vmc-onboarding-images.s3-us-west-2.amazonaws.com/2.Connect-SDDC/direct-connect/hosted-private-vif/pasteaccountid.jpg)

## Go back to the VMware Cloud on AWS portal and you will see the connection ready to accept. Click accept. 

![Hosted VIF attach](https://vmc-onboarding-images.s3-us-west-2.amazonaws.com/2.Connect-SDDC/direct-connect/hosted-private-vif/hostedvifattach.png)

## On the pop up screen 
1. Check that you understand the terms of the connection
2. Click attach virtual interface

![Hosted VIF Confirm](https://vmc-onboarding-images.s3-us-west-2.amazonaws.com/2.Connect-SDDC/direct-connect/hosted-private-vif/hostedvifconfirm.png)

## You will see the new connection as down for a few minutes. 

![Hosted VIF attaching](https://vmc-onboarding-images.s3-us-west-2.amazonaws.com/2.Connect-SDDC/direct-connect/hosted-private-vif/hostedvifattaching.png)

## Click the refresh button until you see the connection as up with a green circle. 

![Hosted VIF Up](https://vmc-onboarding-images.s3-us-west-2.amazonaws.com/2.Connect-SDDC/direct-connect/hosted-private-vif/hostedvifup.png)