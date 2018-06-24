local sensorInfo = {
    name = "GetUnitsNotOnFront",
    desc = "Returns unit which is too far from the front point",
    author = "vvancak",
    date = "2018-06-21",
    license = "notAlicense",
}

local EVAL_PERIOD_DEFAULT = -1 -- acutal, no caching
local DISTANCE_CLOSE_ENOUGH = 500

function getInfo()
    return {
        period = EVAL_PERIOD_DEFAULT
    }
end

-- @description return current wind statistics
return function(class_units, front)
    local return_arr = {}
    for i = 1, #class_units do
        local current = class_units[i]
        local position = Sensors.GetUnitPosition(current)
        if (position:Distance(front) > DISTANCE_CLOSE_ENOUGH) then
            return_arr[#return_arr + 1] = current
        end
    end
    return return_arr
end