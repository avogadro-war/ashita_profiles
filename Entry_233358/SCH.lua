local profile = {};
gcinclude = gFunc.LoadFile('common\\gcinclude.lua');

local sets = {
    Idle = {
        Main = 'Mpaca\'s Staff',
        Sub = 'Khonsu',
        Ammo = 'Staunch Tathlum +1',
        Head = 'Arbatel Bonnet +3',
        Neck = 'Warder\'s Charm +1',
        Ear1 = 'Eabani Earring',
        Ear2 = 'Hearty Earring',
        Body = 'Arbatel Gown +3',
        Hands = 'Nyame Gauntlets',
        Ring1 = 'Shadow Ring',
        Ring2 = 'Shneddick Ring',
        Back = 'Lugh\'s Cape',
        Waist = 'Plat. Mog. Belt',
        Legs = 'Arbatel Pants +3',
        Feet = 'Nyame Sollerets',
    },
    lockstyle = {
        Main = 'Musa',
        Head = 'Ahriman Cap',
        Body = 'Goblin Suit',
    },
    Empyrean = {
        Main = 'Musa',
        Head = 'Arbatel Bonnet +3',
        Body = 'Arbatel Gown +3',
        Hands = 'Arbatel Bracers +3',
        Legs = 'Arbatel Pants +3',
        Feet = 'Arbatel Loafers +3',
    },   
    Resting = {},
    Idle_Regen = {
        Main = 'Mpaca\'s Staff',
        Sub = 'Khonsu',
        Ammo = 'Staunch Tathlum +1',
        Head = 'Arbatel Bonnet +3',
        Neck = 'Bathy Choker +1',
        Ear1 = 'Eabani Earring',
        Ear2 = 'Hearty Earring',
        Body = 'Arbatel Gown +3',
        Hands = 'Nyame Gauntlets',
        Ring1 = 'Shadow Ring',
        Ring2 = 'Shneddick Ring',
        Back = 'Lugh\'s Cape',
        Waist = 'Plat. Mog. Belt',
        Legs = 'Arbatel Pants +3',
        Feet = 'Nyame Sollerets',
    },
    Idle_Refresh = {
        Main = 'Mpaca\'s Staff',
        Sub = 'Khonsu',
        Ammo = 'Staunch Tathlum +1',
        Head = 'Arbatel Bonnet +3',
        Neck = 'Loricate Torque +1',
        Ear1 = 'Eabani Earring',
        Ear2 = 'Hearty Earring',
        Body = 'Arbatel Gown +3',
        Hands = 'Nyame Gauntlets',
        Ring1 = 'Shadow Ring',
        Ring2 = 'Shneddick Ring',
        Back = 'Lugh\'s Cape',
        Waist = 'Plat. Mog. Belt',
        Legs = 'Arbatel Pants +3',
        Feet = 'Nyame Sollerets',
    },

    Dt = {
        Ammo = 'Staunch Tathlum',
        Head = 'Nyame Helm',
        Neck = 'Loricate Torque +1',
        Ear1 = 'Odnowa Earring +1',
        Ear2 = 'Etiolation Earring',
        Body = 'Agwu\'s Robe',
        Hands = 'Nyame Gauntlets',
        Ring1 = 'Defending Ring',
        Ring2 = 'Gelatinous Ring +1',
        Back = 'Lugh\'s Cape',
        Waist = 'Gishdubar Sash',
        Legs = 'Nyame Flanchard',
        Feet = 'Nyame Sollerets',
    },

    Tp_Default = {
        Ammo = 'Oshasha\'s Treatise',
        Head = { Name = 'Nyame Helm', AugPath='B' },
        Neck = 'Sanctity Necklace',
        Ear1 = 'Telos Earring',
        Ear2 = 'Cessance Earring',
        Body = { Name = 'Nyame Mail', AugPath='B' },
        Hands = { Name = 'Nyame Gauntlets', AugPath='B' },
        Ring1 = 'Chirich Ring +1',
        Ring2 = 'Ephramad\'s Ring',
        Back = { Name = 'Lugh\'s Cape', Augment = { [1] = 'Phys. dmg. taken -10%', [2] = '"Mag. Atk. Bns."+10', [3] = 'Mag. Acc.+20', [4] = 'INT+30', [5] = 'Magic Damage+20' } },
        Waist = 'Eschan Stone',
        Legs = { Name = 'Nyame Flanchard', AugPath='B' },
        Feet = { Name = 'Nyame Sollerets', AugPath='B' },
    },
    Tp_Hybrid = {
    },
    Tp_Acc = {
        Ring1 = 'Cacoethic Ring +1',
        Ring2 = 'Chirich Ring +1',
    },
    Precast_Grimoire = {
        Head = 'Peda. M.Board +3',
        Feet = 'Acad. Loafers +3',
    },

    Precast = {
        Main = 'Musa', --10
        Sub = 'Khonsu',
        Ammo = 'Incantor Stone', --2
        Ear1 = 'Etiolation Earring', --1
        Head = 'Acad. Mortar. +2', --7
        Back = { Name = 'Lugh\'s Cape', Augment = { [1] = '"Fast Cast"+10', [2] = 'HP+60' } },
        Neck = 'Voltsurge Torque', --4
        Body = 'Pinga Tunic', --13
        Hands = 'Acad. Bracers +3', --9
        Ring1 = 'Kishar Ring', --4
        Waist = 'Embla Sash', --5
        Legs = 'Agwu\'s Slops', --7
        Feet = 'Peda. Loafers +3', --8
    },
    Cure_Precast = {
        Ear1 = 'Mendi. Earring',
        Feet = 'Vanya Clogs',
    },
    Enhancing_Precast = {
        Waist = 'Siegel Sash',
    },
    Stoneskin_Precast = {
        Head = 'Umuthi Hat',
        Hands = 'Carapacho Cuffs',
        Waist = 'Siegel Sash',
    },

    CureNuke = {
    Main = 'Wizard\'s Rod',
    Sub = 'Culminus',
    Ammo = 'Ghastly Tathlum +1',
    Head = 'Arbatel Bonnet +3',
    Neck = 'Argute Stole +2',
    Ear1 = 'Friomisi Earring',
    Ear2 = 'Arbatel Earring',
    Body = 'Arbatel Gown +3',
    Hands = 'Arbatel Bracers +3',
    Ring1 = 'Mallquis Ring',
    Ring2 = 'Metamor. Ring +1',
    Back = { Name = 'Lugh\'s Cape', Augment = { [1] = 'Phys. dmg. taken -10%', [2] = '"Mag. Atk. Bns."+10', [3] = 'Mag. Acc.+20', [4] = 'INT+30', [5] = 'Magic Damage+20' } },
    Waist = 'Skyrmir Cord',
    Legs = 'Arbatel Pants +3',
    Feet = 'Arbatel Loafers +3',
    },


    Cure = {--I cap is 50, II cap is 30
        Main = 'Musa',
        Sub = 'Khonsu',
        Ammo = 'Pemphredo Tathlum',
        Neck = 'Nodens Gorget',--I 5
        Ear1 = 'Mendi. Earring',--I 5
        Ear2 = 'Regal Earring',
        Hands = 'Peda. Bracers +3',--II 2 and skill
        Ring1 = 'Lebeche Ring',
        Ring2 = { Name = 'Metamor. Ring +1', AugPath='A' },
        Legs = 'Acad. Pants +3',
        Back = 'Solemnity Cape',--I 7
        Waist = 'Acad. Pants +2',--11
        Feet = 'Vanya Clogs',--I 10
    },
    Self_Cure = {--cap 30
        Waist = 'Gishdubar Sash',
    },
    Regen = {
        Main = { Name = 'Musa', AugPath='C' },
        Sub = 'Khonsu',
        ring1 = 'Gelatinous Ring +1',
        ring2 = 'Defending Ring',
        Ammo = 'Pemphredo Tathlum',
        Head = 'Arbatel Bonnet +3',
        Neck = { Name = 'Loricate Torque +1', AugPath='A' },
        Ear1 = 'Eabani Earring',
        Ear2 = 'Magnetic Earring',
        Body = { Name = 'Telchine Chas.', Augment = '"Regen" potency+3' },
        Hands = 'Arbatel Bracers +3',
        Back = 'Bookworm\'s Cape',
        Waist = 'Embla Sash',
        Legs = { Name = 'Telchine Braconi', Augment = '"Regen" potency+3' },
        Feet = { Name = 'Telchine Pigaches', Augment = '"Regen" potency+3' },
    },
    Cursna = {
        Ring1 = 'Purity Ring',
        Hands = 'Peda. Bracers +3',
		Waist = 'Gishdubar Sash',
    },
    Self_Enhancing = {},
    Enhancing_skill = {
        Ear2 = 'Mimir Earring',
    },
    Enhancing_duration = {
        Main = { Name = 'Musa', AugPath='C' },
        Sub = 'Khonsu',
        Ammo = 'Pemphredo Tathlum',
        Head = { Name = 'Telchine Cap', Augment = 'Enh. Mag. eff. dur. +10' },
        Neck = { Name = 'Loricate Torque +1', AugPath='A' },
        Ear1 = 'Eabani Earring',
        Ear2 = 'Magnetic Earring',
        Body = 'Peda. Gown +3',
        Hands = 'Telchine Gloves',
        Back = { Name = 'Lugh\'s Cape', Augment = { [1] = 'Phys. dmg. taken -10%', [2] = '"Mag. Atk. Bns."+10', [3] = 'Mag. Acc.+20', [4] = 'INT+30', [5] = 'Magic Damage+20' } },
        Waist = 'Embla Sash',
        Legs = { Name = 'Telchine Braconi', Augment = 'Enh. Mag. eff. dur. +10' },
        Feet = { Name = 'Telchine Pigaches', Augment = 'Enh. Mag. eff. dur. +10' },
    },

    Stoneskin = {
        Neck = 'Nodens Gorget',
        Waist = 'Siegel Sash',
    },
    Phalanx = {},
    Refresh = {
		Waist = 'Gishdubar Sash',
    },
    Self_Refresh = {},
    subNIN = {
        Sub = 'Bunzi\'s Rod',
    },

    Enfeebling = {
        Main = 'Wizard\'s Rod',
        Sub = 'Culminus Shield',
        Ammo = 'Pemphredo Tathlum',
        Head = 'Arbatel Bonnet',
        Neck = 'Erra Pendant',
        Ear1 = 'Regal Earring',
        Ear2 = 'Malignance Earring',
        Body = 'Acad. Gown +2',
        Hands = 'Peda. Bracers +2',
        Ring1 = 'Stikini Ring +1',
        Ring2 = { Name = 'Metamor. Ring +1', AugPath='A' },
        Back = { Name = 'Aurist\'s Cape +1', AugPath='A' },
        Waist = { Name = 'Acuity Belt +1', AugPath='A' },
        Legs = 'Acad. Pants +2',
        Feet = 'Acad. Loafers +2',
    },

    Drain = {
        Main = 'Wizard\'s Rod',
        Sub = 'Ammurapi Shield',
        Ammo = 'Staunch Tathlum +1',
        Head = 'Pixie Hairpin +1',
        Neck = 'Erra Pendant',
        Ear1 = 'Hirudinea Earring',
        Ear2 = 'Mani Earring',
        Body = 'Acad. Gown +2',
        Hands = 'Nyame Gauntlets',
        Ring1 = 'Evanescence Ring',
        Ring2 = 'Archon Ring',
        Back = 'Aurist\'s Cape +1',
        Waist = 'Fucho-no-Obi',
        Legs = 'Pedagogy Pants +3',
        Feet = 'Agwu\'s Pigaches',
    },

    Nuke = {
        Main = 'Wizard\'s Rod',
        Sub = 'Culminus',
        Ammo = 'Ghastly Tathlum +1',
        Head = 'Arbatel Bonnet +3',
        Neck = 'Argute Stole +2',
        Ear1 = 'Friomisi Earring',
        Ear2 = 'Arbatel Earring',
        Body = 'Arbatel Gown +3',
        Hands = 'Arbatel Bracers +3',
        Ring1 = 'Mallquis Ring',
        Ring2 = 'Metamor. Ring +1',
        Back = { Name = 'Lugh\'s Cape', Augment = { [1] = 'Phys. dmg. taken -10%', [2] = '"Mag. Atk. Bns."+10', [3] = 'Mag. Acc.+20', [4] = 'INT+30', [5] = 'Magic Damage+20' } },
        Waist = 'Skyrmir Cord',
        Legs = 'Arbatel Pants +3',
        Feet = 'Arbatel Loafers +3',
    },
    NukeACC = {
        Neck = 'Argute Stole +1',
        Waist = { Name = 'Acuity Belt +1', AugPath='A' },
    },
    Burst = {
        Main = 'Wizard\'s Rod', -- 10 and 0
        Sub = 'Culminus',
        Ammo = 'Ghastly Tathlum +1',
        Head = 'Agwu\'s Cap', -- 0 and 4
        Neck = 'Argute Stole +2', -- 7 and 0
        Ear1 = 'Friomisi Earring',
        Ear2 = 'Arbatel Earring',
        Body = 'Arbatel Gown +3', -- 10 and 0
        Hands = 'Arbatel Bracers +3', -- 0 and 6
        Ring1 = 'Mujin Band', -- 0 and 5
        Ring2 = 'Metamor. Ring +1',
        Back = 'Lugh\'s Cape',
        Waist = 'Skrymir Cord',
        Legs = 'Arbatel Pants +3', -- 9 and 0
        Feet = 'Arbatel Loafers +3', -- 6 and 0
    },
    Helix = {
        Main = 'Wizard\'s Rod',
        Sub = 'Culminus',
        Ammo = 'Ghastly Tathlum +1',
        Head = 'Arbatel Bonnet +3',
        Neck = 'Argute Stole +2',                                               
        Ear1 = 'Friomisi Earring',
        Ear2 = 'Arbatel Earring',
        Body = 'Arbatel Gown +3',
        Hands = 'Arbatel Bracers +3',
        Ring1 = 'Mallquis Ring',    
        Ring2 = '',
        Back = 'Lugh\'s Cape',
        Waist = 'Skrymir Cord',
        Legs = 'Arbatel Pants +3',
        Feet = 'Arbatel Loafers +3',
    },
    HelixBurst = {
        Ring2 = 'Mujin Band',
        Hands = 'Agwu\'s Gages',
        Body = 'Agwu\'s Robe',
        Head = 'Agwu\'s Cap',
    },
    Storm = {
        Feet = 'Peda. Loafers +3',
    },
    Kaustra = {--need to refine this set
        Main = 'Marin Staff +1',
        Sub = 'Enki Strap',
        Ammo = 'Pemphredo Tathlum',
        Head = 'Pixie Hairpin +1',
        Neck = 'Argute Stole +1',
        Ear1 = 'Regal Earring',
        Ear2 = 'Arbatel Earring',
        Body = 'Seidr Cotehardie',
        Hands = 'Amalric Gages +1',
        Ring1 = 'Stikini Ring +1',--freke ring
        Ring2 = 'Archon Ring',
        Back = 'Lugh\'s Cape',
        Waist = { Name = 'Acuity Belt +1', AugPath='A' },
        Legs = 'Amalric Slops +1',
        Feet = 'Amalric Nails +1',
    },
    Mp_Body = {Body = 'Seidr Cotehardie',},

    Preshot = {
    },
    Midshot = {
        Ear1 = 'Telos Earring',
        Ear2 = 'Crep. Earring',
    },

    Ws_Default = {
        Head = 'Nyame Helm',
        Neck = 'Sanctity Necklace',
        Ear2 = 'Malignance Earring',
        Body = 'Nyame Mail',
        Hands = 'Nyame Gauntlets',
        Ring2 = 'Karieyh Ring +1',
        Waist = 'Eschan Stone',
        Legs = 'Nyame Flanchard',
        Feet = 'Nyame Sollerets',
    },
    Ws_Hybrid = {
    },
    Ws_Acc = {
    },
    Mykyr_Default = {
        Ammo = 'Ghastly Tathlum +1',
        Head = 'Pixie Hairpin +1',
        Neck = 'Sanctity Necklace',
        Ear1 = 'Mendi. Earring',
        Ear2 = 'Etiolation Earring',
        Body = 'Acad. Gown +2',
        Hands = 'Nyame Gauntlets',
        Ring1 = 'Sangoma Ring',
        Ring2 = 'Metamor. Ring +1',
        Back = 'Aurist\'s Cape +1',
        Waist = 'Shinjutsu-no-Obi +1',
        Legs = 'Amalric Slops +1',
        Feet = 'Arbatel Loafers +3',
    },
    Mykyr_Hybrid = {
    },
    Mykyr_Acc = {
    },
    Cataclysm_Default = {
        Ammo = 'Pemphredo Tathlum',
        Head = 'Pixie Hairpin +1',
        Neck = 'Sanctity Necklace',
        Ear1 = 'Malignance Earring',
        Ear2 = 'Crematio Earring',
        Body = 'Nyame Mail',
        Hands = 'Nyame Gauntlets',
        Ring1 = 'Shiva Ring +1',
        Ring2 = 'Karieyh Ring +1',
        Back = 'Lugh\'s Cape',
        Waist = 'Eschan Stone',
        Legs = 'Nyame Flanchard',
        Feet = 'Nyame Sollerets',
    },
    Cataclysm_Hybrid = {
    },
    Cataclysm_Acc = {
    },

    Sublimation = {
        Head = 'Acad. Mortar. +2',
        Body = 'Peda. Gown +3',
        Waist = 'Embla Sash',
    },
    Power = {--rapture/ebullience
        Head = 'Arbatel Bonnet +3',
	},
    Klimaform = {--klimaform dmg boost
        Feet = 'Arbatel Loafers +3',
	},
    TH = {
        Ammo = 'Per. Lucky Egg',
		Waist = 'Chaac Belt',
	},
    Aquaveil = {
        Main = 'Vadose Rod',
        Head = 'Chironic Hat',

    },
    Movement = {
        Ring2 = 'Shneddick Ring',
	},
    PenuryParsimony = {
        Legs = 'Arbatel Pants +3',
    },
    CelerityAlacrity = {
        Feet = 'Pedagogy Loafers +1',
    },
    RaptureEbullience = {
        Head = 'Arbatel Bonnet +3',
    },
    Altruism = { --worthless with obi
        Head = 'Peda. M',
    },
    Perpetuance = {
        Hands = 'Arbatel Bracers +3',
    },
    Immanence = {
        Head = 'Nyame Helm',
        Neck = 'Warder\'s Charm +1',
        Body = 'Nyame Mail',
        Hands = 'Arbatel Bracers +3',
    },
    Enlightenment  = {
        Body = 'Pedagogy Gown +1',
    },
    Tabula = {
        Legs = 'Pedagogy Pants +3',
    },
    VagarySC = {
        Main = 'remove',
        Sub = 'Genmei Shield',
        Ammo = 'Staunch Tathlum +1',
        Head = 'remove',
        Body = 'remove',
        Hands = 'remove',
        Feet = 'remove',
        Neck = { Name = 'Loricate Torque +1', AugPath='A' },
        Ear1 = 'Eabani Earring',
        Ear2 = 'Hearty Earring',
        Ring1 = 'Eihwaz Ring',
        Ring2 = { Name = 'Gelatinous Ring +1', AugPath='A' },
        Back = { Name = 'Lugh\'s Cape', Augment = { [1] = '"Fast Cast"+10', [2] = 'HP+60' } },
        Waist = 'Plat. Mog. Belt',
        Legs = 'Volte Hose',
    },
};

