# Misc Apps on Shared Hosting

I use [DreamHost](http://www.dreamhost.com/r.cgi?279254) for my main blog RodrigoPolo.com, and sometimes I need to work with multimedia files, upload or download a YouTube video, but working on a shared hosting account is limited, you don’t have “Super User” access for obvious reasons, so I precompiled some tools that can work in this environment (GNU/Linux X x64), here is how to install them and use them.



## Setup an app and a bin folder
```bash
cd
mkdir apps
mkdir bin
```

Add the bin path to the $PATH

Edit `~/.bash_profile`
```bash
nano ~/.bash_profile
```

Add the following text
```bash
# For local bin
export PATH=$PATH:~/bin
```

## PhantomJS Install

Download
```bash
wget https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-1.9.8-linux-x86_64.tar.bz2
```

Uncompress
```bash
tar xjf phantomjs-1.9.8-linux-x86_64.tar.bz2
```

Move to the apps folder and delete downloaded and uncompressed files
```bash
mv phantomjs-1.9.8-linux-x86_64/bin/phantomjs ~/apps/phantomjs
rm -rf phantomjs-1.9.8-linux-x86_64
rm phantomjs-1.9.8-linux-x86_64.tar.bz2
```

Create a symbolic link to the bin folder
```bash
ln -s ~/apps/phantomjs ~/bin/phantomjs
```



## YouTube Downloader Install

Download the binary into the apps folder
```bash
wget https://yt-dl.org/downloads/2015.01.25/youtube-dl
```

Set permissions
```bash
chmod +x youtube-dl
```

Create a symbolic link to the bin folder
```bash
ln -s ~/apps/youtube-dl ~/bin/youtube-dl
```



## YouTube Uploader Install

Follow this script line by line on the terminal to install the required script and libraries
```bash
mkdir pyu
cd pyu
curl -O -J https://google-api-python-client.googlecode.com/files/google-api-python-client-1.2.tar.gz
tar xzvf google-api-python-client-1.2.tar.gz && rm google-api-python-client-1.2.tar.gz
cd google-api-python-client-1.2/ && mv apiclient/ oauth2client/ uritemplate/ .. && cd ..
curl -O -J https://pypi.python.org/packages/ff/a9/5751cdf17a70ea89f6dde23ceb1705bfb638fd8cee00f845308bf8d26397/httplib2-0.9.2.tar.gz
tar xzvf httplib2-0.9.2.tar.gz && rm httplib2-0.9.2.tar.gz
mv httplib2-0.9.2/python2/httplib2 httplib2 && rm -rf httplib2-0.9.2
curl -O -J https://raw.githubusercontent.com/rodrigopolo/cheatsheets/master/upload_video.py
```

Create a project in the [Google Cloud Console](https://cloud.google.com/console/project) using the YouTube credential
* Enable YouTube Data API v3 in APIs & auth->API.
* In Credentials, click on CREATE NEW CLIENT ID, select Installed application for Application Type, and Other for Installed application type, and click Create Client ID.

Create a `client_secrets.json` within the `pyu` folder containging the following, replace `client_id` and `client_secret` with the ones from Google Cloud Console:
```
{
	"installed": {
		"client_id": "xxxxxxxxxx-yyyyyyyyyyyyyyy.apps.googleusercontent.com",
		"client_secret": "ABCDXXxxxxxxxxx-CddddddddD",
		"redirect_uris": ["http://locahost", "urn:ietf:wg:oauth:2.0:oob"],
		"auth_uri": "https://accounts.google.com/o/oauth2/auth",
		"token_uri": "https://accounts.google.com/o/oauth2/token"
	}
}
```

Create a bash script `~/apps/pyu/pyu` for global access and paste this:
```bash
#!/usr/bin/env bash
python ~/apps/pyu/upload_video.py $@
```

Set permissions and create a symbolic link to the bin folder
```bash
chmod +x ~/apps/pyu/pyu
ln -s ~/apps/pyu/pyu ~/bin/pyu
```

Then upload your video, it will give you a link the first time, this links is for authentication, follow the instructions on the terminal output.

```bash
pyu \
--file="01-TestHD1080.mp4" \
--title="Test" \
--description="Test" \
--keywords="test" \
--category=22 \
--privacyStatus="private" \
--noauth_local_webserver
```

> After the first upload it will create a `pyu-oauth2.json` with your keys, you can delete this file to create new keys for other user.

IDs for categories:
```
1       Film & Animation
2       Autos & Vehicles
10      Music
15      Pets & Animals
17      Sports
19      Travel & Events
20      Gaming
22      People & Blogs
23      Comedy
24      Entertainment
25      News & Politics
26      Howto & Style
27      Education
28      Science & Technology
29      Nonprofits & Activism
```


## MP4Box Install

Download and uncompress
```bash
wget http://tools.rodrigopolo.com/bin/gnulnx/gpac.tar.gz
tar xzf gpac.tar.gz
rm gpac.tar.gz
```

Create a symbolic link to the bin folder
```bash
ln -s ~/apps/gpac/MP4Box ~/bin/mp4box
```

Add library path for gpac
```bash
nano ~/.bash_profile
```

Add this line
```
# For MP4Box
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:~/apps/gpac/
```



## MediaInfo Install
```bash
wget http://tools.rodrigopolo.com/bin/gnulnx/mediainfo.tar.gz
tar xzf mediainfo.tar.gz
rm mediainfo.tar.gz
ln -s ~/apps/mediainfo ~/bin/mediainfo
```

# Media info short template

Create the MediaInfo template file `~/apps/mediainfoshot.txt`
```bash
nano ~/apps/mediainfoshot.txt
```

Paste the following
```
General;Name...............: %FileName%.%FileExtension%\r\nSize...............: %FileSize/String%\r\nDuration...........: %Duration/String3%\r\n
Video;Resolution.........: %Width%x%Height%\r\nCodec..............: %Codec/String% %Format_Profile%\r\nChroma subsampling.: %ChromaSubsampling%\r\nBit depth..........: %BitDepth%\r\nBitrate............: %BitRate/String%\r\nFramerate..........: %FrameRate% fps\r\nAspect Ratio.......: %DisplayAspectRatio/String%\r\n
Audio;Audio..............: %Language/String% %BitRate/String% %BitRate_Mode% %Channel(s)% chnls %Codec/String%\r\n
Text; $if(%Language%,%Language/String%,Unknown)
Text_Begin;Subs...............:
Text_Middle;,
Text_End;.\r\n

```

Create a `~/bin/minfo` file and enter the following script
```bash
#!/usr/bin/env bash
if [ -z "$1" ]; then
        echo
        echo  ERROR!
        echo  No input file specified.
        echo
else
        mediainfo "--Inform=file://${HOME}/apps/mediainfoshot.txt" "$@"
fi
```

Set permissions
```bash
chmod +x ~/bin/minfo
```


## YouTube Downloader Commands:

view available formats getting each id:
```bash
youtube-dl http://youtu.be/<video_id> -F
```

Download an specific format
```bash
youtube-dl http://youtu.be/<video_id> -f <id>
```


## MP4Box Commands

Extract a portion of the video, example from `60` seconds to `60` seconds.
```bash
mp4box \
-splitx 60:60 \
input.m4v
```

Join audio/video
```bash
mp4box \
-keep-sys \
-add "input_video.mp4#1:fps=29.970" \
-add "input_audio.m4a#1" \
-new "output.m4v"
```

## 360 and Stereo video metadata

Clone the `spatial-media` repo on the app folder
```bash
git clone https://github.com/google/spatial-media.git --depth 1
```

Create the `~/bin/spatialmedia` and enter the following
```bash
#!/usr/bin/env bash
python ~/apps/spatial-media/spatialmedia $@
```
Set the file permissions:
```bash
chmod +x ~/bin/spatialmedia
```


## Links
* [YouTube Downloader](http://rg3.github.io/youtube-dl/) 
* [Compiling GPAC on Debian and Ubuntu](http://gpac.wp.mines-telecom.fr/2011/04/20/compiling-gpac-on-ubuntu/) 
* [Upload videos from command line](http://www.cnx-software.com/2014/02/09/how-to-upload-youtube-videos-with-the-command-line-in-linux/#ixzz46SJ9QFX3)


## Notes

For non-login shells
```bash
~/.bashrc 
```

For login shells
```bash
~/.bash_profile
```

### An example
```bash
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

## Node.js

Install Node.js
```bash
cd
cd apps
wget https://nodejs.org/dist/v10.13.0/node-v10.13.0-linux-x64.tar.xz
tar xf node-v10.13.0-linux-x64.tar.xz
rm node-v10.13.0-linux-x64.tar.xz 
mv node-v10.13.0-linux-x64 node
ln -s ~/apps/node/bin/node ~/bin/node
ln -s ~/apps/node/lib/node_modules/npm/bin/npm-cli.js ~/bin/npm
ln -s ~/apps/node/lib/node_modules/npm/bin/npx-cli.js ~/bin/npx
```

Check Node.js version
```bash
node --version
npm --version
```

Uninstall Node.js
```bash
rm ~/bin/node
rm ~/bin/npm
rm ~/bin/npx
rm -rf ~/apps/node/
```

Bins and apps
```sh
mkdir .bin
mkdir .apps
ln -s /Applications/MAMP/Library/bin/mysql ~/.bin/mysql
ln -s /Applications/MAMP/Library/bin/mysqldump ~/.bin/mysqldump
ln -s /Applications/MAMP/bin/php/php7.3.24/bin/php ~/.bin/php
ln -s ~/.apps/rar/rar ~/.bin/rar
ln -s ~/.apps/rar/unrar ~/.bin/unrar
```
