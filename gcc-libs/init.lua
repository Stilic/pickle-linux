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

    local flags = " --prefix= --with-gxx-include-dir=/include/c++ --disable-multilib --disable-nls --host=" ..
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
    end
    os.execute('make install-target-libgcc DESTDIR="' .. install_dir .. '"')
    os.execute('make install-target-libatomic DESTDIR="' .. install_dir .. '"')
    if stage ~= 1 then
        os.execute('make install-target-libstdc++-v3 DESTDIR="' .. install_dir .. '"')
    end
end

function pack()
    tools.pack_default()()

    os.execute("mv filesystem/lib64/* filesystem/lib")
    os.execute("rm -r filesystem/lib64")

    if stage ~= 1 then
        os.execute("mv filesystem/lib/gcc/*/*/include/* filesystem/include")
        os.execute("mv filesystem/lib/gcc/*/*/* filesystem/lib")
        os.execute("rm -r filesystem/lib/gcc")
    end

    os.execute("rm -r filesystem/share")

    os.execute("find filesystem -type f -exec sed -i 's/#include_next/#include/g' {} +")
end
