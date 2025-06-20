local profile = {};
gcinclude = gFunc.LoadFile('common\\gcinclude.lua');

local sets = {
    Idle = {
		Ammo = 'Staunch Tathlum +1',
        Head = 'Nyame Helm',
        Neck = 'Warder\'s Charm +1',
        Ear2 = 'Eabani Earring',
        Ear1 = 'Hearty Earring',
        Body = 'Ebers Bliaut +3',
        Hands = 'Nyame Gauntlets',
        Ring1 = 'Defending Ring',
        Ring2 = 'Shneddick Ring',
        Back = { Name = 'Alaunus\'s Cape', Augment = { [1] = 'Damage taken-5%', [2] = 'Mag. Evasion+30', [3] = 'MND+20', [4] = 'Evasion+20' } },
        Waist = 'Plat. Mog. Belt',
        Legs = 'Nyame Flanchard',
        Feet = 'Nyame Sollerets',
    },

    Resting = {
	
	},
    Idle_Regen = {
	    Neck = 'Sanctity Necklace',
		Ring1 = 'Chirich Ring',
		Main = 'Pandit\'s Staff',
		Sub = 'Mensch Strap +1',
    },
    Idle_Refresh = {
		Main = 'Pandit\'s Staff',
		Sub = 'Enki Strap',
		Neck = 'Loricate Torque +1',
		Hands = 'Volte Gloves',
		Legs = { Name = 'Chironic Hose', Augment = { [1] = '"Mag. Atk. Bns."+7', [2] = 'Mag. Acc.+7', [3] = 'Accuracy+10', [4] = '"Refresh"+2', [5] = 'AGI+8', [6] = 'Attack+12' } },
		Ring1 = 'Stikini Ring +1',
		
    },
	Lockstyle = { 
		--Head = 'Sheep Cap',
		--Body = 'Holy Breastplate',
		--Hands = 'Ebers Mitts +3',
		--Legs = 'Piety Pantaln. +3',
		--Feet = 'Theo. Duckbills +3',
		Head = 'Ebers Cap +3',
		Body = 'Ebers Bliaut +3',
		Hands = 'Ebers Mitts +3',
		Legs = 'Ebers Pant. +3',
		Feet = 'Ebers Duckbills +2',
    },
    Town = {
		Main = 'Yagrush',
		Sub = 'Ammurapi Shield',
    },

    Dt = {
		Ammo = 'Staunch Tathlum +1',
        Head = 'Nyame Helm',
		Body = 'Nyame Mail',
		Hands = 'Nyame Gauntlets',
        Legs = 'Nyame Flanchard',
		Feet = 'Nyame Sollerets',
		Ring1 = 'Defending Ring',

    },

    Tp_Default = {
		Ammo = 'Staunch Tathlum +1',
        Head = 'Nyame Helm',
        Neck = 'Rep. Plat. Medal',
        Ear1 = 'Eabani Earring',
        Ear2 = 'Cessance Earring',
        Body = 'Nyame Mail',
        Hands = 'Nyame Gauntlets',
        Ring1 = 'Defending Ring',
        Ring2 = 'Chirich Ring',
        Back = { Name = 'Alaunus\'s Cape', Augment = { [1] = 'Damage taken-5%', [2] = 'Mag. Evasion+30', [3] = 'MND+20', [4] = 'Evasion+20' } },
        Waist = 'Plat. Mog. Belt',
        Legs = 'Nyame Flanchard',
        Feet = 'Nyame Sollerets',
    },
    Tp_Hybrid = {
    },
    Tp_Acc = {

    },


    Precast = { --cap is 80, currently 80 with 5% quickcast
		Main = 'Pandit\'s Staff', --20
		Ammo = 'Impatiens',
		Sub = 'Tzacab Grip',
		Ear1 = 'Etiolation Earring', --1
		Ear2 = 'Eabani Earring',
		Legs = 'Pinga Pants', --11
		Ring1 = 'Meridian Ring',
		Waist = 'Witful Belt', --3
		Neck = 'Unmoving Collar +1',
		Head = 'Ebers Cap +3', --10
		Body = 'Inyanga Jubbah +2', --14
		Hands = 'Volte Gloves', --6
		Ring2 = 'Lebeche Ring',
		Back = { Name = 'Alaunus\'s Cape', Augment = '"Fast Cast"+10' }, --10
		Feet = 'Regal Pumps +1', --5
		
		
    },
    Cure_Precast = { 
		Legs = 'Ebers Pant. +2' --14

    },
    Enhancing_Precast = {

    },
    Stoneskin_Precast = {
 
    },


    Cure = {--I cap is 50, II cap is 30
		Ring2 = 'Gelatinous Ring +1',
		Neck = 'Unmoving Collar +1',
		Main = 'Pandit\'s Staff',
		Sub = 'Mensch Strap +1',
		Ammo = 'Clarus Stone',
		Ear1 = 'Glorious Earring',
		Ear2 = 'Etiolation Earring',
        Head = 'Bunzi\'s Hat',
		Feet = 'Bunzi\'s Sabots',
		Body = 'Ebers Bliaut +3',
        Hands = 'Theophany Mitts +3', --4 II
		Legs = 'Ebers Pant. +3',
        Ring1 = 'Mephitas\'s Ring +1',
        Back = { Name = 'Alaunus\'s Cape', Augment = { [1] = 'Damage taken-5%', [2] = 'Mag. Evasion+30', [3] = 'MND+20', [4] = 'Evasion+20' } },


		Waist = 'Hachirin-no-Obi',
		

    },
    Self_Cure = {--cap 30
    },
	
	Curaga = { -- +Afflatus Solace gear doesn't work on Curaga
		Body = 'Theo. Bliaut +3',
		
	},
	Erase = {
		Waist = 'Plat. Mog. Belt',
		Ear1 = 'Etiolation Earring',
		Ear2 = 'Eabani Earring',
		Feet = 'Nyame Sollerets',
		Main = 'Yagrush',
		Sub = 'Ammurapi Shield',
		Ammo = 'Staunch Tathlum +1',
		Head = 'Bunzi\'s Hat',
		Neck = 'Cleric\'s Torque',
		Body = 'Nyame Mail',
		Hands = 'Volte Gloves',
		Ring1 = 'Defending Ring',
		Ring2 = 'Gelatinous Ring +1',
		Back = { Name = 'Alaunus\'s Cape', Augment = { [1] = 'Damage taken-5%', [2] = 'Mag. Evasion+30', [3] = 'MND+20', [4] = 'Evasion+20' } },
		Legs = 'Aya. Cosciales +2',
	
	},
    Regen = {
		Main = 'Gada',
		Sub = 'Ammurapi Shield',
	    Ring1 = 'Meridian Ring',
		Ammo = 'Clarus Stone',
        Head = 'Inyanga Tiara +2',
        Neck = 'Warder\'s Charm +1',
        Ear1 = 'Eabani Earring',
        Ear2 = 'Magnetic Earring',
        Body = 'Piety Bliaut +3',
        Hands = 'Ebers Mitts +3',
        Ring2 = 'Mephitas\'s Ring +1',
        Back = 'Solemnity Cape',
        Waist = 'Embla Sash',
        Legs = 'Th. Pant. +3',
        Feet = 'Theo. Duckbills +3',

    },
    Cursna = {
		Main = 'Gada',
		Sub = 'Ammurapi Shield',
		Ammo = 'Clarus Stone',
		Head = 'Vanya Hood',
		Neck = 'Loricate Torque +1',
		Ear1 = 'Meili Earring',
		Ear2 = 'Ebers Earring',
		Body = 'Ebers Bliaut +3',
		Hands = 'Theophany Mitts +2',
		Ring1 = 'Stikini Ring +1',
		Ring2 = 'Menelaus\'s Ring',
		Back = 'Solemnity Cape',
		Waist = 'Gishdubar Sash',
		Legs = 'Th. Pant. +3',
		Feet = 'Vanya Clogs',
		
	},
	NaSpell ={
		Neck = 'Unmoving Collar +1',
		Ear1 = 'Etiolation Earring',
		Ear2 = 'Eabani Earring',
		Feet = 'Nyame Sollerets',
		Legs = 'Nyame Flanchard',
		Waist = 'Plat. Mog. Belt',
		Main = 'Yagrush',
		Sub = 'Ammurapi Shield',
		Ammo = 'Staunch Tathlum +1',
		Head = 'Bunzi\'s Hat',
		Body = 'Nyame Mail',
		Hands = 'Volte Gloves',
		Ring1 = 'Defending Ring',
		Ring2 = 'Gelatinous Ring +1',
		Back = { Name = 'Alaunus\'s Cape', Augment = { [1] = 'Damage taken-5%', [2] = 'Mag. Evasion+30', [3] = 'MND+20', [4] = 'Evasion+20' } },
		
	},
    Enhancing = { --want 500 for barspells. At 424 without gear
		Main = 'Gada', --18
		Sub = 'Ammurapi Shield',
		Ammo = 'Clarus Stone',
        Head = 'Telchine Cap',
        Neck = 'Melic Torque', --10
        Ear1 = 'Eabani Earring',
        Ear2 = 'Mimir Earring', --10
        Body = 'Ebers Bliaut +3',
        Hands = 'Ebers Mitts +3',
        Ring1 = 'Stikini Ring +1', --8
        Ring2 = 'Stikini Ring +1', --8
        Back = 'Solemnity Cape',
        Waist = 'Embla Sash',
        Legs = { Name = 'Telchine Braconi', Augment = 'Enh. Mag. eff. dur. +8' },
        Feet = 'Theo. Duckbills +3', --21

    },
	BarElemental = {
		Main = 'Gada',
		Sub = 'Ammurapi Shield',
		Ammo = 'Clarus Stone',
		Head = 'Ebers Cap +3',
		Neck = 'Melic Torque',
		Ear1 = 'Eabani Earring',
		Ear2 = 'Mimir Earring',
		Body = 'Ebers Bliaut +3',
		Hands = 'Ebers Mitts +3',
		Ring1 = 'Stikini Ring +1',
		Ring2 = 'Stinkini Ring +1',
		Back = { Name = 'Alaunus\'s Cape', Augment = { [1] = 'Damage taken-5%', [2] = 'Mag. Evasion+30', [3] = 'MND+20', [4] = 'Evasion+20' } },
		Waist = 'Embla Sash',
		Legs = 'Piety Pantaln. +3',
		Feet ='Ebers Duckbills +2',
		
	},
    Stoneskin = {
		Waist = 'Siegel Sash',

    },
    Phalanx = {},
    Refresh = {},
    Self_Refresh = {},

    Enfeebling = {
		Main = 'Pandit\'s Staff',
		Sub = 'Enki Strap',
		Ammo = 'Staunch Tathlum +1',
		Head = 'Theophany Cap +3',
		Neck = 'Erra Pendant',
		Ear1 = 'Vor Earring',
		Ear2 = 'Ebers Earring',
		Body = 'Theo. Bliaut +3',
		Hands = 'Piety Mitts +3',
		Ring1 = 'Stikini Ring +1',
		Ring2 = 'Stinkini Ring +1',
		Back = { Name = 'Alaunus\'s Cape', Augment = { [1] = 'Damage taken-5%', [2] = 'Mag. Evasion+30', [3] = 'MND+20', [4] = 'Evasion+20' } },
		Waist = 'Acuity Belt +1',
		Legs = { Name = 'Chironic Hose', Augment = { [1] = '"Resist Silence"+7', [2] = '"Mag. Atk. Bns."+3', [3] = 'MND+14', [4] = 'Mag. Acc.+30' } },
		Feet = 'Theo. Duckbills +3',
		
    },

    Drain = {

    },

    Nuke = {
		Ammo = 'Staunch Tathlum +1',
		Head = 'Bunzi\'s Hat',
		Neck = 'Sanctity Necklaces',
		Ear1 = 'Friomisi Earring',
		Ear2 = 'Ebers Earring',
		Body = 'Bunzi\'s Robe',
		Hands = 'Bunzi\'s Gloves',
		Ring1 = 'Weather. Ring',
		Ring2 = 'Metamor. Ring +1',
		Back = { Name = 'Alaunus\'s Cape', Augment = { [1] = 'Damage taken-5%', [2] = 'Mag. Evasion+30', [3] = 'MND+20', [4] = 'Evasion+20' } },
		Waist = 'Acuity Belt +1',
		Legs = 'Bunzi\'s Pants',
		Feet = 'Bunzi\'s Sabots',
		
    },
    NukeACC = {

    },

    Preshot = {
    },
    Midshot = {

    },

    Ws_Default = {
		Ammo = 'Oshasha\'s Treatise',
        Head = 'Nyame Helm',
        Neck = 'Rep. Plat. Medal',
        Ear1 = 'Eabani Earring',
        Ear2 = 'Cessance Earring',
        Body = 'Nyame Mail',
        Hands = 'Nyame Gauntlets',
        Ring1 = 'Defending Ring',
        Ring2 = 'Cornelia\'s Ring',
        Back = 'Solemnity Cape',
        Waist = 'Plat. Mog. Belt',
        Legs = 'Nyame Flanchard',
        Feet = 'Nyame Sollerets',
    },
    Ws_Hybrid = {
    },
    Ws_Acc = {
    },
    Cataclysm_Default = {

    },
    Cataclysm_Hybrid = {
    },
    Cataclysm_Acc = {
    },
	Benediction = {
		Body = 'Piety Bliaut +3',
	
	},
	Devotion = {
		Head = 'Piety Cap +1',
	
	},
	Martyr = {
		Hands = 'Piety Mitts +3',
	
	},
    TH = {
		Ammo = 'Per. Lucky Egg',
		Head = 'Wh. Rarab Cap +1',
		Hands = 'Volte Bracers',
		Feet = 'Volte Boots',
		
	},
    Movement = {
		Ring1 = 'Defending Ring',
        Ring2 = 'Shneddick Ring',
		
	},
    DivineCaress = {
        Hands = 'Ebers Mitts +3',
    },
    WakeUp = {
        Main = 'Prime Maul',
        Sub = 'Ammurapi Shield',
    },


};
profile.Sets = sets;

