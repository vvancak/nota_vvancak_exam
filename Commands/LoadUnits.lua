function getInfo()
    return {
        onNoUnits = SUCCESS, -- instant success
        tooltip = "Load unit",
        parameterDefs = {
            {
                name = "target_unit",
                variableType = "expression",
                componentType = "editBox",
                defaultValue = "<none>",
            }
        }
    }
end

-- speed-ups
local SpringGiveOrderToUnit = Spring.GiveOrderToUnit
local SpringGetUnitCommands = Spring.GetUnitCommands
local SpringGetUnitIsTransporting = Spring.GetUnitIsTransporting

function Run(self, units, parameter)
    local target_unit = parameter.target_unit
    local transport = units[1]

    if #SpringGetUnitCommands(transport, 1) > 0 then
        return RUNNING
    end

    if not SpringGetUnitIsTransporting(transport) then
        SpringGiveOrderToUnit(transport, CMD.LOAD_UNITS, { target_unit }, CMD.OPT_SHIFT)
        return RUNNING
    end

    return SUCCESS
end

function Reset(self)
end
