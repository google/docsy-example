---
title: "Policy Based"
linkTitle: "Policy Based"
weight: 2
description: >
  How to setup Policy based VPN for VMware Cloud on AWS
---

# How-to Configure a Policy Based IPSec VPN
## Navigate to Network & Security tab of the SDDC
1. Click the Network & Security tab in the SDDC portal

![Navigate to Network & Security tab of the SDDC](https://vmc-onboarding-images.s3-us-west-2.amazonaws.com/2.Connect-SDDC/vpn/policy-based/step01_network_and_security.png)


## Add new Policy Based VPN
1. Click VPN section under Network in sidebar
2. Select Policy Based tab in VPN section
3. Click ADD VPN button

![Add new Policy Based VPN](https://vmc-onboarding-images.s3-us-west-2.amazonaws.com/2.Connect-SDDC/vpn/policy-based/step02_add_policy_vpn.png)

## Configure Policy Based VPN in VMC
1. Name: Enter a name for this VPN tunnel. This can be anything and should be named something to make it easy to understand what this tunnel is being used for.
2. Local IP Address: Select Public IP from the drop down menu. Unless you're configuring a VPN tunnel over a Private VIF using a Direct Connect you should never need to select Private IP.
3. Remote Public IP: Enter the public IP address of the on-prem firewall being used to terminate this VPN tunnel. The customer should be able to provide you with this information and should already have been provided as part of the technical validation process if this is being done as part of a POC or Paid Pilot.
4. (Optional) Remote Private IP: Leave blank unless the customer's on-prem VPN is being terminated behind a NAT appliance and doesn't have its own public IP. You will almost never need to configure this outside of this rare side case.
5. Remote Networks: Enter the on-prem subnets that will need to access VMC or will need to be accessible from VMC. 
6. Local Networks: Select the local networks in VMC that need to be accessible from on-prem or will need to access on-prem networks. For this you will usually select the Infrastructure Subnet as well as any compute network segments configured in VMC.
7. Preshared Key: Have the customer define a strong password for the preshared key. Be aware that this is shown in plain text when configuring and is accessible as plain text in the CSP so do not choose something that overlaps with other passwords for security purposes.
8. Click **Save**

{{% alert title="Additional Configuration Options" color="primary" %}}
All other configuration options can be modified as needed based on customer requirements. Not every customer's firewall will be able to support the default parameters and some customers may want to choose different options based on established corporate standards. You should NOT need to define any of the remaining configuration parameters but should allow the customer to define them based on feedback from their network or security teams internally.
{{% /alert %}}

![Configure Policy Based VPN in VMC](https://vmc-onboarding-images.s3-us-west-2.amazonaws.com/2.Connect-SDDC/vpn/policy-based/step03b_vpn_config.png)

## Download VPN Configuration and Configure On-Prem VPN Appliance
1. Expand the newly created Policy Based VPN
2. Click Download Config to download the VPN configuration. This configuration can be provided to the customer's network or security team responsible for configuring the VPN tunnel on-prem to make it easier for them to mirror the config.

{{% alert title="Preshared key is in plain text!" color="warning" %}}
Before emailing or sharing the VPN config it is usually a good idea to remove the preshared key from the text file for security purposes. Be sure to let the customer know this is stored in plain text so they can handle it according to any established infosec procedures they may have in their environment for storing or transferring this file.
{{% /aert %}}

{{% alert title="Differences with AWS Native" color="primary" %}}
Unlike AWS native which will allow you to select your on-prem firewall appliance and auto generate a corresponding configuration, the config provided by VMC is in a generic format and the customer will be responsible for configuring their own appliances themselves.
{{% /aert %}}

![Download VPN Configuration and Configure On-Prem VPN Appliance](https://vmc-onboarding-images.s3-us-west-2.amazonaws.com/2.Connect-SDDC/vpn/policy-based/step04a_status_down.png)

## Verify Status of VPN Tunnel
1. Once the customer has properly configured their on-prem firewall for the VPN tunnel the status of the tunnel should change from Down to Success. If the tunnel does not come up have the customer validate their configuration as most times the problem will lie on their end. Be aware however that as of M9 the tunnel configuration defaults to Private IP for the Local IP Address in the tunnel configuration whereas previously this defaulted to Public IP, which can easily be missed. Aside from validating the configuration parameters matching the customer will be responsible for any troubleshooting of the configuration on their side.

![Verify Status of VPN Tunnel](https://vmc-onboarding-images.s3-us-west-2.amazonaws.com/2.Connect-SDDC/vpn/policy-based/step04b_status_success.png)
