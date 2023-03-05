local logger = {}

function logger.log(b, ...)
    local p = ""
    for i, v in ipairs({ ... }) do
        p = p .. v
        if #{ ... } > 1 then
            if i ~= #{ ... } then
                p = p .. "\t"
            end
        end
    end
    io.write(b .. p .. "\n")
end

function logger.info(...)
    logger.log("[" .. os.date("%X") .. "] [INFO] ", ...)
end

function logger.warn(...)
    logger.log("[" .. os.date("%X") .. "] [WARN] ", ...)
end

function logger.error(...)
    logger.log("[" .. os.date("%X") .. "] [ERROR!] ", ...)
end

return logger
