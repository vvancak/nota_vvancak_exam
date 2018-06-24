local sensorInfo = {
    name = "GetFirstEnemyStrongPoint",
    desc = "Gets first enemy strong point",
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
local SpringGetTeamInfo = Spring.GetTeamInfo

-- @description return current wind statistics
return function(corridor_def)
    local teamID = SpringGetMyTeamID()
    local teamID, leader, isDead, isAiTeam, side, allyTeam, customTeamKeys, incomeMultiplier = SpringGetTeamInfo(teamID)

    for i = 1, #corridor_def do
        local point = corridor_def[i]
        if (point.isStrongpoint and point.ownerAllyID ~= allyTeam) then
            return point
        end
    end

    -- enemy base
    return nil
end