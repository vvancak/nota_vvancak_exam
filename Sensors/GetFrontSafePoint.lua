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
return function(corridor_def, points_behind)
    for i = 1, #corridor_def do

        local position = corridor_def[i].position
        local dps_ratio = Sensors.GetAreaDpsRatio(position)

        -- position not above DPS limit
        if (dps_ratio <= 1) then

            -- move [points_behind] back
            if (i > points_behind) then
                position = corridor_def[i - points_behind].position
            else
                position = corridor_def[1].position
            end

            -- draw green cross
            if (Script.LuaUI('drawCross_update')) then
                Script.LuaUI.drawCross_update({
                    x = position.x,
                    y = position.y,
                    z = position.z,
                    color = { r = 0, g = 1, b = 0 }
                })
            end

            return position
        end
    end

    -- n points behind the front line
    return Sensors.GetFrontLinePoint(corridor_def, points_behind)
end