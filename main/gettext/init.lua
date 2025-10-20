local lfs = require "lfs"
local tools = require "tools"

local self = {}

self.version = "0.3.2"
self.sources = {
    { "source", "http://ftp.barfooze.de/pub/sabotage/tarballs/gettext-tiny-" .. self.version .. ".tar.xz" }
}

function self.build()
    tools.make("LIBINTL=MUSL")
    lfs.mkdir("_install")
    os.execute('make install prefix=/ LIBINTL=MUSL DESTDIR="' .. lfs.currentdir() .. '/_install"')
end

self.pack = tools.pack_default()

return self
