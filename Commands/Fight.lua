function getInfo()
    return {
        onNoUnits = SUCCESS, -- instant success
        tooltip = "Gives Fight order to units",
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
            }
        }
    }
end

local SpringGiveOrderToUnit = Spring.GiveOrderToUnit

function Run(self, units, parameter)
    local unit_group = parameter.unit_group
    local position = parameter.position

    for i = 1, #unit_group do
        local unit = unit_group[i]
        SpringGiveOrderToUnit(unit, CMD.FIGHT, position:AsSpringVector(), {})
    end

    return SUCCESS
end


function Reset(self)
    return self
end