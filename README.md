# PlexCleaner-H265
H265 Encode your entire plex/emby library it will save you disk space!

This will check to see if media is already hevc encoded if it is it will skip that file so you don't have to worry about loss of quality / editing already h265 encoded media files.

# Usage

Run `H265_LargestFileFirst.cmd` and enjoy It will start with the largest video files in your library want to claim back that disk space as fast as we can after all :)

# Optional

`H265_Size.cmd` This script will only convert files larger than the set size `set max_file_size=2GB` in `plexcleaner.json` adjust the CRF quality factor to 27 - 30 to convert to decrease size each time you run this.

# How to change settings

Edit `plexcleaner.json` this line specificly https://github.com/C0nw0nk/PlexCleaner-H265/blob/main/win-x64/PlexCleaner.json#L141

For example you will see by default `"Video": "nvenc_h265_10bit` i use NVIDIA GPU for 265 encoding you can change it to AMD VAAPI CPU what ever you prefer.

Here is the list of options

## CPU Encoding

```
x265
x265_10bit
x265_12bit
```

## Intel QSV Encoding

```
qsv_h265
qsv_h265_10bit
```

## Nvidia GPU Encoding

```
nvenc_h265
nvenc_h265_10bit
```

## AMD GPU Encoding

```
vce_h265
vce_h265_10bit
```
