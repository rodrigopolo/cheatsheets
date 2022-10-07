Simple use
```bash
mediainfo input.mp4
```

Mediainfo all tags in XML
```bash
mediainfo -f -Lang=raw --ReadByHuman=0 --Output=XML input.mp4 > output.xml
```

Mediainfo using template:
```bash
mediainfo --Inform="file://template_mediainfo.txt" input.mp4
```

template_mediainfo.txt
```
File_Begin;
File_Middle;
File_End;\r\n
General;Name...............: %FileName%.%FileExtension%\r\nSize...............: %FileSize/String% (%FileSize% bytes)\r\nDuration...........: %Duration/String3% (%Duration%ms)\r\n
Video;Frames.............: %FrameCount%\r\nFramerate..........: %FrameRate% fps\r\nResolution.........: %Width%x%Height%\r\nAspect Ratio.......: %DisplayAspectRatio/String%\r\nLevels/Range.......: %colour_range%\r\nChroma subsampling.: %ChromaSubsampling%\r\nColor space........: %ColorSpace%\r\nPrimaries..........: %colour_primaries%\r\nMatrix Coefficients: %matrix_coefficients_Original%%matrix_coefficients%\r\nCodec..............: %InternetMediaType% %Format% %Format_Profile%\r\nBitrate............: %BitRate/String% (%BitRate% b/s) \r\nBit depth..........: %BitDepth%\r\n
Audio;Audio..............: %Channel(s)% chnls %Format% %BitRate/String% %BitRate_Mode% %SamplingRate%Hz %Language/String%\r\n
Text; $if(%Language%,%Language/String%,Unknown)
Text_Begin;Subs...............:
Text_Middle;,
Text_End;.\r\n
```

Example result:
```
Name...............: VIDEO.MP4
Size...............: 12.6 GiB (13481173961 bytes)
Duration...........: 01:14:10.667 (4450667ms)
Frames.............: 106814
Framerate..........: 24.000 fps
Resolution.........: 4096x2160
Aspect Ratio.......: 1.896
Levels/Range.......: Limited
Chroma subsampling.: 4:2:0
Color space........: YUV
Primaries..........: BT.709
Matrix Coefficients: BT.709
Codec..............: video/H265 HEVC Main 10@L5@Main
Bitrate............: 23.9 Mb/s (23908438 b/s) 
Bit depth..........: 10
Audio..............: 2 chnls AAC 320 kb/s CBR 48000Hz 
```

Get image resolutions
```bash
mediainfo --Inform="file://tempalte.txt" *.tiff >> res.txt
```

tempalte.txt
```
General;%FileName%.%FileExtension%
Image;	%Width%	%Height%\r\n

```

JSON Template
```
Page;
Page_Begin;
Page_Middle;
Page_End;
;
File;
File_Begin;{\n
File_Middle;,\n
File_End;}\n\n\n
;
General;      "path": "%CompleteName%",\n      "size": %FileSize%,\n      "bitrate": %OverallBitRate%,\n      "duration": %Duration%,\n      "created": "%File_Created_Date%",\n      "modified": "%File_Modified_Date%",\n      "encoded": "%Encoded_Date%",\n      "tagged": "%Tagged_Date%",\n      "menu": $if(%MenuCount%,true,false)\n
General_Begin;     "general": {\n
General_Middle;
General_End;    }\n
;
Video;      {\n          "width": %Width%,\n          "height": %Height%,\n          "codec": "%Format%",\n          "fps": $if(%FrameRate%,%FrameRate%,false),\n          "bitrate": $if(%BitRate%,%BitRate%,false),\n          "profile":$if(%Format_Profile%, "%Format_Profile%", false),\n          "settings":$if(%Format_Settings%, "%Format_Settings%", false),\n          "aspect":$if(%DisplayAspectRatio%, "%DisplayAspectRatio/String%", false)\n      }
Video_Begin;     ,"video": [\n
Video_Middle;,\n
Video_End;\n    ]\n
;
Audio;      {\n          "ch": %Channel(s)%,\n          "ch_pos": "%ChannelPositions%",\n          "sample_rate": "%SamplingRate%",\n          "codec": "%Codec%",\n          "bitrate": $if(%BitRate%,%BitRate%,false),\n          "bitrate_mode": "$if(%BitRate_Mode%,%BitRate_Mode%,false)",\n          "lang": $if(%Language%, "%Language%",false)\n      }
Audio_Begin;     ,"audio": [\n
Audio_Middle;,\n
Audio_End;\n    ]\n
;
Text; "%Language%"
Text_Begin;     ,"Subs": [
Text_Middle;, 
Text_End;]\n
;
```

Short examples
```sh
#To get the duration of video stream:
mediainfo --Inform="Video;%Duration%"  [inputfile]

#To get the duration of the media file:
mediainfo --Inform="General;%Duration%" [inputfile]

#To get the duration of audio stream only:
mediainfo --Inform="Audio;%Duration%" [inputfile]

#To get values of more than one parameter:
#1280,720,3000000,30.0

mediainfo --Inform="Video;%Width%,%Height%,%BitRate%,%FrameRate%" [inputfile]
```
