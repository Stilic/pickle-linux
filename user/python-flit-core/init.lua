local lfs = require "lfs"
local tools = require "tools"
local python = pkg "user.python"


version = "3.12.0"
dependencies = { pkg "user.python" }
sources = {
    { "source", "https://github.com/pypa/flit/archive/refs/tags/" .. version .. ".tar.gz" }
}

build = tools.build_flit("source/flit_core")
function pack()
    lfs.chdir("source/flit_core")

    os.execute("python bootstrap_install.py --installdir ../../filesystem/lib/python" ..
        python.short_version .. "/site-packages dist/*.whl")
    os.execute("install -Dm644 LICENSE -t ../../filesystem/share/licenses/" .. name)
end

