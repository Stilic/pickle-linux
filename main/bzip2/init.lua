local lfs = require "lfs"
local system = require "system"
local tools = require "tools"

local self = {}

self.version = "1.0.8"
self.sources = {
    { "source", "https://sourceware.org/pub/bzip2/bzip2-" .. self.version .. ".tar.gz" }
}

function self.build()
    lfs.chdir("source")

    -- fix man path and generate relative paths
    os.execute([[sed -i -e "s:\$(PREFIX)/man:\$(PREFIX)/share/man:g" -e "s:ln -s -f $(PREFIX)/bin/:ln -s :" Makefile]])
    -- fix version stuff
    os.execute([[sed -i -e "s:1\.0\.4:]] .. self.version .. ':" bzip2.1 bzip2.txt Makefile-libbz2_so manual.*')

    local cflags = ' CFLAGS="' .. tools.DEFAULT_CFLAGS .. '" '
    os.execute("make libbz2.a bzip2 bzip2recover" .. cflags .. system.get_make_jobs())
    os.execute("make" .. cflags .. "-f Makefile-libbz2_so" .. system.get_make_jobs())

    lfs.mkdir("_install")
    os.execute('make install PREFIX="' .. lfs.currentdir() .. '/_install"')
end

function self.pack()
    os.execute("cp -ra source/_install/* filesystem")
    os.execute("cp source/libbz2.so." .. self.version .. " filesystem/lib")
    for _, path in ipairs({ "filesystem/lib/libbz2.so", "filesystem/lib/libbz2.so.1", "filesystem/lib/libbz2.so.1.0" }) do
        lfs.link("libbz2.so." .. self.version, path, true)
    end
end

return self
