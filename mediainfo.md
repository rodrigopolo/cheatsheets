Simple use
```
mediainfo input.mp4
```

Mediainfo all tags in XML
```
mediainfo -f -Lang=raw --ReadByHuman=0 --Output=XML input.mp4 > output.xml
```

Mediainfo using template:
```
mediainfo --Inform="file://template_mediainfo.txt" input.mp4
```

template_mediainfo.txt
```
General;Name...............: %FileName%.%FileExtension%\r\nSize...............: %FileSize/String%\r\nDuration...........: %Duration/String3%\r\n
Video;Resolution.........: %Width%x%Height%\r\nCodec..............: %Codec/String% %Format_Profile%\r\nChroma subsampling.: %ChromaSubsampling%\r\nBit depth..........: %BitDepth%\r\nBitrate............: %BitRate/String%\r\nFramerate..........: %FrameRate% fps\r\nAspect Ratio.......: %DisplayAspectRatio/String%\r\n
Audio;Audio..............: %Language/String% %BitRate/String% %BitRate_Mode% %Channel(s)% chnls %Codec/String%\r\n
Text; $if(%Language%,%Language/String%,Unknown)
Text_Begin;Subs...............:
Text_Middle;,
Text_End;.\r\n
```

Example result:
```
Name...............: A003C004_151124_R00H.mov
Size...............: 1.41 GiB
Duration...........: 00:00:15.208
Resolution.........: 3840x2160
Codec..............: ap4h
Chroma subsampling.: 4:4:4
Bit depth..........:
Bitrate............: 790 Mbps
Framerate..........: 24.000 fps
Aspect Ratio.......: 16:9
```

Get image resolutions
```
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