sets.Tp_Hybrid = sets.Tp_Hybrid or {};
sets.Tp_Acc = sets.Tp_Acc or {};
sets.Resting = sets.Resting or {};
sets.Self_Enhancing = sets.Self_Enhancing or {};
sets.Self_Refresh = sets.Self_Refresh or {};
sets.Ws_Hybrid = sets.Ws_Hybrid or {};
sets.Ws_Acc = sets.Ws_Acc or {};
sets.Mykyr_Hybrid = sets.Mykyr_Hybrid or {};
sets.Mykyr_Acc = sets.Mykyr_Acc or {};
sets.Cataclysm_Hybrid = sets.Cataclysm_Hybrid or {};
sets.Cataclysm_Acc = sets.Cataclysm_Acc or {};
sets.Phalanx = sets.Phalanx or {};
sets.Preshot = sets.Preshot or {};

profile.Sets = sets;

profile.Packer = {
    {Name = 'Tropical Crepe', Quantity = 'all'},
    {Name = 'Rolan. Daifuku', Quantity = 'all'},
};

profile.OnLoad = function()
	gSettings.AllowAddSet = true;
    gcinclude.Initialize();

    AshitaCore:GetChatManager():QueueCommand(1, '/macro book 8');
    AshitaCore:GetChatManager():QueueCommand(1, '/macro set 2');
