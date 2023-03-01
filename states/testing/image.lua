local t = {}
local images = {}

function t:enter()
    -- load 1000 of the same image
    local toLoad = {}
    for i = 1, 1000 do
        toLoad[#toLoad + 1] = { "newImage", "assets/images/love.png" }
    end
    images = assetLoader.load(toLoad)
    love.graphics.setColor(1, 1, 1)
end

function t:draw()
    for i, v in ipairs(images) do
        love.graphics.draw(v, i)
    end
    love.graphics.print("FPS: " .. math.floor(1 / love.timer.getDelta(), 3))
end

function t:exit()
    for i, v in ipairs(images) do
        v:release()
    end
    collectgarbage()
end

function t:keypressed(key)
    if key == "space" then
        state.switch("testing/menu")
    end
end

return t
