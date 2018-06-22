local sensorInfo = {
    name = "Refresh Units",
    desc = "Splits units into classes",
    author = "vvancak",
    date = "2018-06-21",
    license = "notAlicense",
}

local EVAL_PERIOD_DEFAULT = -1 -- acutal, no caching
local SPHERE_RADIUS = 500

function getInfo()
    return {
        period = EVAL_PERIOD_DEFAULT
    }
end

local SpringGetMyTeamID = Spring.GetMyTeamID
local SpringGetTeamUnits = Spring.GetTeamUnits
local SpringValidUnitID = Spring.ValidUnitID

-- @description return current wind statistics
return function(position)
    local teamID = SpringGetMyTeamID()
    local allies = SpringGetTeamUnits(teamID)

    -- init
    if bb.transports == nil then
        bb.transports = {}
    end

    if bb.attack == nil then
        bb.attack = {}
    end

    if bb.workers == nil then
        bb.workers = {}
    end

    -- dead
    for key, value in pairs(bb.transports) do
        if not SpringValidUnitID(key) then bb.transports[key] = nil end
    end

    for key, value in pairs(bb.attack) do
        if not SpringValidUnitID(key) then bb.attack[key] = nil end
    end

    for key, value in pairs(bb.workers) do
        if not SpringValidUnitID(key) then bb.workers[key] = nil end
    end

    for _, value in pairs(allies) do
        local defID = SpringGetUnitDefID(value)
        if UnitDefs[defID].isTransport then
            bb.transports[value] = "IDLE"
        else
            local unitName = UnitDefs[defID].name

            if unitName == "armzeus" or unitName == "armmav" then
                bb.attack[value] = "IDLE"
            end

            if unitName == "armfark" then
                bb.workers[value] = "IDLE"
            end
        end
    end
end