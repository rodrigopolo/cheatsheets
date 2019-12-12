### SSH Transfers

Send a file
```bash
scp -P <OPTIONAL_PORT> <file_to_upload> <username>@<hostname>:<destination_path>
```

Download a file
```bash
scp -r <username>@<hostname>:<path_to_download> <path_to_save>
```

> use pscp.exe on Windows

And Tunnel:
```bash
 ssh -D 8080 -q -C -N user@domain.com
```
