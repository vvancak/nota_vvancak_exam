local sensorInfo = {
    name = "IsPointSafe",
    desc = "Point is safe <=> Out of enemy range",
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

local SpringGetUnitPosition = Spring.GetUnitPosition

-- @description return current wind statistics
return function(position)
    local enemies = Sensors.core.EnemyUnits()

    for i = 1, #enemies do
        local enemy = enemies[i]
        local x, y, z = SpringGetUnitPosition(enemy)
        local enemy_pos = Vec3(x, y, z)
        if (enemy_pos:Distance(position) < Sensors.GetUnitRange(enemy)) then
            return false
        end
    end

    return true
end