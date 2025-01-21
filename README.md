After system installation:
```bash
guix pull
sudo guix system reconfigure ~/.config/guix/config.scm --substitute-urls='https://ci.guix.gnu.org https://bordeaux.guix.gnu.org https://substitutes.nonguix.org'
```

Subsequently:
```bash
guix pull
sudo guix system reconfigure ~/.config/guix/config.scm
```

# Error: no code for module (nongnu packages linux)
https://gitlab.com/nonguix/nonguix/-/issues/184
```bash
guix pull
export GUIX_PROFILE=$HOME/.config/guix/current
. $GUIX_PROFILE/etc/profile
hash guix
```

```
The following derivation will be built:
  /gnu/store/ib3j6i2qqvljlaswcfn7fzkanzid6762-install-bootloader.scm.drv

building /gnu/store/ib3j6i2qqvljlaswcfn7fzkanzid6762-install-bootloader.scm.drv...
guix system: bootloader successfully installed on '(/boot/efi)'
guix system: error: error parsing derivation `/gnu/store/5l9iqirah5k1lq8b8b8k6sds6jlchgf0-module-import-compiled.drv': expected string `Derive(['
```

```
$ guix package --list-profiles
/home/eldar/.config/guix/current
```
