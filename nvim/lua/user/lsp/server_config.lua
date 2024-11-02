local lua_ls = { settings = {} }
lua_ls.settings.Lua = {
    runtime = { version = 'LuaJIT' },
    diagnostics = {
        globals = { 'vim' },
    },
    telemetry = { enable = false },
}

local rust_analyzer = { settings = {} }
rust_analyzer.settings['rust-analyzer'] = {
    diagnostics = {
        disabled = { 'unlinked-file' }
    }
}

local ts_ls = { settings = {} }
ts_ls.settings.typescript = {}
ts_ls.settings.typescript.inlayHints = {
    includeInlayEnumMemberValueHints = true,
    includeInlayFunctionLikeReturnTypeHints = true,
    includeInlayFunctionParameterTypeHints = true,
    includeInlayParameterNameHints = "all",
    includeInlayParameterNameHintsWhenArgumentMatchesName = true,
    includeInlayPropertyDeclarationTypeHints = true,
    includeInlayVariableTypeHints = true,
}

return {
    lua_ls = lua_ls,
    rust_analyzer = rust_analyzer,
    ts_ls = ts_ls,
}
