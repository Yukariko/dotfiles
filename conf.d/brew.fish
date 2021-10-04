switch (uname)
    case Linux
        set prefix (/home/linuxbrew/.linuxbrew/bin/brew shellenv)
        eval "$prefix"
    case Darwin
        set PATH $PATH /opt/homebrew/bin
end