end

profile.OnUnload = function()
    gcinclude.Unload();
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

    if (weather.WeatherElement == element .. ' x2' or b.double == 1)
    or ((weather.WeatherElement == element or b.single == 1) and weather.DayElement ~= weak and (buff[weak].single ~= 1 and buff[weak].double ~= 1))
    or (weather.DayElement == element and weather.WeatherElement ~= weak and weather.WeatherElement ~= weak .. ' x2') then
        gFunc.Equip('Waist', 'Hachirin-no-Obi');
    end
end

-------------------------------------------------------------------------------
-- Default handler ------------------------------------------------------------
-------------------------------------------------------------------------------

profile.HandleDefault = function()
    local player = gData.GetPlayer()
    local sub    = gData.GetBuffCount('Sublimation: Activated')
    local status = (player.Status or 'Idle'):lower()

    local function equipIfSetExists(set)
        if set and sets[set] then
            gFunc.EquipSet(sets[set])
        end
    end

    local function equipEngaged()
        gFunc.EquipSet(sets.Tp_Default)
        local meleeSet = gcdisplay.GetCycle('MeleeSet')
        equipIfSetExists('Tp_' .. meleeSet)
        if gcdisplay.GetToggle('TH') then gFunc.EquipSet(sets.TH) end
    end

    local statusSetMap = {
        engaged = equipEngaged,
        resting = function() gFunc.EquipSet(sets.Resting) end,
        idle    = function() gFunc.EquipSet(sets.Idle) end,
    }

    (statusSetMap[status] or statusSetMap.idle)()

    if sub > 0 then gFunc.EquipSet(sets.Sublimation) end

    gcinclude.CheckDefault()

    local togglesToSets = {
        DTset = sets.Dt,
        Kite  = sets.Movement,
    }

    for toggleName, gearSet in pairs(togglesToSets) do
        if gcdisplay.GetToggle(toggleName) then
            gFunc.EquipSet(gearSet)
        end
    end
