---@diagnostic disable: redundant-parameter, undefined-field
-- made by Waw5Y
local self = {
    _backgroundColour = { 0, 0, 0 },
    _currentState = {
        draw = function()
            love.graphics.print("No state loaded", 0, 0)
        end
    },
    _addedStates = { {
        tag = "nothing",
        state = {}
    } }
}
local init = false
local registry = {}

local state = {
    add = function(tag, state)
        if not tag then
            error("state.add(tag, state) - tag is required")
        end
        for i, v in ipairs(self._addedStates) do
            if v.tag == tag then
                error("state.add(tag, state) - tag already exists")
            end
        end
        table.insert(self._addedStates, {
            tag = tag,
            state = state
        })

        if self._addedStates[#self._addedStates].state.onAdd then
            self._addedStates[#self._addedStates].state.onAdd()
        end
    end,
    remove = function(tag)
        assert(init, "Not Initialized")
        for i, v in ipairs(self._addedStates) do
            if v.tag == tag then
                if v.state.onRemove then
                    v.state.onRemove()
                end
                table.remove(self._addedStates, i)
            end
        end
    end,
    current = function()
        assert(init, "Not Initialized")
        if self._currentState ~= nil then
            return self._currentState
        end
    end,
    get = function(tag)
        assert(init, "Not Initialized")
        for i, v in ipairs(self._addedStates) do
            if v.tag == tag then
                return v
            end
        end
    end,
    emit = function(fn, ...)
        assert(init, "Not Initialized")
        if self._currentState ~= nil then
            if self._currentState[fn] ~= nil then
                if type(self._currentState[fn]) ~= "function" then
                    error("ERROR: '" .. self._currentState.tag .. "." .. fn .. "' must be a function!")
                    return
                end
                self._currentState[fn](self._currentState, ...)
            end
        end
    end
}

function state.switch(tag, ...)
    if tag ~= nil then
        for i, v in ipairs(self._addedStates) do
            if v.tag == tag then
                state.emit("exit")
                self._subStates = {}
                self._currentState = v.state
                state.emit("enter")
                break
            end
        end
    end
end

function state.init()
    init = true
    local function null() end

    local all_callbacks = { 'update' }
    for k in pairs(love.handlers) do
        all_callbacks[#all_callbacks + 1] = k
    end
    for _, f in ipairs(all_callbacks) do
        registry[f] = love[f] or null
        love[f] = function(...)
            registry[f](...)
            return state.emit(f, ...)
        end
    end
end

return state
