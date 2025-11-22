local lfs = require "lfs"
local system = require "system"
local tools = require "tools"

version = "4.2.0"
dependencies = { pkg "ninja" }
sources = {
    { "source", "https://github.com/Kitware/CMake/releases/download/v" .. version .. "/cmake-" .. version .. ".tar.gz" }
}

function build()
    lfs.chdir("source")

    local bootstrap_cmd = "./bootstrap --prefix=/usr --mandir=/share/man --datadir=/share/" ..
        name .. " --docdir=/share/doc/" .. name
    if system.build_cores ~= 1 then
        bootstrap_cmd = bootstrap_cmd .. " --parallel=" .. system.build_cores
    end
    os.execute(bootstrap_cmd)

    os.execute("make" .. system.get_make_jobs())

    lfs.mkdir("_install")
    os.execute('make install DESTDIR="' .. lfs.currentdir() .. '/_install"')
end

pack = tools.pack_default()
