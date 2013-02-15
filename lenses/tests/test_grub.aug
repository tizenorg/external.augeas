module Test_grub =

  let conf = "# grub.conf generated by anaconda
#
# Note that you do not have to rerun grub after making changes to this file
# NOTICE:  You have a /boot partition.  This means that
#          all kernel and initrd paths are relative to /boot/, eg.
#          root (hd0,0)
#          kernel /vmlinuz-version ro root=/dev/vg00/lv00
#          initrd /initrd-version.img
#boot=/dev/sda
device (hd0) HD(1,800,64000,9895c137-d4b2-4e3b-a93b-dc9ac4)
password --md5 $1$M9NLj$p2gs87vwNv48BUu.wAfVw0
default=0
background 103332
timeout=5
splashimage=(hd0,0)/grub/splash.xpm.gz
gfxmenu=(hd0,0)/boot/message
hiddenmenu
title Fedora (2.6.24.4-64.fc8)
        root (hd0,0)
        kernel /vmlinuz-2.6.24.4-64.fc8 ro root=/dev/vg00/lv00 crashkernel=
        initrd /initrd-2.6.24.4-64.fc8.img
title=Fedora (2.6.24.3-50.fc8)
        root (hd0,0)
        kernel /vmlinuz-2.6.24.3-50.fc8 ro root=/dev/vg00/lv00
        initrd /initrd-2.6.24.3-50.fc8.img
title Fedora (2.6.21.7-3.fc8xen)
        root (hd0,0)
        kernel /xen.gz-2.6.21.7-3.fc8
        module /vmlinuz-2.6.21.7-3.fc8xen ro root=/dev/vg00/lv00
        module /initrd-2.6.21.7-3.fc8xen.img
title Fedora (2.6.24.3-34.fc8)
        root (hd0,0)
        kernel /vmlinuz-2.6.24.3-34.fc8 ro root=/dev/vg00/lv00
        initrd /initrd-2.6.24.3-34.fc8.img
        map (hd0) (hd1)
title othermenu
        configfile /boot/grub/othergrub.conf
"

  test Grub.lns get conf =
    { "#comment" = "grub.conf generated by anaconda" }
    {}
    { "#comment" = "Note that you do not have to rerun grub after making changes to this file" }
    { "#comment" = "NOTICE:  You have a /boot partition.  This means that" }
    { "#comment" = "all kernel and initrd paths are relative to /boot/, eg." }
    { "#comment" = "root (hd0,0)" }
    { "#comment" = "kernel /vmlinuz-version ro root=/dev/vg00/lv00" }
    { "#comment" = "initrd /initrd-version.img" }
    { "#comment" = "boot=/dev/sda" }
    { "device"   = "(hd0)"
	    { "file" = "HD(1,800,64000,9895c137-d4b2-4e3b-a93b-dc9ac4)" } }
    { "password" = "$1$M9NLj$p2gs87vwNv48BUu.wAfVw0"
        { "md5" } }
    { "default" = "0" }
    { "background" = "103332" }
    { "timeout" = "5" }
    { "splashimage" = "(hd0,0)/grub/splash.xpm.gz" }
    { "gfxmenu" = "(hd0,0)/boot/message" }
    { "hiddenmenu" }
    { "title" = "Fedora (2.6.24.4-64.fc8)"
        { "root" = "(hd0,0)" }
        { "kernel" = "/vmlinuz-2.6.24.4-64.fc8"
            { "ro" }  { "root" = "/dev/vg00/lv00" } {"crashkernel" = ""} }
        { "initrd" = "/initrd-2.6.24.4-64.fc8.img" } }
    { "title" = "Fedora (2.6.24.3-50.fc8)"
        { "root" = "(hd0,0)" }
        { "kernel" = "/vmlinuz-2.6.24.3-50.fc8"
            { "ro" } { "root" = "/dev/vg00/lv00" } }
        { "initrd" = "/initrd-2.6.24.3-50.fc8.img" } }
    { "title" = "Fedora (2.6.21.7-3.fc8xen)"
        { "root" = "(hd0,0)" }
        { "kernel" = "/xen.gz-2.6.21.7-3.fc8" }
        { "module" = "/vmlinuz-2.6.21.7-3.fc8xen"
            { "ro" } { "root" = "/dev/vg00/lv00" } }
        { "module" = "/initrd-2.6.21.7-3.fc8xen.img" } }
    { "title" = "Fedora (2.6.24.3-34.fc8)"
        { "root" = "(hd0,0)" }
        { "kernel" = "/vmlinuz-2.6.24.3-34.fc8"
            { "ro" } { "root" = "/dev/vg00/lv00" } }
        { "initrd" = "/initrd-2.6.24.3-34.fc8.img" }
        { "map" { "from" = "(hd0)" } { "to" = "(hd1)" } } }
    { "title" = "othermenu"
        { "configfile" = "/boot/grub/othergrub.conf" } }


  test Grub.lns put conf after set "default" "0" = conf

  test Grub.lns get "# menu.lst - See: grub(8), info grub, update-grub(8)

