## HD Video to DVD

Convert video to MPEG

```bash
ffmpeg \
-y \
-hide_banner \
-i /path/to/input.m4v \
-vf "scale=min(iw*480/ih\,854):min(480\,ih*854/iw),pad=854:480:(854-iw)/2:(480-ih)/2" \
-target ntsc-dvd \
-aspect 16:9 \
mpeg_video.mpg
```

Create the DVDAuthor `video.xml` file.
```xml
<dvdauthor dest="/path/to/output/DVD_FOLDER">
	<vmgm />
	<titleset>
		<titles>
			<pgc>
				<vob file="/path/to/mpeg_video.mpg" />
			</pgc>
		</titles>
	</titleset>
</dvdauthor>
```

Create the `VIDEO_TS` folder using DVDAuthor
```bash
dvdauthor -x video.xml 
```

Convert the `VIDEO_TS` folder to a ISO image using DiskUtil
```bash
hdiutil makehybrid -udf -udf-volume-name Label -o ISO_File.iso /path/to/input/DVD_FOLDER
```

Use ImgBurn on Windows
http://www.imgburn.com/

OS X: `brew install dvdauthor`
Windows: http://www.videohelp.com/software/dvdauthor
