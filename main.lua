-- polluting the global namespace is awesome XDDD
require("global")

function love.load()
	love.filesystem.setIdentity(fileSystemIdentity)
	logger.info("Game starting")
	timer.setSecond(1000)
	local vsync, fullscreen = loadOptionsSave()
	state.add("testing/menu", require("states.testing.menu"))
	state.add("testing/menu2", require("states.testing.menu2"))
	state.add("testing/menu3", require("states.testing.menu3"))
	state.add("testing/timer", require("states.testing.timer"))
	-- if you were to add another state add it before state.init()
	state.init()
	-- switch to the state after state.init()
	state.switch("skdjfkjsdfh")
	if not love.filesystem.getInfo("save") then
		generateNewGeneralSave("save", {
			windowTitle = "game"
		})
	end
	local t = loadGeneralSave("save")
	love.window.setTitle(t.windowTitle)
	love.window.setMode(800, 600, {
		resizable = true,
		vsync = vsync,
		fullscreen = fullscreen
	})
end

function love.draw()
	state.emit("draw")
end

function love.update(dt)
	curFrames = curFrames + 1
	timer.update(dt)
end

function love.quit()
	love.window.close()
	love.audio.stop()
	lily.quit()
end

function love.keyreleased(key)
	if key == "f11" then
		-- switch between windowed and fullscreen and save it to "saveOptionsFileName"
		toggleFullscreenSave()
	end
end
