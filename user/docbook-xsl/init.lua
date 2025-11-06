local lfs = require "lfs"


version = "1.79.2"
sources = {
    { "source", "https://github.com/docbook/xslt10-stylesheets/releases/download/release%2F" .. version .. "/docbook-xsl-" .. version .. ".tar.bz2" },
    { "nons",   "https://github.com/docbook/xslt10-stylesheets/releases/download/release%2F" .. version .. "/docbook-xsl-nons-" .. version .. ".tar.bz2" }
}

function pack()
    for _, source in ipairs(sources) do
        local dir = source[1]

        local namespace = ""
        if dir ~= "source" then
            namespace = "-" .. dir
        end
        local pkg_root = "filesystem/share/xml/docbook/xsl-stylesheets-" .. version .. namespace

        os.execute("install -Dt " .. pkg_root .. " -m644 " .. dir .. "/VERSION " .. dir .. "/VERSION.xsl")

        local extensions = { "xml", "xsl", "dtd", "ent" }
        for _, subdir in ipairs({
            "assembly", "common", "eclipse", "epub", "epub3", "fo", "highlighting",
            "html", "htmlhelp", "javahelp", "lib", "manpages", "params", "profiling",
            "roundtrip", "template", "website", "xhtml", "xhtml-1_1", "xhtml5"
        }) do
            for _, ext in ipairs(extensions) do
                os.execute("install -Dt " ..
                    pkg_root ..
                    "/" .. subdir .. " -m644 " .. dir .. "/" .. subdir .. "/*." .. ext .. " 2>/dev/null || true")
            end
        end

        lfs.link("xsl-stylesheets-" ..
            version .. namespace, "filesystem/share/xml/docbook/xsl-stylesheets" .. namespace, true)
    end

    os.execute("install -Dm644 source/COPYING -t filesystem/share/licenses/" .. name)
end

