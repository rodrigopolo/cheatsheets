# Multimedia Cheatsheet

## Video crop factors

### Common Digital Video Formats

Format | Dimensions | Aspect Ratio
|----- |:----------:| -----------:|
|HD    |   1280x720 |         16:9|
|FHD   |  1920x1080 |         16:9|
|4K-UHD|  3840x2160 |         16:9|
|4K-DCI|  4096x2160 |      256:135|
|5K    |  5120x2880 |         16:9|
|6K    |  6144x3456 |         16:9|
|8K    |  7680x4320 |         16:9|

### Cinemascope (2.35:1)

Format  | 2.35:1 (47:20) | Letterbox |   FFmpeg Crop
| ----- |---------------:|----------:|---------------:|
|HD     |       1280x544 |        88 |   1280:544:0:88|
|FHD    |       1920x816 |       132 |  1920:816:0:132|
|4K-UHD |      3840x1632 |       264 | 3840:1632:0:264|
|4K-DCI |      4096x1744 |       208 | 4096:1744:0:208|
|5K     |      5120x2176 |       352 | 5120:2176:0:352|
|6K     |      6144x2608 |       424 | 6144:2608:0:424|
|8K     |      7680x3264 |       528 | 7680:3264:0:528|

### Cinemascope (2.40:1)

Format  | 2.40:1 (12:5) | Letterbox |   FFmpeg Crop
| ----- |--------------:|----------:|---------------:|
|HD     |      1280x528 |        96 |   1280:528:0:96|
|FHD    |      1920x800 |       140 |  1920:800:0:140|
|4K-UHD |     3840x1600 |       280 | 3840:1600:0:280|
|4K-DCI |     4096x1712 |       224 | 4096:1712:0:224|
|5K     |     5120x2128 |       376 | 5120:2128:0:376|
|6K     |     6144x2560 |       448 | 6144:2560:0:448|
|8K     |     7680x3200 |       560 | 7680:3200:0:560|

### Ultra Panavision 70 (2.76:1)

Format  | 2.76:1/69:25 | Letterbox |  FFmpeg Crop
| ----- |-------------:|----------:|---------------:|
|HD     |     1280x464 |       128 |  1280:464:0:128|
|FHD    |     1920x688 |       196 |  1920:688:0:196|
|4K-UHD |    3840x1382 |       384 | 3840:1382:0:384|
|4K-DCI |    4096x1488 |       336 | 4096:1488:0:336|
|5K     |    5120x1856 |       512 | 5120:1856:0:512|
|6K     |    6144x2224 |       616 | 6144:2224:0:616|
|8K     |    7680x2784 |       768 | 7680:2784:0:768|

### 4K-DCI

Format  | 4K-DCI (256:135) | 2.35:1 Letterbox |   FFmpeg Crop
| ----- | ----------------:|-----------------:|---------------:|
|HD     |         1280x672 |               24 |   1280:672:0:24|
|FHD    |        1920x1008 |               36 |  1920:1008:0:36|
|4K-UHD |        3840x2032 |               64 |  3840:2032:0:64|
|4K-DCI |        4096x2160 |                0 |   4096:2160:0:0|
|5K     |        5120x2704 |               88 |  5120:2704:0:88|
|6K     |        6144x3248 |              104 | 6144:3248:0:104|
|8K     |        7680x4048 |              136 | 7680:4048:0:136|

## Slow motion percentage
From    |  to  | Perc.
|------:|-----:|------:|
|  59.94|    24|   40% |
| 119.88|    24|   20% |
| 239.76|    24|   10% |
|  59.94| 29.97|   50% |
| 119.88| 29.97|   25% |
| 239.76| 29.97| 12.5% |
|  59.94|    60|  100% |
| 119.88|    60|   50% |
| 239.76|    60|   25% |

## Sony Codecs
|   Sony Format   | Resolution |    Codec   |    CM    |
|:---------------:|:----------:|:----------:|:--------:|
| XAVC HS 4K      |  3840x2160 | HEVC/H.265 | Long GOP |
| XAVC S 4K       |  3840x2160 | AVC/H.264  | Long GOP |
| XAVC S HD       |  1920x1080 | AVC/H.264  | Long GOP |
| XAVC S-I 4K     |  3840x2160 | AVC/H.264  | Intra    |
| XAVC S-I HD     |  1920x1080 | AVC/H.264  | Intra    |
| XAVC S-I DCI 4K |  4096x2160 | AVC/H.264  | Intra    |

## Custom LUTs on Sony FX30

1. Load the LUTs into the card
2. Go to the pink `Exposure and Color` menu
3. Select menu `5`, `Color/Tone`.
4. Select the `Manage User LUTs` menu.
5. Select `Import/Edit`.
6. Select a slut to import the LUT, and then, the media where your LUT is located.
7. On `Main>Main1`, select the LUT, and turn the `LUT ON`.

To enable the LUT on recording:
1. Select the red `Shooring` menu.
2. Select `1`, `Image Quality/Rec`.
3. Select `Log Shooting Setting`.
4. Select `S-Gamut3.Cine/S-Log3` in `Color Gamut`.
5. Set `Embed LUT File` to `ON`.

On the CF Express Card
```
CF root
└── SONY
    └── PRO
        └── LUT
```

On the SD-Card
```
SD root
└── private
    └── SONY
        └── PRO
            └── LUT
```

