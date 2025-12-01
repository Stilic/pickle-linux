local system = require "system"
local tools = require "tools"
local lfs = require "lfs"

version = "21.1.6"
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
    local additional_command = ""

    if projects then
        additional_command = "-DLLVM_ENABLE_PROJECTS="

        local l = #projects
        for i, project in ipairs(projects) do
            additional_command = additional_command .. project
            if i ~= l then
                additional_command = additional_command .. ";"
            end
        end

        additional_command = additional_command .. " "
    end

    if runtimes then
        additional_command = additional_command .. "-DLLVM_ENABLE_RUNTIMES="

        local l = #runtimes
        for i, runtime in ipairs(runtimes) do
            additional_command = additional_command .. runtime
            if i ~= l then
                additional_command = additional_command .. ";"
            end
        end

        additional_command = additional_command .. " "
    end

    return tools.build_cmake(additional_command .. "-DLLVM_TARGET_ARCH=" ..
        arch ..
        " -DLLVM_HOST_TRIPLE=" ..
        triplet ..
        " -DLLVM_DEFAULT_TARGET_TRIPLE=" ..
        triplet .. " " ..
        (part == "llvm"
            and "-DENABLE_LINKER_BUILD_ID=ON -DLLVM_INSTALL_BINUTILS_SYMLINKS=ON -DLLVM_INSTALL_UTILS=ON -DLLVM_BUILD_LLVM_DYLIB=ON -DLLVM_LINK_LLVM_DYLIB=ON -DLLVM_ENABLE_RTTI=ON -DLLVM_ENABLE_PER_TARGET_RUNTIME_DIR=ON -DCLANG_DEFAULT_RTLIB=compiler-rt -DCLANG_DEFAULT_UNWINDLIB=libunwind -DCLANG_DEFAULT_CXX_STDLIB=libc++ -DLLVM_ENABLE_LIBXML2=OFF -DLLVM_ENABLE_LIBCXX=ON -DMLIR_INSTALL_AGGREGATE_OBJECTS=OFF"
            or "-DCOMPILER_RT_DEFAULT_TARGET_ONLY=ON -DCOMPILER_RT_BUILD_GWP_ASAN=OFF -DLIBCXX_CXX_ABI=libcxxabi -DLIBCXX_ENABLE_STATIC_ABI_LIBRARY=OFF -DLIBCXX_HAS_MUSL_LIBC=ON -DLIBCXX_HARDENING_MODE=fast -DLIBCXXABI_ENABLE_STATIC_UNWINDER=OFF -DLIBUNWIND_ENABLE_ASSERTIONS=OFF -DLIBUNWIND_HAS_NODEFAULTLIBS_FLAG=OFF -DCOMPILER_RT_SCUDO_STANDALONE_BUILD_SHARED=OFF"),
        nil, part)
end

build = gen_build("llvm", { "clang", "clang-tools-extra", "lld", "mlir" })

function pack()
    tools.pack_default()()

    lfs.link("clang", "filesystem/bin/cc", true)
    lfs.link("clang++", "filesystem/bin/c++", true)
end

variants = {
    libs = {
        build = gen_build("runtimes", nil, { "compiler-rt", "libunwind", "libcxx", "libcxxabi" }),
        pack = tools.pack_default()
    }
}
