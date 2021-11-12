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

### Zmiana url repozytorium
```sh
git remote set-url origin git@username-github.com:username/repo-name.git
git remote -v
```

### Zmiana ustawien w repozytorium
nano .git/config
```sh
[core]
        repositoryformatversion = 0
        filemode = true
        bare = false
        logallrefupdates = true
[remote "origin"]
        url = git@username-github.com:username/repo-name.git
        fetch = +refs/heads/*:refs/remotes/origin/*
[branch "main"]
        remote = origin
        merge = refs/heads/main
```

### Klonowanie, pobieranie repo z kluczem
```sh
git clone git@username-github.com:username/repo-name.git
```
