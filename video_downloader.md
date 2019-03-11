# YouTube-dl 
- Download videos from YouTube (and more sites)

Download:
https://rg3.github.io/youtube-dl/

Documentation:
https://github.com/rg3/youtube-dl/blob/master/README.md#readme


List all available formats
```
youtube-dl  -F https://www.youtube.com/watch?v=<ID>
```

List all available formats filtering MP4 with grep
```
youtube-dl -F https://www.youtube.com/watch?v=<ID> | grep mp4

```

Download best mp4 format available or any other best if no mp4 available
```
youtube-dl \
-f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best' \
https://www.youtube.com/watch?v=<ID>
```

List all available extractors (1126 until now 2018-08-29)
```
youtube-dl --list-extractors
```

Periscope download (list first)
```
youtube-dl -F https://www.pscp.tv/w/<id>
```

Twitter download (list first)
```
youtube-dl -F https://twitter.com/<user>/status/<tw-id>
```

Fox News aka Akamai AMP feed (list first)
```
youtube-dl -F http://video.foxbusiness.com/v/<id>/
```


Download `en` auto subtitle
```
youtube-dl         \
--write-auto-sub   \
--sub-lang=en      \
--skip-download    \
https://www.youtube.com/watch?v=<ID>
```

Download `en` subtitle
```
youtube-dl         \
--write-sub        \
--sub-lang en      \
--skip-download    \
https://www.youtube.com/watch?v=<ID>
```

Convert VTT to SRT using FFmpeg:
```
ffmpeg -i foo.vtt foo.srt
```

JSON playlist
```
youtube-dl -j --flat-playlist 'https://www.youtube.com/watch?v=ID' | jq -r '.id' | sed 's_^_https://youtube.com/v/_'
```

Extra options
```
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