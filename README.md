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

# Preparation

Install Bottles from flatpak and use your package manager to install `wget` for file downloads and `cabextract` for unpacking the IE7 installer.
```
# Arch Linux
sudo pacman -S wget cabextract
```

# Downloads
Run the download script to collect copies of Microsoft Money Deluxe Sunset and IE7 installers.


# References
[1] [Microsoft Money Offline Linux Instructions](https://microsoftmoneyoffline.wordpress.com/2025/02/22/running-money-on-linux-os/)

[2] [Nathan Giard's Shared Files](https://drive.google.com/drive/folders/1QerT2ylQzDK4an76atBpcdivF9Hy-nIa)
