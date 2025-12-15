local lfs = require "lfs"
local system = require "system"
local tools = require "tools"
local config = require "neld.config"

version = "13.1.0"
sources = {
    { "source", config.gnu_site .. "/gcc/gcc-" .. version .. "/gcc-" .. version .. ".tar.xz" }
}
dependencies = { pkg "isl", pkg "mpc", pkg "mpfr" }
if not hostfs then
    table.insert(dependencies, pkg "gmp")
end

-- TODO: figure out how to remove duplicate files
function build()
    lfs.chdir("source")

    local install_dir = lfs.currentdir() .. "/_install"

    lfs.mkdir("build")
    lfs.chdir("build")

    os.execute(tools.get_flags() ..
        " ../libstdc++-v3/configure --prefix=/usr --libdir=/lib --disable-multilib --disable-nls")

    os.execute("CPATH=/include:/usr/include make" .. system.get_make_jobs())
    os.execute('make install DESTDIR="' .. install_dir .. '"')

    os.execute(tools.get_flags() ..
        " ../configure --prefix=/usr --libdir=/lib --with-system-zlib --disable-multilib --disable-nls --enable-default-pie --enable-default-ssp --enable-host-pie --enable-languages=c,c++" ..
        (hostfs and " --disable-bootstrap" or ""))

    os.execute("CPATH=/include:/usr/include make all-target-libgcc" .. system.get_make_jobs())
    os.execute('make install-target-libgcc DESTDIR="' .. install_dir .. '"')

    os.execute("CPATH=/include:/usr/include make all-gcc " .. system.get_make_jobs())
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

            -- https://git.yoctoproject.org/poky/commit/?id=483143a38ec0ac7b12b9cdf3cd5ce79d8f20cb2f
            os.execute("find filesystem-libs -type f -exec sed -i 's/# *include_next/#include/g' {} +")
        end
    }
}
