### manual actions

enable unstable to get freash go and goland
```bash
nix-channel --add https://nixos.org/channels/nixos-unstable unstable
nix-channel --update
```

edit goland vm options to enable wayland
```
-Dawt.toolkit.name=WLToolkit
```
