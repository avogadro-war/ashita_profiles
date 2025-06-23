local profile = {};
local gcinclude = require('common/gcinclude');
local JHaste = require('common/J-Haste')

local sets = {
    Idle = {
        Ammo = 'Staunch Tathlum +1',
        Head = 'Nyame Helm',
        Neck = 'Warder\'s Charm +1',
        Ear1 = 'Hearty Earring',
        Ear2 = 'Eabani Earring',
        Body = 'Nyame Mail',
        Hands = 'Nyame Gauntlets',
        Ring1 = 'Shneddick Ring',
        Ring2 = 'Chirich Ring +1',
        Back = { Name = 'Smertrios\'s Mantle', Augment = { [1] = 'Damage taken-5%', [2] = 'Accuracy+30', [3] = 'Attack+20', [4] = '"Store TP"+10', [5] = 'DEX+20' } },
        Waist = 'Plat. Mog. Belt',
        Legs = 'Nyame Flanchard',
        Feet = 'Nyame Sollerets',
    },
    Resting = {},
    Idle_Regen = {
        Head = 'Crepuscular Helm',
        Neck = 'Bathy Choker +1',
        Ear1 = 'Infused Earring',
        Body = 'Hiza. Haramaki +2',
        Hands = 'Rao Kote',
        Ring2 = 'Chirich Ring +1',
    },
    Idle_Refresh = {},
    Town = {
    },

    Dt = {
        Ammo = 'Staunch Tathlum',--3
        Head = 'Nyame Helm',--7
        Neck = { Name = 'Loricate Torque +1', AugPath='A' },--6
        Ear1 = { Name = 'Odnowa Earring +1', AugPath='A' },--1
        Ear2 = 'Schere Earring',
        Body = 'Mpaca\'s Doublet',
        Hands = 'Nyame Gauntlets',--7
        Ring1 = 'Defending Ring',--10
        Ring2 = { Name = 'Gelatinous Ring +1', AugPath='A' },--7
        Back = { Name = 'Smertrios\'s Mantle', Augment = { [1] = 'Damage taken-5%', [2] = 'Accuracy+30', [3] = 'Attack+20', [4] = '"Store TP"+10', [5] = 'DEX+20' } },
        Waist = 'Ioskeha Belt +1',
        Legs = 'Nyame Flanchard',--8
        Feet = 'Nyame Sollerets',--7
    },

    Tp_Default = {
        Ammo = 'Coiste Bodhar',
        Head = 'Kasuga Kabuto +3',
        Neck = { Name = 'Sam. Nodowa +2', AugPath='A' },
        Ear1 = 'Telos Earring',
        Ear2 = 'Kasuga Earring +1',
        Body = 'Kasuga Domaru +3',
        Hands = 'Tatena. Gote +1',--'Wakido Kote +4', 
        Ring1 = 'Petrov Ring',
        Ring2 = 'Chirich Ring +1',
        Back = { Name = 'Smertrios\'s Mantle', Augment = { [1] = 'Phys. dmg. taken -10%', [2] = 'Accuracy+20', [3] = 'Attack+20', [4] = '"Store TP"+10', [5] = 'DEX+30' } },
        Waist = 'Sweordfaetels +1',
        Legs = 'Kasuga Haidate +3',
        Feet = 'Ryuo Sune-Ate +1', 
    },
    Tp_Hybrid = {
        Head = 'Mpaca\'s Cap',
        Body = 'Mpaca\'s Doublet',
        Hands = 'Mpaca\'s Gloves',
        Legs = 'Mpaca\'s Hose',
        Feet = 'Mpaca\'s Boots', 
    },
    Tp_Acc = {
        Ear1 = 'Mache Earring +1',
        Hands = 'Tatena. Gote +1',
        Ring1 = 'Cacoethic Ring +1',
        Ring2 = 'Chirich Ring +1',
        Waist = 'Ioskeha Belt +1',
        Feet = 'Tatena. Sune. +1',
    },
    Lockstyle = {
        Main = 'Tenkomaru',
        Head = 'Cait Sith Cap +1',
        Body = 'Haubergeon',
        Hands = 'Bandomusha Kote',
        Legs = 'Jokushu Haidate',
        Feet = 'Shinobi Kyahan',
    },
    Lockstyle2 = {
        Main = 'Delphinius',
        Head = 'Cait Sith Cap +1',
        Body = 'Kasuga Domaru +3',
        Hands = 'Tatena. Gote +1',
        Legs = 'Kasuga Haidate +3',
        Feet = 'Tatena. Sune. +1',
    },
    Tp_Proc = { -- a set to force low dmg for things like Vagary
        Ammo = { Name = 'Coiste Bodhar', AugPath='A' },
        Head = 'Flam. Zucchetto +2',
        Neck = { Name = 'Sam. Nodowa +1', AugPath='A' },
        Ear1 = 'Telos Earring',
        Ear2 = 'Schere Earring',
        Body = 'Kasuga Domaru +3',
        Hands = 'Flam. Manopolas +2',
        Ring1 = 'Petrov Ring',
        Ring2 = 'Karieyh Ring +1',
        Back = { Name = 'Smertrios\'s Mantle', Augment = { [1] = 'Damage taken-5%', [2] = 'Accuracy+30', [3] = 'Attack+20', [4] = '"Store TP"+10', [5] = 'DEX+20' } },
        Waist = 'Ioskeha Belt +1',
        Legs = { Name = 'Tatena. Haidate +1', AugPath='A' },
        Feet = 'Flam. Gambieras +2',
    },
    Phalanx = {
        Head = 'Valorous Mask',
        Body = 'Valorous Mail',
    },
    HPSet = {
        Ammo = 'Staunch Tathlum +1',
        Head = 'Kasuga Kabuto +3',
        Neck = { Name = 'Unmoving Collar +1', AugPath='A' },
        Ear1 = 'Telos Earring',
        Ear2 = 'Tuisto Earring',
        Body = 'Kasuga Domaru +3',
        Hands = 'Wakido Kote +3',
        Ring1 = { Name = 'Gelatinous Ring +1', AugPath='A' },
        Ring2 = 'Chirich Ring +1',
        Back = { Name = 'Smertrios\'s Mantle', Augment = { [1] = 'Phys. dmg. taken -10%', [2] = 'Accuracy+20', [3] = 'Attack+20', [4] = '"Store TP"+10', [5] = 'DEX+30' } },
        Waist = 'Plat. Mog. Belt',
        Legs = 'Kasuga Haidate +3',
        Feet = 'Ryuo Sune-Ate +1',
    },
    Doji = {
        Main = 'Dojikiri Yasutsuna',
        Sub = 'Utu Grip',
    },
    Masa = {
        Main = 'Masamune',
        Sub = 'Utu Grip',
    },
    Pole = {
        Main = 'Shining One',
        Sub = 'Utu Grip',
    },
    Prime = {
        Main = 'Kusanagi',
        Sub = 'Utu Grip'
    },
    Khonsu = {
        Sub = 'Khonsu',
    },

    Precast = {
        Ammo = 'Sapience Orb',
        Neck = 'Voltsurge Torque',
        Ear1 = 'Etiolation Earring',
        Ear2 = 'Loquac. Earring',
        Hands = 'Leyline Gloves',
        Ring2 = 'Prolix Ring',
    },


    Cure = {
    },

    Enhancing = {
    },

    Preshot = {
        Ring1 = 'Crepuscular Ring',
    },
    Midshot = {
        Ear1 = 'Telos Earring',
        Ear2 = 'Crep. Earring',
    },

    Ws_Default = {
        Ammo = 'Knobkierrie',
        Head = 'Mpaca\'s Cap',
        Neck = { Name = 'Sam. Nodowa +2', AugPath='A' },
        Ear1 = 'Thrud Earring',
        Ear2 = 'Kasuga Earring +1',
        Body = 'Sakonji Domaru +3',
        Hands = 'Kasuga Kote +3',
        Ring1 = 'Ephramad\'s Ring',
        Ring2 = 'Sroda Ring',
        Back = { Name = 'Smertrios\'s Mantle', Augment = { [1] = 'Phys. dmg. taken -10%', [2] = 'STR+30', [3] = 'Accuracy+20', [4] = 'Attack+20', [5] = 'Weapon skill damage +10%' } },
        Waist = { Name = 'Sailfi Belt +1', AugPath='A' },
        Legs = 'Nyame Flanchard',
        Feet = 'Nyame Sollerets',
    },
    Ws_Hybrid = {
        Body = 'Nyame Mail',
        Hands = 'Nyame Gauntlets',
        Legs = 'Nyame Flanchard',

        Feet = 'Nyame Sollerets',
    },
    Ws_Acc = {
    },
    Ws_Proc = { -- a set to force low dmg for things like Vagary
        Ammo = 'Staunch Tathlum',
        Head = 'Flam. Zucchetto +2',
        Neck = { Name = 'Loricate Torque +1', AugPath='A' },
        Ear1 = 'Telos Earring',
        Ear2 = 'Cessance Earring',
        Body = 'Kasuga Domaru +3',
        Hands = 'Wakido Kote +3',
        Ring1 = 'Defending Ring',
        Ring2 = 'Beithir Ring',
        Back = 'Solemnity Cape',
        Waist = 'Flume Belt +1',
        Legs = 'Mpaca\'s Hose',
        Feet = 'Flam. Gambieras +2',
    },

    Savage_Default = {
        Ammo = 'Knobkierrie',
        Head = 'Mpaca\'s Cap',
        Neck = 'Fotia Gorget',
        Ear1 = 'Schere Earring',
        Ear2 = 'Telos Earring',
        Body = { Name = 'Sakonji Domaru +3', AugTrial=5483 },
        Hands = 'Kasuga Kote +3',
        Ring1 = 'Beithir Ring',
        Ring2 = 'Karieyh Ring +1',
        Back = { Name = 'Smertrios\'s Mantle', Augment = { [1] = 'STR+30', [2] = 'Weapon skill damage +10%', [3] = 'Attack+20', [4] = 'Accuracy+20' } },
        Waist = { Name = 'Sailfi Belt +1', AugPath='A' },
        Legs = 'Mpaca\'s Hose',
        Feet = 'Valorous Greaves',
    },
    Savage_Hybrid = {
        Body = 'Nyame Mail',
        Legs = 'Nyame Flanchard',
        Feet = 'Nyame Sollerets',
    },
    Savage_Acc = {},

    Jinpu_Default = {
        Ammo = 'Knobkierrie',
        Head = 'Nyame Helm',
        Neck = 'Fotia Gorget',
        Ear1 = 'Friomisi Earring',
        Ear2 = 'Kasuga Earring +1',
        Body = 'Nyame Mail',
        Hands = 'Nyame Gauntlets',
        Ring2 = 'Ephramad\'s Ring',
        Ring1 = 'Metamor. Ring +1',
        Back = { Name = 'Smertrios\'s Mantle', Augment = { [1] = 'Phys. dmg. taken -10%', [2] = 'STR+30', [3] = 'Accuracy+20', [4] = 'Attack+20', [5] = 'Weapon skill damage +10%' } },
        Waist = 'Fotia Belt',
        Legs = 'Nyame Flanchard',
        Feet = 'Nyame Sollerets',
    },
    Jinpu_Hybrid = {
        Body = 'Nyame Mail',
        Legs = 'Nyame Flanchard',
        Feet = 'Nyame Sollerets',
    },
    Jinpu_Acc = {},

    Ageha_Default = {
        Ammo = 'Pemphredo Tathlum',
        Head = 'Kasuga Kabbuto +3',
        Neck = 'Sanctity Necklace',
        Ear1 = 'Crep. Earring',
        Ear2 = 'Kasuga Earring +1',
        Body = 'Kasuga Domaru +3',
        Hands = 'Kasuga Kote +3',
        Ring1 = 'Stikini Ring +1',
        Ring2 = { Name = 'Metamor. Ring +1', AugPath='A' },
        Back = { Name = 'Smertrios\'s Mantle', Augment = { [1] = 'STR+30', [2] = 'Weapon skill damage +10%', [3] = 'Attack+20', [4] = 'Accuracy+20' } },
        Waist = 'Eschan Stone',
        Legs = 'Kasuga Haidate +3',
        Feet = 'Kasuga Sune-Ate +2',
    },
    Ageha_Hybrid = {
        Body = 'Nyame Mail',
        Legs = 'Nyame Flanchard',
        Feet = 'Nyame Sollerets',
    },
    Ageha_Acc = {},

    Stardiver_Default = {
        Ammo = 'Knobkierrie',
        Head = 'Mpaca\'s Cap',
        Neck = { Name = 'Sam. Nodowa +1', AugPath='A' },
        Ear1 = 'Thrud Earring',
        Ear2 = 'Schere Earring',
        Body = { Name = 'Sakonji Domaru +3', AugTrial=5483 },
        Hands = 'Mpaca\'s Gloves',
        Ring1 = 'Beithir Ring',
        Ring2 = 'Karieyh Ring +1',
        Back = { Name = 'Smertrios\'s Mantle', Augment = { [1] = 'STR+30', [2] = 'Weapon skill damage +10%', [3] = 'Attack+20', [4] = 'Accuracy+20' } },
        Waist = 'Fotia Belt',    
        Legs = 'Mpaca\'s Hose',
        Feet = 'Valorous Greaves',
    },
    Stardiver_Hybrid = {
        Body = 'Nyame Mail',
        Legs = 'Nyame Flanchard',
        Feet = 'Nyame Sollerets',
    },
    Stardiver_Acc = {},

    HassoGloves = {
        Hands = 'Wakido Kote +4',
    },

    ThirdEye = {
        Legs = 'Sakonji Haidate +1',
    },
    Seigan = {
        Head = 'Kasuga Kabuto +3',
    },
    Sekkanoki = {
        Hands = 'Kasuga Kote +3',
    },
    Sengikori = {
        Feet = 'Kas. Sune-Ate +2',
    },
    Meditate = {
        Head = 'Wakido Kabuto +3',
        Hands = 'Sakonji Kote +3',
    },
    Meikyo = {
        Feet = 'Sakonji Sune-Ate',
    },
    Enmity = {
        Neck = { Name = 'Unmoving Collar +1', AugPath='A' },
        Ear1 = 'Cryptic Earring',
        Ring1 = 'Petrov Ring',
    },

    TH = {
        Ammo = 'Per. Lucky Egg',
		Waist = 'Chaac Belt',
	},
    Movement = {
        Feet = 'Danzo Sune-Ate',
	},
    ['wscape'] = {
        Main = 'Shining One',
        Sub = 'Khonsu',
        Ammo = 'Staunch Tathlum +1',
        Head = { Name = 'Nyame Helm', AugPath='B' },
        Neck = 'Bathy Choker +1',
        Ear1 = 'Hearty Earring',
        Ear2 = 'Eabani Earring',
        Body = { Name = 'Nyame Mail', AugPath='B' },
        Hands = { Name = 'Nyame Gauntlets', AugPath='B' },
        Ring1 = 'Shneddick Ring',
        Ring2 = 'Warp Ring',
        Back = { Name = 'Smertrios\'s Mantle', Augment = { [1] = 'Phys. dmg. taken -10%', [2] = 'STR+30', [3] = 'Accuracy+20', [4] = 'Attack+20', [5] = 'Weapon skill damage +10%' } },
        Waist = 'Carrier\'s Sash',
        Legs = { Name = 'Nyame Flanchard', AugPath='B' },
        Feet = { Name = 'Nyame Sollerets', AugPath='B' },
    },
    ['phalanx'] = {
        Main = { Name = 'Shirodachi', AugTrial=647 },
        Sub = 'Khonsu',
        Ammo = 'Staunch Tathlum +1',
        Head = { Name = 'Valorous Mask', Augment = { [1] = '"Mag. Atk. Bns."+9', [2] = 'Mag. Acc.+9', [3] = 'Accuracy+23', [4] = 'Phalanx +3', [5] = 'Attack+20', [6] = 'Weapon skill damage +3%' } },
        Neck = { Name = 'Loricate Torque +1', AugPath='A' },
        Ear1 = 'Hearty Earring',
        Ear2 = 'Eabani Earring',
        Body = { Name = 'Valorous Mail', Augment = { [1] = '"Repair" potency +1%', [2] = 'Pet: INT+10', [3] = 'Accuracy+3', [4] = 'Phalanx +4', [5] = 'Attack+3' } },
        Hands = { Name = 'Nyame Gauntlets', AugPath='B' },
        Ring1 = 'Shneddick Ring',
        Ring2 = 'Chirich Ring +1',
        Back = { Name = 'Smertrios\'s Mantle', Augment = { [1] = 'Phys. dmg. taken -10%', [2] = 'Accuracy+20', [3] = 'Attack+20', [4] = '"Store TP"+10', [5] = 'DEX+30' } },
        Waist = { Name = 'Sailfi Belt +1', AugPath='A' },
        Legs = { Name = 'Nyame Flanchard', AugPath='B' },
        Feet = { Name = 'Nyame Sollerets', AugPath='B' },
    },
    ['hpsetbig'] = {
        Main = { Name = 'Dojikiri Yasutsuna', AugPath='A' },
        Sub = 'Khonsu',
        Ammo = 'Staunch Tathlum +1',
        Head = 'Kasuga Kabuto +3',
        Neck = { Name = 'Unmoving Collar +1', AugPath='A' },
        Ear1 = 'Odnowa Earring +1',
        Ear2 = 'Tuisto Earring',
        Body = 'Kasuga Domaru +3',
        Hands = 'Wakido Kote +3',
        Ring1 = { Name = 'Gelatinous Ring +1', AugPath='A' },
        Ring2 = 'Eihwaz Ring',
        Back = { Name = 'Smertrios\'s Mantle', Augment = { [1] = 'Phys. dmg. taken -10%', [2] = 'Accuracy+20', [3] = 'Attack+20', [4] = '"Store TP"+10', [5] = 'DEX+30' } },
        Waist = 'Plat. Mog. Belt',
        Legs = 'Kasuga Haidate +3',
        Feet = { Name = 'Mpaca\'s Boots', AugPath='A' },
    },
    ['bighp'] = {
        Main = { Name = 'Dojikiri Yasutsuna', AugPath='A' },
        Sub = 'Khonsu',
        Ammo = 'Staunch Tathlum +1',
        Head = 'Kasuga Kabuto +3',
        Neck = { Name = 'Unmoving Collar +1', AugPath='A' },
        Ear1 = 'Tuisto Earring',
        Ear2 = 'Odnowa Earring +1',
        Body = 'Kasuga Domaru +3',
        Hands = 'Wakido Kote +3',
        Ring1 = { Name = 'Gelatinous Ring +1', AugPath='A' },
        Ring2 = 'Chirich Ring +1',
        Back = { Name = 'Smertrios\'s Mantle', Augment = { [1] = 'Phys. dmg. taken -10%', [2] = 'Accuracy+20', [3] = 'Attack+20', [4] = '"Store TP"+10', [5] = 'DEX+30' } },
        Waist = 'Plat. Mog. Belt',
        Legs = 'Kasuga Haidate +3',
        Feet = 'Kas. Sune-Ate +2',
    },
};
profile.Sets = sets;

