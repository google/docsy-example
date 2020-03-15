---
title: "VMware Cloud on AWS APIs"
linkTitle: "VMware Cloud on AWS APIs"
date: 2020-03-13
weight: 30
description: >
  In this lab exercise we will be showing how you can interact with the VMware Cloud on AWS platform through programmatic means. We will go through how we can use PowerShell as a means to interact with the Cloud Solution Platform as well as the vCenter instance. We will then delve into how we can interact with the VMware Cloud on AWS REST API and perform actions in both the integrated "Developer Center" view in the console, and also through popular third party and open source REST clients. For the purposes of our lab exercise we will be making use of "Postman" as our REST Client.
---
## Using PowerShell

![APIs1](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/APIs/APIs1.jpg)

1. Click on **Start**, and scroll down until you see the Windows PowerShell menu
2. Right click on the **PowerShell** CLI shortcut icon and select **Run as Administrator**

    ![APIs3](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/APIs/APIs3.jpg)

Install the VMware PowerCLI module

```powershell
Install-Module VMware.PowerCLI
```

**NOTE**: You will be asked to install the NuGet provider, take the default or press **Y** and press enter, you will then be asked to trusted an untrusted repository, **DO NOT** take the default but type **Y** and press Enter.

![APIs4](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/APIs/APIs4.jpg)

