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
