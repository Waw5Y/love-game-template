local menu2 = {}

function menu2:enter()
    self.rec = {
        x = 300,
        y = 300
    }
end

function menu2:draw()
    love.graphics.setColor(1, 1, 1)
    love.graphics.print("menu2 testy westy!!!\nSpace to go to menu3")
    love.graphics.setColor(vivid.HSLtoRGB(love.timer.getTime() % 1, 1, 0.5))
    love.graphics.rectangle("fill", self.rec.x, self.rec.y, 100, 100)
end

function menu2:keypressed(key)
    state.switch("menu3")
end

function menu2:update(dt)
    self.rec.x = 300 + math.cos(love.timer.getTime()) * 100
end

return menu2
