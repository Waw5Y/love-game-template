local logger = {}

function logger.info(...)
    local p = ""
    for i, v in ipairs({ ... }) do
        p = p .. v
        if #{ ... } > 1 then
            if i ~= #{ ... } then
                p = p .. "\t"
            end
        end
    end
    print("[".. os.date("%X") .. "] [INFO] " .. p)
end

function logger.warn(...)
    local p = ""
    for i, v in ipairs({ ... }) do
        p = p .. v
        if #{ ... } > 1 then
            if i ~= #{ ... } then
                p = p .. "\t"
            end
        end
    end
    print("[".. os.date("%X") .. "] [WARN!] " .. p)
end

function logger.error(...)
    local p = ""
    for i, v in ipairs({ ... }) do
        p = p .. v
        if #{ ... } > 1 then
            if i ~= #{ ... } then
                p = p .. "\t"
            end
        end
    end
    print("[".. os.date("%X") .. "] [ERROR!] " .. p)
end

return logger
