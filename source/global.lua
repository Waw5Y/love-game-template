---@diagnostic disable: duplicate-set-field
-- this is just a long sloppy file for globals and stuff

ffi = require("ffi")
bitser = require("libs.bitser")
timer = require("libs.timer")
state = require("libs.state")
logger = require("libs.logger")
json = require("libs.json")
lily = require("libs.lily")
assetLoader = require("libs.assetLoader")
vivid = require("libs.vivid")
errorMessages = require("errorMessages")

local saveOptionsFileName = "o"
fileSystemIdentity = "very gamer game"

saveData = nil

curFrames = 0

--[[
	arg1: fullscreen
	arg2: vsync
	arg3: lowerFPSWhenNotFocused
]]
function generateNewOptionsSave(fullscreen, vsync, lowerFPSWhenNotFocused)
	love.filesystem.write(saveOptionsFileName, bitser.dumps({
		fullscreen = fullscreen,
		vsync = vsync,
		lowerFPSWhenNotFocused = lowerFPSWhenNotFocused
	}))
end

-- loads options stuff duh
function loadOptionsSave()
	local ok = pcall(function(...)
		saveData = bitser.loads(love.filesystem.read(saveOptionsFileName))
		if saveData == nil then
			logger.error(errorMessages.loadSaveError)
			generateNewOptionsSave(false, true, true)
			saveData = bitser.loads(love.filesystem.read(saveOptionsFileName))
		end
	end)
	if not ok then
		logger.error(errorMessages.loadSaveError)
		generateNewOptionsSave(false, true, true)
		saveData = bitser.loads(love.filesystem.read(saveOptionsFileName))
	else
		saveData = bitser.loads(love.filesystem.read(saveOptionsFileName))
	end
	love.window.setVSync(saveData.vsync)
	love.window.setFullscreen(saveData.fullscreen)
	return saveData.vsync, saveData.fullscreen
end

function generateNewGeneralSave(name, table)
	love.filesystem.write(name, bitser.dumps(table))
end

function loadGeneralSave(name)
	if not love.filesystem.getInfo(name) then
		return logger.error("no such save named " .. name .. "!")
	end
	return bitser.loads(love.filesystem.read(name))
end

-- im gonna do whats called a pro gamer move (WARNING: THIS IS SUCH A PRO GAMER MOVE!!)
local oldDraw = love.graphics.draw
local oldfloor = math.floor
local ss = love.graphics.setScissor

-- this is here so the game doesnt crash if the drawable is nil
function love.graphics.draw(...)
	local args = { ... }
	if args[1] ~= nil then
		return oldDraw(...)
	else
		return love.graphics.print("Failed to draw", args[2], args[3])
	end
end

-- why not
function love.graphics.odraw(...)
	return oldDraw(...)
end

-- better floor
function math.floor(x, n)
	n = n or 0
	n = math.pow(10, n or 0)
	x = x * n
	if x >= 0 then x = oldfloor(x + 0.5) else x = math.ceil(x - 0.5) end
	return x / n
end

-- why not
function math.oldfloor(x)
	return oldfloor(x)
end

-- annoying
function love.graphics.setScissor(x, y, w, h)
	if not x or not y or not w or not h then
		ss()
		return
	end
	if x < 0 or y < 0 or w < 0 or h < 0 then
		return
	end
	ss(x, y, w, h)
end

-- all these functions should explain themselves

function toggleFullscreenSave()
	generateNewOptionsSave(not saveData.fullscreen, saveData.vsync, saveData.lowerFPSWhenNotFocused)
	loadOptionsSave()
end

function setFullscreenSave(f)
	generateNewOptionsSave(f, saveData.vsync, saveData.lowerFPSWhenNotFocused)
	loadOptionsSave()
end

function toggleFullscreen()
	love.window.setFullscreen(not love.window.getFullscreen())
end

function setFullscreen(f)
	love.window.setFullscreen(f)
end

function toggleVSyncSave()
	generateNewOptionsSave(saveData.fullscreen, not saveData.vsync, saveData.lowerFPSWhenNotFocused)
	loadOptionsSave()
end

function setVSyncSave(f)
	generateNewOptionsSave(saveData.fullscreen, f, saveData.lowerFPSWhenNotFocused)
	loadOptionsSave()
end

function toggleVSync()
	love.window.setVSync(boolToNum(not love.window.getVSync()))
end

function setVSync(f)
	love.window.setVSync(f)
end

function toggleLowerFPSWhenNotFocusedSave()
	generateNewOptionsSave(saveData.fullscreen, saveData.vsync, not saveData.lowerFPSWhenNotFocused)
	loadOptionsSave()
end

function setLowerFPSWhenNotFocusedSave(f)
	generateNewOptionsSave(saveData.fullscreen, saveData.vsync, f)
	loadOptionsSave()
end

function toggleLowerFPSWhenNotFocused()
	saveData.lowerFPSWhenNotFocused = not saveData.lowerFPSWhenNotFocused
end

function setLowerFPSWhenNotFocused(f)
	saveData.lowerFPSWhenNotFocused = f
end

-- other
function numToBool(i)
	return i > 1 and i < 2
end

function boolToNum(i)
	return (i and 1 or 0)
end