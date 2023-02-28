-- polluting the global namespace is awesome XDDD
require("global")

function love.load()
	love.filesystem.setIdentity(fileSystemIdentity)
	logger.info("Game starting")
	timer.setSecond(1000)
	loadOptionsSave()
	state.add("menu", require("states.menu"))
	state.add("menu2", require("states.menu2"))
	state.add("menu3", require("states.menu3"))
	-- if you were to add another state add it before state.init()
	state.init()
	-- switch to the state after state.init()
	state.switch("menu")
	if not love.filesystem.getInfo("save") then
		generateNewGeneralSave("save", {
			windowTitle = "game"
		})
	end
	local t = loadGeneralSave("save")
	love.window.setTitle(t.windowTitle)
	love.window.setMode(800, 600, {
		resizable = true
	})
end

function love.draw()
	state.emit("draw")
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
