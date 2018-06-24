local sensorInfo = {
    name = "GetNeededUnit",
    desc = "Returns unit which the line needs at the moment",
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

local function tableLength(T)
    local count = 0
    for _ in pairs(T) do count = count + 1 end
    return count
end

-- @description return current wind statistics
return function(mission_info, line_id)
    -- radars
    if (#bb.lines[line_id].radar < 1) and Sensors.CanAffordUnit(mission_info, "armseer", 1) then
        return "armseer"
    end

    local chance = math.random(10)

    -- workers
    if (chance < 5 and #bb.lines[line_id].workers < 3) and Sensors.CanAffordUnit(mission_info, "armfark", 1) then
        return "armfark"
    end

    -- artillery
    if (chance < 5) and  Sensors.CanAffordUnit(mission_info, "armmart", 1) then
        return "armmart"
    end

    -- army (last option => ensure we have excess metal in case radar/fark is needed)
    if (chance >= 5) and Sensors.CanAffordUnit(mission_info, "armzeus", 1.5) then
        return "armzeus"
    end

    return nil
end