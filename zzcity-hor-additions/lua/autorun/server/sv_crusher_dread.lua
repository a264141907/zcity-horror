if not SERVER then return end

local CRUSHER_SUBROLE = "traitor_strangler"

local DREAD_RANGE     = 900
local CHECK_RATE      = 0.5

local function IsCrusher(ply)
    return IsValid(ply)
        and (ply.SubRole == CRUSHER_SUBROLE or ply.SubRole == CRUSHER_SUBROLE .. "_soe")
end

timer.Create("ZB_CrusherDread", CHECK_RATE, 0, function()
    local crushers = {}
    for _, ply in player.Iterator() do
        if IsCrusher(ply) and ply:Alive() then
            crushers[#crushers + 1] = ply
        end
    end
    if #crushers == 0 then return end

    for _, ply in player.Iterator() do
        if not ply:Alive() then continue end
        if IsCrusher(ply) then continue end
        local org = ply.organism
        if not org or org.otrub then continue end

        local nearest = math.huge
        local plyPos = ply:GetPos()
        for _, cr in ipairs(crushers) do
            local d = plyPos:Distance(cr:GetPos())
            if d < nearest then nearest = d end
        end

        if nearest <= DREAD_RANGE then
            local closeness = 1 - (nearest / DREAD_RANGE)
            org.fearadd = math.max(org.fearadd or 0, 1 + closeness * 2)
        end
    end
end)