profile.Packer = {
    
};

profile.OnLoad = function()
	gSettings.AllowAddSet = true;
    gcinclude.Initialize();
	
		--Lockstyle
    AshitaCore:GetChatManager():QueueCommand(1, '/lac Lockstyle Lockstyle');

    AshitaCore:GetChatManager():QueueCommand(1, '/macro book 5');
    AshitaCore:GetChatManager():QueueCommand(1, '/macro set 1');
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
    local asleep = math.min(gData.GetBuffCount(2) + gData.GetBuffCount(193) + gData.GetBuffCount(19), 1);

    gFunc.EquipSet(sets.Idle);

    if (player.Status == 'Engaged') then
        gFunc.EquipSet(sets.Tp_Default)
        if (gcdisplay.GetCycle('MeleeSet') ~= 'Default') then
            gFunc.EquipSet('Tp_' .. gcdisplay.GetCycle('MeleeSet')) end
		if (gcdisplay.GetToggle('TH') == true) then gFunc.EquipSet(sets.TH) end
    elseif (player.Status == 'Resting') then
        gFunc.EquipSet(sets.Resting);
    elseif (player.IsMoving == true) then
		gFunc.EquipSet(sets.Movement);
    end
	
    gcinclude.CheckDefault ();
    if (gcdisplay.GetToggle('DTset') == true) then gFunc.EquipSet(sets.Dt) end;
    if (gcdisplay.GetToggle('Kite') == true) then gFunc.EquipSet(sets.Movement) end;

    if asleep > 0 then
        if gData.GetBuffCount(37) > 0 then
            AshitaCore:GetChatManager():QueueCommand(1, '/cancel 37');
		end
        gFunc.EquipSet(sets.WakeUp)
    end
