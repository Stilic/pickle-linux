local lfs = require "lfs"
local system = require "system"
local tools = require "tools"
local config = require "neld.config"

version = "13.1.0"
dependencies = { pkg "binutils", pkg "mpc", pkg "mpfr", pkg "gmp" }
sources = {
    { "source", config.gnu_site .. "/gcc/gcc-" .. version .. "/gcc-" .. version .. ".tar.xz" }
}

function build()
    lfs.chdir("source")

    local install_dir = lfs.currentdir() .. "/_install"

    lfs.mkdir("build")
    lfs.chdir("build")

    local flags =
        " --prefix=/usr --libdir=/lib --with-gxx-include-dir=/include/c++ --disable-multilib --disable-nls --host=" ..
        system.target .. " --build=" .. system.target

    if stage == 1 then
        os.execute(tools.get_flags() .. " ../libstdc++-v3/configure" .. flags)

        os.execute("make" .. system.get_make_jobs())
        os.execute('make install DESTDIR="' .. install_dir .. '"')
    end

    os.execute(tools.get_flags() ..
        " ../configure --disable-bootstrap --enable-default-pie --enable-default-ssp --enable-host-pie --enable-languages=c,c++" ..
        flags)

    os.execute("make all-target-libgcc" .. system.get_make_jobs())
    os.execute("make all-target-libatomic" .. system.get_make_jobs())
    if stage ~= 1 then
        os.execute("make all-target-libstdc++-v3" .. system.get_make_jobs())
        os.execute("make all-gcc" .. system.get_make_jobs())
    end

    os.execute('make install-target-libgcc DESTDIR="' .. install_dir .. '"')
    os.execute('make install-target-libatomic DESTDIR="' .. install_dir .. '"')
    if stage ~= 1 then
        os.execute('make install-target-libstdc++-v3 DESTDIR="' .. install_dir .. '"')
        os.execute('make install-gcc DESTDIR="' .. install_dir .. '"')
    end
end

pack = tools.pack_default("source/_install/usr")

variants = {
    libs = {
        pack = function()
            os.execute("cp -ra source/_install/lib source/_install/include filesystem-libs")
            os.execute("cp -ra source/_install/lib64/* filesystem-libs/lib")

            if stage ~= 1 then
                os.execute("mv filesystem-libs/lib/gcc/*/*/include/* filesystem-libs/include")
                os.execute("mv filesystem-libs/lib/gcc/*/*/* filesystem-libs/lib")
                os.execute("rm -r filesystem-libs/lib/gcc")
            end

            os.execute("find filesystem-libs -type f -exec sed -i 's/#include_next/#include/g' {} +")
        end
    }
}
