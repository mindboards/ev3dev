### How To Do It

In many cases, you can just plug in your USB wifi dongle and it will "Just Work (tm)" - but sometimes, it just won't. Here's how to get that off brand dongle you bought on DealExtreme to work.

Note: From time to time we release incremental updates for specific modules that are added as needed. The incremental updates are "rolled up" when we do new `ev3dev-rootfs` or `ev3dev-modules` releases so you don't need to monkey around with downloading specific drivers one at a time.

### Figure out the USB pid/vid

Use the 'lsusb' command to dump the current USB device list. For my TPLINK TL-WN725N device, it looks like this:

```clean
Bus 001 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 001 Device 005: ID 0bda:8179 Realtek Semiconductor Corp.
```

So, good news, the TL-WN725N uses a Realtek chipset, but which one?

### Figure out the chipset details

Head on over to the [Wikidevi site](http://wikidevi.com/wiki/Main_Page), then paste `0bda:8179` into the search window and you'll get some hits for that pid/vid combination.

A bit of reading and you'll find that it uses the Realtek RTL8188EUS chipset - and you can get drivers for it, but only for the Raspberry Pi.

### Wait for someone to build the kernel module

You're in luck, I've just added this module to the module list! You gan get the latest and greatest modules on the [ev3dev-releases][ev3dev-releases] site and look for the [`v00.01.01-rtl8188eu-module` release][v00.01.01-rtl8188eu-module], and download it.

Note, higher versioned `ev3dev-rootfs` and `ev3dev-modules` bundles will have these changes "rolled up" in them, so you won't need to go back and get the driver if you upgrade.

Using your [mad nfs skilz][SetUpAnNfsFileShare] as root, unzip the `rtl8188ue` tar file like this:

```clean
# cd / 
# tar -pxvf /nfs/path/to/your/downloads/rtl8188eu.tar.gz 
# depmod -a
```

That command is running as `root` so be careful. Basically, it changes the current directory to the very top of your filesystem, and then it extracts the contents of the `rtl8188eu.tar.gz` file (preserving permissions). The files will fit right into `/lib/modules/...` and `/lib/firmware/...` with no additional work on your part.

If you're paying attention, we did not even copy the `rtl8188eu.tar.gz` file to the EV3 first, we left it on the host machine!

Of course, you need to run `depmod -a` so that the module loader knows where to find the new module(s).

After that, it's just [setting up your wifi][SetUpWifiNetworking] configuration to work with this dongle!

## <a name="References"/> References

- [ev3dev][ev3dev]
- [ev3dev-wiki][ev3dev-wiki]
- [ev3dev-releases][ev3dev-releases]
- [ev3dev-GettingStarted][ev3dev-GettingStarted]
- [Larry Finger's rtl8188eu repo][LarryFingers-rtl8188eu]

[ev3dev]: https://github.com/mindboards/ev3dev
[ev3dev-wiki]: https://github.com/mindboards/ev3dev/wiki
[ev3dev-releases]: https://github.com/mindboards/ev3dev/releases
[ev3dev-GettingStarted]: https://github.com/mindboards/ev3dev/wiki#getting-started

[SetUpAnNfsFileShare]: https://github.com/mindboards/ev3dev/wiki/Set-Up-An-nfs-FileShare
[SetUpWifiNetworking]: https://github.com/mindboards/ev3dev/wiki/Setting-Up-wifi-Networking

[v00.01.01-rtl8188eu-module]: https://github.com/mindboards/ev3dev/releases/tag/v00.01.01-rtl8188eu-module

[LarryFingers-rtl8188eu]: https://github.com/lwfinger/rtl8188eu.git