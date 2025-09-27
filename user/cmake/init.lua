local lfs = require "lfs"
local system = require "system"
local tools = require "tools"
local gcc = pkg "user.gcc"

local self = {}

self.version = "4.0.1"
self.sources = {
    { "source", "https://github.com/Kitware/CMake/releases/download/v" .. self.version .. "/cmake-" .. self.version .. ".tar.gz" }
}

function self.build()
    lfs.chdir("source")
    local bootstrap_cmd = './bootstrap CFLAGS="' ..
        tools.DEFAULT_CFLAGS ..
        '" --prefix=/usr --mandir=/share/man --datadir=/share/' .. self.name .. ' --docdir=/share/doc/' .. self.name
    if system.build_cores ~= 1 then
        bootstrap_cmd = bootstrap_cmd .. " --parallel=" .. system.build_cores
    end
    os.execute(bootstrap_cmd)
    os.execute("CPLUS_INCLUDE_PATH=/usr/include/c++/" .. gcc.version .. " make" .. system.get_make_jobs())
    lfs.mkdir("_install")
    os.execute('make install DESTDIR="' .. lfs.currentdir() .. '/_install"')
end

self.pack = tools.pack_default()

return self
