local lua_ls = { settings = { Lua = {} } }
lua_ls.settings.Lua = {
    runtime = { version = 'LuaJIT' },
    diagnostics = {
        globals = { 'vim' },
    },
    telemetry = { enable = false },
}

local tsserver = { settings = { typescript = {} } }
tsserver.settings.typescript.inlayHints = {
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
    tsserver = tsserver,
}
