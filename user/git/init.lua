local lfs = require "lfs"
local tools = require "tools"

version = "2.49.0"
dependencies = { pkg "user.curl" }
sources = {
    { "source", "https://www.kernel.org/pub/software/scm/git/git-" .. version .. ".tar.xz" }
}

function build()
    lfs.chdir("source")
    os.execute("make configure")
    tools.build_gnu_configure("--prefix=/usr NO_TCLTK=YesPlease", "")()
end

pack = tools.pack_default("source/_install/usr")
