local sensorInfo = {
    name = "GetReclaimAmount",
    desc = "Checks how much reclaim is around a position",
    author = "vvancak",
    date = "2018-06-21",
    license = "notAlicense",
}

local EVAL_PERIOD_DEFAULT = -1 -- acutal, no caching
local SPHERE_RADIUS = 300

function getInfo()
    return {
        period = EVAL_PERIOD_DEFAULT
    }
end

local SpringGetFeaturesInSphere = Spring.GetFeaturesInSphere
local SpringGetFeatureResources = Spring.GetFeatureResources

-- @description return current wind statistics
return function(position)
    local features = SpringGetFeaturesInSphere(position.x, position.y, position.z, SPHERE_RADIUS)
    local reclaim = 0

    for i = 1, #features do
        local reclaim_curr = SpringGetFeatureResources(features[i])
        Spring.Echo(reclaim_curr)
        
        if reclaim_curr > 0 then
            reclaim = reclaim + reclaim_curr
        end
    end
    return reclaim
end