profile.Packer = {
    {Name = 'Red Curry Bun', Quantity = 'all'},
};

profile.OnLoad = function()
	gSettings.AllowAddSet = true;
    gcinclude.Initialize();

    AshitaCore:GetChatManager():QueueCommand(1, '/macro book 4');
    AshitaCore:GetChatManager():QueueCommand(1, '/macro set 8');
end

profile.OnUnload = function()
    if gcinclude and gcinclude.Unload then gcinclude.Unload() end
    package.loaded['common/gcinclude'] = nil
    package.loaded['common/gcdisplay'] = nil
    package.loaded['common/J-Haste'] = nil
end

profile.HandleCommand = function(args)
    gcinclude.HandleCommands(args);
end

profile.Hachirin = function(element)
    local buff = {
        Fire    = { single = gData.GetBuffCount(178), double = gData.GetBuffCount(589) },
        Ice     = { single = gData.GetBuffCount(179), double = gData.GetBuffCount(590) },
        Wind    = { single = gData.GetBuffCount(180), double = gData.GetBuffCount(591) },
        Earth   = { single = gData.GetBuffCount(181), double = gData.GetBuffCount(592) },
        Thunder = { single = gData.GetBuffCount(182), double = gData.GetBuffCount(593) },
        Water   = { single = gData.GetBuffCount(183), double = gData.GetBuffCount(594) },
        Light   = { single = gData.GetBuffCount(184), double = gData.GetBuffCount(595) },
        Dark    = { single = gData.GetBuffCount(185), double = gData.GetBuffCount(596) },
    }

    local weakness = {
        Fire    = 'Water',
        Ice     = 'Fire',
        Wind    = 'Ice',
        Earth   = 'Wind',
        Thunder = 'Earth',
        Water   = 'Thunder',
        Light   = 'Dark',
        Dark    = 'Light',
    }

    local weather = gData.GetEnvironment()
    local b = buff[element]
    local weak = weakness[element]

    if not b then 
        return 
    end

    -- Check for double weather or storm
    if (weather.WeatherElement == element .. ' x2' or b.double == 1)
    -- Check for single weather or storm, and weak day isn't active
    or ((weather.WeatherElement == element or b.single == 1) and weather.DayElement ~= weak and (buff[weak].single ~= 1 and buff[weak].double ~= 1))
    -- Check for matching day, and opposing weather isn't active
    or (weather.DayElement == element and weather.WeatherElement ~= weak and weather.WeatherElement ~= weak .. ' x2') then
        gFunc.Equip('Waist', 'Hachirin-no-Obi');
    end
