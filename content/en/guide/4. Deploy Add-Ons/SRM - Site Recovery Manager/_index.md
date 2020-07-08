---
title: "SRM - Site Recovery Manager"
linkTitle: "SRM - Site Recovery Manager"
weight: 2
description: >
  How to install SRM for VMware Cloud on AWS 
---

## Introduction

## What is VMware Site Recovery

VMware Site Recovery brings VMware's enterprise-class Software-Defined Data Center (SDDC) Disaster Recovery as a Service to the AWS Cloud. It enables customers to protect and recover applications without the requirement for a dedicated secondary site. It is delivered, sold, supported, maintained and managed by VMware as an on-demand service.VMware Site Recovery works in conjunction with VMware Site Recovery Manager and VMware vSphere Replication to automate the process of recovering, testing, re-protecting, and failing-back virtual machine workloads. VMware Site Recovery can address multiple DR use cases for organizations, and it can be used between a customer's datacenters/remote locations and a VMware Cloud on AWS SDDC or between two SDDCs deployed in different AWS availability zones or regions.

![UseCases](https://vmc-workshops-images.s3-us-west-2.amazonaws.com/srm-lab/Cheshire/UseCases.JPG)

Visit [VMware Site Recovery Resources](https://cloud.vmware.com/vmware-site-recovery/resources) for further information including the [VMware Site Recovery Evaluation Guide](https://storagehub.vmware.com/section-assets/draas-eval-guide).

----------------------------------------------------------------------------------------------------------

## Activate the Site Recovery Add On

To use the VMware Site Recovery service, you must activate VMware Site Recovery at the recovery site on VMware Cloud on AWS.  If VMware Cloud on AWS serves as both the protected and recovery sites, it will need to be activated in both SDDCs.

![SRM1](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/srm-lab/SRM1.jpg)

1. For the selected SDDC, Click on the ***Add Ons*** tab
2. Under the Site Recovery Add On, Click the ***ACTIVATE*** button

    ![SRM2](https://vmc-workshops-images.s3-us-west-2.amazonaws.com/srm-lab/Cheshire/SRM2.png)

3. If you need to download Site Recovery Manager and vSphere Replication for the on-premises installation, click the download link to open the page that will be used in the following step.
   
   Unless you are doing a shared recovery site configuration with multiple protected sites and one recovery site, leave the **Default extension ID** option selected.  For more information, see the [VMware Site Recovery documentation](https://docs.vmware.com/en/VMware-Site-Recovery/index.html).

    *Default extension ID:  Use this option when you deploy Site Recovery Manager in a standard configuration with one protected site and one recovery site.*

    *Custom extension ID:  Use this option when you deploy Site Recovery Manager in a shared recovery site configuration, with multiple protected sites and one recovery site. For more details, see the Site Recovery Manager documentation.*


4. Click ***ACTIVATE*** to install the VMware Site Recovery and vSphere Replication components into the SDDC.

    ![SRM3](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/srm-lab/SRM3.jpg)

**The activation process takes approximately 10 minutes to complete.**

## Download and Install Site Recovery Manager and vSphere Replication On-Prem
If you don't have vSphere Replication and Site Recovery Manager already installed in your on-premises location, you will need to download those components and install them.  If you do have them installed, be sure to review the [Site Recovery Documentation & Compatibility Matrices](https://docs.vmware.com/en/VMware-Site-Recovery/index.html) to ensure the versions you have on-prem are compatible with the versions installed into the VMware Cloud on AWS SDDC.

![SRM4](https://vmc-workshops-images.s3-us-west-2.amazonaws.com/srm-lab/Cheshire/SRM4.png)

1. On the page that was opened to download the on-premises components, click ***GO TO DOWNLOADS***  (*note that the selected version depicted in the screenshot may be different*)

    ![SRM5](https://vmc-workshops-images.s3-us-west-2.amazonaws.com/srm-lab/Cheshire/SRM5.png)

2. Click ***DOWNLOAD NOW*** to download the Site Recovery Manager *.iso disk image file
3. Click ***DOWNLOAD NOW*** to download the vSphere Replication *.iso disk image file
   
   (*note that version numbers may differ from what is depicted in the above screenshot)*

![SRM6](https://vmc-workshops-images.s3-us-west-2.amazonaws.com/srm-lab/Cheshire/SRM6.png)

1. After downloading and unzipping the disk image files, log in to your on-premises vCenter as a user with privileges to install OVFs, select the location you want to install Site Recovery Manager and vSphere Replication to, and for each appliance, right-click and choose ***Deploy OVF Template...***.  Power on both appliances after the installations are complete.

***For detailed information on installing the Site Recovery Manager and vSphere Replication appliances, see the [Site Recovery Manager documentation](https://docs.vmware.com/en/Site-Recovery-Manager/index.html) and the [vSphere Replication documentation](https://docs.vmware.com/en/vSphere-Replication/index.html).***

### ***ADD SCREENSHOTS FOR CONFIGURING ON-PREM VR AND SRM APPLIANCES***

## Create Firewall Rules to Allow Traffic from the Protected Site to the VMC SDDC

To allow for Site Recovery Manager and vSphere Replication traffic, it is necessary to create Management Gateway firewall rules. If you are using a VMware Cloud an AWS SDDC for both the protected and DR sites, this will need to be done in both SDDCs.

*From EVAL GUIDE:  To allow communication and replication traffic between the remote site site and the VMware Cloud on AWS SDDC requires the addition of some firewall
rules to the management gateway. Rules may also need to be added for the
remote site firewall. Those changes are outside of the scope of this guide.*

### Create Management Group for On-Premises Components

![SRM7](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/srm-lab/Cheshire/SRM7.jpg)

1. In your SDDC, click ***Networking & Security***
2. Click ***Groups***

    ![SRM8](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/srm-lab/Cheshire/SRM8.jpg)

You will start by creating a group that contains the IP Addresses for your on-prem vCenter, vSphere Replication, and Site Recovery Manager.

3. Click ***Management Groups***

    ![SRM9](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/srm-lab/Cheshire/SRM9.jpg)

4. Click ***ADD GROUP***

    ![SRM10](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/srm-lab/Cheshire/SRM10.jpg)

5.  Enter ***On-Prem VC, vSR, SRM*** in the *Name* field
6.  Click ***Set Members***

    ![SRM11](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/srm-lab/Cheshire/SRM11.jpg)

7.  Enter the ***IP Addresses*** for your *on-premises vCenter, vSphere Replication and Site Recovery Manager Appliances*.
8.  Click ***APPLY***

    ![SRM12](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/srm-lab/Cheshire/SRM12.jpg)

9.  Click ***SAVE***

### Create Management Gateway Firewall Rules

Management Gateway Firewall Rules to allow replication traffic from the on-premises site to the VMC SDDC.  The below rules represent the simple firewall rule configuration.  For more granular firewall rules see [Set the NSX-T Edge Management Gateway Firewall Rules for VMware Site Recovery](https://docs.vmware.com/en/VMware-Site-Recovery/services/com.vmware.srmaas.install_config.doc/GUID-2AC3C681-58C4-49B1-BD29-33F7C70F3184.html).

  
![SRM13](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/srm-lab/Cheshire/SRM13.jpg)

1.  In the *Networking & Security* tab of your SDDC, click ***Gateway Firewall***
2.  Click ***Management Gateway***

    ![SRM14](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/srm-lab/Cheshire/SRM14.jpg)

3.  Click ***ADD RULE***
4.  Enter ***On-Prem to SRM*** in the ***Name*** column 

    ![SRM15](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/srm-lab/Cheshire/SRM15.jpg)

5.  Hover over the ***Source*** column and click the ***pencil icon***

    ![SRM16](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/srm-lab/Cheshire/SRM16.jpg)

6.  Click the ***User Defined Groups*** *radio button*
7.  Click the *check box* next to the ***On-Prem VC, vSR, SRM*** group you created earlier
8.  Click ***APPLY***

    ![SRM17](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/srm-lab/Cheshire/SRM17.jpg)

9.  Hover over the ***Destination*** column and click the ***pencil icon***

    ![SRM18](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/srm-lab/Cheshire/SRM18.jpg)

10.  Click the ***System Defined Groups*** *radio button*
11.  Click the *check box* next to ***Site Recovery Manager***
12.  Click ***APPLY***

    
![SRM19](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/srm-lab/Cheshire/SRM19.jpg)

13.  Click the ***Services*** field

![SRM20](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/srm-lab/Cheshire/SRM20.jpg)

14.  Select ***VMware Site Recovery SRM***

![SRM21](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/srm-lab/Cheshire/SRM21.jpg)

15.  Click ***PUBLISH*** to publish this firewall rule

![SRM22](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/srm-lab/Cheshire/SRM22.jpg)

16.  Go through ***Steps 3 through 15*** three more times to add the ***SRM to On-Prem, On-Prem to VR, and VR to On-Prem*** firewall rules depicted in the above screenshot, and ***PUBLISH*** them when complete.

### Troubleshoot Connectivity Issues

If you are having connectivity issues, you can use the Connectivity Validator  to run network connectivity tests to ensure all necessary access is available to perform the use case you select. If a test fails, follow the recommendations to correct the problem.

![SRM23](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/srm-lab/Cheshire/SRM23.jpg)

1.  Click on the ***Troubleshooting*** tab for your SDDC
2.  Select ***Site Recovery*** from the ***Connectivity Use Case*** dropdown
3.  Enter the required ***Inputs*** for each ***Test Group***
4.  Click ***RUN ALL TESTS*** *(note that you can also run test groups individually)*


## Pair VMware Site Recovery Sites

### ***SCREENSHOTS AND INSTRUCTIONS FOR SITE PAIRING NEED UPDATED***

![SRM16](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/srm-lab/SRM16.jpg)

1. Navigate to the SDDC and click ***Add Ons***
2. Click ***OPEN SITE RECOVERY*** (*If necessary, login with the cloudadmin credentials for that SDDC*)

    ![SRM17](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/srm-lab/SRM17.jpg)

3. Click ***NEW SITE PAIR***

    ![SRM19](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/srm-lab/SRM19.jpg)

4. Enter the *vCenter FQDN* of your on-prem vCenter in the format **vcenter.sddc-xx-xxx-xx-xx.vmc.vmware.com** in the *PSC host name* field
5. Enter the ***User name*** for your on-prem vCenter
6. Enter the ***Password*** for your on-prem vCenter
7. Click ***NEXT***

    ![SRM20](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/srm-lab/SRM20.jpg)

8. Click the ***top-level checkbox*** to select all Services
9. Click ***NEXT***

    ![SRM21](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/srm-lab/SRM21.jpg)

10. Click ***FINISH***

    ![SRMNew2](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/srm-lab/SRMNew2.jpg)

11. Click ***VIEW DETAILS***

    ![SRMNew3](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/srm-lab/SRMNew3.jpg)

12. Enter ***cloudadmin@vmc.local*** for the *User name*
13. Enter the ***cloudadmin password*** for your **partner's SDDC** for the *Password*
14. Click *LOG IN*

    ![SRMNew4](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/srm-lab/SRMNew4.jpg)

Once logged in to your on-prem vCenter, you will see the ***Site Pair Summary***

**After your site pairing is complete, you can now proceed with configuring mappings, setting up replication for your VMs, creating protection groups and recovery plans, and testing your recovery plans.  For details on using Site Recovery Manager, see the [Site Recovery Manager documentation](https://docs.vmware.com/en/Site-Recovery-Manager/index.html) and refer to the [VMware Site Recovery Evaluation Guide](https://storagehub.vmware.com/section-assets/draas-eval-guide).**