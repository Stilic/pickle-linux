local system = require "system"
local tools = require "tools"
local lfs = require "lfs"

version = "21.1.6"
dependencies = { pkg "zstd" }
dev_dependencies = { pkg "cmake", pkg "python" }
sources = {
    { "source", "https://github.com/llvm/llvm-project/releases/download/llvmorg-" .. version .. "/llvm-project-" .. version .. ".src.tar.xz" }
}

local arch, triplet = "", ""
if buildmode then
    if system.architecture == "x86_64" then
        arch = "X86"
    elseif system.architecture == "aarch64" then
        arch = "AArch64"
    elseif system.architecture == "ppc64le" or system.architecture == "ppc64" or system.architecture == "ppc" then
        arch = "PowerPC"
    elseif system.architecture == "riscv64" then
        arch = "RISCV64"
    elseif system.architecture == "armv7l" or system.architecture == "armv7" or system.architecture == "armhf" then
        arch = "ARM"
    elseif system.architecture == "loongarch64" or system.architecture == "loongarch32" then
        arch = "LoongArch"
    end

    triplet = system.architecture .. "-pc-linux-musl"
end
local function gen_build(part, projects, runtimes)
    local options = ""

    if projects then
        options = "-DLLVM_ENABLE_PROJECTS="

        local l = #projects
        for i, project in ipairs(projects) do
            options = options .. project
            if i ~= l then
                options = options .. ";"
            end
        end

        options = options .. " "
    end

    if runtimes then
        options = options .. "-DLLVM_ENABLE_RUNTIMES="

        local l = #runtimes
        for i, runtime in ipairs(runtimes) do
            options = options .. runtime
            if i ~= l then
                options = options .. ";"
            end
        end

        options = options .. " "
    end

    return function()
        local build_dir = lfs.currentdir()

        if stage ~= 0 and part ~= "llvm" then
            os.execute("rm -rf source/build-" .. part)

            local bin_dir = build_dir .. "/filesystem"
            options = options .. "-DLLVM_EXTERNAL_LIT=" ..
                build_dir .. "/source/build-llvm/utils/lit -DLLVM_ROOT=" .. bin_dir .. " "
            bin_dir = bin_dir .. "/bin/"
            -- options = options ..
            --     "-DCMAKE_C_COMPILER=" ..
            --     bin_dir .. "clang" ..
            --     " -DCMAKE_CXX_COMPILER=" .. bin_dir .. "clang++" .. " "
        end

        local compiler_flags = "-I" .. build_dir .. "/filesystem-unwind/include"
        tools.build_cmake(
            options ..
            (stage == 0 and ("-DLLVM_TARGETS_TO_BUILD=" .. arch .. " -DLIBCXX_USE_COMPILER_RT=OFF -DLIBCXX_USE_STATIC_ABI_LIBRARY=OFF ") or "") ..
            "-DLLVM_TARGET_ARCH=" .. arch ..
            " -DLLVM_HOST_TRIPLE=" .. triplet ..
            " -DLLVM_DEFAULT_TARGET_TRIPLE=" .. triplet ..
            " -DENABLE_LINKER_BUILD_ID=ON -DLLVM_INSTALL_BINUTILS_SYMLINKS=ON -DLLVM_INSTALL_UTILS=ON -DLLVM_BUILD_LLVM_DYLIB=ON -DLLVM_LINK_LLVM_DYLIB=ON -DLLVM_ENABLE_RTTI=ON -DLLVM_ENABLE_PER_TARGET_RUNTIME_DIR=ON -DLLVM_ENABLE_LIBXML2=OFF -DMLIR_INSTALL_AGGREGATE_OBJECTS=OFF -DCOMPILER_RT_BUILD_GWP_ASAN=OFF -DLIBCXX_CXX_ABI=libcxxabi -DLIBCXX_ENABLE_STATIC_ABI_LIBRARY=OFF -DLIBCXX_HAS_MUSL_LIBC=ON -DLIBCXX_HARDENING_MODE=fast -DLIBCXXABI_ENABLE_STATIC_UNWINDER=OFF -DLIBUNWIND_ENABLE_ASSERTIONS=OFF -DCOMPILER_RT_SCUDO_STANDALONE_BUILD_SHARED=OFF -DCLANG_DEFAULT_RTLIB=compiler-rt -DCLANG_DEFAULT_CXX_STDLIB=libc++ -DLLVM_ENABLE_LIBCXX=ON -DLLVM_INCLUDE_TESTS=OFF",
            nil, part, nil, compiler_flags, compiler_flags, "-L" .. build_dir .. "/filesystem-unwind/lib")()
    end
end

if stage ~= 0 then
    variants = {
        unwind = {
            build = gen_build("runtimes", nil, { "libunwind" }),
            pack = tools.pack_default(nil, "unwind")
        },
        libs = {
            build = gen_build("runtimes", nil, { "compiler-rt", "libcxx", "libcxxabi" }),
            pack = tools.pack_default(nil, "libs")
        }
    }
end

build = gen_build("llvm", { "clang", "lld" })

function pack()
    tools.pack_default()()

    lfs.link("clang", "filesystem/bin/cc", true)
    lfs.link("clang++", "filesystem/bin/c++", true)
end
