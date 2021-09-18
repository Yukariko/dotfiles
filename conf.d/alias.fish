function agi
    apt-get install $argv
end

function l
    lsd -a $argv
end

function lsl
    lsd -al $argv
end

function ls
    lsd $argv
end

function ps
    /bin/ps -ef $argv
end

function ncore
    cat /proc/cpuinfo | grep -c "processor" $argv
end

function buildcpp
    g++ -o (string split "." -- $argv[1])[1] $argv[1] -std=c++11 -O2 -Wall
end

function mmv
    find . -maxdepth 1 -name "*$argv[1]" -exec bash -c 'mv "$1" "${1%$2}$3"' _ "{}" $argv[1] $argv[2] \;
end

function apt
    sudo apt $argv
end

function akill
    sudo kill -9 (ps -ef | grep "$argv" | awk "{print \$2}")
end

function df
    duf $argv
end

function btm
    /usr/bin/btm --color=nord $argv
end
