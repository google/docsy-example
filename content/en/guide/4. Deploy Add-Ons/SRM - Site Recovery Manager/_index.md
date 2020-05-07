---
title: "SRM - Site Recovery Manager"
linkTitle: "SRM - Site Recovery Manager"
weight: 2
description: >
  How to install SRM for VMware Cloud on AWS 
---

## Introduction

## What is VMware Site Recovery

VMware Site Recovery brings VMware enterprise-class Software-Defined Data Center (SDDC) Disaster Recovery as a Service to the AWS Cloud. It enables customers to protect and recover applications without the requirement for a dedicated secondary site. It is delivered, sold, supported, maintained and managed by VMware as an on-demand service.VMware Site Recovery works in conjunction with VMware Site Recovery Manager and VMware vSphere Replication to automate the process of recovering, testing, re-protecting, and failing-back virtual machine workloads. VMware Site Recovery utilizes VMware Site Recovery Manager servers to coordinate the operations of the VMware SDDC. 

![SRM5](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/srm-lab/SRM5.jpg)

VMware Site Recovery can be used between a customer's datacenter and an SDDC deployed on VMware Cloud on AWS or it can be used between two SDDCs deployed to different AWS availability zones or regions. VMware Site Recovery extends the feature set of the virtual infrastructure platform to provide for rapid business continuity through partial or complete site failures.

----------------------------------------------------------------------------------------------------------

## Activate the Site Recovery Add On

To use the VMware Site Recovery service, you must activate VMware Site Recovery at the recovery site on VMware Cloud on AWS.  If VMware Cloud on AWS is used at both the protected and recovery sites, it will need to be activated in both SDDCs.

### Activate Site Recovery

![SRM1](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/srm-lab/SRM1.jpg)

1. Click on the *Add Ons* tab
2. Under the Site Recovery Add On, Click the *ACTIVATE* button

    ![SRM2](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/srm-lab/SRM2.jpg) 

    Default extension ID:  Use this option when you deploy Site Recovery Manager in a standard configuration with one protected site and one recovery site.

    Custom extension ID:  Use this option when you deploy Site Recovery Manager in a shared recovery site configuration, with multiple protected sites and one recovery site.  For more details, see the Site Recovery Manager documentation.

3. In the pop up window Click *ACTIVATE* again


    ![SRM3](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/srm-lab/SRM3.jpg)

The activation process takes approximately 10 minutes to complete.

## Instructions to download and install on-prem components
### Site Recovery Manager
### vSphere Replication


### Changing to private IP instead of public IP




## Prepare and Pair Site Recovery

### Firewall Rules for Site Recovery

We will need to create Management Gateway firewall rules to allow for additional management gateway traffic including Site Recovery and vSphere Replication traffic. This needs to be done in both SDDCs.

![SRMNew1](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/srm-lab/SRMNew1.jpg)

1. In your SDDC, click *Networking & Security*
2. Click *Gateway Firewall* in the left-hand navigation menu
3. Click *Management Gateway*
4. Add the additional **four** rules that are shown above. Ask your instructor if you need assistance with creating the management gateway firewall rules. 
5. Click *PUBLISH*

### VMware Site Recovery - Site Pairing

![SRM18](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/srm-lab/SRM18.jpg)

You will be pairing to the other SDDC that is in your workshop organization.  Before beginning, each student needs to navigate to their partner's SDDC and save the vCenter FQDN and cloudadmin password.

1. Click *Settings* for your **partner's SDDC**
 
    The username on both sides (yours and your peer) will always be *cloudadmin@vmc.local*

2. Copy your partner's cloudadmin password and save it to notepad
3. Copy your partners vCenter FQDN.  Before saving it to notepad, change the format from what is displayed to what will be used, as shown below:

    *DISPLAYED*:

    ```link
    https://vcenter.sddc-xx-xxx-xx-xx.vmc.vmware.com/ui
    ```

    *USED*:

    ```link
    vcenter.sddc-xx-xxx-xx-xx.vmc.vmware.com
    ```

![SRM16](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/srm-lab/SRM16.jpg)

***IMPORTANT NOTE*: Only one person can do the Site Pairing exercise. Please decide between you and your partner who performs this step.**

1. Navigate to the SDDC of the student that will do the site pairing and click *Add Ons*
2. Click *OPEN SITE RECOVERY* (*If necessary, login with the cloudadmin credentials for that SDDC*)


    ![SRM17](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/srm-lab/SRM17.jpg)

3. Click *NEW SITE PAIR*

    ![SRM19](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/srm-lab/SRM19.jpg)
4. Enter the *vCenter FQDN* of your partner's SDDC in the format **vcenter.sddc-xx-xxx-xx-xx.vmc.vmware.com** in the *PSC host name* field
5. Enter *cloudadmin@vmc.local* in the *User name* field
6. Enter the *cloudadmin password* of your partner's SDDC into the *Password* field
7. Click *NEXT*

    ![SRM20](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/srm-lab/SRM20.jpg)
8. Click the *top-level checkbox* to select all Services
9. Click *NEXT*

    ![SRM21](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/srm-lab/SRM21.jpg)
10. Click *FINISH*

    ![SRMNew2](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/srm-lab/SRMNew2.jpg)

11. Click *VIEW DETAILS*

    ![SRMNew3](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/srm-lab/SRMNew3.jpg)

12. Enter *cloudadmin@vmc.local* for the *User name*
13. Enter the cloudadmin password for your **partner's SDDC** for the *Password*
14. Click *LOG IN*

    ![SRMNew4](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/srm-lab/SRMNew4.jpg)

Once logged in to your partner's SDDC, you will see the *Site Pair Summary*