end

-------------------------------------------------------------------------------
-- Ability handler ------------------------------------------------------------
-------------------------------------------------------------------------------

profile.HandleAbility = function()
    local abilityName = gData.GetAction().Name:lower()

    local abilityMap = {
        ['dark arts']     = function() AshitaCore:GetChatManager():QueueCommand(1, '/macro set 6') end,
        ['light arts']    = function() AshitaCore:GetChatManager():QueueCommand(1, '/macro set 2') end,
        ['enlightenment'] = function() gFunc.EquipSet(sets.Enlightenment) end,
        ['tabula rasa']   = function() gFunc.EquipSet(sets.Tabula) end,
    }

    for key, handler in pairs(abilityMap) do
        if abilityName:match(key) then
            handler()
            break
        end
    end

    gcinclude.CheckCancels()
end

-------------------------------------------------------------------------------
-- Item handler ---------------------------------------------------------------
-------------------------------------------------------------------------------

profile.HandleItem = function()
    local item = gData.GetAction()
    if item.Name:match('Holy Water') then
        gFunc.EquipSet(gcinclude.sets.Holy_Water)
    end
end

-------------------------------------------------------------------------------
-- Precast handler ------------------------------------------------------------
-------------------------------------------------------------------------------

profile.HandlePrecast = function()
    local lightArts = gData.GetBuffCount('Light Arts')
    local darkArts  = gData.GetBuffCount('Dark Arts')
    local spell     = gData.GetAction()

    gFunc.EquipSet(sets.Precast)

    local grimoireMap = {
        ['White Magic'] = lightArts,
        ['Black Magic'] = darkArts,
    }

    if (grimoireMap[spell.Type] or 0) > 0 then
        gFunc.EquipSet(sets.Precast_Grimoire)
    end

    gcinclude.CheckCancels()
