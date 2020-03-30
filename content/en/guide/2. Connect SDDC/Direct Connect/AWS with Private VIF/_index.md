---
title: "AWS with Private VIF"
linkTitle: "AWS with Private VIF"
weight: 2
description: >
  How to connect to your SDDC with AWS Private VIF
---

## Overview

In this guide we will be connecting your on-prem data center to your VMware Cloud on AWS SDDC 

![Login to AWS and VMC](https://vmc-onboarding-images.s3.amazonaws.com/2.Connect-SDDC/direct-connect/aws-with-private-vif/dxwithprivatevif.png)

## Pre-Reqs

- VMware Cloud on AWS SDDC deployed

- Amazon Direct Connect Ordered and installed -> https://docs.aws.amazon.com/directconnect/latest/UserGuide/getting_started.html 

## Login to both your AWS account and the VMware Cloud on AWS portal

Note: You need to login to the AWS account you used to deploy your VMware Cloud on AWS SDDC

![Login to AWS and VMC](https://vmc-onboarding-images.s3.amazonaws.com/2.Connect-SDDC/direct-connect/aws-with-private-vif/opentabs.png)

## In the VMC portal, get the AWS Account ID for your SDDC

1. Click on your SDDC

   ![Select SDDC](https://vmc-onboarding-images.s3.amazonaws.com/2.Connect-SDDC/direct-connect/aws-with-private-vif/selectsddc.png)

2. Click on the Networking and Security TAB then click on Direct Connect and note the account ID for next steps

  ![AWS account ID](https://vmc-onboarding-images.s3.amazonaws.com/2.Connect-SDDC/direct-connect/aws-with-private-vif/awsaccountid.jpg)

## Now navigate to Direct Connect

![Change Region](https://vmc-onboarding-images.s3.amazonaws.com/2.Connect-SDDC/direct-connect/aws-with-private-vif/navigatetodirectconnect.jpg)

## On the left of the portal, select Virtual Interfaces and click create Virtual Interface

![Create VIF](https://vmc-onboarding-images.s3.amazonaws.com/2.Connect-SDDC/direct-connect/aws-with-private-vif/createvif.jpg)

## Enter Virtual Interface Details as shown and click continue

![Enter VIF details](https://vmc-onboarding-images.s3.amazonaws.com/2.Connect-SDDC/direct-connect/aws-with-private-vif/createvifdetails.jpg)

## Notice the status indicates Virtual Interface needs to be accepted

![VIF Status](https://vmc-onboarding-images.s3.amazonaws.com/2.Connect-SDDC/direct-connect/aws-with-private-vif/vifneedstobeaccepted.jpg)

## Go back to the VMC portal and you will see the new Vitual Interface

1. Click attach

   ![Attach VIF in VMC Portal](https://vmc-onboarding-images.s3.amazonaws.com/2.Connect-SDDC/direct-connect/aws-with-private-vif/attachvifinvmcportal.jpg)

2. Confirm to Attach Virtual Interface

![Confirm Attach VIF](https://vmc-onboarding-images.s3.amazonaws.com/2.Connect-SDDC/direct-connect/aws-with-private-vif/confirmattachvif.jpg)

## Go back to AWS Portal and notice the Virtual Interface is down

 At this point, VIF is Attached to your SDDC. However it can take upto 10 min for the BGP session to become active 

![VIF Down](https://vmc-onboarding-images.s3.amazonaws.com/2.Connect-SDDC/direct-connect/aws-with-private-vif/vifdown.jpg)

## Go back to the VMC Portal and click refresh

You should now see advertised and learned BG routes, if after several minutes you do not see this go to next step 

![Refesh VIF in VMC Portal](https://vmc-onboarding-images.s3.amazonaws.com/2.Connect-SDDC/direct-connect/aws-with-private-vif/refreshvmcportal.jpg)

{{% alert title="Note" %}}If your virtual interface is still down you may not have configured the subinterface on your router{{% /alert %}}

 1. Go back to the AWS portal, select the new virtual interface, click the Actions dropdown and select download router config
 2. Choose the router type that matches your router and click download
 3. Send this to your network team to add this subinterface to your router

![Add Sub-Interface to MPLS Router](https://vmc-onboarding-images.s3.amazonaws.com/2.Connect-SDDC/direct-connect/aws-with-private-vif/configuremplsrouter.jpg)
