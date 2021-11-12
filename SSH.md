# Klucze ssh github

### Utwórz klucz ssh
Save to ~/.ssh/username
```sh
ssh-keygen -t ed25519 -C "email@example.com" -f ~/.ssh/username
```

### Konfiguracja wielu kluczy ssh do github
nano ~/.ssh/config
```sh
Host username-github.com
    HostName github.com
    IdentityFile ~/.ssh/username
    IdentitiesOnly yes
    # PreferredAuthentications publickey    
    # AddressFamily inet
    # User git  
    # Port 22
    
# Ssh, github.com, others
Host *
    IdentityFile ~/.ssh/key-ecdsa
    IdentitiesOnly yes
    # PreferredAuthentications publickey
    # AddressFamily inet
    # Protocol 2
    # Compression yes
```