end


-------------------------------------------------------------------------------
-- Static lookup tables -------------------------------------------------------
-------------------------------------------------------------------------------

-- Targets that trigger the CureNuke set when hit with Cure IV.
local cureNukeTargets = T{ 'Skomora', 'Lost Soul', 'Triboulex' }

-- Extra Enhancing‑Magic gear to layer on top of the always‑equipped
-- Enhancing Duration set. Keys are lowercase patterns that must appear in the
-- spell name.
local enhancingExtraSetMap = {
    phalanx   = 'Enhancing_skill',
    stoneskin = 'Stoneskin',
    regen     = 'Regen',
    storm     = nil,          -- Still only duration; no extra set
    refresh   = nil,
}

-- Base gear sets to equip immediately when we see a given magic skill.  Any
-- further, more specific logic will add on top of this.
local skillBaseSetMap = {
    ['Enfeebling Magic'] = 'Enfeebling',
    ['Dark Magic']       = 'Enfeebling', -- Dark falls back to M.Acc set first
}

-- Buffs that map 1‑for‑1 to gear sets.  The `buffs` table created at runtime
-- must contain matching keys whose value > 0.
local buffGearMap = {
    raptureEbullience = 'RaptureEbullience',
    perpetuance       = 'Perpetuance',
    immanence         = 'Immanence',
    celerityAlacrity  = 'CelerityAlacrity',
    penuryParsimony   = 'PenuryParsimony',
}

