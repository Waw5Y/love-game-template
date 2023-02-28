local assetManager = {
    isLoading = false
}
local multiLoad
local returnedLoad = {}

function assetManager.load(insert)
    assetManager.isLoading = true
    returnedLoad = {}
    multilily = lily.loadMulti(insert)
    multilily:onComplete(function(_, lilies)
        for i = 1, #lilies do
            returnedLoad[#returnedLoad + 1] = lilies[i][1]
        end
    end)
    assetManager.isLoading = false
    return returnedLoad
end

function assetManager.returnValues()
    if not multiLoad:isComplete() then
        local getCount, getLoadedCount = multiLoad:getCount(), multiLoad:getLoadedCount()
        percent = getLoadedCount / getCount
        return { math.floor(percent * 100), getLoadedCount, getCount, multiLoad:isComplete() }
    end
    return { 100, 1, 1, true }
end

return assetManager
