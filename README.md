### manual actions

enable unstable to get freash go and goland
```bash
nix-channel --add https://nixos.org/channels/nixos-unstable unstable
nix-channel --update
```

 - copy configuration.nix
 - copy hypr config dir
 - copy waybar config dir
 - copy wlogout config dir
 - copy xsettingsd config dir

enable waybar config
```bash
ln -s '/home/truewebber/.config/waybar/configs/[TOP] Default Laptop' '/home/truewebber/.config/waybar/config'
ln -s '/home/truewebber/.config/waybar/style/[Dark] Wallust Obsidian Edge.css' '/home/truewebber/.config/waybar/style.css'
```

---

edit goland vm options to enable wayland
```
-Dawt.toolkit.name=WLToolkit
```

Install gcloud using [official instruction](https://cloud.google.com/sdk/docs/install)

```
gcloud components install kubectl gke-gcloud-auth-plugin
```
