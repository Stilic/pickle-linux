local lfs = require "lfs"
local tools = require "tools"


version = "20250531"
sources = {
    { "source", "https://openpam.des.dev/downloads/openpam-" .. version .. ".tar.gz" }
}

build = tools.build_gnu_configure()
function pack()
    tools.pack_default()()
    lfs.mkdir("filesystem/lib/pkgconfig")
    os.execute("cp ../pam.pc filesystem/lib/pkgconfig")
end