## EOS R5 ProRes RAW and CinemaDNG 5K (5120 x 2696)

|     ProRes RAW     |    Mbps   |   MB/s   | GB x Min |
|-------------------:|----------:|---------:|---------:|
|             23.976 |    967.03 |   120.88 |     7.25 |
|                 24 |       968 |      121 |     7.26 |
|                 25 |  1,008.33 |   126.04 |     7.56 |
|              29.97 |  1,208.79 |    151.1 |     9.07 |
|                 30 |  1,210.00 |   151.25 |     9.08 |
|                 60 |  2,420.00 |    302.5 |    18.15 |

| DNG No Compression | Mbps      | MB/s     | GB x Min |
|-------------------:|----------:|---------:|---------:|
|             23.976 |  5,295.43 |   661.93 |    39.72 |
|                 24 |  5,300.72 |   662.59 |    39.76 |
|                 25 |  5,521.59 |    690.2 |    41.41 |
|              29.97 |  6,619.28 |   827.41 |    49.64 |
|                 30 |  6,625.90 |   828.24 |    49.69 |
|                 60 | 13,251.80 | 1,656.48 |    99.39 |

| DNG Lossless       | Mbps      | MB/s     | GB x Min |
|-------------------:|----------:|---------:|---------:|
|             23.976 |  2,844.44 |   355.55 |    21.33 |
|                 24 |  2,847.28 |   355.91 |    21.35 |
|                 25 |  2,965.92 |   370.74 |    22.24 |
|              29.97 |  3,555.55 |   444.44 |    26.67 |
|                 30 |  3,559.10 |   444.89 |    26.69 |
|                 60 |  7,118.20 |   889.78 |    53.39 |

| DNG 3:1            | Mbps      | MB/s     | GB x Min |
|-------------------:|----------:|---------:|---------:|
|             23.976 |  1,237.23 |   154.65 |     9.28 |
|                 24 |  1,238.47 |   154.81 |     9.29 |
|                 25 |  1,290.07 |   161.26 |     9.68 |
|              29.97 |  1,546.54 |   193.32 |     11.6 |
|                 30 |  1,548.09 |   193.51 |    11.61 |
|                 60 |  3,096.17 |   387.02 |    23.22 |

| DNG 5:1            | Mbps      | MB/s     | GB x Min |
|-------------------:|----------:|---------:|---------:|
|             23.976 |     474.7 |    59.34 |     3.56 |
|                 24 |    475.18 |     59.4 |     3.56 |
|                 25 |    494.98 |    61.87 |     3.71 |
|              29.97 |    593.38 |    74.17 |     4.45 |
|                 30 |    593.97 |    74.25 |     4.45 |
|                 60 |  1,187.95 |   148.49 |     8.91 |

| DNG 7:1            | Mbps      | MB/s     | GB x Min |
|-------------------:|----------:|---------:|---------:|
|             23.976 |    282.21 |    35.28 |     2.12 |
|                 24 |    282.49 |    35.31 |     2.12 |
|                 25 |    294.26 |    36.78 |     2.21 |
|              29.97 |    352.76 |    44.09 |     2.65 |
|                 30 |    353.11 |    44.14 |     2.65 |
|                 60 |    706.22 |    88.28 |      5.3 |

## HDR Video Characteristics

Based on the [QuickTime File Format and ProRes Video Parameter Editing](https://github.com/bbc/qtff-parameter-editor).

The colour primaries can be selected from the list:

| No.  | Colour Primaries  |
| -----| --------------    |
|0     | Reserved          |
|1     | ITU-R BT.709      |
|2     | Unspecified       |
|3     | Reserved          |
|4     | ITU-R BT.470M     |
|5     | ITU-R BT.470BG    |
|6     | SMPTE 170M        |
|7     | SMPTE 240M        |
|8     | FILM              |
|9     | ITU-R BT.2020     |
|10    | SMPTE ST 428-1    |
|11    | DCI P3            |
|12    | P3 D65            |

The transfer function can be selected from the list:

| No.  | Transfer Function                   |
| -----| ---------------------------------   |
|0     | Reserved                            |
|1     | ITU-R BT.709                        |
|2     | Unspecified                         |
|3     | Reserved                            |
|4     | Gamma 2.2 curve                     |
|5     | Gamma 2.8 curve                     |
|6     | SMPTE 170M                          |
|7     | SMPTE 240M                          |
|8     | Linear                              |
|9     | Log                                 |
|10    | Log Sqrt                            |
|11    | IEC 61966-2-4                       |
|12    | ITU-R BT.1361 Extended Colour Gamut |
|13    | IEC 61966-2-1                       |
|14    | ITU-R BT.2020 10 bit                |
|15    | ITU-R BT.2020 12 bit                |
|16    | SMPTE ST 2084 (PQ)                  |
|17    | SMPTE ST 428-1                      |
|18    | ARIB STD-B67 (HLG)                  |

The colour matrix can be selected from the list:

| No.  | Colour Matrix                  |
| -----| ---------------------------    |
|0     |GBR                             |
|1     |BT709                           |
|2     |Unspecified                     |
|3     |Reserved                        |
|4     |FCC                             |
|5     |BT470BG                         |
|6     |SMPTE 170M                      |
|7     |SMPTE 240M                      |
|8     |YCOCG                           |
|9     |BT2020 Non-constant Luminance   |
|10    |BT2020 Constant Luminance       |