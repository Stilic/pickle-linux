local lfs = require "lfs"
local tools = require "tools"

local self = {}

self.version = "4.5"
self.sources = {
    { self.version, "https://www.oasis-open.org/docbook/xml/" .. self.version .. "/docbook-xml-" .. self.version .. ".zip" },
    { "4.4",        "https://www.oasis-open.org/docbook/xml/4.4/docbook-xml-4.4.zip" },
    { "4.3",        "https://www.oasis-open.org/docbook/xml/4.3/docbook-xml-4.3.zip" },
    { "4.2",        "https://www.oasis-open.org/docbook/xml/4.2/docbook-xml-4.2.zip" }
}

function self.pack()
    os.execute("mkdir -p filesystem/etc/xml")
    os.execute("xmlcatalog --noout --create filesystem/etc/xml/docbook-xml")

    os.execute("mkdir -p filesystem/share/xml/docbook")
    for _, source in ipairs(self.sources) do
        local dir = source[1]

        lfs.chdir(dir)

        lfs.mkdir("../filesystem/share/xml/docbook/xml-dtd-" .. dir)
        os.execute("cp -dr docbook.cat *.dtd ent *.mod ../filesystem/share/xml/docbook/xml-dtd-" .. dir)

        lfs.chdir("..")

        local base_url = "http://www.oasis-open.org/docbook/xml/" .. dir
        local target_dir = "filesystem/etc/xml/docbook-xml"

        os.execute("xmlcatalog --noout --add public '-//OASIS//DTD DocBook XML V" ..
            dir .. "//EN' " .. base_url .. "/docbookx.dtd " .. target_dir)
        os.execute("xmlcatalog --noout --add public '-//OASIS//DTD DocBook CALS Table Model V" ..
            dir .. "//EN' " .. base_url .. "/calstblx.dtd " .. target_dir)
        os.execute("xmlcatalog --noout --add public '-//OASIS//DTD XML Exchange Table Model 19990315//EN' " ..
            base_url .. "/soextblx.dtd " .. target_dir)
        os.execute("xmlcatalog --noout --add public '-//OASIS//ELEMENTS DocBook Information Pool V" ..
            dir .. "//EN' " .. base_url .. "/dbpoolx.mod " .. target_dir)
        os.execute("xmlcatalog --noout --add public '-//OASIS//ELEMENTS DocBook Document Hierarchy V" ..
            dir .. "//EN' " .. base_url .. "/dbhierx.mod " .. target_dir)
        os.execute("xmlcatalog --noout --add public '-//OASIS//ENTITIES DocBook Additional General Entities V" ..
            dir .. "//EN' " .. base_url .. "/dbgenent.mod " .. target_dir)
        os.execute("xmlcatalog --noout --add public '-//OASIS//ENTITIES DocBook Notations V" ..
            dir .. "//EN' " .. base_url .. "/dbnotnx.mod " .. target_dir)
        os.execute("xmlcatalog --noout --add public '-//OASIS//ENTITIES DocBook Character Entities V" ..
            dir .. "//EN' " .. base_url .. "/dbcentx.mod " .. target_dir)

        if dir == "4.4" or dir == "4.5" then
            os.execute("xmlcatalog --noout --add public '-//OASIS//ELEMENTS DocBook XML HTML Tables V" ..
                dir .. "//EN' " .. base_url .. "/htmltblx.mod " .. target_dir)
        end

        os.execute("xmlcatalog --noout --add rewriteSystem " ..
            base_url .. " /usr/share/xml/docbook/xml-dtd-" .. dir .. " " .. target_dir)
        os.execute("xmlcatalog --noout --add rewriteURI " ..
            base_url .. " /usr/share/xml/docbook/xml-dtd-" .. dir .. " " .. target_dir)
    end

    os.execute("install -Dt filesystem/share/licenses/" .. self.name .. " -m644 ../license-from-upstream")

    os.execute("find filesystem -type f -exec chmod -c a-x {} +")
    os.execute("chmod -Rc u=rwX,go=rX filesystem")
end

return self
