function getInfo()
    return {
        onNoUnits = SUCCESS, -- instant success
        tooltip = "Repair frendly units",
        parameterDefs = {
            {
                name = "unit_group",
                variableType = "expression",
                componentType = "editBox",
                defaultValue = "<none>",
            }, {
                name = "position",
                variableType = "expression",
                componentType = "editBox",
                defaultValue = "<none>",
            }, {
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

function Run(self, units, parameter)
    local unit_group = parameter.unit_group
    local position = parameter.position
    local radius = parameter.radius

    for i = 1, #unit_group do
        local unit = unit_group[i]
        SpringGiveOrderToUnit(unit, CMD.REPAIR, { position.x, position.y, position.z, radius }, {})
    end

    return SUCCESS
end

function Reset(self)
    return self
end

