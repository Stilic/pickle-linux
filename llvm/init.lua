local system = require "system"
local tools = require "tools"
local lfs = require "lfs"

version = "21.1.6"
dev_dependencies = { pkg "cmake", pkg "python" }
sources = {
    { "source", "https://github.com/llvm/llvm-project/releases/download/llvmorg-" .. version .. "/llvm-project-" .. version .. ".src.tar.xz" }
}

local arch = ""
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
end
local function gen_build(projects, runtimes)
    local has_external_llvm = buildmode and not projects

    local projects_command = " -DLLVM_ENABLE_PROJECTS= "
    if projects then
        projects_command = " -DLLVM_ENABLE_PROJECTS=" .. projects .. " "
    end

    local runtimes_command = " -DLLVM_ENABLE_RUNTIMES= "
    if runtimes then
        runtimes_command = " -DLLVM_ENABLE_RUNTIMES=" .. runtimes .. " "
    end

    return function()
        local external_command = ""
        if has_external_llvm then
            local build_dir = lfs.currentdir()
            external_command = "-DLLVM_EXTERNAL_LIT=" ..
                build_dir .. "/source/build-llvm/utils/lit -DLLVM_ROOT=" .. build_dir .. "/filesystem "
        end
        tools.build_cmake(external_command ..
            "-DLLVM_PARALLEL_LINK_JOBS=2 -DLLVM_TARGETS_TO_BUILD=" ..
            arch .. projects_command .. runtimes_command ..
            "-DCOMPILER_RT_USE_BUILTINS_LIBRARY=ON -DCOMPILER_RT_DEFAULT_TARGET_ONLY=ON -DCOMPILER_RT_BUILD_GWP_ASAN=OFF -DLIBCXX_CXX_ABI=libcxxabi -DLIBCXX_USE_COMPILER_RT=ON -DLIBCXX_ENABLE_STATIC_ABI_LIBRARY=OFF -DLIBCXX_HAS_MUSL_LIBC=ON -DLIBCXX_HARDENING_MODE=fast -DLIBCXXABI_USE_LLVM_UNWINDER=ON -DLIBCXXABI_ENABLE_STATIC_UNWINDER=OFF -DLIBCXXABI_USE_COMPILER_RT=ON -DLLVM_INSTALL_UTILS=ON -DLLVM_BUILD_LLVM_DYLIB=ON -DLLVM_LINK_LLVM_DYLIB=ON -DLLVM_ENABLE_RTTI=ON -DLLVM_ENABLE_PER_TARGET_RUNTIME_DIR=ON -DCLANG_DEFAULT_RTLIB=compiler-rt -DCLANG_DEFAULT_UNWINDLIB=libunwind -DCLANG_DEFAULT_CXX_STDLIB=libc++ -DLLVM_ENABLE_LIBXML2=OFF -DLLVM_ENABLE_LIBCXX=ON -DLIBUNWIND_ENABLE_ASSERTIONS=OFF -DLIBUNWIND_USE_COMPILER_RT=ON",
            nil, "llvm")()
    end
end

build = gen_build("clang;clang-tools-extra;lld;mlir")

pack = tools.pack_default()

variants = {
    libs = {
        build = gen_build(nil, "compiler-rt;libcxx;libcxxabi;libunwind")
    }
}
