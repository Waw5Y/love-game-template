-- timer lib by waw5y

local timer = {
    timers = {},
    second = 1
}

--- @type function
function timer.new(args)
    for i, v in ipairs(timer.timers) do
        assert(args.tag ~= v.tag, "Cannot create timer with the same tag as another active timer!")
    end
    timer.timers[#timer.timers + 1] = {
        time = args.time,
        staticTime = args.time,
        callback = args.callback,
        type = args.type,
        tag = args.tag
    }
end

--- @type function
function timer.setSecond(second)
    timer.second = second
end

--- @type function
function timer.remove(tag)
    for i, v in ipairs(timer.timers) do
        if tag == v.tag then
            table.remove(timer.timers, i)
            break
        end
    end
end

--- @type function
local function update(dt)
    for i, v in ipairs(timer.timers) do
        v.time = v.time - dt * timer.second
        if v.time <= 0 then
            if v.type == "normal" then
                v.callback()
                table.remove(timer.timers, i)
            elseif v.type == "repeat" or v.type == "loop" then
                v.time = v.staticTime
                v.callback()
            elseif v.type == "everyFrameAfter0" then
                v.callback()
            else
                v.callback()
                table.remove(timer.timers, i)
            end
        end
    end
end

local registry = {}

local function null()
end

local all_callbacks = { 'update' }
for _, f in ipairs(all_callbacks) do
    registry[f] = love[f] or null
    love[f] = function(...)
        registry[f](...)
        return update(...)
    end
end

return timer
