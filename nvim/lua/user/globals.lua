function P(arg)
    vim.notify(vim.inspect(arg))
end

function Dict_len(dict)
    local len = 0
    for _, _ in pairs(dict) do
        len = len + 1
    end
    print(len)
end

