local sensorInfo = {
    name = "GetHightstDpsUnit",
    desc = "Get enemy unit with highest DPS in the area",
    author = "vvancak",
    date = "2018-06-21",
    license = "notAlicense",
}

local EVAL_PERIOD_DEFAULT = -1 -- acutal, no caching

function getInfo()
    return {
        period = EVAL_PERIOD_DEFAULT
    }
end

local SpringGetUnitsInSphere = Spring.GetUnitsInSphere

-- @description return current wind statistics
return function(position, radius)
    local units_in_sphere = SpringGetUnitsInSphere(position.x, position.y, position.z, radius)
    local max_unit = nil
    local max_dps = 0

    for i = 1, #units_in_sphere do
        local current = units_in_sphere[i]
        if (Sensors.IsEnemy(current)) then
            local dps = Sensors.GetUnitDPS(current)
            if (dps > max_dps) then
                max_unit = current
                max_dps = dps
            end
        end
    end

    if (max_unit ~= nil) then
        return Sensors.GetUnitPosition(max_unit)
    else
        return nil
    end
end