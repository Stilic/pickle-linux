local lfs = require "lfs"
local tools = require "tools"

local self = {}

self.version = "1.2.76"
self.sources = {
    { "source", "https://git.kernel.org/pub/scm/libs/libcap/libcap.git/snapshot/libcap-" .. self.version .. ".tar.gz" }
}

function self.build()
    lfs.chdir("source")

    tools.make("GOLANG=no")
    os.execute(
        'make install PKGCONFIGDIR=/lib/pkgconfig SBINDIR=/bin LIBDIR=/lib RAISE_SETFCAP=no DESTDIR="' ..
        lfs.currentdir() .. '/_install"')
end

function self.pack()
    tools.pack_default()()

    os.execute("mv filesystem/usr/* filesystem")
    os.execute("rm -r filesystem/usr")
end

return self
