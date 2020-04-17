---
title: "SRM - Site Recovery Manager"
linkTitle: "SRM - Site Recovery Manager"
weight: 2
description: >
  How to install SRM for VMware Cloud on AWS 
---

## Introduction

## What is VMware Site Recovery

VMware Site Recovery brings VMware enterprise-class Software-Defined Data Center (SDDC) Disaster Recovery as a Service to the AWS Cloud. It enables customers to protect and recover applications without the requirement for a dedicated secondary site. It is delivered, sold, supported, maintained and managed by VMware as an on-demand service. IT teams manage their cloud-based resources with familiar VMware tools without the difficulties of learning new skills or utilizing new tools and processes.

VMware Site Recovery works in conjunction with VMware Site Recovery Manager and VMware vSphere Replication to automate the process of recovering, testing, re-protecting, and failing-back virtual machine workloads. VMware Site Recovery utilizes VMware Site Recovery Manager servers to coordinate the operations of the VMware SDDC. This is so that, as virtual machines at the protected site are shut down, copies of these virtual machines at the recovery site startup. By using the data replicated from the protected site these virtual machines assume responsibility for providing the same services.

![SRM5](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/srm-lab/SRM5.jpg)

VMware Site Recovery can be used between a customer's datacenter and an SDDC deployed on VMware Cloud on AWS or it can be used between two SDDCs deployed to different AWS availability zones or regions. The second option allows VMware Site Recovery to provide a fully VMware-managed Disaster Recovery solution. Migration of protected inventory and services from one site to the other is controlled by a recovery plan that specifies the order in which virtual machines are shut down and started up, the resource pools to which they are allocated, and the networks they can access.

VMware Site Recovery extends the feature set of the virtual infrastructure platform to provide for rapid business continuity through partial or complete site failures.

----------------------------------------------------------------------------------------------------------

## Activate the Site Recovery Add On

To use the VMware Site Recovery service, you must activate VMware Site Recovery at the recovery site on VMware Cloud on AWS.  If VMware Cloud on AWS is used at both the protected and recovery sites, it will need to be activated in both SDDCs.

### Activate Site Recovery

![SRM1](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/srm-lab/SRM1.jpg)

1. Click on the *Add Ons* tab
2. Under the Site Recovery Add On, Click the *ACTIVATE* button

    ![SRM2](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/srm-lab/SRM2.jpg) 

3. In the pop up window Click *ACTIVATE* again

    ![SRM3](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/srm-lab/SRM3.jpg)

Wait until the Site Recovery Add On has been activated. This process takes approximately 10 minutes to complete.

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

## Configure Mappings
### Configure Network Mappings

![SRM22](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/srm-lab/SRM22.jpg)

1. Click *Network Mappings* in the left pane of the Site Recovery page
2. Click *+ NEW*

    ![SRM23](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/srm-lab/SRM23.jpg)
3. Select *Prepare mappings manually*
4. Click *NEXT*

    ![SRM24](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/srm-lab/SRM24.jpg)
5. Expand *SDDC Datacenter* on both sides
6. Expand *VMC Networks* on both sides
7. Click the *checkbox* next to *Demo-Net* on the left
8. Click the *radio button* next to *Demo-Net* on the right
9. Click *ADD MAPPINGS*

    ![SRM24-a](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/srm-lab/SRM24-a.jpg)

10. Click the *checkbox* next to *sddc-cgw-network-1* on the left
11. Click the *radio button* next to *sddc-cgw-network-1* on the right
12. Click *ADD MAPPINGS*

    ![SRM24-b](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/srm-lab/SRM24-b.jpg)

13. Ensure both network mappings have been created
14. Click *NEXT*

    ![SRM25](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/srm-lab/SRM25.jpg)

    DO NOT select anything in Reverse Mappings

15. Click *NEXT*

    ![SRM26](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/srm-lab/SRM26.jpg)

16. Click *NEXT*

    ![SRM27](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/srm-lab/SRM27.jpg)

17. Click *FINISH*

### Folder mappings

![SRM28](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/srm-lab/SRM28.jpg)

1. Select *Folder Mappings* in the left pane
2. Click *+ NEW

    ![SRM29](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/srm-lab/SRM29.jpg)
3. Select *Prepare mappings manually*
4. Click *Next*

    ![SRM30](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/srm-lab/SRM30.jpg)
5. Expand *vcenter...* on both sides
6. Expand *SDDC-Datacenter* on both sides
7. Click the *checkbox* next to *Workloads* on the left
8. Click the *radio button* next to *Workloads* on the right
9. Click *ADD MAPPINGS*

    ![SRM30-a](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/srm-lab/SRM30-a.jpg)

10. Click *NEXT*

    ![SRM31](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/srm-lab/SRM31.jpg)

    DO NOT select any Reverse mappings

11. Click *NEXT*

    ![SRM32](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/srm-lab/SRM32.jpg)

12. Click *FINISH*

### Resource Mappings

