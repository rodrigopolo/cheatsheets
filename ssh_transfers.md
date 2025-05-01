### SSH Transfers and sync files

Send a file from local to external
```bash
scp -P <OPTIONAL_PORT> <file_to_upload> <username>@<hostname>:<destination_path>
```

Download a file from external to local
```bash
scp -r <username>@<hostname>:<path_to_download> <path_to_save>
```

> use pscp.exe on Windows

With `rsync` from external to local
```sh
rsync \
-az \
--info=progress2 \
user@host:/path/to/src/ \
/path/to/dest/
```

With `rsync` from local to external
```sh
rsync \
-az \
--info=progress2 \
/path/to/src/ \
user@host:/path/to/dest/
```

To make the destination an exact mirror of the source (deleting files in the destination that don’t exist in the source), add `--delete`
```sh
rsync \
-az \
--info=progress2 \
--delete \
user@host:/path/to/src/ \
/path/to/dest/
```

Create a ssh tunnel
```bash
ssh -D 8080 -q -C -N user@domain.com
```