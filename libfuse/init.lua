local lfs = require "lfs"
local tools = require "tools"

version = "3.16.2"
dev_dependencies = { pkg "meson", pkg "pkgconf" }
sources = {
    { "source", "https://github.com/libfuse/libfuse/releases/download/fuse-" .. version .. "/fuse-" .. version .. ".tar.gz" }
}

build = tools.build_meson("-Ddisable-mtab=true")

function pack()
    tools.pack_default()()

    os.execute("mv filesystem/include/fuse3/* filesystem/include")
    lfs.rmdir("filesystem/include/fuse3")
end
