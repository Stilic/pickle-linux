local lfs = require "lfs"
local tools = require "tools"

version = "4.6.1"
sources = {
    { "source", "https://github.com/plougher/squashfs-tools/archive/refs/tags/" .. version .. ".tar.gz" }
}

function build()
    lfs.chdir("source")
    local source_dir = lfs.currentdir()

    lfs.mkdir("_install")
    lfs.chdir("squashfs-tools")

    tools.make("XATTR_SUPPORT=1 LZO_SUPPORT=1")

    os.execute('make install INSTALL_MANPAGES_DIR="' ..
        source_dir .. '/share/man/man1" INSTALL_PREFIX="' .. source_dir .. '/_install"')
end

pack = tools.pack_default()
