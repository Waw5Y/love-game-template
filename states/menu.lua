local menu = {}

function menu:enter()
    self.rec = {
        x = 300,
        y = 300
    }
end

function menu:draw()
    love.graphics.setColor(1, 1, 1)
    love.graphics.print("menu1 testy westy!!!" ..
    "\nvsync: " ..
    tostring(saveData.vsync) ..
    "\nlower fps when not focused: " ..
    tostring(saveData.lowerFPSWhenNotFocused) .. "\nfullscreen: " .. tostring(saveData.fullscreen) .. "\nSpace to go to menu2")
    love.graphics.setColor(vivid.HSLtoRGB(love.timer.getTime() % 1, 1, 0.5))
    love.graphics.rectangle("fill", self.rec.x, self.rec.y, 100, 100)
end

function menu:keypressed(key)
    if key == "space" then 
        state.switch("menu2")
    end
end


function menu:update(dt)
    self.rec.y = 300 + math.sin(love.timer.getTime()) * 100
end

return menu
