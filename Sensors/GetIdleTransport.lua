local sensorInfo = {
    name = "GetIdleTransport",
    desc = "Searches for a transporter with nothing to do",
    author = "vvancak",
    date = "2018-06-21",
    license = "notAlicense",
}

local EVAL_PERIOD_DEFAULT = -1 -- acutal, no caching
local SPHERE_RADIUS = 300

function getInfo()
    return {
        period = EVAL_PERIOD_DEFAULT
    }
end

local SpringGetUnitCommands = Spring.GetUnitCommands
local SpringGetUnitIsTransporting = Spring.GetUnitIsTransporting


-- @description return current wind statistics
return function()
    for i = 1, #units do
        local current = units[i]
        local cmds = SpringGetUnitCommands(current, 1)
        if #cmds == 0 and not SpringGetUnitIsTransporting(current) then
            return current
        end
    end
    return nil
end