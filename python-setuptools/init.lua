local tools = require "tools"

version = "80.9.0"
dependencies = { pkg "python", pkg "python-packaging", pkg "python-installer" }
dev_dependencies = { pkg "python-gpep517" }
sources = {
    { "source", "https://github.com/pypa/setuptools/archive/refs/tags/v" .. version .. ".tar.gz" }
}

build = tools.build_python(nil,
    "SETUPTOOLS_INSTALL_WINDOWS_SPECIFIC_FILES=0 SETUPTOOLS_DISABLE_VERSIONED_EASY_INSTALL_SCRIPT=1")

pack = tools.pack_python()