end

profile.HandleDefault = function()
    if gcinclude.phalanxSet == true then
        gFunc.EquipSet(sets.PhalanxSet);
    else
        gFunc.EquipSet(sets.Idle);
    end
    local thirdeye = gData.GetBuffCount('Third Eye');
    local seigan = gData.GetBuffCount('Seigan');
	local player = gData.GetPlayer();
    local equipment = gData.GetEquipment();
    local legsEquip = equipment.Legs and equipment.Legs.Name or ''
    local handsEquip = equipment.Hands and equipment.Hands.Name or ''

    if (player.Status == 'Engaged') then
        gFunc.EquipSet(sets.Tp_Default);
        if (gcdisplay.GetCycle('MeleeSet') ~= 'Default') then
            gFunc.EquipSet('Tp_' .. gcdisplay.GetCycle('MeleeSet')) end
        if gcdisplay.GetToggle('AutoHasso') == true then
            local maHaste = JHaste.magicHaste
            if maHaste <= (389) then
                local hasso = gData.GetBuffCount('Hasso')
                if hasso > 0 then
                    gFunc.EquipSet(sets.HassoGloves);
                end
            end
        end        
        if (thirdeye >= 1) and (seigan >= 1) then 
            gFunc.EquipSet(sets.ThirdEye);
        elseif (seigan >= 1) then
            gFunc.EquipSet(sets.Seigan);
        end
		if (gcdisplay.GetToggle('TH') == true) then gFunc.EquipSet(sets.TH) end
        if (gcdisplay.GetToggle('PROC') == true) then
            gFunc.EquipSet(sets.Tp_Proc); 
        end
        if gcinclude.settings.HPSet == true then
            gFunc.EquipSet(sets.HPSet)
        end
    elseif (player.Status == 'Resting') then
        gFunc.EquipSet(sets.Resting);
    end
    --melee wep
    local mwTable = {
        Doji  = 'Doji',
        Masa  = 'Masa',
        Pole  = 'Pole',
        Prime = 'Kusanagi',
    }

    local choice = mwTable[gcdisplay.GetCycle('MWep')]
    if choice and sets[choice] then
        gFunc.EquipSet(sets[choice])
    end
	
    gcinclude.CheckDefault ();
    if (gcdisplay.GetToggle('DTset') == true) then gFunc.EquipSet(sets.Dt) end;
    if (gcdisplay.GetToggle('Kite') == true) then gFunc.EquipSet(sets.Movement) end;