-------------------------------------------------------------------------------
-- Helper closures ------------------------------------------------------------
-------------------------------------------------------------------------------

local function equipSubNINorDNC(player)
    if player.SubJob == 'NIN' or player.SubJob == 'DNC' then
        gFunc.EquipSet(sets.subNIN)
    end
end

local function applyHachirin(element)
    if element and element ~= '' then
        profile.Hachirin(element)
    end
end

-------------------------------------------------------------------------------
-- Main mid‑cast handler ------------------------------------------------------
-------------------------------------------------------------------------------

profile.HandleMidcast = function()
    -- Convenience locals ------------------------------------------------------
    local player  = gData.GetPlayer()
    local spell   = gData.GetAction()
    local target  = gData.GetActionTarget()
    local me      = AshitaCore:GetMemoryManager():GetParty():GetMemberName(0)

    local spellName     = string.lower(spell.Name or '')
    local spellElement  = spell.Element or ''
    local spellSkill    = spell.Skill or ''

    ---------------------------------------------------------------------------
    -- Buff state snapshot -----------------------------------------------------
    ---------------------------------------------------------------------------
    local buffs = {
        klimaform         = gData.GetBuffCount('Klimaform'),
        perpetuance       = gData.GetBuffCount('Perpetuance'),
        immanence         = gData.GetBuffCount('Immanence'),
        raptureEbullience = gData.GetBuffCount('Rapture') + gData.GetBuffCount('Ebullience'),
        penuryParsimony   = gData.GetBuffCount('Penury')  + gData.GetBuffCount('Parsimony'),
        celerityAlacrity  = gData.GetBuffCount('Celerity') + gData.GetBuffCount('Alacrity'),
    }

    ---------------------------------------------------------------------------
    -- Generic skill‑level base set -------------------------------------------
    ---------------------------------------------------------------------------
    do
        local baseSetName = skillBaseSetMap[spellSkill]
        if baseSetName then
            gFunc.EquipSet(sets[baseSetName])
        end
    end

    ---------------------------------------------------------------------------
    -- Skill‑specific handling -------------------------------------------------
    ---------------------------------------------------------------------------

    if spellSkill == 'Enhancing Magic' then
        gFunc.EquipSet(sets.Enhancing_duration)
        for pattern, extraSetName in pairs(enhancingExtraSetMap) do
            if spellName:find(pattern) then
                if extraSetName then
                    gFunc.EquipSet(sets[extraSetName])
                end
                break -- one match is sufficient
            end
        end

    elseif spellSkill == 'Healing Magic' then
        if spellName:find('cure') or spellName:find('curaga') then
            gFunc.EquipSet(sets.Cure)
            if target.Name == me then
                gFunc.EquipSet(sets.Self_Cure)
            end
            applyHachirin(spellElement)
        end

        if spell.Name == 'Cure IV' and cureNukeTargets:contains(target.Name) then
            gFunc.EquipSet(sets.CureNuke)
            equipSubNINorDNC(player)
            applyHachirin(spellElement)
        end

        if spellName:find('cursna') then
            gFunc.EquipSet(sets.Cursna)
        end

    elseif spellSkill == 'Elemental Magic' then
        gFunc.EquipSet(sets.Nuke)
        if gcdisplay.GetCycle('NukeSet') == 'Macc' then
            gFunc.EquipSet(sets.NukeACC)
        end
        if gcdisplay.GetToggle('Burst') then
            gFunc.EquipSet(sets.Burst)
        end

        equipSubNINorDNC(player)
        applyHachirin(spellElement)

        if buffs.klimaform > 0 then
            gFunc.EquipSet(sets.Klimaform)
        end

        if player.MPP <= 40 then
            gFunc.EquipSet(sets.Mp_Body)
        end

        if spellName:find('helix') then
            gFunc.EquipSet(sets.Helix)
            if gcdisplay.GetToggle('Burst') then
                gFunc.EquipSet(sets.HelixBurst)
            end
            if spellName:find('nocto') then
                gFunc.Equip('Head', 'Pixie Hairpin +1')
            end
            equipSubNINorDNC(player) -- ensure sub job set layered last
        end

    elseif spellSkill == 'Enfeebling Magic' then
        equipSubNINorDNC(player)
        applyHachirin(spellElement)

    elseif spellSkill == 'Dark Magic' then
        if spellName:find('aspir') or spellName:find('drain') then
            gFunc.EquipSet(sets.Drain)
        elseif spellName:find('kaustra') then
            gFunc.EquipSet(sets.Kaustra)
        end
        equipSubNINorDNC(player)
        applyHachirin(spellElement)
        if buffs.klimaform > 0 then
            gFunc.EquipSet(sets.Klimaform)
        end
    end

    ---------------------------------------------------------------------------
    -- Universal add‑ons (TH toggle, buff‑driven sets) -------------------------
    ---------------------------------------------------------------------------

    if gcdisplay.GetToggle('TH') then
        gFunc.EquipSet(sets.TH)
    end

    -- Iterate the simple buff►gear mapping table.
    for buffKey, setName in pairs(buffGearMap) do
        if buffs[buffKey] and buffs[buffKey] > 0 then
            gFunc.EquipSet(sets[setName])
        end
    end

    -- Extra logic specific to Immanence + Vagary combo
    if buffs.immanence > 0 and gcinclude.settings.vagarySC == 1 then
        gFunc.EquipSet(sets.VagarySC)
    end