![SRM33](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/srm-lab/SRM33.jpg)

1. Click *Resource Mappings* in the left pane
2. Click *+ NEW*

    ![SRM34](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/srm-lab/SRM34.jpg)

3. Expand *SDDC-Datacenter* on both sides
4. Expand *Cluster-1* on both sides
5. Click the *checkbox* next to *Compute-ResourcePool* on the left
6. Click the *radio button* next to *Compute-ResourcePool* on the right
7. Click *ADD MAPPINGS*

    ![SRM34-a](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/srm-lab/SRM34-a.jpg)
    
8. Click *NEXT*

    ![SRM35](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/srm-lab/SRM35.jpg)
    
    DO NOT select any reverse mappings

9. Click *NEXT*

    ![SRM36](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/srm-lab/SRM36.jpg)

10. Click *FINISH*

### Storage Policy Mappings

![SRM37](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/srm-lab/SRM37.jpg)

1. Select *Storage Policy Mappings* in the left pane
2. Click *+ NEW*

    ![SRM38](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/srm-lab/SRM38.jpg)

3. Select *Prepare mappings manually*
4. Click *NEXT*

    ![SRM39](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/srm-lab/SRM39.jpg)

5. Click the *checkbox* next to *vSAN Default Storage Policy* on the left
6. Click the *radio button* next to *vSAN Default Storage Policy* on the right
7. Click *ADD MAPPINGS*

    ![SRM39-b](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/srm-lab/SRM39-b.jpg)

8. Click *NEXT*

    ![SRM40](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/srm-lab/SRM40.jpg)

9. Click the *checkbox* next to *vSAN Default Storage Policy* for Reverse mappings
10. Click *NEXT*

    ![SRM41](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/srm-lab/SRM41.jpg)

11. Click *FINISH*

### Placeholder Datastores

![SRM42](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/srm-lab/SRM42.jpg)

1. Select *Placeholder Datastores* in the left pane
2. Click *+ NEW*

    ![SRM43](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/srm-lab/SRM43.jpg)

3. Click the *checkbox* next to *WorkloadDatastore*
4. Click *ADD*

    ![SRM43-a](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/srm-lab/SRM43-a.jpg)

For Placeholder Datastores, you must select a datastore at each side, so you'll repeat the same steps for the other vCenter.

5. Click the *vCenter entry* for the vCenter that you are **paired with**
6. Click *+ NEW*

    ![SRM43-b](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/srm-lab/SRM43-b.jpg)

7. Click the *checkbox* next to *WorkloadDatastore*
8. Click *ADD*

## Create VMs to use wtih Site Recovery

You will now create four VMs to use for Site Recovery.

Navigate back to the vSphere client for ***YOUR SDDC***

If you need to log back in to your SDDC thru the VMC console, use the *cedxx@vmware-hol.com* userid provided to you at the beginning and the password of *VMware1!*

![SRM70](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/srm-lab/SRM70.jpg)

1. From ***YOUR SDDC*** vSphere Client, Click *Menu*

2. Click *Content Libraries*

    ![SRM71](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/srm-lab/SRM71.jpg) 

3. Click the *Windows-Content-Library*

    ![SRM72](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/srm-lab/SRM72.jpg) 

4. Click *Templates*

5. Click *OVF & OVA Templates*

6. Right-click the *Windows2012r2* template

7. Click *New VM from This Template...*

    ![SRM73](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/srm-lab/SRM73.jpg)

8. Enter *CRM-APP-xx* where *xx* is **your student ID number**

9. Select *Workloads*

10. Click *NEXT*

    ![SRM74](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/srm-lab/SRM74.jpg)

11. Select *Compute-ResourcePool*
12. Click *NEXT*

    ![SRM75](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/srm-lab/SRM75.jpg)

13. Click *NEXT*

    ![SRM76](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/srm-lab/SRM76.jpg)

14. Select *WorkloadDatastore*
15. Click *NEXT*

    ![SRM77](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/srm-lab/SRM77.jpg)

16. Select *Demo-Net* from teh *Destination Network* dropdown listbox
17. Click *NEXT*

    ![SRM78](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/srm-lab/SRM78.jpg)

18. Click *FINISH*

    **REPEAT the steps above three more times and create VMs named *CRM-DB-xx, FIN-APP-xx, and FIN-DB-xx* where *xx* is your Student ID number**

    ![SRM79](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/srm-lab/SRM79.jpg)

19. After you have created all four of your VMs, navigate to the VMs in the vSphere Client and ***Power On*** all four VMs.

## Using Site Recovery

We will use Site Recovery to replicate the VMs we want to protect, create protection groups for those VMs, and create and test recovery plans.  Navigate back to Site Recovery for your SDDC
<br>

### Replicate VMs to Recovery Site
<br>

![SRM100](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/srm-lab/SRM100.jpg)

We will use Site Recovery to Navigate back to Site Recovery for your SDDC

1. Click *Replications* from the top menu bar
2. Click *+ NEW*

    ![SRM101](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/srm-lab/SRM101.jpg)

