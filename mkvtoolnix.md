# MKVToolNix

Info
```sh
mkvinfo file.mkv
```

Info of tracks
```sh
mkvinfo file.mkv | grep -i track
```

Extract SRTs
```sh
mkvextract \
tracks \
file.mkv \
2:file.srt
```

Split files by MiB
```sh
mkvmerge \
--split 20M \
-o output.mkv \
input.mkv
```

Split extracting different parts into one output
```sh
mkvmerge \
--split "parts:00:01:00.000-00:02:00.000,+00:04:00.000-00:05:00.000" \
-o output.mkv \
input.mkv
```


Split extracting different parts into multiple outputs
```sh
mkvmerge \
--split "parts:00:01:00.000-00:02:00.000,00:04:00.000-00:05:00.000" \
-o output.mkv \
input.mkv
```

Chapters XML format
```xml
<?xml version="1.0" encoding="UTF-8"?>
<!-- <!DOCTYPE Chapters SYSTEM "matroskachapters.dtd"> -->
<Chapters>
  <EditionEntry>
    <ChapterAtom><ChapterTimeStart>00:00:00.000</ChapterTimeStart><ChapterDisplay><ChapterString>CH1</ChapterString></ChapterDisplay></ChapterAtom>
    <ChapterAtom><ChapterTimeStart>00:02:30.500</ChapterTimeStart><ChapterDisplay><ChapterString>CH2</ChapterString></ChapterDisplay></ChapterAtom>
    <ChapterAtom><ChapterTimeStart>00:03:45.750</ChapterTimeStart><ChapterDisplay><ChapterString>CH3</ChapterString></ChapterDisplay></ChapterAtom>
  </EditionEntry>
</Chapters>
```
