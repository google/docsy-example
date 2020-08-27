---
title: "vmware"
date: 2020-04-24T22:47:10+02:00
draft: false
weight : 15
pre: "<b>513. </b>"
--- 

# System Vmware

---

## Abilitare VNC su una VM del Nodo

[![Vmwareparameter.png](http://192.168.178.102/images/e/e2/Vmwareparameter.png)](http://192.168.178.102/index.php/File:Vmwareparameter.png)

```
RemoteDisplay.vnc.password = password (inserire psw)
RemoteDisplay.vnc.port = TCP_Port (es: 9041)
RemoteDisplay.vnc.enabled = TRUE
RemoteDisplay.vnc.keymap = it
```

---

## Other Stuff

esxcfg-volume -l list

esxcfg-volume -M montaggio persistente

---

## List all VMs registered to this host (This reveals the Vmid needed for other commands)

vim-cmd /vmsvc/getallvms Unregister a VM vim-cmd /vmsvc/unregister <Vmid> Register a VM vim-cmd /solo/register /path/to/file.vmx Get power state of a VM vim-cmd /vmsvc/power.getstate <Vimid> Power off a VM vim-cmd /vmsvc/power.off <Vmid> Power on a VM vim-cmd /vmsvc/power.on <Vmid>

vim-cmd solo/registervm /vmfs/volumes/datastore_name/VM_directory/VM_name.vmx


If you have received the question, run this command to determine the virtual machine ID:

[root@user ~]# vim-cmd vmsvc/getallvms 80 VC4.1-user [datastore1] VC4.1-user/VC4.1-user.vmx winLonghorn64Guest vmx-07

For example, in this output, the virtual machine ID is 80. Run this command to get the question ID:

root@user ~]# vim-cmd vmsvc/message 80

You see output similar to:

Virtual machine message 12: msg.uuid.altered:This virtual machine may have been moved or copied.

To configure certain management and networking features VMware ESX needs to know which.

Did you move this virtual machine, or did you copy it? If you don't know, answer "I copied it".

\0. Cancel (Cancel) 1. I _moved it (I _moved it) 2. I _copied it (I _copied it) [default]

In this example the question ID is 12, and there are three choices: 0, 1, 2. To answer the question, run this command with the virtual machine ID and the Question ID followed by the choice number.

[root@user ~]# vim-cmd vmsvc/message VM_ID 12 2

For example to answer the question with choice 2, run:

[root@user ~]# vim-cmd vmsvc/message 80 12 2

The parameters in order are: 80 is the virtual machine ID, 12 is the question ID, and 2 is the choice number.

Note: In vSphere Client 5.x, if you see Virtual machine message _vmx1, run the command:

[root@user ~]# vim-cmd vmsvc/message VM_ID _vmx1 2

---

## Installare vmware su Domain Controller

```
VMware-viclient-all-5.5.0-1281650.exe /VSKIP_OS_CHECKS="1"
```
