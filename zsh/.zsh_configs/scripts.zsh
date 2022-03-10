export DIRS_LARGE=/usr/share/SecLists/Discovery/Web-Content/raft-large-directories.txt
export DIRS_SMALL=/usr/share/SecLists/Discovery/Web-Content/raft-small-directories.txt
export FILES_LARGE=/usr/share/SecLists/Discovery/Web-Content/raft-large-files.txt
export FILES_SMALL=/usr/share/SecLists/Discovery/Web-Content/raft-small-files.txt
export BIG=/usr/share/SecLists/Discovery/Web-Content/big.txt
export ROCKYOU=/usr/share/SecLists/Passwords/Leaked-Databases/rockyou.txt

alias postfiledumphere='docker run --rm -it -p80:3000 -v "${PWD}:/data" rflathers/postfiledump'

function ipinfo(){
    curl ipinfo.io/$1
}

function emailrep(){
    curl emailrep.io/$1
}

function git_hunt(){
    toplevel=$(git rev-parse --show-toplevel)
    {
        find ${toplevel}/.git/objects/pack/ -name "*.idx" |
            while read i; do
                git show-index < "$i" | awk '{print $2}';
            done;
            find ${toplevel}/.git/objects/ -type f |
                grep -v '/pack/' |
                awk -F'/' '{print $(NF-1)$NF}';
    } |
    while read o; do
        git cat-file -p $o;
    done | rg -a $1
}

function deep_scan(){
    mkdir -p $1
    sudo nmap -sS -p- -A -sC -sV -oA $1/$1 $2 -vvvv
}
