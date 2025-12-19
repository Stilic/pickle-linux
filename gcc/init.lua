local lfs = require "lfs"
local system = require "system"
local tools = require "tools"
local config = require "neld.config"

version = "13.1.0"
dependencies = { pkg "mpc", pkg "mpfr", pkg "gmp" }
sources = {
    { "source", config.gnu_site .. "/gcc/gcc-" .. version .. "/gcc-" .. version .. ".tar.xz" }
}

function build()
    lfs.chdir("source")

    local install_dir = lfs.currentdir() .. "/_install"

    lfs.mkdir("build")
    lfs.chdir("build")

    local flags = " --prefix=/usr --libdir=/lib --disable-multilib --disable-nls --host=" ..
        system.target .. " --build=" .. system.target

    os.execute(tools.get_flags() .. " ../libstdc++-v3/configure" .. flags)

    os.execute("CPATH=/include/c++:/include make" .. system.get_make_jobs())

    os.execute(tools.get_flags() ..
        " ../configure --enable-default-pie --enable-default-ssp --enable-host-pie --enable-languages=c,c++" ..
        (stage == 2 and " --disable-bootstrap" or "") .. flags)

    os.execute("CPATH=/include/c++:/include make all-gcc " .. system.get_make_jobs())
    os.execute('make install-gcc DESTDIR="' .. install_dir .. '"')
end

function pack()
    tools.pack_default("source/_install/usr")()

    os.execute("rm -r filesystem/include")

    lfs.link("gcc", "filesystem/bin/cc", true)
    lfs.link("g++", "filesystem/bin/c++", true)
end

variants = {
    libs = {
        pack = function()
            os.execute("cp -ra source/_install/lib source/_install/usr/include filesystem-libs")
            os.execute("cp -ra source/_install/lib64/* filesystem-libs/lib")

            os.execute("find filesystem-libs -type f -exec sed -i 's/#include_next/#include/g' {} +")
        end
    }
}