We now need to set the execution policy to Remote Signed.

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Force
```

![APIs5](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/APIs/APIs5.jpg)

You now will need to set the PowerCLI Configuration to Ignore Invalid Certificates.

**IMPORTANT STEP:**

```powershell
Set-PowerCLIConfiguration -InvalidCertificateAction Ignore -Confirm:$false -WarningAction:SilentlyContinue
```

**NOTE**: Be sure the "i" in "Ignore" is capitalized if you are not using copy/paste

![APIs6](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/APIs/APIs6.jpg)

We now need to install the VMware CLI commands

```powershell
Install-Module -name VMware.VMC -scope AllUsers -Force
```

![APIs7](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/APIs/APIs7.jpg)

Let's take a quick look at the VMware CLI commands

```powershell
Get-VMCCommand -WarningAction:SilentlyContinue
```

![APIs8](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/APIs/APIs8.jpg)

We now need to get your Refresh Token from the VMC console. Switch back to or open the web browser and log into **vmc.vmware.com**

If you are not already logged in

3. Open a new tab
4. Click on the VMware Cloud on AWS shortcut
5. Fill in your email address
6. Click on **Next**

    ![APIs9](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/APIs/APIs9.jpg)

7. Click on the drop down next to your **Name/Org ID**
8. Click on **My Account**

    ![APIs10](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/APIs/APIs010.jpg)

    We will now create a new Refresh Token for the ID linked to this Org

9. Click on **API Tokens** tab.
10. Click **Generate a New API Token**

    ![APIs011](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/APIs/APIs011.jpg)

11. Give the token a name.
12. Select checkbox by **Organization Owner.**
13. Select checkbox by **VMware Cloud on AWS.**
14. Click **Generate** button.

    ![APIs012](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/APIs/APIs012.jpg)

15.  Click on **Copy** button to save refresh token to clipboard.

***Note:*** Make sure to save this refresh token in a safe place to be used in the next section when using API's in Postman.

Now let's attach to the VMC server, input the command below and append the refresh token after the -refreshtoken parameter

```powershell
connect-vmc -refreshtoken
```

![APIs13](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/APIs/APIs13.jpg)

Now that we are connected to our VMC organization through PowerShell, we can see what Orgs we have access to using the following command

```powershell
Get-VMCorg
```

Note the Org Display_Name and ID

![APIs14](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/APIs/APIs14.jpg)

Now that we know the Org Display_Name we can find out information about the SDDC's inside our org.

**NOTE**: replace # with your workstation number

```powershell
Get-VMCSDDC -Org VMC-WS#
```

![APIs15](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/APIs/APIs15.png)

Another cool thing you can do is see the Default Credentials for your SDDC

```powershell
Get-VMCSDDCDefaultCredential -org VMC-WS#
```

**NOTE**: replace # with your workstation number

## REST APIs through Developer Center

In this module we will be using the VMware Cloud on AWS REST API to get some basic information about your VMware Cloud on AWS Organization and SDDC deployment. To do this we will be using the new Developer Center feature in VMware Cloud on AWS. This was built specifically to focus on using APIs and scripts to create SDDCs, add and remove hosts, plus connect to and use the full vCenter API set. To get started, let go back to your VMC environment.

![DeveloperCenter1](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/APIs/DeveloperCenter1.jpg)

Launch the Chrome browser on your Student View Desktop

![DeveloperCenter2](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/APIs/DeveloperCenter2.jpg)

If you are not already logged in, log into your VMware Cloud on AWS organisation.

1. From within the VMware Cloud on AWS tab, click on the Developer Center menu

    ![DeveloperCenter3](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/APIs/DeveloperCenter3.jpg)

    In the Developer Center there are a lot of great resources for you to explore. For example, let's check out a code sample that was uploaded by one of our API developers. If you scroll through this screen you will see there are code samples for Postman (a REST API Development Tool)

    You will also find samples for Python, PowerCLI, and many others. Anyone can contribute code samples to the community, if that interests you go to <http://code.vmware.com> or click on the link **VMware{code} Sample Exchange**.
2. Click on *Code Samples* in the menu
3. Click on *Download* in the "PowerCLI - VMC Example Script" box

    ![DeveloperCenter4](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/APIs/DeveloperCenter4.jpg)

    After the script downloads
4. Click on the dropdown arrow
5. Click on **Show in Folder**
6. Unzip the **PowerCLI-Example-Scripts-master.zip** file
7. Open the **PowerCLI-Example-Scripts-master** folder
8. Open **Scripts** folder
9. Open **VMware_Cloud_on_AWS** folder
10. Right click on the **VMC Example Script.ps1** script
11. Click on edit

    This will open the PowerShell ISE environment. Now you can see the PowerShell commands you used in the previous module as well as other commands you can use with your SDDC. Close the PowerShell ISE windows

    ![DeveloperCenter6](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/APIs/DeveloperCenter6.jpg)

    Let's now run some simple REST API commands built into Developer Center, go back to your browser

12. Click on the API Explorer menu
13. Make sure you select your SDDC
14. Click on the drop down arrow next to Organization
15. Click on the drop down arrow next to the first "GET" API
16. Click on *Execute*

    ![DeveloperCenter7](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/APIs/DeveloperCenter7.jpg)

    What did we not do?? We did not put in any authentication to pull this data. The reason is we are using the session authentication to execute these commands. To run these commands in other application, like PowerShell or Postman, you will need to get your resource and session tokens before you can run these commands.

    Let's look through the response.
17. Here you see the Organization's alphanumeric name. Which you can also find in *\#3*
18. The organization *ID*. *NOTE*: Copy the ID number, without the quotes, for possible use in the next step.
19. The organization *Display_Name*
20. The organization Version

    ![DeveloperCenter8](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/APIs/DeveloperCenter8.jpg)

    In this step, we will GET some information about our organization
21. Click on the drop down arrow by SDDCs
22. Click on **GET**
23. The Org ID should already be filled in for you, another great feature the developers built in based on customer feedback. *NOTE*: If this Org ID did not automatically fill in, paste it in.
24. Click on **Execute**

    ![DeveloperCenter9](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/APIs/DeveloperCenter9.jpg)

    Now let's look at the response body
25. The creation date of the SDDC
26. The SDDC ID
27. the SDDC state

## Postman

In this module, we will be exploring how to use Postman to execute REST API requests and build automation through collections. Postman is an API Explorer tool. As an example, you can create variables for use within the APIs, test the response, and use webhooks to integrate with collaboration platforms.

![Postman1](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/APIs/Postman1.jpg)

Postman is very easy to install, so let's get started.

1. Open a new browser tab and go to <https://www.getpostman.com>
2. Click on *Download the App*

    ![Postman2](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/APIs/Postman2.jpg)

3. Select Postman for **Windows (64-bit)**. Click **Download**. Double-click on the downloaded file, the install will execute without interaction.

    *NOTE*: For cleanup you can close all postman tabs in Chrome

    ![Postman3](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/APIs/Postman3.jpg)

4. Click on the text: *Skip Signing in and Take me straight to the app*

    ![Postman4](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/APIs/Postman4.jpg)

5. Uncheck *Show this window on launch*
6. Close this window

    ![Postman5](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/APIs/Postman5.jpg)

    Go back to your browser window, if you do not have a tab opened for VMware Cloud on AWS, follow the below instructions

7. Navigate to <https://github.com/vmware/vsphere-automation-sdk-rest/archive/master.zip> to download the vSphere Automation REST SDK. 

    Our internal API development team has done a great job pre-creating SDKs for many of the popular languages in use today. For this module, we will be using the SDK for REST to show you how you can easily import and reuse some pre-built collections to create your own.

    ![Postman7](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/APIs/Postman7.jpg)

8. *This step intentionally left blank*
9. *This step intentionally left blank*
10. Click on the download menu
11. Click on *Open*

    ![Postman8](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/APIs/Postman8.jpg)

12. Click on *Extract*
13. Click on *Extract all*

    ![Postman9](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/APIs/Postman9.jpg)

    We will keep the default file path.

14. Uncheck the box
15. Click on *Extract*

    Close the file explorer window

    ![Postman10](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/APIs/Postman10.jpg)

    Now that we have Postman installed and our REST samples on our local system, lets import the VMC collection and use some the requests to build our own collection.

16. Click on *Import*
17. Click on *Choose Files*

    ![Postman11](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/APIs/Postman11.jpg)

    To import the VMC collection json file we downloaded earlier.

18. Browse to the directory we extracted the zip file to earlier. That directory should be *C:\downloads\vsphere-automation-sdk-rest-master\vsphere-automation-sdk-rest-master\samples\postman*
19. Click *VMware Cloud on AWS APIs.postman_collection.json*
20. Click *Open*

    ![Postman12](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/APIs/Postman12.jpg)

    We now need to get our refresh token for our Org in VMC. Go back to your VMware Cloud on AWS tab in your browser

21. Click on the drop down next to your *Name/Org ID*
22. Click on *My Account*

    We will now create a new Refresh Token for the ID linked to this Org.

    ***NOTE***: If you have already generated a token, use the same token that was generated.  You can also regenerate a new token if needed.

    ![Postman13](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/APIs/APIs010.jpg)

23. Click on **API Tokens** tab.
24. Click **Generate a New API Token**

    ![APIs011](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/APIs/APIs011.jpg)

25. Give the token a name.
26. Select checkbox by **Organization Owner.**
27. Select checkbox by **VMware Cloud on AWS.**
28. Click **Generate** button.

    ![APIs012](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/APIs/APIs012.jpg)

29. Click on **Copy** button to save refresh token to clipboard.

    ![Postman16](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/APIs/Postman16.jpg)

    Return to the Postman app. We now need to setup a Postman environment for use with VMC. An environment is where we will be creating and storing our variables. These variables can be local or global, depending on your use within Postman. In this module, we will only be using local variables.

30. Click on **New**
31. Click on **Environment**

    ![Postman17](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/APIs/Postman17.jpg)

32. Name the environment **VMC**
33. In the Key column type in **refresh_token**
34. In the Value column use CTRL-V to paste your actual refresh token you copied in a previous step.
35. Click on **Add**
36. Close the window

    ![Postman18](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/APIs/Postman18.jpg)

    Now set this as our default environment.

    *NOTE*: If you don't set the default environment to *VMC*, then the variables that get created will not be accessible.

37. Click on the drop down arrow
38. Select **VMC**

    ![Postman19](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/APIs/Postman19.jpg)

    Now we will start to build our own collection by using some request that came in the SDK we imported earlier.

39. Click on **Collections**
40. Click on - **Authentication and Login**
41. See how this request is our refresh token variable we defined in an earlier step.

    *NOTE*: If the environment is not set to VMC, this will request will fail because the refresh_token variable is not defined.

42. Click on **Send**
43. You will now see the access token that was generated with the refresh token. This is the body or payload of the response to our request.

    ![Postman20](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/APIs/Postman20.jpg)

44. Click on the Eye icon

    You will see that we have stored your access token into a variable so we can use it for futurecalls. How did we do that? We ran a "test" on the response body. You will see how in the next step.

    ![Postman21](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/APIs/Postman21.jpg)

45. Click on **Tests**

    The access_token variable was set by running some java script code against the response. We are also using the Postman setEnvironmentVariable function to create it.

    ![Postman22](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/APIs/Postman22.jpg)

    Lets save this request to our own collection so we can use it later.

46. Click on the drop down arrow
47. Click on **Save As**

    ![Postman23](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/APIs/Postman23.jpg)

48. Change the Request name to **Authorize**
49. Change the Request description to *Get Access Token*
50. Click on **Create Collection**
51. Type **Workshop** and click the *check box*

    ![Postman24](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/APIs/Postman24.jpg)

52. Select the **Workshop** folder
53. Click on **Save to Workshop**

    ![Postman25](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/APIs/Postman25.jpg)

    A new window will pop open indicating that you created a new collection. We will not do anything here at this time.

54. Close this window

    ![Postman26](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/APIs/Postman26.jpg)

    Let's request some details from our Org so we can send them to Slack.

55. Click on **Orgs** and **List Orgs**
56. Click on **Headers**
57. Click **Send**
58. You see here how we are using the **access_token** variable for the **csp-auth-token**. This will authorize our request. *NOTE*: This access token is only good for 30 minutes. If you run this request and get a response of **400 unauthorized**, go back and run the authorize request.
59. Look through the response body for your Org's **display_name**

    ![Postman27](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/APIs/Postman27.jpg)

    Let's save this request to our own collection so we can use it later.

60. Click on the drop down arrow
61. Click on **Save As**

    ![Postman28](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/APIs/Postman28.jpg)

62. Change the Request name to **Org list**
63. Change the Request description to **Get a list of your Orgs**
64. Be sure *Workshop* is selected under **Select a collection or folder to save to:**
65. Click on **Save to Workshop**

    ![Postman29](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/APIs/Postman29.jpg)

    We need to replace the Test code that came with the SDK so we can create variable we want to use when send our message to Slack.

66. Click on **Tests**
    Copy and paste the below code into the **Tests** section. *NOTE*: You may have to press CTRL-V to paste into the text box.
67. Click **Send**

    ```javascript
    var jsonData = JSON.parse(responseBody);

    if (responseCode.code === 200) {
    for (i = 0; i < jsonData.length; i++) {
      pm.environment.set("name", jsonData[i].display_name);
      pm.environment.set("ID", jsonData[i].id);
      pm.environment.set("version", jsonData[i].version);
      pm.environment.set("state", jsonData[i].project_state);
       }
     }
     ```

    ![Postman30](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/APIs/Postman30.jpg)

    We can verify if the variables have been created and assigned values.

68. Click on the eye icon
69. Scroll down to see if the new variables were created.
    Once verified click on the "eye" icon again to close the window

    ![Postman31](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/APIs/Postman31.jpg)

    Lets save the changes we made to this request.
70. Click on **Save**

    ![Postman32](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/APIs/Postman32.jpg)

    Now that we have details of our Org lets send them to slack inn a message.

    To post to slack a link needs to be generated for the slack channel that we want to post to. This has already been done for you and is listed below. One of the instructors will have this slack channel displayed on the screens. So you can see the results.

    Slack channel URL:

    ```link
    https://hooks.slack.com/services/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
    ```

    Now we need to setup the request:

71. Click on the **+** sign for a new request
72. Change the request type to **POST**
73. Cut and paste the above slack channel URL to the *address* box
74. Select **Body**
75. Change the format type to **raw**
76. Type the below code, or cut and paste it into the Body section. *NOTE*: You may have to press CTRL-V to past into the text box.

    ```json
    {
      "text" : "{% raw %}Your Org ID is: {{ID}}\nYour Org version is: {{version}}\nAnd your Org state is: {{state}}{% endraw %}",
      "username" : "{% raw %}{{name}}{% endraw %}"
    }
    ```

77. Click **Send**

    ![Postman33](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/APIs/Postman33.jpg)

    Lets save this request to our own collection so we can use it later.

78. Click on the drop down arrow
79. Click on **Save As**

     ![Postman34](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/APIs/Postman34.jpg)

80. Change the Request name to **Post to Slack**
81. Change the Request description to **Post some Org details to slack** Be sure Workshop is selected under *Select a collection or folder to save to:*
82. Click on **Save to Workshop**

    Check and see if your request posted the Name, ID, Version, and Status of your Org.

    ![Postman35](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/APIs/Postman35.jpg)

    The last thing to show you with Postman is the way that you can run a collection to automate a series of tasks. What we have been doing in this module is building a collection. As you see in the screen shot there are 3 tasks in the Workshop collection.

83. Click on the Arrow in the Workshop window
84. Click on **Run**

    ![Postman36](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/APIs/Postman36.jpg)

85. Click on **Run Workshop**
86. Be sure the **Environment** is set to VMC

    ![Postman37](https://s3-us-west-2.amazonaws.com/vmc-workshops-images/APIs/Postman37.jpg)

    If all your work was saved and ran individually, they should run here as well.

87. Check out the status of each request.

If you have all "200 OK" then you will see another post in slack for your workshop Org.

Please add comments below if you would like to give feedback on this lab.