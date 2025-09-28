local lfs = require "lfs"
local system = require "system"
local tools = require "tools"
local config = require "neld.config"

local self = {}

self.version = "14.2.0"
self.dependencies = { pkg "user.gmp", pkg "user.mpfr", pkg "user.mpc" }
self.dev_dependencies = { pkg "user.binutils" }
self.sources = {
    { "source", config.gnu_site .. "/gcc/gcc-" .. self.version .. "/gcc-" .. self.version .. ".tar.xz" }
}

function self.build()
    lfs.chdir("source")

    local install_dir = lfs.currentdir() .. "/_install"

    lfs.mkdir("build")
    lfs.chdir("build")

    os.execute(tools.get_flags() ..
        " ../configure --prefix=/usr --disable-multilib --disable-nls --with-system-zlib --with-native-system-header-dir=/include --enable-default-pie --enable-default-ssp --enable-host-pie --enable-languages=c,c++")
    os.execute("CPATH=/usr/include make" .. system.get_make_jobs())

    os.execute('make install-strip DESTDIR="' .. install_dir .. '"')
end

function self.pack()
    tools.pack_default()()
    os.execute("rm -r filesystem/usr/lib filesystem/usr/lib64")
    lfs.link("gcc", "filesystem/usr/bin/cc", true)
end

self.variants = {
    libs = {
        pack = function()
            lfs.mkdir("filesystem-libs/usr")
            os.execute("cp -ra source/_install/usr/lib filesystem-libs/usr/lib")
            os.execute("cp -ra source/_install/usr/lib64/* filesystem-libs/usr/lib")
        end
    }
}

return self