end


profile.HandlePreshot = function()
    gFunc.EquipSet(sets.Preshot);
end

profile.HandleMidshot = function()
    gFunc.EquipSet(sets.Midshot);
	if (gcdisplay.GetToggle('TH') == true) then gFunc.EquipSet(sets.TH) end
end

profile.HandleWeaponskill = function()
    local canWS = gcinclude.CheckWsBailout();
    if (canWS == false) then gFunc.CancelAction() return;
    else
        local ws = gData.GetAction();
    
        gFunc.EquipSet(sets.Ws_Default)
        if (gcdisplay.GetCycle('MeleeSet') ~= 'Default') then
        gFunc.EquipSet('Ws_' .. gcdisplay.GetCycle('MeleeSet')) end

        if string.match(ws.Name, 'Cataclysm') then
            gFunc.EquipSet(sets.Cataclysm_Default)
            if (gcdisplay.GetCycle('MeleeSet') ~= 'Default') then
            gFunc.EquipSet('Cataclysm_' .. gcdisplay.GetCycle('MeleeSet')); end
        elseif string.match(ws.Name, 'Mykyr') then
            gFunc.EquipSet(sets.Mykyr_Default)
            if (gcdisplay.GetCycle('MeleeSet') ~= 'Default') then
            gFunc.EquipSet('Mykyr_' .. gcdisplay.GetCycle('MeleeSet')); end
        end
    end
end

return profile;