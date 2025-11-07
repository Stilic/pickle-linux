local lfs = require "lfs"
local tools = require "tools"

version = "2.4.3"
sources = {
    { "source", "https://distfiles.ariadne.space/pkgconf/pkgconf-" .. version .. ".tar.xz" }
}

build = tools.build_gnu_configure(
    "--with-pkg-config-dir=/usr/lib/pkgconfig:/usr/share/pkgconfig:/lib/pkgconfig:/share/pkgconfig")

function pack()
    tools.pack_default()()
    lfs.link("pkgconf", "filesystem/bin/pkg-config", true)
end
