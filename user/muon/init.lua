local lfs = require "lfs"
local tools = require "tools"

local self = {}

self.version = "0.4.0"
-- TODO: add deps for [wrap-file] support
self.dependencies = { pkg "user.pkgconf" }
self.sources = {
    { "source", "https://muon.build/releases/v" .. self.version .. "/muon-v" .. self.version .. ".tar.gz" }
}

function self.build()
    lfs.chdir("source")

    local flags = tools.get_flags()

    os.execute(flags .. " ./bootstrap.sh build")

    os.execute(flags .. " build/muon-bootstrap setup build")
    os.execute("build/muon-bootstrap -C build samu")
    os.execute('DESTDIR="' .. lfs.currentdir() .. '/_install" build/muon-bootstrap -C build install')
end

function self.pack()
    lfs.mkdir("filesystem/usr")
    os.execute("cp -ra source/_install/usr/local/bin filesystem/usr")
    os.execute("ln -s muon filesystem/usr/bin/meson")
    os.execute("ln -s muon filesystem/usr/bin/ninja")
end

return self
