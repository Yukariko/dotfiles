function agi
    apt-get install $argv
end

function apt
    sudo apt $argv
end

function akill
    sudo kill -9 (ps -ef | grep "$argv" | awk "{print \$2}")
end

function btm
    set path (which btm)
    $path --color=nord $argv
end

function cat
    bat $argv
end

function l
    lsd -a $argv --icon=never
end

function ls
    lsd $argv --icon=never
end

function ps
    /bin/ps -ef $argv
end

function mmv
    find . -maxdepth 1 -name "*$argv[1]" -exec bash -c 'mv "$1" "${1%$2}$3"' _ "{}" $argv[1] $argv[2] \;
end

function ncore
    cat /proc/cpuinfo | grep -c "processor" $argv
end

function gs
    git status $argv
end

function gsw
    git switch $argv
end

function gb
    git branch $argv
end

function gc
    git commit $argv
end

function gp
    git push $argv
end

function gpl
    git pull $argv
end

function ga
    git add $argv
end

function gap
    git add -p $argv
end

function gd
    git diff $argv
end

function gl
    git log $argv
end

function gcl
    git clone $argv
end

function gg
    git log --decorate --graph --all --oneline
end

