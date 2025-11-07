local lfs = require "lfs"
local system = require "system"
local tools = require "tools"

version = "5.4.7"
short_version = version:sub(1, version:find(".", version:find(".", 1, true) + 1, true) - 1)
sources = {
    { "source", "https://www.lua.org/ftp/lua-" .. version .. ".tar.gz" }
}

function build()
    lfs.chdir("source")

    os.execute(tools.get_flags() .. " make linux" .. system.get_make_jobs())
    os.execute("make INSTALL_MAN=../install/share/man/man1 local")

    os.execute("mkdir -p install/lib/pkgconfig")
    os.execute("cp ../../lua.pc install/lib/pkgconfig/lua" .. short_version .. ".pc")
end

function pack()
    tools.pack_default("source/install")()
    lfs.link("lua", "filesystem/bin/lua" .. short_version, true)
end
