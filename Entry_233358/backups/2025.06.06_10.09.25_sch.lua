local profile = {};
gcinclude = gFunc.LoadFile('common\\gcinclude.lua');

local sets = {
    Idle = {
        Main = 'Mpaca\'s Staff',
        Sub = 'Khonsu',
        Ammo = 'Staunch Tathlum +1',
        Head = 'Arbatel Bonnet +3',
        Neck = 'Loricate Torque +1',
        Ear1 = 'Eabani Earring',
        Ear2 = 'Hearty Earring',
        Body = 'Arbatel Gown +2',
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
        Body = 'Arbatel Gown +2',
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
        Body = 'Arbatel Gown +2',
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
        Body = 'Arbatel Gown +2',
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
        Main = 'Wizard\'s Rod',
        Sub = 'Bunzi\'s Rod',
        Ammo = 'Jukukik Feather',
        Head = 'Agwu\'s Cap',
        Neck = 'Sanctity Necklace',
        Ear1 = 'Cessance Earring',
        Ear2 = 'Telos Earring',
        Body = 'Agwu\'s Robe',
        Hands = 'Nyame Gauntlets',
        Ring1 = 'Cacoethic Ring +1',
        Ring2 = 'Chirich Ring +1',
        Back = 'Aurist\'s Cape +1',
        Waist = 'Eschan Stone',
        Legs = 'Agwu\'s Slops',
        Feet = 'Agwu\'s Pigaches',
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
        Ammo = 'Pemphredo Tathlum',
        Head = 'Pixie Hairpin +1',
        Neck = 'Erra Pendant',
        Ear1 = 'Regal Earring',
        Ear2 = 'Malignance Earring',
        Body = 'Acad. Gown +2',
        Hands = 'Acad. Bracers +3',
        Ring1 = 'Kishar Ring',
        Ring2 = 'Metamor. Ring +1',
        Back = 'Aurist\'s Cape +1',
        Waist = 'Fucho-no-Obi',
        Legs = 'Acad. Pants +2',
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
        Body = 'Arbatel Gown +2',
        Hands = 'Arbatel Bracers +3',
        Ring1 = 'Mallquis Ring',
        Ring2 = 'Metamor. Ring +1',
        Back = 'Lugh\'s Cape',
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
        Body = 'Arbatel Gown +2', -- 10 and 0
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
        Body = 'Arbatel Gown +2',
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
        Legs = 'Pedagogy Pants +1',
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
    ['fccloak'] = {
        Main = { Name = 'Mpaca\'s Staff', AugPath='A' },
        Sub = 'Khonsu',
        Ammo = 'Staunch Tathlum +1',
        Head = 'Arbatel Bonnet +3',
        Neck = { Name = 'Loricate Torque +1', AugPath='A' },
        Ear1 = 'Eabani Earring',
        Ear2 = 'Hearty Earring',
        Body = 'Arbatel Gown +2',
        Hands = { Name = 'Nyame Gauntlets', AugPath='B' },
        Ring1 = 'Shadow Ring',
        Ring2 = 'Shneddick Ring',
        Back = { Name = 'Lugh\'s Cape', Augment = { [1] = '"Fast Cast"+10', [2] = 'HP+60' } },
        Waist = 'Plat. Mog. Belt',
        Legs = 'Arbatel Pants +3',
        Feet = { Name = 'Nyame Sollerets', AugPath='B' },
    },
    ['vagarylowdmg'] = {
        Sub = 'Genmei Shield',
        Ammo = 'Staunch Tathlum +1',
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
    local player = gData.GetPlayer();
    local sub = gData.GetBuffCount('Sublimation: Activated');

    
    gFunc.EquipSet(sets.Idle);
    
    if (player.Status == 'Engaged') then
        gFunc.EquipSet(sets.Tp_Default)
        if (gcdisplay.GetCycle('MeleeSet') ~= 'Default') then
            gFunc.EquipSet('Tp_' .. gcdisplay.GetCycle('MeleeSet')) end
		if (gcdisplay.GetToggle('TH') == true) then gFunc.EquipSet(sets.TH) end
    elseif (player.Status == 'Resting') then
        gFunc.EquipSet(sets.Resting);
    else 
        gFunc.EquipSet(sets.Idle);
    end

    
    if (sub > 0) then
        gFunc.EquipSet(sets.Sublimation);
    end
	
    gcinclude.CheckDefault();
    if (gcdisplay.GetToggle('DTset') == true) then 
        gFunc.EquipSet(sets.Dt) 
    end;
    if (gcdisplay.GetToggle('Kite') == true) then 
        gFunc.EquipSet(sets.Movement) 
    end;
    
end

profile.HandleAbility = function()
    local ability = gData.GetAction();

    if string.match(ability.Name, 'Dark Arts') then
        AshitaCore:GetChatManager():QueueCommand(1, '/macro set 6');
    elseif string.match(ability.Name, 'Light Arts') then
        AshitaCore:GetChatManager():QueueCommand(1, '/macro set 2');
    elseif string.match(ability.Name, 'Enlightenment') then
        gFunc.EquipSet(sets.Enlightenment);
    elseif string.match(ability.Name, 'Tabula Rasa') then
        gFunc.EquipSet(sets.Tabula);
    end
		 

    gcinclude.CheckCancels();
end

profile.HandleItem = function()
    local item = gData.GetAction();
	if string.match(item.Name, 'Holy Water') then gFunc.EquipSet(gcinclude.sets.Holy_Water) end
end

profile.HandlePrecast = function()
    local lightArts = gData.GetBuffCount('Light Arts')
    local darkArts = gData.GetBuffCount('Dark Arts')
    local spell = gData.GetAction();

    gFunc.EquipSet(sets.Precast);

    if spell.Type == 'White Magic' and lightArts > 0 then
        gFunc.EquipSet(sets.Precast_Grimoire);
    elseif spell.Type == 'Black Magic' and darkArts > 0 then
        gFunc.EquipSet(sets.Precast_Grimoire);
    end

    gcinclude.CheckCancels();
end

profile.HandleMidcast = function()
    local player = gData.GetPlayer();
    local spell = gData.GetAction();
    local target = gData.GetActionTarget();
    local me = AshitaCore:GetMemoryManager():GetParty():GetMemberName(0);
    local power = gData.GetBuffCount('Ebullience') +  gData.GetBuffCount('Rapture');
    local klimaform = gData.GetBuffCount('Klimaform');
    local PenuryParsimony = gData.GetBuffCount('Penury') + gData.GetBuffCount('Parsimony');
    local CelerityAlacrity = (gData.GetBuffCount('Celerity')) + (gData.GetBuffCount('Alacrity'));
    local RaptureEbullience = (gData.GetBuffCount('Rapture')) + (gData.GetBuffCount('Ebullience'));
    local Perpetuance = gData.GetBuffCount('Perpetuance')
    local Immanence = gData.GetBuffCount('Immanence')


    if (spell.Skill == 'Enhancing Magic') then
        if string.match(spell.Name, 'Phalanx') then
            gFunc.EquipSet(sets.Enhancing_duration);
            gFunc.EquipSet(sets.Enhancing_skill);
        elseif string.match(spell.Name, 'Stoneskin') then
            gFunc.EquipSet(sets.Enhancing_duration);
            gFunc.EquipSet(sets.Stoneskin);
        elseif string.contains(spell.Name, 'Regen') then
            gFunc.EquipSet(sets.Enhancing_duration);
            gFunc.EquipSet(sets.Regen);
        elseif string.contains(spell.Name, 'storm') then
            gFunc.EquipSet(sets.Enhancing_duration);
        elseif string.contains(spell.Name, 'Refresh') then
            gFunc.EquipSet(sets.Enhancing_duration);
        end
    elseif (spell.Skill == 'Healing Magic') then
        if string.contains(spell.Name, 'Cure') or string.contains(spell.Name, 'Curaga') then
            gFunc.EquipSet(sets.Cure);

            if (target.Name == me) then
             gFunc.EquipSet(sets.Self_Cure);
            end

            profile.Hachirin(spell.Element);
        end

        if string.match(spell.Name, 'Cursna') then
            gFunc.EquipSet(sets.Cursna);
        end
    elseif (spell.Skill == 'Elemental Magic') then
        gFunc.EquipSet(sets.Nuke);

        if (gcdisplay.GetCycle('NukeSet') == 'Macc') then
            gFunc.EquipSet(sets.NukeACC);
        end
        if (gcdisplay.GetToggle('Burst') == true) then
            gFunc.EquipSet(sets.Burst);
        end
        if player.SubJob == 'NIN' or player.SubJob == 'DNC' then
            gFunc.EquipSet(sets.subNIN);
        end

        profile.Hachirin(spell.Element);
    
        if klimaform > 0 then
            gFunc.EquipSet(sets.Klimaform)
        end

        if (player.MPP <= 40) then
            gFunc.EquipSet(sets.Mp_Body);
        end
        if string.contains(spell.Name, 'helix') then
            gFunc.EquipSet(sets.Helix);
            if (gcdisplay.GetToggle('Burst') == true) then
                gFunc.EquipSet(sets.HelixBurst);
                
            end
            if string.contains(spell.Name, 'Nocto') then
                gFunc.Equip('Head', 'Pixie Hairpin +1');
            end
            if player.SubJob == 'NIN' or player.SubJob == 'DNC' then
                gFunc.EquipSet(sets.subNIN);
            end
        end
    elseif (spell.Skill == 'Enfeebling Magic') then
        gFunc.EquipSet(sets.Enfeebling);
        if player.SubJob == 'NIN' or player.SubJob == 'DNC' then
            gFunc.EquipSet(sets.subNIN);
        end
        --hachirin with storms
        profile.Hachirin(spell.Element);
    elseif (spell.Skill == 'Dark Magic') then
        gFunc.EquipSet(sets.Enfeebling); -- mostly macc anyways
        if (string.contains(spell.Name, 'Aspir') or string.contains(spell.Name, 'Drain')) then
            gFunc.EquipSet(sets.Drain);
        elseif (string.match(spell.Name, 'Kaustra')) then
            gFunc.EquipSet(sets.Kaustra);
        end
        if player.SubJob == 'NIN' or player.SubJob == 'DNC' then
            gFunc.EquipSet(sets.subNIN);
        end
        --hachirin with storms
        profile.Hachirin(spell.Element);
        if klimaform > 0 then
            gFunc.EquipSet(sets.Klimaform)
        end
    end
	if (gcdisplay.GetToggle('TH') == true) then 
        gFunc.EquipSet(sets.TH) 
    end
    if RaptureEbullience > 0 then
        gFunc.EquipSet(sets.RaptureEbullience);
    end
    if Perpetuance > 0 then
        gFunc.EquipSet(sets.Perpetuance);
    end
    if Immanence > 0 then
        gFunc.EquipSet(sets.Immanence);
        if gcinclude.settings.vagarySC == 1 then
            gFunc.EquipSet(sets.VagarySC)
        end
    end
    if CelerityAlacrity > 0 then
        gFunc.EquipSet(sets.CelerityAlacrity);
    end
    if PenuryParsimony > 0 then
        gFunc.EquipSet(sets.PenuryParsimony);
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
