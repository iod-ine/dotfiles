return {
    cmd = { "/usr/bin/clangd-19", "--background-index", "--clang-tidy", "--log=verbose", "-j=8" },
    filetypes = { "c", "cpp" },
    root_markers = { "compile_commands.json" },
    init_options = {
        fallbackFlags = { "-std=c++20" },
    },
}
