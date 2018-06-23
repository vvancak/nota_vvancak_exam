local sensorInfo = {
    name = "GetFrontSafePoint",
    desc = "Gets Position on the front out of enemy range",
    author = "vvancak",
    date = "2018-06-22",
    license = "notAlicense",
}

local EVAL_PERIOD_DEFAULT = -1 -- acutal, no caching

function getInfo()
    return {
        period = EVAL_PERIOD_DEFAULT
    }
end

-- @description return current wind statistics
return function(corridor_def)
    for i = 1, #corridor_def do
        local pos = corridor_def[i].position
        if not Sensors.IsPointSafe(pos) then
            if (i > 2) then
                if (Script.LuaUI('drawCross_update')) then
                    Script.LuaUI.drawCross_update({
                        x = pos.x,
                        y = pos.y,
                        z = pos.z,
                        color = { r = 0, g = 1, b = 0 }
                    })
                end
                return corridor_def[i - 2]
            else
                return corridor_def[1]
            end
        end
    end
    return Sensors.GetFrontLinePoint(corridor_def)
end