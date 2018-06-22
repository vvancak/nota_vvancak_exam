local sensorInfo = {
    name = "GetIdleBoxOfDeath",
    desc = "Returns BOD which is not on the front",
    author = "vvancak",
    date = "2018-06-21",
    license = "notAlicense",
}

local EVAL_PERIOD_DEFAULT = -1 -- acutal, no caching
local DISTANCE_CLOSE_ENOUGH = 100

function getInfo()
    return {
        period = EVAL_PERIOD_DEFAULT
    }
end

-- @description return current wind statistics
return function(border_strongpoint)
    for i = 1, #units do
        local current = units[i]
        local position = Sensors.GetUnitPosition(current)
        if (position:Distance(border_strongpoint) > DISTANCE_CLOSE_ENOUGH) then
            return current
        end
    end
end