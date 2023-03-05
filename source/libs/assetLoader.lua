local assetLoader = {
    isLoading = false
}
local multiLoad
local returnedLoad = {}

function assetLoader.load(insert)
    returnedLoad = {}
    assetLoader.isLoading = true
    multiLoad = lily.loadMulti(insert)
    multiLoad:onComplete(function(_, lilies)
        for i = 1, #lilies do
            returnedLoad[i] = lilies[i][1]
        end
        assetLoader.isLoading = false
    end)
    collectgarbage("collect")
    return returnedLoad
end

function assetLoader.returnValues()
    if not multiLoad:isComplete() then
        local getCount, getLoadedCount = multiLoad:getCount(), multiLoad:getLoadedCount()
        percent = getLoadedCount / getCount
        return { math.floor(percent * 100), getLoadedCount, getCount, multiLoad:isComplete() }
    end
    return { 100, 1, 1, true }
end

return assetLoader
