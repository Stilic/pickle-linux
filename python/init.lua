local lfs = require "lfs"
local tools = require "tools"

version = "3.13.3"
short_version = version:sub(1, version:find(".", version:find(".", 1, true) + 1, true) - 1)
dev_dependencies = { pkg "perl", pkg "expat" }
sources = {
    { "source", "https://www.python.org/ftp/python/" .. version .. "/Python-" .. version .. ".tar.xz" }
}

build = tools.build_gnu_configure("--prefix=/ --enable-shared --with-system-expat --without-ensurepip")

function pack()
    tools.pack_default()()

    local major_version = version:sub(1, 1)

    os.execute("mv filesystem/include/python*/* filesystem/include")
    os.execute("rm -r filesystem/include/python*")

    for _, v in ipairs({ "python" .. major_version, "idle" .. major_version, "pydoc" .. major_version }) do
        lfs.link(v, "filesystem/bin/" .. v:sub(1, -2), true)
    end

    lfs.link("python" .. major_version .. "-config", "filesystem/bin/python-config", true)
    lfs.link("python" .. major_version .. ".1", "filesystem/share/man/man1/python.1", true)
end
