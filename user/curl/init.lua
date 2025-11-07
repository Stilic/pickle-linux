local tools = require "tools"

version = "8.13.0"
dependencies = { pkg "user.nghttp2", pkg "user.libidn2", pkg "user.libpsl" }
sources = {
    { "source", "https://curl.se/download/curl-" .. version .. ".tar.xz" }
}

build = tools.build_gnu_configure("--with-openssl")

pack = tools.pack_default()
