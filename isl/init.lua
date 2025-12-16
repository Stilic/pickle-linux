local lfs = require "lfs"
local system = require "system"
local tools = require "tools"
local config = require "neld.config"

version = "0.24"
sources = {
    { "source", "https://libisl.sourceforge.io/isl-" .. version .. ".tar.xz" }
}

function build()
    lfs.chdir("source")

    local install_dir = lfs.currentdir() .. "/_install"

    lfs.mkdir("build")
    lfs.chdir("build")

    os.execute(tools.get_flags() ..
        " ../configure --prefix=/usr --libdir=/lib --with-system-zlib --disable-multilib --disable-nls --enable-default-pie --enable-default-ssp --enable-host-pie --enable-languages=c,c++" ..
        (hostfs and " --disable-bootstrap" or ""))

    os.execute("make" .. system.get_make_jobs())
    os.execute('make install DESTDIR="' .. install_dir .. '"')
end

pack = tools.pack_default()
