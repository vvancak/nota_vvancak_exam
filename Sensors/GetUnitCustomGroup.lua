local sensorInfo = {
    name = "GetUnitCustomGroup",
    desc = "Create custom group for Movement in Group command",
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
return function(list_of_units)
    if not list_of_units then
        return {}
    end

    local return_dict = {}
    for i = 1, #list_of_units do
        return_dict[list_of_units[i]] = i
        if i == 30 then
            return return_dict
        end
    end
    return return_dict
end