end

profile.HandleAbility = function()
    local ability = gData.GetAction();
	
	if ability.Name == 'Devotion' then
        gFunc.EquipSet(sets.Devotion);
    end
	if ability.Name == 'Martyr' then
        gFunc.EquipSet(sets.Martyr);
    end
	if ability.Name == 'Benediction' then
        gFunc.EquipSet(sets.Benediction);
    end

    gcinclude.CheckCancels();
end

profile.HandleItem = function()
    local item = gData.GetAction();

	if string.match(item.Name, 'Holy Water') then gFunc.EquipSet(gcinclude.sets.Holy_Water) end
end

profile.HandlePrecast = function()
    local spell = gData.GetAction();

    gFunc.EquipSet(sets.Precast);

    if (spell.Skill == 'Enhancing Magic') then
        gFunc.EquipSet(sets.Enhancing_Precast);

        if string.contains(spell.Name, 'Stoneskin') then
            gFunc.EquipSet(sets.Stoneskin_Precast);
        end
    elseif (spell.Skill == 'Healing Magic') then
        gFunc.EquipSet(sets.Cure_Precast);
    end

    gcinclude.CheckCancels();
end

profile.HandleMidcast = function()
    local player = gData.GetPlayer();
    local spell = gData.GetAction();
    local target = gData.GetActionTarget();
    local divineCaress = gData.GetBuffCount('Divine Caress');
    local me = AshitaCore:GetMemoryManager():GetParty():GetMemberName(0);
    local na_spells = {Paralyna = true, Silena = true, Stona = true, Poisona = true, Blindna = true, Viruna = true, Cursna = true,}

    if (spell.Skill == 'Enhancing Magic') then
        gFunc.EquipSet(sets.Enhancing);
		if string.match(spell.Name, 'Erase') then
			gFunc.EquipSet(sets.Erase);
		end
        if string.match(spell.Name, 'Phalanx') then
            gFunc.EquipSet(sets.Phalanx);
		elseif string.match(spell.Name, 'Barstonra') or string.match(spell.Name, 'Barwatera') or string.match(spell.Name, 'Baraera') or string.match(spell.Name, 'Barfira') or string.match(spell.Name, 'Barblizzara') or string.match(spell.Name, 'Barthundra') then
			gFunc.EquipSet(sets.BarElemental);
        elseif string.match(spell.Name, 'Stoneskin') then
            gFunc.EquipSet(sets.Stoneskin);
        elseif string.contains(spell.Name, 'Regen') then
            gFunc.EquipSet(sets.Regen);
        elseif string.contains(spell.Name, 'Refresh') then
            gFunc.EquipSet(sets.Refresh);
            if (target.Name == me) then
                gFunc.EquipSet(sets.Self_Refresh);
            end
        end
    elseif (spell.Skill == 'Healing Magic') then
        gFunc.EquipSet(sets.Cure);
        profile.Hachirin(spell.Element);
        if (target.Name == me) then
            gFunc.EquipSet(sets.Self_Cure);
            profile.Hachirin(spell.Element);
        end
		if string.contains(spell.Name, 'Curaga') then
			gFunc.EquipSet(sets.Curaga);
            profile.Hachirin(spell.Element);
		end
        if string.match(spell.Name, 'Cursna') then
            gFunc.EquipSet(sets.Cursna);
        end
		if na_spells[spell.Name] then
			gFunc.EquipSet(sets.NaSpell);
		end
        if divineCaress > 0 and na_spells[spell.Name] then
            gFunc.EquipSet(sets.DivineCaress);
        end
    elseif (spell.Skill == 'Elemental Magic') then
        gFunc.EquipSet(sets.Nuke);
        profile.Hachirin(spell.Element);

        if (gcdisplay.GetCycle('NukeSet') == 'Macc') then
            gFunc.EquipSet(sets.NukeACC);
            profile.Hachirin(spell.Element);
        end
    elseif (spell.Skill == 'Enfeebling Magic') then
        gFunc.EquipSet(sets.Enfeebling);
        profile.Hachirin(spell.Element);
    elseif (spell.Skill == 'Dark Magic') then
        gFunc.EquipSet(sets.Enfeebling); -- mostly macc anyways
        if (string.contains(spell.Name, 'Aspir') or string.contains(spell.Name, 'Drain')) then
            gFunc.EquipSet(sets.Drain);
        end
        profile.Hachirin(spell.Element);
    end
	if (gcdisplay.GetToggle('TH') == true) then gFunc.EquipSet(sets.TH) 
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
    if (canWS == false) then 
        gFunc.CancelAction() 
        return;
    else
        local ws = gData.GetAction();
    
        gFunc.EquipSet(sets.Ws_Default)
        if (gcdisplay.GetCycle('MeleeSet') ~= 'Default') then
        gFunc.EquipSet('Ws_' .. gcdisplay.GetCycle('MeleeSet')) end

        if string.match(ws.Name, 'Cataclysm') then
            gFunc.EquipSet(sets.Cataclysm_Default)
            if (gcdisplay.GetCycle('MeleeSet') ~= 'Default') then
                gFunc.EquipSet('Cataclysm_' .. gcdisplay.GetCycle('MeleeSet')); 
            end
            profile.Hachirin(spell.Element);
        end
    end
end

return profile;
