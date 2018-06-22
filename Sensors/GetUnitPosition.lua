local sensorInfo = {
    name = "GetUnitPosition",
    desc = "Spring triplet into Vec3 transformation",
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

SpringGetUnitPosition = Spring.GetUnitPosition

-- @description return current wind statistics
return function(unit)
    return Vec3(SpringGetUnitPosition(unit))
end