local event = require('common/event')
local buffChange = require('common/buffChange')
local jobChange = require('common/jobChange')
local onAction = require('common/action')

local proxy = {}

local T = function(t) return t end

local hasteChange = event:new();

local packetsIncoming = T {};

local onSubJobChange = jobChange.onSubJobChange;

local onBuffGain = buffChange.buffGain;
local onBuffLoss = buffChange.buffLoss;
local function buffactive() return buffChange.buffs end

local brdJAMult = 1;
local brdBonus = 0;
local geoBonus = 0;

local jobDW = 0;
local jobh2hDelay = 480;

local function getBrdBonus() return brdBonus; end
local function setBrdBonus(val) brdBonus = val end
local function getGeoBonus() return geoBonus end
local function setGeoBonus(val) geoBonus = val end

local function updateJobDW()

    local mainJobDW = {
        NIN = 35,
        DNC = 35, 
        THF = 30,
        BLU = 25
    }
    local subJobDW = {
        NIN = 25, 
        DNC = 15 
    }

    local mainJob = gData.GetPlayer().MainJob;
    local subJob = gData.GetPlayer().SubJob;

    jobDW = mainJobDW[mainJob] or subJobDW[subJob] or 0;
end

local function updateJobMA()
    local mainJob = gData.GetPlayer().MainJob;
    local subJob  = gData.GetPlayer().SubJob;

    local mainJobh2hDelay = {
        MNK = 270, 
        PUP = 235 
    }
    local subJobh2hDelay = {
        MNK = 340, 
        PUP = 380 
    }

    jobh2hDelay = mainJobh2hDelay[mainJob] or subJobh2hDelay[subJob] or 480;
end


updateJobDW();
onSubJobChange:register(updateJobDW);

updateJobMA();
onSubJobChange:register(updateJobMA);

local gearHaste = 256;
local function setGearHaste(haste) 
    gearHaste = haste; 
end

local hasteLevel = 0;
onBuffGain:register(function(buffId)
    if (buffId == 33) then -- haste
        hasteChange:trigger(true);
    elseif (buffId == 228 or buffId == 214 or buffId == 604 or buffId == 580) then
        hasteChange:trigger(true);
    end
end);

onBuffLoss:register(function(buffId)
    if (buffId == 33) then -- haste
        hasteLevel = 0;
        hasteChange:trigger(true);
    elseif (buffId == 228 or buffId == 214 or buffId == 604 or buffId == 580) then
        hasteChange:trigger(true);
    end
end);

local marches = T { 'Honor March', 'Victory March', 'Advancing March' } 
local function getMarchHaste(song)
    if song == 'Honor March'     then return (126 + 12 * math.min(brdBonus,4)) * brdJAMult end
    if song == 'Victory March'   then return (163 + 16 * brdBonus) * brdJAMult end
    if song == 'Advancing March' then return (108 + 11 * brdBonus) * brdJAMult end
    return 0
end

local function getMaHaste()
    local maHaste = 0;

    -- Haste/Haste2
    if (buffactive()[33]) then
        maHaste = maHaste + (hasteLevel == 2 and 307 or 150);
    end

    -- Assume bards are playing optimal marches
    for i = 1, buffactive()[214] or 0 do
        maHaste = maHaste + getMarchHaste(marches[i]);
    end

    if (buffactive()[604]) then -- Mighty Guard
        maHaste = maHaste + 150;
    end

    if (buffactive()[580]) then -- indi/geo haste
        maHaste = maHaste + (306 + 11 * geoBonus);  -- use `geoBonus` directly, not `gcinclude.settings.geoBonus`
    end
        
    return maHaste;
end

local hasteSambaTime = 0;
local hasteSambaPotency = 51;
local function expireHasteSamba()
    if (os.time() - hasteSambaTime >= 10) then hasteChange:trigger(); end
end

local function getJaHaste()
    local jaHaste = 0;
    jaHaste = jaHaste + ((os.time() - hasteSambaTime < 10) and hasteSambaPotency or 0)

    local player = gData.GetPlayer()
    local mainJob = player.MainJob;
    local subJob = player.SubJob;

    local myIndex = AshitaCore:GetMemoryManager():GetParty():GetMemberTargetIndex(0);
    local petIndex = AshitaCore:GetMemoryManager():GetEntity():GetPetTargetIndex(myIndex);

    --hasso
    if (mainJob == 'SAM' or subJob == 'SAM') and buffactive()[353] then
        local hassoPieces = {
            ['Unkai Haidate +1'] = 15,
            ['Unkai Haidate +2'] = 26,
            ['Kasuga Haidate'] = 26,
            ['Kasuga Haidate +1'] = 31,
            ['Kasuga Haidate +2'] = 31,
            ['Kasuga Haidate +3'] = 31,
            ['Wakido Kote'] = 10,
            ['Wakido Kote +1'] = 20,
            ['Wakido Kote +2'] = 31,
            ['Wakido Kote +3'] = 41,
            ['Wakido Kote +4'] = 41,
        }
        local equipment = gData.GetEquipment() -- or player.GetEquipment(), if player is correct
        local legsEquip = equipment.Legs and equipment.Legs.Name or ''
        local handsEquip = equipment.Hands and equipment.Hands.Name or ''

        if hassoPieces[legsEquip] then
            jaHaste = jaHaste + hassoPieces[legsEquip]
        end
        if hassoPieces[handsEquip] then
            jaHaste = jaHaste + hassoPieces[handsEquip]
        end

        jaHaste = jaHaste + 102
    end
    --last resort
    if subJob == 'DRK' and buffactive()[64] then
        jaHaste = jaHaste + 154
    end
    if (mainJob == 'DRG' and petIndex > 0 and AshitaCore:GetMemoryManager():GetEntity():GetHPPercent(petIndex) > 0) then
        jaHaste = jaHaste + 101;
    end

    return jaHaste;
