local sensorInfo = {
    name = "GetIdleUnits",
    desc = "Searches for units with nothing to do",
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

local SpringGetUnitCommands = Spring.GetUnitCommands

-- @description return current wind statistics
return function(class_units)
    local return_arr = {}

    for i = 1, #class_units do
        local current = class_units[i]
        local cmds = SpringGetUnitCommands(current, 1)
        if #cmds == 0 then
            return_arr[#return_arr + 1] = current
        end
    end

    return return_arr
end