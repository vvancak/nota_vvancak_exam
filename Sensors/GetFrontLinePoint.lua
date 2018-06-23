local sensorInfo = {
    name = "GetFrontLinePoint",
    desc = "Gets a point where the DPS ratio drops below 1",
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
        local dps_ratio = Sensors.GetAreaDpsRatio(pos)
        if (dps_ratio <= 1) then
            if (i > 2) then
                return corridor_def[1]
            end
        end
    end
    return corridor_def[#corridor_def]
end