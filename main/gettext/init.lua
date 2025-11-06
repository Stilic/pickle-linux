local lfs = require "lfs"
local tools = require "tools"


version = "0.3.2"
sources = {
    { "source", "http://ftp.barfooze.de/pub/sabotage/tarballs/gettext-tiny-" .. version .. ".tar.xz" }
}

function build()
    lfs.chdir("source")

    tools.make("LIBINTL=MUSL")

    lfs.mkdir("_install")
    os.execute('make install prefix=/ LIBINTL=MUSL DESTDIR="' .. lfs.currentdir() .. '/_install"')
end

pack = tools.pack_default()