end

local function getTotalHaste()
    local jaHaste = getJaHaste();
    local maHaste = getMaHaste();
    local embravaHaste = buffactive()[228] and 266 or 0;

    jaHaste = math.min(jaHaste, 256);
    maHaste = math.min(maHaste, 448);

    local total = gearHaste + jaHaste + maHaste + embravaHaste;
    return total <= 819 and total or 819;
end

local function getDwNeeded()
    local player = gData.GetPlayer();
    local mainJob = player.MainJob;
    local subJob = player.SubJob;
    if mainJob == 'NIN' or mainJob == 'THF' or mainJob == 'DNC' or mainJob == 'BLU' or subJob == 'NIN' or subJob == 'DNC' then
        return math.ceil((1 - (0.2 / ((1024 - getTotalHaste()) / 1024))) * 100 - jobDW)
    else 
        return 'N/A'
    end
    return dwNeeded
end

local function GetDWGearSet(pool)
    local dwNeeded = getDwNeeded()
    if type(dwNeeded) ~= 'number' or dwNeeded <= 0 or type(pool) ~= 'table' then return {} end

    table.sort(pool, function(a, b) return a[1] < b[1] end) -- lower priority first

    local totalDW = 0
    local gearSet = {}

    for _, gear in ipairs(pool) do
        local priority, slot, item, dwVal = table.unpack(gear)
        if (totalDW + dwVal) <= dwNeeded then
            gearSet[slot] = item
            totalDW = totalDW + dwVal
        end
        if totalDW >= dwNeeded then break end
    end

    return gearSet, totalDW
end

proxy.GetDWGearSet = GetDWGearSet

local function getMANeeded()
    local player = gData.GetPlayer();
    local weapon = (gData.GetEquipment().Main and gData.GetEquipment().Main.Name) or ''
    local h2hDelayCap = 96
    local hasteFraction = 1 - math.min((getTotalHaste() / 1024), 0.8)
    local h2hWeapons = {
        Verethragna = 81,
        Godhands = 138,
        Denouements = 165,
        Ohtas = 107,
        Midnights = 119,
        Kenkonken = 79,
        Spharai = 116,
    }

    if player.MainJob == 'MNK' or player.MainJob == 'PUP' or player.SubJob == 'MNK' or player.SubJob == 'PUP' then
        local baseDelay = jobh2hDelay or 480
        local weaponDelay = h2hWeapons[weapon] or 0
        local totalDelay = (baseDelay + weaponDelay) * hasteFraction
        local delayOverCap = totalDelay - h2hDelayCap

        return math.max(math.floor(delayOverCap + 0.5), 0) -- Rounded delay that needs to be shaved via MA gear
    else 
        return 'N/A'
    end
    return maNeeded
end

local function GetMAGearSet(pool)
    local maNeeded = getMANeeded()
    if type(maNeeded) ~= 'number' or maNeeded <= 0 or type(pool) ~= 'table' then return {} end

    table.sort(pool, function(a, b) return a[1] < b[1] end) -- lower priority first

    local totalMA = 0
    local gearSet = {}

    for _, gear in ipairs(pool) do
        local priority, slot, item, maVal = table.unpack(gear)
        if (totalMA + maVal) <= maNeeded then
            gearSet[slot] = item
            totalMA = totalMA + maVal
        end
        if totalMA >= maNeeded then break end
    end

    return gearSet, totalMA
end

proxy.GetMAGearSet = GetMAGearSet

local partyFromPacket = T {};

packetsIncoming[0x0DD] = function(e)
    local id = struct.unpack('L', e.data, 0x04 + 0x01);
    local mainJob = struct.unpack('B', e.data, 0x22 + 0x01);
    local subJob = struct.unpack('B', e.data, 0x24 + 0x01);

    partyFromPacket[id] = {
        id = id,
        mainJob = mainJob,
        subJob = subJob
    };
end

