local lfs = require "lfs"
local tools = require "tools"


version = "20250116"
sources = {
    { "source", "https://github.com/onetrueawk/awk/archive/refs/tags/" .. version .. ".tar.gz" }
}

function build()
    lfs.chdir("source")
    tools.make("YACC='yacc -d -b awkgram'")
end

function pack()
    lfs.mkdir("filesystem/bin")
    os.execute("cp source/a.out filesystem/bin/awk")
end

