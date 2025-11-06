local lfs = require "lfs"
local tools = require "tools"


version = "0.8.12"
dev_dependencies = { pkg "user.bash" }
sources = {
    { "source", "https://landley.net/toybox/downloads/toybox-" .. version .. ".tar.gz" }
}

function build()
    os.execute("find source -type f -exec sed -i 's|^#!/bin/bash|#!/usr/bin/bash|' {} +")
    tools.build_kconfig()()
    os.execute("make install")
end

function pack()
    os.execute("cp -ra source/install/bin source/install/sbin filesystem")
    os.execute("cp -ra source/install/usr/bin source/install/usr/sbin filesystem")
end

