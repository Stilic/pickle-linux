local lfs = require "lfs"
local tools = require "tools"
local config = require "neld.config"


version = "8.2.13"
sources = {
    { "source", config.gnu_site .. "/readline/readline-" .. version .. ".tar.gz" }
}

build = tools.build_gnu_configure("--with-curses bash_cv_termcap_lib=libcurses")
function pack()
    tools.pack_default()()
    lfs.rmdir("filesystem/usr/bin")
end

