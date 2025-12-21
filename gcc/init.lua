local lfs = require "lfs"
local system = require "system"
local tools = require "tools"
local config = require "neld.config"

version = "14.3.0"
dependencies = { pkg "binutils", pkg "mpc", pkg "mpfr", pkg "gmp" }
if stage > 2 then
    table.insert(dependencies, pkg "isl")
end
sources = {
    { "source", config.gnu_site .. "/gcc/gcc-" .. version .. "/gcc-" .. version .. ".tar.xz" }
}

function build()
    lfs.chdir("source")

    local install_dir = lfs.currentdir() .. "/_install"

    lfs.mkdir("build")
    lfs.chdir("build")

    os.execute(tools.get_flags() ..
        " ../configure --prefix=/usr --libdir=/lib --disable-multilib --disable-werror --disable-nls --enable-default-pie --enable-default-ssp --enable-host-pie --enable-languages=c,c++" ..
        " --host=" .. system.target .. " --build=" .. system.target .. (stage == 2 and " --disable-libsanitizer" or ""))

    -- os.execute("make all-target-libgcc" .. system.get_make_jobs())
    -- os.execute("make all-target-libatomic" .. system.get_make_jobs())
    -- os.execute("make all-target-libstdc++-v3" .. system.get_make_jobs())
    -- os.execute("make all-gcc" .. system.get_make_jobs())

    -- os.execute('make install-target-libgcc DESTDIR="' .. install_dir .. '"')
    -- os.execute('make install-target-libatomic DESTDIR="' .. install_dir .. '"')
    -- os.execute('make install-target-libstdc++-v3 DESTDIR="' .. install_dir .. '"')
    -- os.execute('make install-gcc DESTDIR="' .. install_dir .. '"')

    os.execute("make" .. system.get_make_jobs())
    os.execute('make install DESTDIR="' .. install_dir .. '"')
end

function pack()
    tools.pack_default("source/_install/usr")()

    os.execute("find filesystem/include -type f -exec sed -i 's/#include_next/#include/g' {} +")

    if stage ~= 1 then
        lfs.link("gcc", "filesystem/bin/cc", true)
        lfs.link("g++", "filesystem/bin/c++", true)
    end
end

variants = {
    libs = {
        pack = function()
            os.execute("cp -ra source/_install/lib filesystem-libs")
            os.execute("cp -ra source/_install/lib64/* filesystem-libs/lib")

            os.execute("find filesystem-libs -type f -exec sed -i 's/#include_next/#include/g' {} +")
        end
    }
}
