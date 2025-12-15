local lfs = require "lfs"
local tools = require "tools"

version = "2.51.2"
dependencies = { pkg "curl" }
sources = {
    { "source", "https://www.kernel.org/pub/software/scm/git/git-" .. version .. ".tar.xz" }
}

function build()
    lfs.chdir("source")

    os.execute("cp ../../config config.mak")
    os.execute("make configure")

    tools.build_gnu_configure(nil, "")()
end

pack = tools.pack_default("source/_install/usr")
