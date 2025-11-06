local tools = require "tools"


version = "0.0.29"
dev_dependencies = { pkg "user.automake", pkg "user.flex", pkg "user.docbook-xsl" }
sources = {
    { "source", "https://releases.pagure.org/xmlto/xmlto-" .. version .. ".tar.bz2" }
}

build = tools.build_autotools()
pack = tools.pack_default()

