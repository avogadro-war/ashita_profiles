local profile = {};
gcinclude = gFunc.LoadFile('common\\gcinclude.lua')



--!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! USE /lac addset <name> TO FIND CORRECT AUGMENT SYNTAX IF REQUIRED.!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!--
--!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! USE /lac addset <name> TO FIND CORRECT AUGMENT SYNTAX IF REQUIRED.!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!--
--!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! USE /lac addset <name> TO FIND CORRECT AUGMENT SYNTAX IF REQUIRED.!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!--
--!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! USE /lac addset <name> TO FIND CORRECT AUGMENT SYNTAX IF REQUIRED.!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!--

local sets = {
    Idle = {
		Ammo = 'Staunch Tathlum +1',
        Head = 'Nyame Helm',
        Neck = 'Warder\'s Charm +1',
        Ear1 = 'Eabani Earring',
        Ear2 = 'Hearty Earring',
        Body = 'Hashishin Mintan +3',
        Hands = 'Nyame Gauntlets',
        Ring1 = 'Defending Ring',
        Ring2 = 'Shneddick Ring',
		Back = { Name = 'Rosmerta\'s Cape', Augment = { [1] = 'Damage taken-5%', [2] = '"Dual Wield"+10', [3] = 'Accuracy+20', [4] = 'Attack+20', [5] = 'DEX+20' } },
        Waist = 'Plat. Mog. Belt',
        Legs = 'Nyame Flanchard',
        Feet = 'Nyame Sollerets',
		
    },
	Resting = {

    },
    Idle_Regen = {
	    Neck = 'Sanctity Necklace',
		Ring1 = 'Chirich Ring +1',
		
    },
    Idle_Refresh = {
	    Body = 'Hashishin Mintan +3',
		
    },
	Lockstyle = { 
		--Head = 'Adenium Masque',
        --Body = 'Adenium Suit',
		Head = 'Hashishin Kavuk +3',
		Body = 'Hashishin Mintan +3',
		Hands = 'Hashi. Bazu. +3',
		Legs = 'Hashishin Tayt +3',
		Feet = 'Hashi. Basmak +2',


    },
	
	Town = {
        
    },

    Evasion = {--this set will be my idle set when in /cj mode for evasion pulling

    },
	
	Dt = { --49 dt, lots of def/meva
		Ammo = 'Staunch Tathlum +1',
        Head = 'Nyame Helm',
		Neck = 'Loricate Torque +1',
		Body = 'Nyame Mail',
		Hands = 'Nyame Gauntlets',
        Legs = 'Carmine Cuisses +1',
		Feet = 'Nyame Sollerets',
		Ring1 = 'Defending Ring',
	},
	
	Tp_Default = { --48 dt, total: 50 pdt 48 mdt
		Ammo = 'Coiste Bodhar',
        Head = 'Malignance Chapeau', --6 dt
        Neck = 'Mirage Stole +2',
        Ear1 = 'Cessance Earring',
        Ear2 = 'Hashi. Earring +1',
        Body = 'Hashishin Mintan +3', --13 dt
        Hands = 'Hashi. Bazu. +3', --10
        Ring1 = 'Defending Ring', --10 dt
        Ring2 = 'Epona\'s Ring',
		Back = { Name = 'Rosmerta\'s Cape', Augment = { [1] = 'Damage taken-5%', [2] = '"Dual Wield"+10', [3] = 'Accuracy+20', [4] = 'Attack+20', [5] = 'DEX+20' } }, --5 dt
        Waist = 'Kentarch Belt +1',
        Legs = 'Malignance Tights', --7 dt
        Feet = { Name = 'Herculean Boots', Augment = { [1] = 'Accuracy+17', [2] = '"Triple Atk."+4', [3] = 'DEX+4' } }, --2 pdt
		
    },
	Tp_Hybrid = {
		Ammo = 'Staunch Tathlum +1',
        Head = 'Hashishin Kavuk +3',
        Neck = 'Mirage Stole +2',
        Ear1 = 'Cessance Earring',
        Ear2 = 'Hashi. Earring +1',
        Body = 'Nyame Mail',
        Hands = 'Nyame Gauntlets',
        Ring1 = 'Defending Ring',
        Ring2 = 'Epona\'s Ring',
		Back = { Name = 'Rosmerta\'s Cape', Augment = { [1] = 'Damage taken-5%', [2] = '"Dual Wield"+10', [3] = 'Accuracy+20', [4] = 'Attack+20', [5] = 'DEX+20' } }, --5 dt
        Waist = 'Sailfi Belt +1',
        Legs = 'Malignance Tights', --7 dt
        Feet = 'Nyame Sollerets',
		
    },
	Tp_Acc = {

    },
	
	Precast = {--need 80. +15 from traits if Fast Cast is gained through spellset
		Ring1 = 'Kishar Ring', --4
		Ear1 = 'Etiolation Earring', --1
		Ammo = 'Impatiens', --2 QUICKCAST
		Head = 'Carmine Mask +1', --14
		Neck = 'Voltsurge Torque', --4
		Ear2 = 'Loquac. Earring', --2
		Body = 'Pinga Tunic', --13
		Hands = 'Leyline Gloves', --8
		Ring2 = 'Lebeche Ring', --2 QUICKCAST
		Back = { Name = 'Rosmerta\'s Cape', Augment = '"Fast Cast"+10' }, --10
		Waist = 'Embla Sash', --5
		Legs = 'Pinga Pants', --11
		Feet = 'Carmine Greaves +1', --8
    },
    Blu_Precast = {
		Body = 'Hashishin Mintan +3',
		Hands = 'Hashi. Bazu. +3',
    },
    Stoneskin_Precast = {

    },
    Cure = {--I cap is 50, II cap is 30
		Ring2 = 'Meridian Ring',
		Waist = 'Plat. Mog. Belt',
		Head = 'Nyame Helm',
		Neck = 'Mirage Stole +2',
		Ear1 = 'Eabani Earring',
		Ear2 = 'Magnetic Earring', --just for Conserve MP
		Body = 'Hashishin Mintan +3',
		Hands = 'Telchine Gloves',
		Ring1 = 'Defending Ring',
		Back = 'Repulse Mantle',
		Legs = 'Nyame Flanchard',
		Feet = 'Carmine Greaves +1',
		
    },
    WhiteWind = {--HP+
		Ammo = 'Staunch Tathlum +1',
		Head = 'Nyame Helm',
		Neck = 'Unmoving Collar +1',
		Ear1 = 'Eabani Earring',
		Ear2 = 'Magnetic Earring', --just for Conserve MP
		Body = 'Pinga Tunic',
		Hands = 'Hashi. Bazu. +3',
		Ring1 = 'Gelatinous Ring +1',
		Ring2 = 'Meridian Ring',
		Back = 'Trepidity Mantle',
		Waist = 'Plat. Mog. Belt',
		Legs = 'Pinga Pants',
		Feet = 'Carmine Greaves +1',
		
    },
	BatteryCharge = {
		Head = 'Amalric Coif +1',
		Waist = 'Gishdubar Sash',	
		Ear1 = 'Eabani Earring',
		Ear2 = 'Magnetic Earring',
		Hands = 'Hashi. Bazu. +3',
		Ring2 = 'Ayanmo Ring',
		Back = { Name = 'Rosmerta\'s Cape', Augment = { [1] = 'Damage taken-5%', [2] = '"Dual Wield"+10', [3] = 'Accuracy+20', [4] = 'Attack+20', [5] = 'DEX+20' } },
		
	},
	ErraticFlutter = {
		Ear1 = 'Eabani Earring',
		Ear2 = 'Magnetic Earring',
		Hands = 'Hashi. Bazu. +3',
		Ring2 = 'Ayanmo Ring',
		Back = { Name = 'Rosmerta\'s Cape', Augment = { [1] = 'Damage taken-5%', [2] = '"Dual Wield"+10', [3] = 'Accuracy+20', [4] = 'Attack+20', [5] = 'DEX+20' } },
	
	},
	Aquaveil = {
		Head = 'Amalric Coif +1',
		Ear1 = 'Eabani Earring',
		Ear2 = 'Mimir Earring',
		Ring2 = 'Ayanmo Ring',
		Back = { Name = 'Rosmerta\'s Cape', Augment = { [1] = 'Damage taken-5%', [2] = '"Dual Wield"+10', [3] = 'Accuracy+20', [4] = 'Attack+20', [5] = 'DEX+20' } },
	},
	Phalanx = {
		Head = { Name = 'Taeon Chapeau', Augment = 'Phalanx +3' },
		Body = { Name = 'Taeon Tabard', Augment = 'Phalanx +3' },
		Hands = { Name = 'Taeon Gloves', Augment = 'Phalanx +3' },
		Legs = { Name = 'Taeon Tights', Augment = 'Phalanx +3' },
		Feet = { Name = 'Taeon Boots', Augment = 'Phalanx +3' },
		Neck = 'Melic Torque',
		Ear1 = 'Eabani Earring',
		Ear2 = 'Mimir Earring',
		Ring1 = 'Stikini Ring +1',
		Ring2 = 'Stikini Ring +1',
		Back = { Name = 'Rosmerta\'s Cape', Augment = { [1] = 'Damage taken-5%', [2] = '"Dual Wield"+10', [3] = 'Accuracy+20', [4] = 'Attack+20', [5] = 'DEX+20' } },
		Waist = 'Olympus Sash',
		
	},
	
	Stoneskin = {
		Head = 'Nyame Helm',
		Neck = 'Sanctity Necklace',
		Ear1 = 'Eabani Earring',
		Ear2 = 'Magnetic Earring',
		Body = 'Nyame Mail',
		Hands = 'Nyame Gauntlets',
		Ring1 = 'Defending Ring',
		Ring2 = 'Ayanmo Ring',
		Back = { Name = 'Rosmerta\'s Cape', Augment = { [1] = 'Damage taken-5%', [2] = '"Dual Wield"+10', [3] = 'Accuracy+20', [4] = 'Attack+20', [5] = 'DEX+20' } },
		Waist = 'Siegel Sash',
		Legs = 'Carmine Cuisses +1',
		Feet = 'Nyame Sollerets',
		
	},
    BluSkill = {
		Head = 'Luh. Keffiyeh +1',
		Neck = 'Mirage Stole +2',
		Ear1 = 'Njordr Earring',
		Ear2 = 'Hashi. Earring +1',
		Body = 'Assim. Jubbah +4',
		Hands = 'Hashi. Bazu. +3',
		Ring1 = 'Stikini Ring +1',
		Ring2 = 'Stikini Ring +1',
        Back = { Name = 'Rosmerta\'s Cape', Augment = { [1] = 'Phys. dmg. taken -10%', [2] = '"Mag. Atk. Bns."+10', [3] = 'Mag. Acc.+20', [4] = 'INT+20', [5] = 'Magic Damage+20' } },
		Legs = 'Hashishin Tayt +3',
		Feet = 'Luhlaza Charuqs +1',
    },
    BluMagical = {
		Head = 'Hashishin Kavuk +3',
		Neck = 'Sibyl Scarf',
		Ear1 = 'Hecate\'s Earring',
		Ear2 = 'Friomisi Earring',
		Body = 'Hashishin Mintan +3',
		Hands = 'Hashi. Bazu. +3',
		Ring1 = 'Defending Ring',
		Ring2 = 'Jhakri Ring',
        Back = { Name = 'Rosmerta\'s Cape', Augment = { [1] = 'Phys. dmg. taken -10%', [2] = '"Mag. Atk. Bns."+10', [3] = 'Mag. Acc.+20', [4] = 'INT+20', [5] = 'Magic Damage+20' } },
		Waist = 'Acuity Belt +1',
		Legs = 'Luh. Shalwar +4',
		Feet = 'Nyame Sollerets',
		
    },
    BluDark = {
		Neck = 'Sibyl Scarf',
        Head = 'Pixie Hairpin +1',
		Hands = 'Hashi. Bazu. +3',
        Ring2 = 'Archon Ring',
		
    },
    BluMagicAccuracy = {
		Head = 'Assim. Keffiyeh +4',
		Neck = 'Mirage Stole +2',
		Ear1 = 'Njordr Earring',
		Ear2 = 'Hashi. Earring +1',
		Body = 'Assim. Jubbah +4',
		Hands = 'Hashi. Bazu. +3',
		Ring1 = 'Stikini Ring +1',
		Ring2 = 'Stikini Ring +1',
        Back = { Name = 'Rosmerta\'s Cape', Augment = { [1] = 'Phys. dmg. taken -10%', [2] = '"Mag. Atk. Bns."+10', [3] = 'Mag. Acc.+20', [4] = 'INT+20', [5] = 'Magic Damage+20' } },
		Waist = 'Acuity Belt +1',
		Legs = 'Hashishin Tayt +3',
		Feet = 'Nyame Sollerets',

    },
    CJmid = {--same as macc set but with weapons since in CJmode we idle in eva swords

    },
    BluStun = {
		Head = 'Assim. Keffiyeh +4',
		Neck = 'Mirage Stole +2',
		Ear1 = 'Njordr Earring',
		Ear2 = 'Hashi. Earring +1',
		Body = 'Assim. Jubbah +4',
		Hands = 'Hashi. Bazu. +3',
		Ring1 = 'Stikini Ring +1',
		Ring2 = 'Stikini Ring +1',
        Back = { Name = 'Rosmerta\'s Cape', Augment = { [1] = 'Phys. dmg. taken -10%', [2] = '"Mag. Atk. Bns."+10', [3] = 'Mag. Acc.+20', [4] = 'INT+20', [5] = 'Magic Damage+20' } },
		Waist = 'Acuity Belt +1',
		Legs = 'Hashishin Tayt +3',
		Feet = 'Nyame Sollerets',

    },
    BluPhysical = {
		Head = 'Hashishin Kavuk +3',
		Neck = 'Mirage Stole +2',
		Ear1 = 'Njordr Earring',
		Ear2 = 'Hashi. Earring +1',
		Body = 'Hashishin Mintan +3',
		Hands = 'Hashi. Bazu. +3',
		Ring1 = 'Rajas Ring',
		Ring2 = 'Chirich Ring +1',
        Back = { Name = 'Rosmerta\'s Cape', Augment = { [1] = 'Damage taken-5%', [2] = '"Dual Wield"+10', [3] = 'Accuracy+20', [4] = 'Attack+20', [5] = 'DEX+20' } },
		Waist = 'Sailfi Belt +1',
		Legs = 'Hashishin Tayt +3',
		Feet = 'Nyame Sollerets',

    },
    CMP = {
		Ear1 = 'Gifted Earring',
		Ear2 = 'Magnetic Earring',
    },

    Preshot = {
    },
    Midshot = {

    },

    Ws_Default = {
		Ammo = 'Oshasha\'s Treatise',
		Head = 'Hashishin Kavuk +3',
        Neck = 'Mirage Stole +2',
        Ear1 = 'Cessance Earring',
        Ear2 = 'Ishvara Earring',
        Body = 'Assim. Jubbah +4',
        Hands = 'Jhakri Cuffs +2',
        Ring1 = 'Rajas Ring',
        Ring2 = 'Cornelia\'s Ring',
		Back = { Name = 'Rosmerta\'s Cape', Augment = { [1] = 'STR+20', [2] = 'Weapon skill damage +10%', [3] = 'Attack+20', [4] = 'Accuracy+20' } },
        Waist = 'Sailfi Belt +1',
        Legs = 'Luh. Shalwar +4',
        Feet = { Name = 'Herculean Boots', Augment = { [1] = 'Weapon skill damage +4%', [2] = 'Attack+15', [3] = 'STR+15' } },

    },
    Ws_Hybrid = {

    },
    Ws_Acc = {
    },
    Chant_Default = {
		Ammo = 'Oshasha\'s Treatise',
		Head = 'Hashishin Kavuk +3',
        Neck = 'Mirage Stole +2',
        Ear1 = 'Cessance Earring',
        Ear2 = 'Hashi. Earring +1',
        Body = 'Gleti\'s Cuirass',
        Hands = 'Gleti\'s Gauntlets',
		Ring1 = 'Rajas Ring',
        Ring2 = 'Epona\'s Ring',
		Back = { Name = 'Rosmerta\'s Cape', Augment = { [1] = 'STR+20', [2] = 'Weapon skill damage +10%', [3] = 'Attack+20', [4] = 'Accuracy+20' } },
        Waist = 'Fotia Belt',
        Legs = 'Luh. Shalwar +4',
        Feet = 'Gleti\'s Boots',
    },
    Chant_Hybrid = {

    },
    Chant_Acc = {
    },
    Savage_Default = {
		Ammo = 'Oshasha\'s Treatise',
		Head = 'Hashishin Kavuk +3',
        Neck = 'Mirage Stole +2',
        Ear1 = 'Cessance Earring',
        Ear2 = 'Ishvara Earring',
        Body = 'Assim. Jubbah +4',
        Hands = 'Jhakri Cuffs +2',
        Ring1 = 'Rajas Ring',
        Ring2 = 'Cornelia\'s Ring',
		Back = { Name = 'Rosmerta\'s Cape', Augment = { [1] = 'STR+20', [2] = 'Weapon skill damage +10%', [3] = 'Attack+20', [4] = 'Accuracy+20' } },
        Waist = 'Sailfi Belt +1',
        Legs = 'Luh. Shalwar +4',
        Feet = 'Nyame Sollerets',

    },
    Savage_Hybrid = {

    },
    Savage_Acc = {
    },
    Expiacion_Default = {
		Ammo = 'Oshasha\'s Treatise',
		Head = 'Hashishin Kavuk +3',
        Neck = 'Mirage Stole +2',
        Ear1 = 'Cessance Earring',
        Ear2 = 'Ishvara Earring',
        Body = 'Assim. Jubbah +4',
        Hands = 'Jhakri Cuffs +2',
        Ring1 = 'Rajas Ring',
        Ring2 = 'Cornelia\'s Ring',
		Back = { Name = 'Rosmerta\'s Cape', Augment = { [1] = 'STR+20', [2] = 'Weapon skill damage +10%', [3] = 'Attack+20', [4] = 'Accuracy+20' } },
        Waist = 'Sailfi Belt +1',
        Legs = 'Luh. Shalwar +4',
        Feet = 'Nyame Sollerets',

    },
    Expiacion_Hybrid = {

    },
    Expiacion_Acc = {
    },
    Requiescat_Default = {

    },
    Requiescat_Hybrid = {
    },
    Requiescat_Acc = {
    },
	
	Sanguine_Default = {
		Ammo = 'Oshasha\'s Treatise',
        Head = 'Pixie Hairpin +1',
        Neck = 'Sibyl Scarf',
		Ear1 = 'Hecate\'s Earring',
        Ear2 = 'Friomisi Earring',
        Body = 'Nyame Mail',
        Hands = 'Jhakri Cuffs +2',
        Ring1 = 'Cornelia\'s Ring',
        Ring2 = 'Archon Ring',
		Back = { Name = 'Rosmerta\'s Cape', Augment = { [1] = 'Phys. dmg. taken -10%', [2] = '"Mag. Atk. Bns."+10', [3] = 'Mag. Acc.+20', [4] = 'INT+20', [5] = 'Magic Damage+20' } },
        Waist = 'Acuity Belt +1',
        Legs = 'Luh. Shalwar +4',
        Feet = 'Nyame Sollerets',
    },
    Sanguine_Hybrid = {
    },
    Sanguine_Acc = {
    },
	
    Ca = {
		Head = 'Hashishin Kavuk +3',

    },
    Ba = {
		Feet = 'Hashi. Basmak +2',

    },
    Diffusion = {
		Feet = 'Luhlaza Charuqs +1',

    },
    Efflux = {
		Legs = 'Hashishin Tayt +3',

    },
    Enmity = {

    },
    TH = {
        Ammo = 'Per. Lucky Egg',
		Hands = 'Volte Bracers',
		Feet = { Name = 'Herculean Boots', Augment = { [1] = 'Mag. Acc.+10', [2] = '"Treasure Hunter"+2', [3] = 'Accuracy+5', [4] = 'INT+2', [5] = 'Attack+5', [6] = '"Mag. Atk. Bns."+33' } },
		
	},
    Salvage = {
		Main = 'Tizona',
		Sub = 'Bunzi\'s Rod',
		
	},
	Movement = {
        Ring1 = 'Defending Ring',
        Ring2 = 'Shneddick Ring',

    },
    Naegling = {
        Main = 'Naegling',
    },
    Tizona = {
        Main = 'Tizona',
    },
    Maxentius = {
        Main = 'Maxentius',
    },
    TPBonusOH = {
        Sub = 'Thibron',
    },
    Bunzi = {
        Sub = 'Bunzi\'s Rod',
    },
    Sakpata = {
        Sub = 'Sakpata\'s Sword',
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
	
			--Lockstyle
    AshitaCore:GetChatManager():QueueCommand(1, '/lac Lockstyle Lockstyle');

    AshitaCore:GetChatManager():QueueCommand(1, '/macro book 2');
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

local dwGearPool = {
    -- Priority, Gear Slot, Item Name, Dual Wield value
    {1, 'Back', { Name = "Rosmerta\'s Cape", Augment = { ['"Dual Wield"+10'] = true } }, 10},
    {2, 'Ear1', 'Eabani Earring', 4},
    {3, 'Ear2', 'Suppanomimi', 5},
    --{4, 'Waist', 'Reiki Yotai', 7},
}

profile.HandleDefault = function()
    local asleep = math.min(gData.GetBuffCount(2) + gData.GetBuffCount(193) + gData.GetBuffCount(19), 1);
    local zone = gData.GetEnvironment();
	local player = gData.GetPlayer();

	gFunc.EquipSet(sets.Idle);
	
    if (player.Status == 'Engaged') then
        gFunc.EquipSet(sets.Tp_Default)
        if (gcdisplay.GetCycle('MeleeSet') ~= 'Default') then
			gFunc.EquipSet('Tp_' .. gcdisplay.GetCycle('MeleeSet')) end
        if gcdisplay.GetToggle('AutoDW') then
            local dwSet, totalDW = JHaste.GetDWGearSet(dwGearPool)

            if next(dwSet) == nil then
                -- Unequip only slots that could have had DW gear, from pool
                for _, gear in ipairs(dwGearPool) do
                    local _, slot = table.unpack(gear)
                    gFunc.Equip(slot, nil)
                end
            else
                for slot, item in pairs(dwSet) do
                    gFunc.Equip(slot, item)
                end
            end
        end
		if (gcdisplay.GetToggle('TH') == true) then gFunc.EquipSet(sets.TH) end
    elseif (player.Status == 'Resting') then
        gFunc.EquipSet(sets.Resting);
    elseif (gcdisplay.GetToggle('CJmode') == true) then
		gFunc.EquipSet(sets.Evasion);
    elseif (player.IsMoving == true) then
		gFunc.EquipSet(sets.Movement);
    end

    --main wep
    local mainHandSets = {
    ['Naegling']  = sets.Naegling,
    ['Tizona']    = sets.Tizona,
    ['Maxentius'] = sets.Maxentius,
    }

    -- Off Hand weapon sets
    local offHandSets = {
    ['TP Bonus'] = sets.TPBonusOH,
    ['Sakpata']  = sets.Sakpata,
    ['Bunzi']    = sets.Bunzi,
    }

    -- Equip main hand set if it exists
    local mhSet = mainHandSets[gcdisplay.GetCycle('MH')]
    if mhSet then gFunc.EquipSet(mhSet) end
    
    -- Equip off hand set if it exists
    local ohSet = offHandSets[gcdisplay.GetCycle('OH')]
    if ohSet then gFunc.EquipSet(ohSet) end
	
    if (gcdisplay.GetToggle('CJmode') ~= true) then
        gcinclude.CheckDefault ();
    end
    if (gcdisplay.GetToggle('DTset') == true) then gFunc.EquipSet(sets.Dt) end;
    if (gcdisplay.GetToggle('Kite') == true) then gFunc.EquipSet(sets.Movement) end;
    --lazy equip weapons for salvage runs
    if (zone.Area:contains('Remnants')) then
        gFunc.EquipSet(sets.Salvage);
    end
    if asleep > 0 then
        print(chat.header('GCinclude'):append(chat.message('Type /zz to wake up.')))
        if gcinclude.settings.wakeUp == true then
            gFunc.EquipSet(sets.WakeUp)
            if gData.GetBuffCount(37) > 0 then
                AshitaCore:GetChatManager():QueueCommand(1, '/cancel 37');
            end
        end
    end
    if gcinclude.settings.wakeUp == true and asleep == 0 then
        gcinclude.settings.wakeUp = false;
    end
end

profile.HandleAbility = function()
	local ability = gData.GetAction();

    if string.match(ability.Name, 'Provoke') then gFunc.EquipSet(sets.Enmity) end

    gcinclude.CheckCancels();
end

profile.HandleItem = function()
    local item = gData.GetAction();

	if string.match(item.Name, 'Holy Water') then gFunc.EquipSet(gcinclude.sets.Holy_Water) end
end

profile.HandlePrecast = function()
    local spell = gData.GetAction();
    gFunc.EquipSet(sets.Precast);

    if string.contains(spell.Skill, 'Blue Magic') then
        gFunc.EquipSet(sets.Blu_Precast);
    elseif string.contains(spell.Name, 'Stoneskin') then
        gFunc.EquipSet(sets.Stoneskin_Precast);
    end 

    gcinclude.CheckCancels();
end

profile.HandleMidcast = function()
    local diff = gData.GetBuffCount('Diffusion');
    local ca = gData.GetBuffCount('Chain Affinity');
    local ba = gData.GetBuffCount('Burst Affinity');
    local ef = gData.GetBuffCount('Efflux');
    local spell = gData.GetAction();

    -- Direct spell name to set mapping
    local directMap = {
        ["Battery Charge"] = "BatteryCharge",
        ["Erratic Flutter"] = "ErraticFlutter",
        ["Aquaveil"] = "Aquaveil",
        ["Phalanx"] = "Phalanx",
        ["Stoneskin"] = "Stoneskin",
        ["White Wind"] = "WhiteWind",
        ["Evryone. Grudge"] = "BluDark",
        ["Tenebral Crush"] = "BluDark",
        ["Entomb"] = nil, -- handled below for Hachirin
        ["Subduction"] = nil, -- handled below for Hachirin
        ["Spectral Floe"] = nil, -- handled below for Hachirin
    }

    -- Category-based mapping (using your gcinclude tables)
    local categoryMap = {
        [gcinclude.BluMagDebuff] = "BluMagicAccuracy",
        [gcinclude.BluMagStun] = "BluStun",
        [gcinclude.BluMagBuff] = "CMP",
        [gcinclude.BluMagSkill] = "BluSkill",
        [gcinclude.BluMagCure] = "Cure",
        [gcinclude.BluMagEnmity] = "Enmity",
        [gcinclude.BluMagTH] = "TH",
    }

    -- Default set
    gFunc.EquipSet(sets.BluMagical);

    -- Direct mapping
    local setToEquip = directMap[spell.Name]
    if setToEquip then
        gFunc.EquipSet(sets[setToEquip])
        if setToEquip == "WhiteWind" or setToEquip == "BluDark" then
            profile.Hachirin(spell.Element)
        end
    else
        -- Category-based mapping
        for tbl, setName in pairs(categoryMap) do
            if tbl:contains(spell.Name) then
                gFunc.EquipSet(sets[setName])
                break
            end
        end
        -- Special Hachirin triggers
        if spell.Name == "Entomb" or spell.Name == "Subduction" or spell.Name == "Spectral Floe" then
            profile.Hachirin(spell.Element)
        end
    end

    -- Affinity gear
    if (ca>=1) then gFunc.EquipSet(sets.Ca) end
    if (ba>=1) then gFunc.EquipSet(sets.Ba) end
    if (ef>=1) then gFunc.EquipSet(sets.Efflux) end
    if (diff>=1) then gFunc.EquipSet(sets.Diffusion) end

    -- CJmode
    if (gcdisplay.GetToggle('CJmode') == true) then
        gFunc.EquipSet(sets.CJmid);
    end

    -- TH
    if (gcinclude.BluMagTH:contains(spell.Name)) and (gcdisplay.GetToggle('TH') == true) then
        gFunc.EquipSet(sets.TH);
    end
end

profile.HandlePreshot = function()
    gFunc.EquipSet(sets.Preshot);
end

profile.HandleMidshot = function()
    gFunc.EquipSet(sets.Midshot);

    if (gcdisplay.GetToggle('TH') == true) then gFunc.EquipSet(sets.TH) end
end

profile.Moonshade = function(wsData, TP)
    local threshold = 3000
    local equipment = gData.GetEquipment()
    if equipment.Sub.Name == 'Thibron' then
        threshold = 2000
    end
    if wsData.moonshade and TP < threshold then
        gFunc.Equip('Ear2', 'Moonshade Earring')
    end
end

profile.HandleWeaponskill = function()
    local canWS = gcinclude.CheckWsBailout();
    if not canWS then
        gFunc.CancelAction()
        return
    end

    local ws = gData.GetAction();
    local wsName = ws.Name
    local meleeSet = gcdisplay.GetCycle('MeleeSet')
    local ohCycle = gcdisplay.GetCycle('OH')
    local defaultSet = sets.Ws_Default
    local player = gData.GetPlayer()

    gFunc.EquipSet(defaultSet)
    if meleeSet ~= 'Default' then
        gFunc.EquipSet('Ws_' .. meleeSet)
    end

    local wsTable = {
        ['Chant du Cygne']  = { set = 'Chant', element = nil, moonshade = false },
        ['Expiacion']       = { set = 'Expiacion', element = nil, moonshade = true },
        ['Savage Blade']    = { set = 'Savage', element = nil, moonshade = true },
        ['Sanguine Blade']  = { set = 'Sanguine', element = 'Dark', moonshade = false },
        ['Seraph Blade']    = { set = 'Seraph', element = 'Light', moonshade = true },
        ['Shining Blade']   = { set = 'Seraph', element = 'Light', moonshade = true },
        ['Red Lotus Blade'] = { set = 'RedLotus', element = 'Fire', moonshade = true },
        ['Burning Blade']   = { set = 'RedLotus', element = 'Fire', moonshade = true },
        --Club
        ['Black Halo']      = { set = 'BlackHalo', element = nil, moonshade = true },
        --Dagger    
        ['Aeolian Edge']    = { set = 'AeolianEdge', element = 'Wind', moonshade = true },
    }

    local found = false
    for pattern, data in pairs(wsTable) do
        if wsName:find(pattern) then
            local setName = data.set .. '_Default'
            if sets[setName] then
                gFunc.EquipSet(sets[setName])
            end
            if meleeSet ~= 'Default' then
                local meleeSetName = data.set .. '_' .. meleeSet
                if sets[meleeSetName] then
                    gFunc.EquipSet(sets[meleeSetName])
                end
            end
            profile.Moonshade(data, player.TP)
            if data.element then
                profile.Hachirin(data.element)
            end
            found = true
            break
        end
    end
    if not found then
        if sets.Ws_Default then
            gFunc.EquipSet(sets.Ws_Default)
        end
        if meleeSet ~= 'Default' and sets['Ws_' .. meleeSet] then
            gFunc.EquipSet(sets['Ws_' .. meleeSet])
        end
    end
end

return profile;