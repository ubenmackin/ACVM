# ACVM

A simple launcher for running ARM64 VM using QEMU on Apple silicon.

The launcher embedded a pre-built binary of QEMU based on [the patches](https://patchwork.kernel.org/project/qemu-devel/list/?series=392975) from [Alexander Graf](https://twitter.com/_AlexGraf).

You can download the Windows 10 on ARM from [here](https://www.microsoft.com/en-us/software-download/windowsinsiderpreviewARM64), and drag the VHDX file to the main image area to boot it.

## How to get internet access in the Windows VM

1. Download the virtio driver ISO from https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/archive-virtio/virtio-win-0.1.190-1/virtio-win-0.1.190.iso
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

## How to setup virtio-gpu in the Windows VM

If you have already enabled test signing for the above ethernet driver, you can skip steps 1-4

1. In Windows 10, right click on the Start menu, then choose “Command Prompt (Admin)”.
2. Click “Yes” in the UAC prompt.
3. Run the following in the CMD prompt to allow drivers that are test-signed:
> bcdedit -set TESTSIGNING ON
4. Restart Windows.

5. After Windows boots, download the virtio driver from [here](https://github.com/ubenmackin/ACVM/releases/download/v1.5/viogpudo.zip).
6. Unzip the folder.
7. Run the InstallCerts and Driver.bat
8. After this is done, shutdown Windows.
9. AVCM configuration for Windows VM, switch the graphics option to from ramfb to virtio-gpu.

Note: This driver use a hardware cursor which causes the default Windows white arrow cursor to not display properly. If you leave the "unhide mouse pointer" checked, then you will see the Mac cursor and it avoids the invisible cursor issue. Alternatively, you can switch the cursor option in Windows to use the Black cursor instead of the White cursor, and then uncheck the "unhide mouse pointer" in ACVM.