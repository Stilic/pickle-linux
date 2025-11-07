local tools = require "tools"

version = "3.5.0"
sources = {
    { "source", "https://github.com/openssl/openssl/releases/download/openssl-" .. version .. "/openssl-" .. version .. ".tar.gz" }
}

build = tools.build_gnu_configure("--prefix=/ --openssldir=/etc/ssl", nil, nil, nil, "Configure")

function pack()
    tools.pack_default()()
    os.rename("filesystem/lib64", "filesystem/lib")
end
