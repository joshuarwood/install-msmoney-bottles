# Introduction
This project contains instructions and scripts for installing Microsoft Money Deluxe Sunset in Arch Linux using [Bottles](https://usebottles.com/).
It is based on the [work by Nathan Giard](https://microsoftmoneyoffline.wordpress.com/2025/02/22/running-money-on-linux-os/)
with the main difference being that it uses a sandboxed wine bottle instead of system wine.
This because I have preferences for:

1. Using the Bottles interface from flatpak
2. Limiting sudo use within scripts downloaded from the internet
3. Grabbing files from Internet Archive

These are purely my personal choices and are not intended to be a criticism of Nathan's work. In fact,
I am extremely grateful that he put together the Linux guide for getting Microsoft Money working in 64 bit mode.

The following guide assumes you're familiar with running commands within a terminal.

# Preparation

Install Bottles from flatpak and use your package manager to install `wget` for file downloads and `cabextract` for unpacking the IE7 installer.
```
# Arch Linux
sudo pacman -S wget cabextract
```

Setup a new custom bottle using the `msmoney_bottle.yml` configuration included in this project. This will automatically
install the `msxml3 msxml4 tahoma32 vcrun2005` dependencies needed by Microsoft Money in addition to `gecko`
and `mono`.

Run the download script to collect copies of Microsoft Money Deluxe Sunset and IE7 installers from Internet Archive.
This step will verify the md5sum checksums on each file to ensure they are the correct files.
```
bash download.sh
```

# IE7 Patches
Microsoft Money requires Internet Explorer 7 to work properly, which is a pain since it won't install in newer
versions of wine with WoW64 support. Luckily, we only need a couple of the DLLs so we can extract them from the
installer and copy them to the wowsys64 directory of your bottle with an extractor script. Do this by
specifying the bottle name you used in the Preparation step.
```
bash ie7-extract.sh BottleName
```
Note: You'll need to replace spaces in the bottle name with `-` for this step since that is how Bottles
chooses to name the system prefix path. For example, `MS Money` would become `MS-Money`.

We now need to register some of the extracted files. Do this by going to Bottles and selecting your bottle name.
Scroll to the bottom where it says Tools and click on Command Line to bring up a Windows command prompt.
Enter the following two commands:
```
cd drive_c\windows\syswow64
ie7cmds.cmd
```
This should print a series of messages like this
```
regsvr32: Successfully registered DLL 'browseui.dll'
regsvr32: Successfully installed DLL 'browseui.dll'

regsvr32: Successfully registered DLL 'mshtml.dll'
regsvr32: Successfully installed DLL 'mshtml.dll'

regsvr32: Successfully registered DLL 'occache.dll'
regsvr32: Successfully installed DLL 'occache.dll'

regsvr32: Successfully registered DLL 'shdocvw.dll'
regsvr32: Successfully installed DLL 'shdocvw.dll'

regsvr32: Successfully registered DLL 'urlmon.dll'
regsvr32: Successfully installed DLL 'urlmon.dll'

regedit ie7dlls.reg
```
Close the command prompt after seeing the final `regedit ie7dlls.reg` command.

# Installing Microsoft Money
Open Bottles and select the bottle where you installed the Internet Explorer 7 patches.
Click the Run Executable button at the top and select the `USMoneyDlxSunset.exe` file that
was downloaded to this project directory during the Preparation step. An installer window
should pop up. The install should complete relatively quickly (<1 min) on most modern computers
after you click through the agreements pages.

To run the program I recommend setting up a shortcut under the Programs section. Do this
by clicking Add Shortcuts and navigate to
```
drive_c/Program Files (x86)/Microsoft Money Plus/MNYCoreFiles/msmoney.exe
```
Click OK to accept after selecting `msmoney.exe`.

You should now see an `msmoney` button under the Programs section with a play icon next to it.
Clicking the play icon should start Microsoft Money. You may see a black bar at the top of the
window when in full screen. This should disappear when you minimize. 

Click the File tab in the top left and open a new file. If this works, then you're good to go!

If it fails... well.. I can try to address it if you submit an issue but
we might need to wait for another fix from [Nathan Giard](https://drive.google.com/drive/folders/1QerT2ylQzDK4an76atBpcdivF9Hy-nIa).
Many, many thanks and credit go to Nathan for figuring this process out.

# Fixing Subtotal Column
The default `comctl32.dll` included with modern wine will result in misaligned subtotal entries on the accounts page.
To fix it you'll need to download `msmoneysetup_Linux_64bit_FullInstall_30Jan2026.zip` from 
[Nathan's Shared Files](https://drive.google.com/drive/folders/1QerT2ylQzDK4an76atBpcdivF9Hy-nIa), unzip it, and copy
`msmoneysetup/moneyinstaller/comctl32.dll` to this project's directory. Then run
```
bash comctl32-patch.sh BottleName
```
to install it.

You'll also need to add a DLL override for this version of `comctl32`. Open Bottles and navigate
to your bottle with Microsoft Money. From there select Settings followed by DLL Overrides under
the Compatibility section. Enter `comctl32` and click the blue checkmark to complete the override.

I do not know which version of Windows this DLL comes from, but it appears to work well. If you want.
to revert to the original DLL from your wine installation do
```
bash comctl32-restore.sh BottleName
```

# References
[1] [Microsoft Money Offline Linux Instructions](https://microsoftmoneyoffline.wordpress.com/2025/02/22/running-money-on-linux-os/)

[2] [Nathan Giard's Shared Files](https://drive.google.com/drive/folders/1QerT2ylQzDK4an76atBpcdivF9Hy-nIa)