local membersHasteSamba = T {};
do
    local playerId;
    playerId = AshitaCore:GetMemoryManager():GetParty():GetMemberServerId(0);

    ashita.events.register('load', 'j-haste_player_id_cb', function()
        playerId = AshitaCore:GetMemoryManager():GetParty():GetMemberServerId(0);
    end);

    local function isTarget(action)
        for _, target in ipairs(action.Targets) do
            if (target.Id == playerId) then
                return true
            end
        end
        return false;
    end

    local function addMarch(march)
        for i = 1, 3 do
            if (marches[i] == march) then
                table.remove(marches, i)
                table.insert(marches, 1, march)
                break
            end
        end
    end

    local mobHasteDazePotency = T {};
    onAction:register(function(data_raw, unpackAction)
        local category = ashita.bits.unpack_be(data_raw, 0, 82, 4);

        if (category == 4) then
            local action = unpackAction();
            if (isTarget(action)) then
                local param = action.Param;

                if (param == 57 and hasteLevel ~= 2) then
                    hasteLevel = 1;
                    hasteChange:trigger();
                elseif (param == 511) then
                    hasteLevel = 2;
                    hasteChange:trigger()
                elseif (param == 417) then
                    addMarch('Honor March');
                    hasteChange:trigger();
                elseif (param == 420) then
                    addMarch('Victory March');
                    hasteChange:trigger();
                elseif (param == 419) then
                    addMarch('Advancing March');
                    hasteChange:trigger();
                end
            end
        elseif (category == 1) then
            local actorId = ashita.bits.unpack_be(data_raw, 0, 40, 32);
            local targetId = ashita.bits.unpack_be(data_raw, 0, 150, 32);
            if (actorId == playerId) then
                local action = unpackAction();

                local meleeAttack = action.Targets[1].Actions[1];

                if (meleeAttack.AdditionalEffect and bit.band(meleeAttack.AdditionalEffect.Damage, 0x3F) == 23) then
                    local update;

                    if (os.time() - hasteSambaTime >= 10) then
                        update = true;
                    end

                    hasteSambaTime = os.time();
                    local newPotency = mobHasteDazePotency[targetId] or 51;
                    if (hasteSambaPotency ~= newPotency) then
                        update = true;
                    end

                    hasteSambaPotency = newPotency;

                    if (update) then
                        hasteChange:trigger();
                    end
                    ashita.tasks.once(10, expireHasteSamba)
                end
            end

            if (membersHasteSamba[actorId]) then
                if (partyFromPacket[actorId] and partyFromPacket[actorId].mainJob == 'DNC') then
                    mobHasteDazePotency[targetId] = 101;
                else
                    mobHasteDazePotency[targetId] = 51;
                end
            end
        end
    end)
end


-- local GUI = require('J-GUI');
-- ashita.events.register('d3d_present', 'haste_debug', function()
--     GUI.text.write(200, 240, 1, "Job Haste: " .. tostring(getJaHaste()))
--     GUI.text.write(200, 260, 1, "Magic Haste: " .. tostring(getMaHaste()))
-- end)

packetsIncoming[0x076] = function(e)
    for k = 0, 4 do
        local id = struct.unpack('L', e.data, k * 0x30 + 0x05);
        if id ~= 0 then
            local hasteSamba = false
            local marcato = false
            local soulVoice = false
            for i = 1, 32 do
                -- Credit: Byrth, GearSwap
                local buff = struct.unpack('B', e.data, (k * 48 + 5 + 16 + i - 1)) + 256 *
                    (math.floor(
                        struct.unpack('B', e.data,
                            k * 48 + 5 + 8 +
                            math.floor((i - 1) / 4)) / 4 ^
                        ((i - 1) % 4)) % 4)
                if buff == 370 then -- Haste Samba
                    hasteSamba = true
                elseif buff == 52 then
                    soulVoice = true
                elseif buff == 231 then
                    marcato = true
                end
            end

            if marcato and not soulVoice then
                brdJAMult = 1.5
            elseif soulVoice then
                brdJAMult = 2
            else 
                brdJAMult = 1
            end

            if hasteSamba then
                membersHasteSamba[id] = true
            else
                membersHasteSamba[id] = false
            end
        end
    end
end

ashita.events.register('packet_in', 'j-haste_packet_cb', function(e)
    if (packetsIncoming[e.id]) then
        packetsIncoming[e.id](e);
    end
end);

local metaProps = {
    dwNeeded   = { get = getDwNeeded },
    maNeeded   = { get = getMANeeded },
    totalHaste = { get = getTotalHaste },
    magicHaste = { get = getMaHaste },
    jobHaste   = { get = getJaHaste },
    gearHaste  = { set = setGearHaste },
    brdBonus   = { get = getBrdBonus, set = setBrdBonus },
    geoBonus   = { get = getGeoBonus, set = setGeoBonus },
    onChange   = hasteChange, -- not a get/set, direct reference
}

-- Proxy object


setmetatable(proxy, {
    __index = function(_, key)
        local prop = metaProps[key]
        if type(prop) == 'table' and prop.get then
            return prop.get()
        end
        return prop -- direct values like `onChange`
    end,
    __newindex = function(_, key, value)
        local prop = metaProps[key]
        if type(prop) == 'table' and prop.set then
            return prop.set(value)
        end
    end
})

return proxy