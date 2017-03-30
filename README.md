# iperi-overlay
Overlay containing various ebuilds for Gentoo.

## List of ebuilds
* dev-util/clion
* dev-util/idea-community
* games-puzzle/vitetris
* sys-firmware/iwl7260-ucode

## Warning
**Use ebuilds supplied in this repository on your own risk.**

## Installation
### Add repository to portage
These are instructions for version >= 2.2.16 of Portage using [new plug-in sync system](https://wiki.gentoo.org/wiki/Project:Portage/Sync).

If you haven't already installed **git**, do it now:

    # emerge --ask dev-vcs/git

Make sure that `/etc/portage/repos.conf` exists, and is a directory. Then, open your favourite editor:

    # nano -w /etc/portage/repos.conf/iperi-overlay.conf

and put the following text in the file:
```
[iperi-overlay]

location = /usr/local/portage/iperi-overlay
sync-type = git
sync-uri = https://github.com/iperi/iperi-overlay.git
priority = 50
auto-sync = yes
```
Sync the repository:

    # emaint sync --repo iperi-overlay

### Mask repository for security
The main advantage of masking is that no unwanted packages from repository will conflict with official portage tree during system updates.

Make sure that `/etc/portage/package.mask`, `/etc/portage/package.unmask` exist, and are directories. Mask all packages from repository:

    # echo "*/*::iperi-overlay" >> /etc/portage/package.mask/iperi-overlay

Now if you want install a package CATEGORY/PACKAGE, you must first unmask it:

    # echo "CATEGORY/PACKAGE::iperi-overlay" >> /etc/portage/package.unmask/PACKAGE

and then normally run:

    # emerge --ask CATEGORY/PACKAGE

## Maintainers
* [iperi](mailto:iperi@users.noreply.github.com)
