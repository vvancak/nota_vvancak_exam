local sensorInfo = {
    name = "GetAreaDPSRatio",
    desc = "Compares my DPS to enemy DPS in the area",
    author = "vvancak",
    date = "2018-06-21",
    license = "notAlicense",
}

local EVAL_PERIOD_DEFAULT = -1 -- acutal, no caching
local SPHERE_RADIUS = 500

function getInfo()
    return {
        period = EVAL_PERIOD_DEFAULT
    }
end

SpringGetUnitsInSphere = Spring.GetUnitsInSphere

-- @description return current wind statistics
return function(position)
    local units_in_sphere = SpringGetUnitsInSphere(position.x, position.y, position.z, SPHERE_RADIUS)
    local my_dps = 1
    local enemy_dps = 1

    for i = 1, #units_in_sphere do
        local current = units_in_sphere[i]
        if (Sensors.IsEnemy(units[1], current)) then
            enemy_dps = enemy_dps + Sensors.GetUnitDPS(current)
        else
            my_dps = my_dps + Sensors.GetUnitDPS(current)
        end
    end

    return my_dps / enemy_dps
end