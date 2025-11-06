local lfs = require "lfs"


version = "7.7"
sources = {
    { "source", "https://github.com/ibara/oksh/releases/download/oksh-" .. version .. "/oksh-" .. version .. ".tar.gz" }
}

function build()
    lfs.chdir("source")
    os.execute("cp ../../pconfig.h .")
    os.execute("gcc -o sh -D_GNU_SOURCE -DEMACS -DVI *.c")
end

function pack()
    lfs.mkdir("filesystem/bin")
    os.execute("cp source/sh filesystem/bin")
end

