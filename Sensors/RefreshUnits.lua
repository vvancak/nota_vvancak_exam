local sensorInfo = {
    name = "Refresh Units",
    desc = "Black board -> Lines -> Unit Classes",
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

local SpringGetMyTeamID = Spring.GetMyTeamID
local SpringGetTeamUnits = Spring.GetTeamUnits
local SpringValidUnitID = Spring.ValidUnitID
local SpringGetUnitDefID = Spring.GetUnitDefID
local SpringGetUnitIsDead = Spring.GetUnitIsDead

local function GetUnitLine(unitName)
    if not bb.orders then
        bb.orders = {}
    end

    for i = 1, #bb.orders do
        local order = bb.orders[i]

        if order.unitName == unitName then
            local ret_val = order.lineId
            table.remove(bb.orders, i)
            return ret_val
        end
    end

    return 1
end

local function CreateLineUnits(line_id)
    local line = bb.lines[line_id]

    -- attack units
    if not line.attack then
        line.attack = {}
    end

    -- skirmishers
    if not line.skirmish then
        line.skirmish = {}
    end

    -- workers
    if not line.workers then
        line.workers = {}
    end

    -- radar
    if not line.radar then
        line.radar = {}
    end
end

local function IsDead(unit_id)
    if not SpringValidUnitID(unit_id) then
        return true
    end

    if SpringGetUnitIsDead(unit_id) then
        return true
    end

    return false
end

local function PurgeDeadUnits(line_id)

    -- radars
    local line = bb.lines[line_id]
    local new_table = {}
    for i = 1, #line.radar do
        local unit_id = line.radar[i]
        if not IsDead(unit_id) then
            new_table[#new_table + 1] = unit_id
        end
    end
    line.radar = new_table

    -- skirmishers
    local line = bb.lines[line_id]
    local new_table = {}
    for i = 1, #line.skirmish do
        local unit_id = line.skirmish[i]
        if not IsDead(unit_id) then
            new_table[#new_table + 1] = unit_id
        end
    end
    line.skirmish = new_table

    -- attack units
    local line = bb.lines[line_id]
    local new_table = {}
    for i = 1, #line.attack do
        local unit_id = line.attack[i]
        if not IsDead(unit_id) then
            new_table[#new_table + 1] = unit_id
        end
    end
    line.attack = new_table

    -- workers
    local line = bb.lines[line_id]
    local new_table = {}
    for i = 1, #line.workers do
        local unit_id = line.workers[i]
        if not IsDead(unit_id) then
            new_table[#new_table + 1] = unit_id
        end
    end
    line.workers = new_table
end

local function CreateNewUnit(unit_id)
    local defID = SpringGetUnitDefID(unit_id)
    local unitName = UnitDefs[defID].name

    local line_id = GetUnitLine(unitName)
    local line = bb.lines[line_id]

    -- attack
    if unitName == "armzeus" or unitName == "armmav" or unitName == "armwar" then
        line.attack[#line.attack + 1] = unit_id
    end

    -- skirmishers
    if unitName == "armmart" then
        line.skirmish[#line.skirmish + 1] = unit_id
    end

    -- radar
    if unitName == "armseer" then
        line.radar[#line.radar + 1] = unit_id
    end

    -- workers
    if unitName == "armfark" then
        line.workers[#line.workers + 1] = unit_id
    end
end

return function()
    -- init lines
    if not bb.lines then
        bb.lines = {}
        table.insert(bb.lines, {})
        table.insert(bb.lines, {})
        table.insert(bb.lines, {})

        -- init classes (transports, attack, skirmish, radar, worker, defense)
        for line_id = 1, #bb.lines do
            CreateLineUnits(line_id)
        end

        -- init marker which units are already assigned
        bb.registered_units = {}
    end

    -- dead units
    local line_to_purge = math.random(#bb.lines)
    PurgeDeadUnits(line_to_purge)

    -- get allies
    local teamID = SpringGetMyTeamID()
    local allies = SpringGetTeamUnits(teamID)

    -- assign units
    for _, value in pairs(allies) do
        if not bb.registered_units[value] then
            bb.registered_units[value] = true
            CreateNewUnit(value)
        end
    end
end