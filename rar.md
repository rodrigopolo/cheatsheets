### RAR

Unrar
```
rar x file.rar
```

View with details
```
rar v file.rar
```

View list
```
rar vb file.rar
```

Compress a folder
```
rar a -m5 -R file.rar path/to/folder
```

Compress a folder excluding `.DS_Store` files
```
rar a \
-x*.DS_Store \
-m5 \
-R \
file.rar \
path/to/folder
```

Compress a folder excluding `.DS_Store` files and sliting into volumes of 100MiB
```
rar a \
-x*.DS_Store \
-m5 \
-R \
-v100m \
file.rar \
path/to/folder
```

Install in shared hosting
```
cd
cd apps
wget https://www.rarlab.com/rar/rarosx-5.6.1.tar.gz
tar xzf rarosx-5.6.1.tar.gz
ln -s ~/apps/rar/rar ~/bin/rar
```

> [Download](http://www.rarlab.com/download.htm)