end

profile.HandleAbility = function()
    local ability = gData.GetAction()
    local name    = ability.Name

    ----------------------------------------------------------------
    -- map: Lua pattern → set key
    ----------------------------------------------------------------
    local abTable = {
        ['^Provoke$']      = 'Enmity',
        ['Meditate']       = 'Meditate',
        ['Third Eye']      = 'ThirdEye',
        ['Sengikori']      = 'Sengikori',
        ['Meikyo']         = 'Meikyo',
    }

    for patt, setKey in pairs(abTable) do
        if name:match(patt) then
            gFunc.EquipSet(sets[setKey])
            break
        end
    end

    gcinclude.CheckCancels()
end

profile.HandleItem = function()
    local item = gData.GetAction();

	if string.match(item.Name, 'Holy Water') then gFunc.EquipSet(gcinclude.sets.Holy_Water) end
end

profile.HandlePrecast = function()
    local spell = gData.GetAction();
    gFunc.EquipSet(sets.Precast);

    gcinclude.CheckCancels();
end

profile.HandleMidcast = function()
    local spell = gData.GetAction();

    if (spell.Skill == 'Enhancing Magic') then
        gFunc.EquipSet(sets.Enhancing);
    elseif (spell.Skill == 'Healing Magic') then
        gFunc.EquipSet(sets.Cure);
    end
	if (gcdisplay.GetToggle('TH') == true) then gFunc.EquipSet(sets.TH) end
