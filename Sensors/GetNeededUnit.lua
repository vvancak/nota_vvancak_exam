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

    -- workers
    if (tableLength(bb.lines[line_id].workers) < 1) and Sensors.CanAffordUnit(mission_info, "armfark", 1) then
        return "armfark"
    end

    -- if (tableLength(bb.lines[line_id].transports) < 1) and Sensors.CanAffordUnit(mission_info, "armatlas", 1) then
    --     return "armatlas"
    -- end

    -- if (tableLength(bb.lines[line_id].defense) < 2) and Sensors.CanAffordUnit(mission_info, "armbox", 1) then
    --     return "armbox"
    -- end

    -- artillery
    if (tableLength(bb.lines[line_id].skirmish) < 20) and Sensors.CanAffordUnit(mission_info, "armmart", 1.5) then
        return "armmart"
    end

    -- army
    if Sensors.CanAffordUnit(mission_info, "armzeus", 2) then
        return "armzeus"
    end

    return nil
end