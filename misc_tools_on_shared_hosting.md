# Misc Apps on Shared Hosting

I use [DreamHost](http://www.dreamhost.com/r.cgi?279254) for my main blog RodrigoPolo.com, and sometimes I need to work with multimedia files, upload or download a YouTube video, but working on a shared hosting account is limited, you don’t have “Super User” access for obvious reasons, so I precompiled some tools that can work in this environment (GNU/Linux X x64), here is how to install them and use them.



## Setup an app and a bin folder
```
cd
mkdir apps
mkdir bin
```

Add the bin path to the $PATH

Edit `~/.bash_profile`
```
nano ~/.bash_profile
```

Add the following text
```
# For local bin
export PATH=$PATH:/home/<user_folder>/bin
```

## PhantomJS Install

Download
```
wget https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-1.9.8-linux-x86_64.tar.bz2
```

Uncompress
```
tar xjf phantomjs-1.9.8-linux-x86_64.tar.bz2
```

Move to the apps folder and delete downloaded and uncompressed files
```
mv phantomjs-1.9.8-linux-x86_64/bin/phantomjs ~/apps/phantomjs
rm -rf phantomjs-1.9.8-linux-x86_64
rm phantomjs-1.9.8-linux-x86_64.tar.bz2
```

Create a symbolic link to the bin folder
```
ln -s /home/<user_folder>/apps/phantomjs /home/<user_folder>/bin/phantomjs
```



## YouTube Downloader Install

Download the binary into the apps folder
```
wget https://yt-dl.org/downloads/2015.01.25/youtube-dl
```

Set permissions
```
chmod +x youtube-dl
```

Create a symbolic link to the bin folder
```
ln -s /home/<user_folder>/apps/youtube-dl /home/<user_folder>/bin/youtube-dl
```



## YouTube Uploader Install

Download and uncompress
```
wget http://tools.rodrigopolo.com/bin/gnulnx/youtube-upload-0.7.2.tar.gz
tar xzf youtube-upload-0.7.2.tar.gz
rm youtube-upload-0.7.2.tar.gz
```

Create a symbolic link to the bin folder
```
ln -s /home/<user_folder>/apps/youtube-upload-0.7.2/youtube-upload /home/<user_folder>/bin/youtube-upload
```



## MP4Box Install

Download and uncompress
```
wget http://tools.rodrigopolo.com/bin/gnulnx/gpac.tar.gz
tar xzf gpac.tar.gz
rm gpac.tar.gz
```

Create a symbolic link to the bin folder
```
ln -s /home/<user_folder>/apps/gpac/MP4Box /home/<user_folder>/bin/mp4box
```

Add library path for gpac
```
nano ~/.bash_profile
```

Add this line
```
# For MP4Box
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/<user_folder>/apps/gpac/
```



# MediaInfo Install
```
wget http://tools.rodrigopolo.com/bin/gnulnx/mediainfo.tar.gz
tar xzf mediainfo.tar.gz
rm mediainfo.tar.gz
ln -s /home/<user_folder>/apps/mediainfo /home/<user_folder>/bin/mediainfo
```


## YouTube Downloader Commands:

view available formats getting each id:
```
youtube-dl http://youtu.be/<video_id> -F
```

Download an specific format
```
youtube-dl http://youtu.be/<video_id> -f <id>
```



## YouTube Uploader Commands

Upload a video:
```
youtube-upload \
--email=your.youtube.id@gmail.com \
--title="Video Title" \
--description="Video description" \
--category=People \
--keywords="some keywords" \
input_video.m4v
```



## MP4Box Commands

Extract a portion of the video, example from `60` seconds to `60` seconds.
```
mp4box \
-splitx 60:60 \
input.m4v
```

Join audio/video
```
mp4box \
-keep-sys \
-add "input_video.mp4#1:fps=29.970" \
-add "input_audio.m4a#1" \
-new "output.m4v"
```



## Links
* [YouTube Downloader](http://rg3.github.io/youtube-dl/) 
* [Compiling GPAC on Debian and Ubuntu](http://gpac.wp.mines-telecom.fr/2011/04/20/compiling-gpac-on-ubuntu/) 



## Notes

For non-login shells
```
~/.bashrc 
```

For login shells
```
~/.bash_profile
```

### An example
```
# View available formats from the video
youtube-dl http://youtu.be/yBX-KpMoxYk -F

# Download audio
youtube-dl http://youtu.be/yBX-KpMoxYk -f 141

# Download video
youtube-dl http://youtu.be/yBX-KpMoxYk -f 137

# Join together audio and video
mp4box \
-keep-sys \
-add "Apple Special Event. September 10, 2013.-yBX-KpMoxYk.mp4#1:fps=29.970" \
-add "Apple Special Event. September 10, 2013.-yBX-KpMoxYk.m4a#1" \
-new "new.m4v"

# Split specific time
mp4box \
-splitx 2758:2880 \
new.m4v

```


