### Sublime Cheat Sheet


##### Find and replace on Sublibe with Regex
Search
```
\$(\w+)\['(\w+)'\]
```

Replace
```
$\1['\L\2']
```

Find all links and replace them with `#`
```
href\="(\S+)"
href="#"
```

Find `(¿[a-z])` and replace with uppercase `\U\1`

Dates on ISO 9075
```
\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}
```

```
\l : first character to lower case
\u : first character to upper case
\L : start of lower case conversion
\U : start of upper case conversion
\E : end lower/upper case conversion
```

> [source](http://philquinn.co.uk/sublime-text-2-convert-regex-backreference-case/)   
> [regext test](http://regex101.com/)

In `Preferences.sublime-settings`
```json
{
  "draw_white_space": "all",
  "ignored_packages":
  [
    "Vintage",
  ],
  "wrap_width": 80,
  "open_files_in_new_window": false,
  "scroll_past_end": true,
  "show_encoding": true,
  "word_wrap": false,
  "rulers": [80],
  "index_files": true,
  "font_size": 12,
}
```