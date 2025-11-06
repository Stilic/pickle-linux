local lfs = require "lfs"
local python = pkg "user.python"


version = "0.7.0"
dependencies = { pkg "user.python" }
sources = {
    { "source", "https://files.pythonhosted.org/packages/py3/i/installer/installer-" .. version .. "-py3-none-any.whl" }
}

function pack()
    local install_dir = "filesystem/lib/python" .. python.short_version .. "/site-packages"
    os.execute("mkdir -p " .. install_dir)
    os.execute("cp -ra source/installer " .. install_dir)
    os.execute("python3 -m compileall " .. install_dir)
end

