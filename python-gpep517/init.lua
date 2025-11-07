local python = pkg "python"

version = "0.7.0"
dependencies = { pkg "python" }
sources = {
    { "source", "https://github.com/gentoo/gpep517/archive/refs/tags/v19.tar.gz" }
}

function pack()
    local install_dir = "filesystem/lib/python" .. python.short_version .. "/site-packages"
    os.execute("mkdir -p " .. install_dir)
    os.execute("cp -ra source/gpep517 " .. install_dir)
    os.execute("python3 -m compileall " .. install_dir)
end
