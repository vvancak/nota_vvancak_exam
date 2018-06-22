function getInfo()
    return {
        onNoUnits = SUCCESS, -- instant success
        tooltip = "Drop unit",
        parameterDefs = {
            {
                name = "target",
                variableType = "expression",
                componentType = "editBox",
                defaultValue = "<none>",
            },
            {
                name = "radius",
                variableType = "expression",
                componentType = "editBox",
                defaultValue = "150",
            }
        }
    }
end

-- speed-ups
local SpringGiveOrderToUnit = Spring.GiveOrderToUnit
local SpringGetUnitCommands = Spring.GetUnitCommands
local SpringGetUnitIsTransporting = Spring.GetUnitIsTransporting

function Run(self, units, parameter)
    local target = parameter.target
    local radius = parameter.radius
    local transport = units[1]

    if #SpringGetUnitCommands(transport, 1) > 0 then
        return RUNNING
    end

    if SpringGetUnitIsTransporting(transport) ~= nil then
        SpringGiveOrderToUnit(transport, CMD.UNLOAD_UNITS, { target.x, target.y, target.z, radius * 0.8 }, CMD.OPT_SHIFT)
        SpringGiveOrderToUnit(transport, CMD.MOVE, target:AsSpringVector(), CMD.OPT_SHIFT)
        return RUNNING
    end

    return SUCCESS
end

function Reset(self)
end
