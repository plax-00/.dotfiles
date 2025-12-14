local config = { settings = {} }
config.settings['rust-analyzer'] = {
    diagnostics = {
        disabled = { 'unlinked-file' }
    }
}

return config
