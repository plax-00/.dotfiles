local config = { settings = {} }
config.settings.Lua = {
    runtime = { version = 'LuaJIT' },
    diagnostics = {
        globals = { 'vim' },
    },
    telemetry = { enable = false },
}

return config
