Join identical video streams:
```bash
mp4box \
-add p1.mp4 \
-cat p2.mp4 \
-cat p3.mp4 \
-cat p4.mp4 \
-cat p5.mp4 \
-cat p6.mp4 \
output.mp4
```

Info
```bash
mp4box -info input.mp4
```


Extract SRT
```bash
mp4box -srt 3 input.mp4
```
