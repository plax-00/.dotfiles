return require('telescope').register_extension {
    exports = {
        sessions = require('sessions')
    }
}
