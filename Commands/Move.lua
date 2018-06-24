function getInfo()
    return {
        onNoUnits = SUCCESS, -- instant success
        tooltip = "Gives move order to units",
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

    local random_spread = (1 + #unit_group) * 5

    for i = 1, #unit_group do
        local unit = unit_group[i]

        local x_spread = math.random(2 * random_spread) - random_spread
        local z_spread = math.random(2 * random_spread) - random_spread
        local new_position = position + Vec3(x_spread, 0, z_spread)

        SpringGiveOrderToUnit(unit, CMD.MOVE, new_position:AsSpringVector(), {})
    end

    return SUCCESS
end


function Reset(self)
    return self
end