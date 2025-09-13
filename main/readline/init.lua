local lfs = require "lfs"
local tools = require "tools"
local config = require "neld.config"

local self = {}

self.version = "8.2.13"
self.sources = {
    { "source", config.gnu_site .. "/readline/readline-" .. self.version .. ".tar.gz" }
}

self.build = tools.build_gnu_configure("", "--with-curses bash_cv_termcap_lib=libcurses")
function self.pack()
    tools.pack_default()()
    lfs.rmdir("filesystem/usr/bin")
end

return self
