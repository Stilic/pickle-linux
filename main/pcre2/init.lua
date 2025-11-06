local tools = require "tools"


version = "10.45"
sources = {
    { "source", "https://github.com/PCRE2Project/pcre2/releases/download/pcre2-" ..
    version .. "/pcre2-" .. version .. ".tar.bz2" }
}

build = tools.build_gnu_configure()
pack = tools.pack_default()

