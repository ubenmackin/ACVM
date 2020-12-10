# ACVM

A simple launcher for running ARM64 VM using QEMU on Apple silicon.

The launcher embedded a pre-built binary of QEMU based on [the patches](https://patchwork.kernel.org/project/qemu-devel/list/?series=392975) from [Alexander Graf](https://twitter.com/_AlexGraf).

You can download the Windows 10 on ARM from [here](https://www.microsoft.com/en-us/software-download/windowsinsiderpreviewARM64), and drag the VHDX file to the main image area to boot it.

## How to get internet access in the Windows VM

1. Download the virtio driver ISO from https://fedorapeople.org/groups/vir...o/virtio-win-0.1.190-1/virtio-win-0.1.190.iso
2. Edit the VM configuration, and load the iso as a "CD Image"
3. In Windows 10, right click on the Start menu, then choose “Command Prompt (Admin)”.
4. Click “Yes” in the UAC prompt.
5. Run the following in the CMD prompt to allow drivers that are test-signed:
> bcdedit -set TESTSIGNING ON
6. Restart Windows.
7. After Windows boots, right click on the Start menu, and choose “Device Manager”.
8. In the “Other devices” section, scroll all the way to the end.
9. Right click on the last “Unknown device” > Update drivers > Browse my computer for drivers > Browse.
10. Choose the virtual CD Drive (D:) virtio-win > OK > Next > Allow.
11. You should now have internet in the Windows 10 virtual machine.
