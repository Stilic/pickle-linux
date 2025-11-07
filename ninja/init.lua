local lfs = require "lfs"
local tools = require "tools"

version = "1.13.1"
dependencies = { pkg "python" }
sources = {
    { "source", "https://github.com/ninja-build/ninja/archive/refs/tags/v" .. version .. ".tar.gz" }
}

function build()
    lfs.chdir("source")
    os.execute(tools.get_flags() .. " python configure.py --bootstrap")
end

function pack()
    lfs.mkdir("filesystem/bin")
    os.execute("cp -a source/ninja filesystem/bin")
end
