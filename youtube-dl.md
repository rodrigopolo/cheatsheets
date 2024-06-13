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

Download playlists with template name
```sh
youtube-dl \
-o "%(playlist_index)s-%(title)s.%(ext)s" \
"https://youtube.com/playlist?list=<id>"
```

Download video with date, channel, title, id and extension template
```sh
youtube-dl \
-o "%(upload_date)s - %(channel)s-%(title)s.%(id)s.%(ext)s" \
https://youtu.be/ID
```

List all available extractors (1126 until now 2018-08-29)
```sh
youtube-dl --list-extractors
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
VIDEO_URL \
--list-subs
```

Download `en` auto subtitle
```sh
youtube-dl         \
VIDEO_URL \
--write-auto-sub   \
--sub-lang=en      \
--skip-download    \
-o sub
```

Download `en` subtitle
```sh
youtube-dl         \
VIDEO_URL \
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
youtube-dl -j --flat-playlist 'https://www.youtube.com/watch?v=ID' | \
jq -r '.id' | \
sed 's_^_https://youtube.com/v/_'
```

Get filenames from a playlist
```sh
youtube-dl \
--get-filename \
-o "%(playlist_index)s-%(title)s.%(id)s.%(ext)s" \
"https://youtube.com/playlist?list=<id>"
```

Get playlist info into JSON
```sh
youtube-dl \
--print-json \
--get-filename \
-o "%(playlist_index)s-%(title)s.%(id)s.%(ext)s" \
"https://youtube.com/playlist?list=PLqifZi_0bBnv7PoPLN4W8vkBotkRlRobh" > playlist_info.txt
```

Get title parsing JSON
```sh
cat playlist_info.txt | \
grep -E "^\{\"id" | \
jq -s "." | \
jq -r '.[] | .title'
```

Get title, thumbnail and description into CSV pasting JSON
```sh
cat playlist_info.txt | \
grep -E "^\{\"id" | \
jq -s "." | \
jq -r '.[] | [.title, .thumbnail, .description] | @tsv'
```

Download using saved cookie
1. Install the *[Get cookies.txt](https://chrome.google.com/webstore/detail/get-cookiestxt/bgaddhkoddajcdgocldbbfleckgcbcid)* extension.
2. Visit site logged in, click on the Get Cookies extension ico, and “Export” to a text file.
3. Save the file in a directory and using the Terminal go to that directory.
4. Run YouTube-DL including the cookie file.

```sh
youtube-dl \
--cookies youtube.com_cookies.txt \
[YouTube URL]
```

Download using browser cookies:
```sh
yt-dlp \
--cookies-from-browser chrome
```

Download using `aria2`
```sh
youtube-dl \
--external-downloader aria2c \
--external-downloader-args "-j 6 -s 6 -x 6 -k 5M" \
VIDEO_URL
```

Flags in `aria2`
```
-j, --max-concurrent-downloads=<N> - maximum number of parallel downloads for every queue item
-s, --split=<N> - Download a file using N connections
-x, --max-connection-per-server
-k, --min-split-size=<SIZE> 
```

Related
* https://github.com/ytdl-org/youtube-dl/issues/29326#issuecomment-879256177  
* https://www.reddit.com/r/DataHoarder/comments/7qpuhn/youtubedl_being_throttled/  
* https://github.com/CyberShadow/turbotuber  
* https://news.ycombinator.com/item?id=28322485  


Other misc options
```sh
-f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best'
-f 'bestvideo[height<=480]+bestaudio/best[height<=480]'
-f 'bestvideo[height<=1080]+bestaudio[ext=m4a]'
-f 'bestvideo[height<=720]+bestaudio/best[height<=720]'
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

### Alternatives


[YT-DLP](https://github.com/yt-dlp/yt-dlp#installation)

Uninstall `youtube-dl`
```sh
brew uninstall youtube-dl
rm -rf ~/.config/youtube-dl/
```

Install `yt-dpl`
```sh
cd ~/.bin
wget https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -O yt-dlp
chmod +x yt-dlp
```

And in case you want to keep using the `youtube-dl` command with `yt-dlp`
```sh
ln -s ~/.bin/yt-dlp ~/.bin/youtube-dl
```

Create defaults:
```sh
mkdir -p ~/.config/yt-dlp/
nano ~/.config/yt-dlp/config
```

Config `~/.config/yt-dlp/config`
```sh
-f 'bestvideo[ext=mp4][vcodec*=avc1.640]+bestaudio[ext=m4a]/best[ext=mp4]/best'
--restrict-filenames
--continue
```

Download trough proxy like `socks5://user:pass@127.0.0.1:1080/`
```sh
youtube-dl \
-f "136+140" \
--proxy socks5://127.0.0.1:1080/ \
'https://www.youtube.com/watch?v=GZlGdRI78Sk'
```

Tunnel
```sh
ssh -D 1080 -q -C -N user@domain.com
```