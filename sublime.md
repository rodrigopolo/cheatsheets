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

```
\l : first character to lower case
\u : first character to upper case
\L : start of lower case conversion
\U : start of upper case conversion
\E : end lower/upper case conversion
```

> [source](http://philquinn.co.uk/sublime-text-2-convert-regex-backreference-case/)   
> [regext test](http://regex101.com/)