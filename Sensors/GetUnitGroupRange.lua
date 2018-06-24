local sensorInfo = {
    name = "GetUnitGroupRange",
    desc = "Returns range of units in group",
    author = "vvancak",
    date = "2018-06-21",
    license = "notAlicense",
}

local EVAL_PERIOD_DEFAULT = -1 -- acutal, no caching
local UNKNOWN_ESTIMATE = 350

function getInfo()
    return {
        period = EVAL_PERIOD_DEFAULT
    }
end

local SpringValidUnitID = Spring.ValidUnitID
local SpringGetUnitIsDead = Spring.GetUnitIsDead

-- @description return current wind statistics
return function(unit_group)
    if (#unit_group == 0) then
        return UNKNOWN_ESTIMATE
    end

    for i = 1, #unit_group do
        local unit = unit_group[i]
        if (SpringValidUnitID(unit) and not SpringGetUnitIsDead(unit)) then
            return Sensors.GetUnitRange(unit)
        end
    end

    return UNKNOWN_ESTIMATE
end