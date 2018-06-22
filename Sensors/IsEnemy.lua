local sensorInfo = {
    name = "IsEnemy",
    desc = "Allies and stuff",
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

local SpringGetUnitAllyTeam = Spring.GetUnitAllyTeam

-- @description return current wind statistics
return function(unit, enemy)
    return SpringGetUnitAllyTeam(unit) ~= SpringGetUnitAllyTeam(enemy)
end