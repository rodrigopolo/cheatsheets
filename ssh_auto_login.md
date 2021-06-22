# SSH Keys for Passwordless Login

### A) Login into your server

1. Open PuTTY
2. Type the host address
3. Click on the `Open` button
4. Enter your user name
5. Enter your password
6. DON'T CLOSE this window.

### B) Public & Private SSH Keys

1.  Run puttygen.exe
2.  For Type of key to generate, select SSH-2 RSA.
3.  In the Number of bits in a generated key field, specify either 2048 or 4096.
4.  Click the Generate button.
5.  Move your mouse pointer around in the blank area of the Key section,
    below the progress bar (to generate some randomness) until the progress bar
    is full.
6.  In the Key comment field, enter any comment you'd like, to help you identify
    this key pair, later (e.g. your e-mail address; home; office; etc.).
7.  Optional: Type a passphrase in the Key passphrase field & re-type the same
    passphrase in the Confirm passphrase.
8.  Click the Save public key button & choose whatever filename you'd like.
9.  Click the Save private key button & choose whatever filename you'd like.
10. Copy the text field labeled `Public key for pasting into
    OpenSSH authorized_keys file`.

### C) Save The Public Key On The Server

1. On the terminal window that was already open, check if you already have
  a `~/.ssh` folder, if not, create it:

  ```bash
  mkdir ~/.ssh
  ```

2. Check the `~./ssh` folder permissions:

  ```bash
  chmod -R og= ~/.ssh
  ```

3. Paste/append you key to the `authorized_keys` file:

  ```bash
  nano authorized_keys
  ```

4. Paste your key and exit.

### D) Create a PuTTY Profile
1. Open PuTTY
2. Enter your user name in `Connection->Data` field `Auto-login`.
3. Browse and select your private key on `Connection->SSH->Auth`
4. Go to  `Sesssion` and save your session.

## Special notes

### Encoding
Some hosting providers and servers have some issues with the key encoding, you
can upload your key directly to your server using `scp` and append you key to
the `authorized_keys` file:

```bash
scp -P 22 your_key.pub user@host:/path/to/home/.ssh/key.pub
cat key.pub >> authorized_keys
```

### File Names
Some hosting providers have a different name for the `authorized_keys` file,
GatorHosts for instance use the `authorized_keys2` file name.

### Permissions
Always double check file permissions and ownership
```bash
chmod -R og= ~/.ssh
```

[PuTTY Downloads](http://www.chiark.greenend.org.uk/~sgtatham/putty/download.html)  
[Info Source](https://www.digitalocean.com/community/tutorials/how-to-create-ssh-keys-with-putty-to-connect-to-a-vps)


Generate and add key (Big Sur)
```sh
ssh-keygen -t ed25519 -C "your_email@example.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
```

Add key to a remote server, and set the permissions
```sh
nano authorized_keys
chmod 644 authorized_keys
```