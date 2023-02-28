local t = {}

function t:enter()
    self.rec = {
        x = 300,
        y = 300
    }
    self.rec2 = {
        x = 300,
        y = 300
    }
    timer.new({
        time = 500,
        type = "repeat",
        callback = function()
            self.rec.x = 300 + math.cos(love.timer.getTime()) * 100
            self.rec2.y = 300 + math.sin(love.timer.getTime()) * 100
        end,
        tag = "updater"
    })
end

function t:draw()
    love.graphics.setColor(1, 1, 1)
    love.graphics.print(
        "timer testy westy!!!\nSpace to go back to menu1\ntest of the timer library\nthis updates the rainbow rectangles every 0.5 seconds")
    love.graphics.setColor(vivid.HSLtoRGB(love.timer.getTime() % 1, 1, 0.5))
    love.graphics.rectangle("fill", self.rec.x, self.rec.y, 100, 100)
    love.graphics.rectangle("fill", self.rec2.x, self.rec2.y, 100, 100)
end

function t:exit()
    timer.remove("updater")
end

function t:keypressed(key)
    if key == "space" then
        state.switch("testing/menu")
    end
end

return t
