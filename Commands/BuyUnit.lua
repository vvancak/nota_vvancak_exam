function getInfo()
    return {
        onNoUnits = SUCCESS, -- instant success
        tooltip = "Buy units !! do not forget to check if you can afford it !!",
        parameterDefs = {
            {
                name = "unitName",
                variableType = "expression",
                componentType = "editBox",
                defaultValue = "<none>",
            }, {
                name = "lineId",
                variableType = "expression",
                componentType = "editBox",
                defaultValue = "<none>",
            }
        }
    }
end

-- get madatory module operators
VFS.Include("modules.lua") -- modules table
VFS.Include(modules.attach.data.path .. modules.attach.data.head) -- attach lib module

-- get other madatory dependencies
attach.Module(modules, "message") -- communication backend load

function Run(self, units, parameter)
    -- orders list
    if not bb.orders then
        bb.orders = {}
    end
    table.insert(bb.orders, {unitName = parameter.unitName, lineId = parameter.lineId})

    -- buy unit
    message.SendRules({
        subject = "swampdota_buyUnit",
        data = {
            unitName = parameter.unitName
        },
    })

    return SUCCESS
end


function Reset(self)
    return self
end