local menu3 = {}

function menu3:enter()
    self.rec = {
        x = 300,
        y = 300
    }
    self.rec2 = {
        x = 300,
        y = 300
    }
end

function menu3:draw()
    love.graphics.setColor(1, 1, 1)
    love.graphics.print("menu3 testy westy!!!\nSpace to go to timer testing\nFPS: " ..
    math.floor(1 / love.timer.getDelta(), 3) .. "\nFrames: " .. curFrames)
    love.graphics.setColor(vivid.HSLtoRGB(love.timer.getTime() % 1, 1, 0.5))
    love.graphics.rectangle("fill", self.rec.x, self.rec.y, 100, 100)
    love.graphics.rectangle("fill", self.rec2.x, self.rec2.y, 100, 100)
end

function menu3:update(dt)
    self.rec.x = 300 + math.cos(love.timer.getTime()) * 100
    self.rec2.y = 300 + math.sin(love.timer.getTime()) * 100
end

function menu3:keypressed(key)
    if key == "space" then
        state.switch("timer")
    end
end

return menu3
