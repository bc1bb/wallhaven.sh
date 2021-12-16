# `wallhaven.sh`
This is a tiny script that downloads a random image from Wallhaven and then (if user asked for) puts it as MATE wallpaper.

(It will always download to `$XDG_PICTURES_DIR/wallhaven/` unless not set, it will download to `$HOME/Images/wallhaven/`)
## Requirements
- MATE Desktop **if you want to put wallpaper**,
- `curl`,
- `cut`,
- `grep`,
- `bash`. (I haven't tested compatibility with any other shell)
(It doesn't require any API Key)

```
curl https://raw.githubusercontent.com/jusdepatate/wallhaven.sh/master/wallhaven.sh > wallhaven.sh
chmod +x wallhaven.sh
./wallhaven.sh
```
