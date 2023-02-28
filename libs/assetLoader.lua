local assetManager = {}
local multiLoad
local returnedLoad = {}

function assetManager.load(insert, f)
    returnedLoad = {}
    multilily = lily.loadMulti(insert)
	multilily:onComplete(function(_, lilies)
        for i = 1, #lilies do
            returnedLoad[#returnedLoad+1] = lilies[i][1]
        end
	end)
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
