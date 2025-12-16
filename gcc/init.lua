local lfs = require "lfs"
local system = require "system"
local tools = require "tools"
local config = require "neld.config"

version = "13.1.0"
sources = {
    { "source", config.gnu_site .. "/gcc/gcc-" .. version .. "/gcc-" .. version .. ".tar.xz" }
}
dependencies = { pkg "isl", pkg "mpc", pkg "mpfr", pkg "gmp" }

function build()
    lfs.chdir("source")

    local install_dir = lfs.currentdir() .. "/_install"

    lfs.mkdir("build")
    lfs.chdir("build")

    os.execute(tools.get_flags() ..
        " ../configure --prefix=/usr --with-system-zlib --disable-multilib --disable-nls --enable-default-pie --enable-default-ssp --enable-host-pie --enable-languages=c,c++")
    os.execute("make" .. system.get_make_jobs())

    os.execute('make install-strip DESTDIR="' .. install_dir .. '"')
end

function pack()
    tools.pack_default("source/_install/usr")()

    os.execute("rm -r filesystem/include filesystem/lib")

    lfs.link("gcc", "filesystem/bin/cc", true)
    lfs.link("g++", "filesystem/bin/c++", true)
end

variants = {
    libs = {
        pack = function()
            os.execute("cp -ra source/_install/usr/lib source/_install/usr/include filesystem-libs")
            os.execute("cp -ra source/_install/usr/lib64/* filesystem-libs/lib")

            -- https://git.yoctoproject.org/poky/commit/?id=483143a38ec0ac7b12b9cdf3cd5ce79d8f20cb2f
            os.execute("find filesystem-libs -type f -exec sed -i 's/#include_next/#include/g' {} +")
        end
    }
}
