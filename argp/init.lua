local lfs = require "lfs"
local tools = require "tools"

version = "1.5.0"
sources = {
    { "source", "https://github.com/argp-standalone/argp-standalone/archive/refs/tags/" .. version .. ".tar.gz" }
}

build = tools.build_autotools()

function pack()
    lfs.mkdir("filesystem/include")
    os.execute("cp source/argp.h filesystem/include/argp.h")

    lfs.mkdir("filesystem/lib")
    os.execute("cp source/libargp.a filesystem/lib/libargp.a")
end
