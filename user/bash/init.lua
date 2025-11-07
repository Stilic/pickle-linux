local lfs = require "lfs"
local tools = require "tools"
local config = require "neld.config"

version = "5.2.37"
dev_dependencies = { pkg "user.bison" }
sources = {
    { "source", config.gnu_site .. "/bash/bash-" .. version .. ".tar.gz" }
}

build = tools.build_gnu_configure("--disable-nls --without-bash-malloc")

function pack()
    tools.pack_default()()
    lfs.link("bash", "filesystem/bin/sh", true)
end
