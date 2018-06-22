local sensorInfo = {
    name = "GetNextStrongPoint",
    desc = "Gets next strong point on that lane",
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

-- @description return current wind statistics
return function(strongpoints)
    for i = 1, #strongpoints do
        -- TODO: I am the owner of a strongpoint
        -- if not owners[strongpoints[i]] == me then
        -- return strongpoints[i-1]
        -- end

        if not Sensors.IsPointSafe(strongpoints[i]) then
            return strongpoints[i - 1]
        end
    end
end