3. Select *ALL FOUR* of the VMs you created previously
4. Click *NEXT*

    ![SRM102](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/srm-lab/SRM102.jpg)

5. Ensure *Auto-assign vSphere Replication Server* is selected
6. Click *NEXT*

    ![SRM103](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/srm-lab/SRM103.jpg)

7. Select *WorkloadDatastore*
8. Click *NEXT*

    ![SRM104](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/srm-lab/SRM104.jpg)

9. Leave all defaults for the RPO and click *NEXT*

    ![SRM105](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/srm-lab/SRM105.jpg)

10. Select *Do not add to protection group now*
11. Click *NEXT*

    ![SRM106](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/srm-lab/SRM106.jpg)

12. Click *FINISH

    ![SRM107](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/srm-lab/SRM107.jpg)

13. Click *Refresh* until all VMs show a status of **OK** (this may take a couple of minutes)

### Create Protection Groups and Recovery Plans

We will create 2 Protection Groups, one for our CRM application and one for our Finance application.  A VM can only belong to one Protection Group, but a Protection Group can belong to more than one Recovery Plan.

![SRM108](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/srm-lab/SRM108.jpg)

1. Click *Protection Groups*
2. Click + NEW*

    ![SRM109](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/srm-lab/SRM109.jpg)

3. Enter *CRM-PG-XX* where **XX** is your Student ID for *Name*
4. Click *NEXT*

    ![SRM110](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/srm-lab/SRM110.jpg)

5. Select *Individual VMs (vSphere Replication)
6. Click *NEXT*

    ![SRM111](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/srm-lab/SRM111.jpg)

7. Select both your *CRM VMs*
8. Click *NEXT*

    ![SRM112](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/srm-lab/SRM112.jpg)

    We will create a Recovery Plan that will just recover our CRM application

9. Select *Add to new recovery plan*
10. Enter *CRM-RP-XX* where **XX** is your Student ID for the *Recovery Plan Name*
11. Click *NEXT*

    ![SRM113](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/srm-lab/SRM113.jpg)

12. Click *FINISH*

    ![SRM114](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/srm-lab/SRM114.jpg)

13. Repeat steps 2 thru 12 above for the FIN VMs to create the *FIN-PG-XX* protection group

**If you get a *Not configured* error when creating the protection groups, ensure under Site Pair that you have configured Placeholder Datastores for each side.  Once that is done, you will need to *Restore all Placeholder VMs* for each protection group**

### Create a Recovery Plan for All Applications

We will create another Recovery Plan that will recover all of our applications.  As stated before, a VM can only belong to one Protection Group, but a Protection Group can belong to more than one Recovery Plan.

![SRM115](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/srm-lab/SRM115.jpg)

1. Click *Recovery Plans*
2. Click + NEW*

    ![SRM116](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/srm-lab/SRM116.jpg)

3. Enter *ALL-APPS-RP-XX* where **XX** is your Student ID for *Name*
4. Click *NEXT*

    ![SRM117](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/srm-lab/SRM117.jpg)

5. Select *Protection groups for individual VMs or datastore groups*
6. Select both the *CRM and FIN* Protection Groups
7. Click *NEXT*

    ![SRM118](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/srm-lab/SRM118.jpg)

8. Click *NEXT*

    ![SRM119](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/srm-lab/SRM119.jpg)

9. Click *FINISH*

    ![SRM120](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/srm-lab/SRM120.jpg)

10. You should now have three Recovery Plans, one just for the CRM app, one just for the FIN app, and one for all apps.

### Perform a Recovery Test

![SRM121](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/srm-lab/SRM121.jpg)

1. Click the *radio button* next to the *CRM-RP-XX* Recovery Plan where **XX** is your Student ID
2. Click *TEST*

    ![SRM122](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/srm-lab/SRM122.jpg)

3. Click *NEXT*

    ![SRM123](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/srm-lab/SRM123.jpg)

4. Click *FINISH*

    ![SRM124](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/srm-lab/SRM124.jpg)

5. Click the *CRM-RP-XX* Recovery Plan where **XX** is your Student ID

    ![SRM125](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/srm-lab/SRM125.jpg)

6. Click *Recovery Steps*

    ![SRM126](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/srm-lab/SRM126.jpg)

7. Note the status of the test

    ![SRM127](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/srm-lab/SRM127.jpg)

8. Ensure the status shows *Test complete*
9. Click *CLEANUP* to cleanup the activity and return the environment to its normal state

    ![SRM128](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/srm-lab/SRM128.jpg)

10. Click *NEXT*

    ![SRM129](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/srm-lab/SRM129.jpg)

11. Click *FINISH*

    ![SRM130](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/srm-lab/SRM130.jpg)

12. Note the status of the cleanup until it is complete

    ![SRM131](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/srm-lab/SRM131.jpg)

**Once the *cleanup* is complete, the Recovery Plan is in a *Ready* status and is ready for a test or a recovery.**

