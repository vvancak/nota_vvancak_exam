local sensorInfo = {
    name = "IsEnemy",
    desc = "Allied teams chedk",
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
local SpringGetTeamInfo = Spring.GetTeamInfo
local SpringGetMyTeamID = Spring.GetMyTeamID
-- @description return current wind statistics
return function(enemy)
    local teamID = SpringGetMyTeamID()
    local teamID, leader, isDead, isAiTeam, side, allyTeam, customTeamKeys, incomeMultiplier = SpringGetTeamInfo(teamID)
    return allyTeam ~= SpringGetUnitAllyTeam(enemy)
end