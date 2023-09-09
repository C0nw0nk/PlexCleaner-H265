# PlexCleaner-H265
H265 Encode your entire plex/emby library it will save you disk space!

This will check to see if media is already hevc encoded if it is it will skip that file so you don't have to worry about loss of quality / editing already h265 encoded media files.

# Usage

Run `H265_LargestFileFirst.cmd` and enjoy It will start with the largest video files in your library want to claim back that disk space as fast as we can after all :)


# How to change settings

Edit `plexcleaner.json` this line specificly https://github.com/C0nw0nk/PlexCleaner-H265/blob/main/win-x64/PlexCleaner.json#L141

For example you will see by default i use NVIDIA GPU for 265 encoding you can change it to AMD VAAPI CPU what ever you prefer.
