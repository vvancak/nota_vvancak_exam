local sensorInfo = {
    name = "GetUnitsRange",
    desc = "Returns range of unit",
    author = "vvancak",
    date = "2018-06-21",
    license = "notAlicense",
}

local EVAL_PERIOD_DEFAULT = -1 -- acutal, no caching
local UNKNOWN_ESTIMATE = 350

function getInfo()
    return {
        period = EVAL_PERIOD_DEFAULT
    }
end

local SpringGetUnitDefID = Spring.GetUnitDefID

-- @description return current wind statistics
return function(unit)

    -- unit definition
    local unitDefId = SpringGetUnitDefID(unit)
    if not unitDefId then
        return UNKNOWN_ESTIMATE
    end

    -- weapons visible
    local unitDef = UnitDefs[unitDefId]
    if not unitDef.weapons or #unitDef.weapons < 1 then
        return 0
    end

    -- weapon definition
    local weaponDefId = unitDef.weapons[1].weaponDef
    if not weaponDefId then
        return 0
    end

    -- weapon properties
    local weapon = WeaponDefs[weaponDefId]
    if not weapon then
        return UNKNOWN_ESTIMATE
    end

    return weapon.range
end