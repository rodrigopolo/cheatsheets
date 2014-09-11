### SSH Transfers

Send a file
```
scp -P <OPTIONAL_PORT> <file_to_upload> <username>@<hostname>:<destination_path>
```

Download a file
```
scp -r <username>@<hostname>:<path_to_download> <path_to_save>
```

> use pscp.exe on Windows
