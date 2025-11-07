local tools = require "tools"

version = "0.0.29"
dev_dependencies = { pkg "automake", pkg "flex", pkg "docbook-xsl" }
sources = {
    { "source", "https://releases.pagure.org/xmlto/xmlto-" .. version .. ".tar.bz2" }
}

build = tools.build_autotools()

pack = tools.pack_default()
