local lfs = require "lfs"

version = "6.6"
sources = {
    { "source", "https://github.com/ibara/yacc/releases/download/oyacc-" .. version .. "/oyacc-" .. version .. ".tar.gz" }
}

function build()
    lfs.chdir("source")
    os.execute("cp ../../config.h .")
    os.execute("gcc -o yacc -D_GNU_SOURCE -D__unused= *.c")
end

function pack()
    lfs.mkdir("filesystem/bin")
    os.execute("cp source/yacc filesystem/bin")
end