end

profile.HandlePreshot = function()
    gFunc.EquipSet(sets.Preshot);
end

profile.HandleMidshot = function()
    gFunc.EquipSet(sets.Midshot);
	if (gcdisplay.GetToggle('TH') == true) then gFunc.EquipSet(sets.TH) end
end

profile.HandleWeaponskill = function()
    local meikyo    = gData.GetBuffCount('Meikyo Shisui')
    local sekkanoki = gData.GetBuffCount('Sekkanoki')

    -- bail‑out / proc mode checks -----------------------------
    if not gcinclude.CheckWsBailout() then
        gFunc.CancelAction()
        return
    elseif gcdisplay.GetToggle('PROC') then
        gFunc.EquipSet(sets.Ws_Proc)
        return
    end

    local player    = gData.GetPlayer()
    local ws        = gData.GetAction()
    local wsName    = ws.Name
    local meleeSet  = gcdisplay.GetCycle('MeleeSet')

    -- always start from generic WS base -----------------------
    gFunc.EquipSet(sets.Ws_Default)
    if meleeSet ~= 'Default' then
        gFunc.EquipSet('Ws_' .. meleeSet)
    end
    if player.TP == 3000 then
        gFunc.Equip('Head', 'Nyame Helm');
        gFunc.Equip('Ear2', 'Kasuga Earring +1');
    end


    ----------------------------------------------------------------
    -- table:   exact‑string match → { key = baseName, element = … }
    ----------------------------------------------------------------
    local wsTable = {
        ['Savage Blade']  = { key = 'Savage' },
        ['Tachi: Jinpu']  = { key = 'Jinpu',    element = 'Wind' },
        ['Tachi: Ageha']  = { key = 'Ageha' },
        ['Stardiver']     = { key = 'Stardiver' },
    }

    local entry = wsTable[wsName]
    if entry then
        -- main WS gear
        gFunc.EquipSet(sets[entry.key .. '_Default'])
        if meleeSet ~= 'Default' and sets[entry.key .. '_' .. meleeSet] then
            gFunc.EquipSet(entry.key .. '_' .. meleeSet)
        end
        -- optional Hachirin element
        if entry.element then
            profile.Hachirin(entry.element)
        end
    end

    -- situational add‑ons -------------------------------------
    if meikyo    > 0 then gFunc.EquipSet(sets.Meikyo)    end
    if sekkanoki > 0 then gFunc.EquipSet(sets.Sekkanoki) end
    if gcinclude.settings.HPSet then
        gFunc.EquipSet(sets.HPSet)
    end
end

return profile;
