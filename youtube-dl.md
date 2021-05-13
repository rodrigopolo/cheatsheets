# YouTube-dl
- Download videos from YouTube (and more sites)

Download:
https://youtube-dl.org/

Documentation:
https://github.com/ytdl-org/youtube-dl/blob/master/README.md


Create defaults:
```sh
mkdir -p ~/.config/youtube-dl/
nano ~/.config/youtube-dl/config
```

Windows: `%APPDATA%\youtube-dl\config.txt`

Custom settings
```
-f 'bestvideo[ext=mp4][vcodec*=avc1.640]+bestaudio[ext=m4a]/best[ext=mp4]/best'
--write-info-json
--restrict-filenames
--continue
```


List all available formats
```sh
VIDEO_youtube-dl  -F URL
```

List all available formats filtering MP4 with grep
```sh
VIDEO_youtube-dl -F URL | grep mp4

```

Download best mp4 format available or any other best if no mp4 available
```sh
youtube-dl \
-f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best' \
VIDEO_URL
```

Download best, less than 720p
```sh
youtube-dl \
-f 'bestvideo[height<=720]+bestaudio/best[height<=720]' \
VIDEO_URL
```

List all available extractors (1126 until now 2018-08-29)
```sh
youtube-dl --list-extractors
```

Periscope download (list first)
```sh
youtube-dl -F https://www.pscp.tv/w/<id>
```

Twitter download (list first)
```sh
youtube-dl -F https://twitter.com/<user>/status/<tw-id>
```

Fox News aka Akamai AMP feed (list first)
```sh
youtube-dl -F http://video.foxbusiness.com/v/<id>/
```


List available subs
```sh
youtube-dl         \
https://www.youtube.com/watch?v=IDP3j_4icBo \
--list-subs
```

Download `en` auto subtitle
```sh
youtube-dl         \
https://www.youtube.com/watch?v=IDP3j_4icBo \
--write-auto-sub   \
--sub-lang=en      \
--skip-download    \
-o sub
```

Download `en` subtitle
```sh
youtube-dl         \
https://www.youtube.com/watch?v=IDP3j_4icBo \
--write-sub        \
--sub-lang en      \
--skip-download    \
-o sub
```

Convert VTT to SRT using FFmpeg:
```sh
ffmpeg -i foo.vtt foo.srt
```

JSON playlist
```sh
youtube-dl -j --flat-playlist 'https://www.youtube.com/watch?v=ID' | jq -r '.id' | sed 's_^_https://youtube.com/v/_'
```

Extra options
```sh
--skip-download                  Do not download the video
--write-info-json                Write video metadata to a .info.json file
--write-thumbnail                Write thumbnail image to disk
--write-all-thumbnails           Write all thumbnail image formats to disk
--list-thumbnails                Simulate and list all available thumbnail
                                 formats
--convert-subs FORMAT            Convert the subtitles to other format
                                 (currently supported: srt|ass|vtt|lrc)
                                 This option only worsk with full download
                                 doesn't work with --skip-download 
```