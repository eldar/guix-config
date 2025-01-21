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


