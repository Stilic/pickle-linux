local lfs = require "lfs"
local system = require "system"
local tools = require "tools"
local config = require "neld.config"

local self = {}

self.version = "14.2.0"
-- self.dependencies = { pkg "user.gmp", pkg "user.mpfr", pkg "user.mpc" }
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
        " ../configure --prefix=/usr --libdir=/lib --with-native-system-header-dir=/include --with-system-zlib --disable-multilib --disable-nls --enable-default-pie --enable-default-ssp --enable-host-pie --enable-languages=c,c++")
    os.execute("CPATH=/usr/include make" .. system.get_make_jobs())

    os.execute('make install-strip DESTDIR="' .. install_dir .. '"')
end

function self.pack()
    tools.pack_default("source/_install/usr")()
    os.execute("rm -r filesystem/include")
    lfs.link("gcc", "filesystem/bin/cc", true)
end

self.variants = {
    libs = {
        pack = function()
            os.execute("cp -ra source/_install/lib source/_install/usr/include filesystem-libs")
            os.execute("cp -ra source/_install/lib64/* filesystem-libs/lib")
        end
    }
}

return self
