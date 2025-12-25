local tools = require "tools"

version = "2.41"
dependencies = { pkg "openpam" }
dev_dependencies = { pkg "meson", pkg "bash", pkg "bison" }
sources = {
    { "source", "https://www.kernel.org/pub/linux/utils/util-linux/v" .. version .. "/util-linux-" .. version .. ".tar.xz" }
}

function build()
    os.execute("find source -type f -exec sed -i 's|^#!/bin/bash|#!/usr/bin/bash|' {} +")
    tools.build_meson(
        "-Dbuild-newgrp=disabled -Dbuild-more=disabled -Dbuild-kill=disabled -Dbuild-nologin=disabled -Dbuild-liblastlog2=disabled -Dbuild-pam-lastlog2=disabled -Dbuild-python=disabled")()
end

pack = tools.pack_default()
