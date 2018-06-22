function getInfo()
    return {
        onNoUnits = SUCCESS, -- instant success
        tooltip = "Reclaim metal",
        parameterDefs = {
            {
                name = "position",
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

function Run(self, units, parameter)
    if not self.init then
        Init(self)
    end

    local position = parameter.position
    local radius = parameter.radius
    local unit = units[1]

    if #SpringGetUnitCommands(unit, 1) > 0 then
        return RUNNING
    end

    if bb.workers[unit] == "IDLE" then
        SpringGiveOrderToUnit(unit, CMD.RECLAIM, { position.x, position.y, position.z, radius }, CMD.OPT_SHIFT)
        bb.workers[unit] = "RECLAIM"
        return RUNNING
    end

    self.working[unit] = "IDLE"
    return SUCCESS
end

function Reset(self)
end
