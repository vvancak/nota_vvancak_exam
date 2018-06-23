local sensorInfo = {
    name = "CanAffordUnit",
    desc = "Checks if I have enough metal to but a unit",
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

local SpringGetMyTeamID = Spring.GetMyTeamID
local SpringGetTeamResources = Spring.GetTeamResources

-- @description return current wind statistics
return function(mission_info, unit_name, metal_mult)
    local team_id = SpringGetMyTeamID()
    local metal = SpringGetTeamResources(team_id, "metal")

    local costs = mission_info.buy
    return costs[unit_name] * metal_mult < metal
end