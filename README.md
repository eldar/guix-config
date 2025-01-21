After system installation:
```
guix pull
sudo guix system reconfigure ~/.config/guix/config.scm --substitute-urls='https://ci.guix.gnu.org https://bordeaux.guix.gnu.org https://substitutes.nonguix.org'
```

Subsequently:
```
guix pull
sudo guix system reconfigure ~/.config/guix/config.scm
```