## default num\n" =
    { "#comment" = "menu.lst - See: grub(8), info grub, update-grub(8)" }
    {}
    { "#comment" = "# default num" }

  (* Color directive *)
  test Grub.lns get "color cyan/blue white/blue\n" =
    { "color"
      { "normal"    { "foreground" = "cyan" }
                    { "background" = "blue" } }
      { "highlight" { "foreground" = "white" }
                    { "background" = "blue" } } }

  test Grub.lns get "\tcolor cyan/light-blue\n" =
    { "color"
      { "normal" { "foreground" = "cyan" }
                 { "background" = "light-blue" } } }

  test Grub.lns put "color cyan/light-blue\n" after
    set "/color/highlight/foreground" "white";
    set "/color/highlight/background" "black"    =
    "color cyan/light-blue white/black\n"

  (* Boot stanza with savedefault *)
  let boot_savedefault =
"title\t\tDebian GNU/Linux, kernel 2.6.18-6-vserver-686
root\t\t(hd0,0)
  kernel\t\t/boot/vmlinuz-2.6.18-6-vserver-686 root=/dev/md0 ro
initrd\t\t/boot/initrd.img-2.6.18-6-vserver-686
\tsavedefault\n"

  test Grub.lns get boot_savedefault =
    { "title" = "Debian GNU/Linux, kernel 2.6.18-6-vserver-686"
      { "root" = "(hd0,0)" }
      { "kernel" = "/boot/vmlinuz-2.6.18-6-vserver-686"
          { "root" = "/dev/md0" } { "ro" } }
      { "initrd" = "/boot/initrd.img-2.6.18-6-vserver-686" }
      { "savedefault" } }

  test Grub.lns get
      "serial --unit=0 --speed=9600 --word=8 --parity=no --stop=1\n"
    =
    { "serial"
        { "unit" = "0" }
        { "speed" = "9600" }
        { "word" = "8" }
        { "parity" = "no" }
        { "stop" = "1" } }

  test Grub.lns get
      "terminal --timeout=10 serial console\n" =
    { "terminal"
        { "timeout" = "10" }
        { "serial" }
        { "console" } }

  test Grub.boot_setting get
      "chainloader --force +1 \n" = { "chainloader" = "+1" { "force" } }

  test Grub.savedefault put "savedefault\n" after
    set "/savedefault" "3" = "savedefault 3\n"

  (* BZ 590067 - handle comments in a title section *)
  (* Comments within a boot stanza belong to that boot stanza *)
  test Grub.lns get "title Red Hat Enterprise Linux AS (2.4.21-63.ELsmp)
    root (hd0,0)
    kernel /vmlinuz-2.4.21-63.ELsmp ro root=LABEL=/
    #initrd /initrd-2.4.21-63.ELsmp.img
    initrd /initrd-2.4.21-63.EL.img.e1000.8139\n" =
  { "title" = "Red Hat Enterprise Linux AS (2.4.21-63.ELsmp)"
    { "root" = "(hd0,0)" }
    { "kernel" = "/vmlinuz-2.4.21-63.ELsmp" { "ro" } { "root" = "LABEL=/" } }
    { "#comment" = "initrd /initrd-2.4.21-63.ELsmp.img" }
    { "initrd" = "/initrd-2.4.21-63.EL.img.e1000.8139" } }

  (* Comments at the end of a boot stanza go into the top level *)
  test Grub.lns get "title Red Hat Enterprise Linux AS (2.4.21-63.ELsmp)
    root (hd0,0)
    kernel /vmlinuz-2.4.21-63.ELsmp ro root=LABEL=/
    initrd /initrd-2.4.21-63.EL.img.e1000.8139
    # Now for something completely different\n" =
  { "title" = "Red Hat Enterprise Linux AS (2.4.21-63.ELsmp)"
    { "root" = "(hd0,0)" }
    { "kernel" = "/vmlinuz-2.4.21-63.ELsmp" { "ro" } { "root" = "LABEL=/" } }
    { "initrd" = "/initrd-2.4.21-63.EL.img.e1000.8139" } }
  { "#comment" = "Now for something completely different" }

  (* Solaris 10 extensions: kernel$ and module$ are permitted and enable *)
  (* variable expansion.  findroot also added, vaguely similar to root.  *)
  test Grub.lns get "title Solaris 10 10/09 s10x_u8wos_08a X86
    findroot (pool_rpool,0,a)
    kernel$ /platform/i86pc/multiboot -B $ZFS-BOOTFS
    module$ /platform/i86pc/boot_archive\n" =
  { "title" = "Solaris 10 10/09 s10x_u8wos_08a X86"
    { "findroot" = "(pool_rpool,0,a)" }
    { "kernel$" = "/platform/i86pc/multiboot" { "-B" } { "$ZFS-BOOTFS" } }
    { "module$" = "/platform/i86pc/boot_archive" } }

  (* Solaris 10 extension: multiboot kernel may take a path as its first *)
  (* argument. *)
  test Grub.lns get "title Solaris failsafe
    findroot (pool_rpool,0,a)
    kernel /boot/multiboot kernel/unix -s
    module /boot/x86.miniroot-safe\n" =
  { "title" = "Solaris failsafe"
    { "findroot" = "(pool_rpool,0,a)" }
    { "kernel" = "/boot/multiboot" { "@path" = "kernel/unix" } { "-s" } }
    { "module" = "/boot/x86.miniroot-safe" } }

(* Local Variables: *)
(* mode: caml       *)
(* End:             *)
