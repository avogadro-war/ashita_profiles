local profile = {};
gcinclude = gFunc.LoadFile('common\\gcinclude.lua')
--!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! USE /lac addset <name> TO FIND CORRECT AUGMENT SYNTAX IF REQUIRED.!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!--
--!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! USE /lac addset <name> TO FIND CORRECT AUGMENT SYNTAX IF REQUIRED.!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!--
--!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! USE /lac addset <name> TO FIND CORRECT AUGMENT SYNTAX IF REQUIRED.!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!--
--!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! USE /lac addset <name> TO FIND CORRECT AUGMENT SYNTAX IF REQUIRED.!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!--

local dwGearPool = {
    -- Priority, Gear Slot, Item Name, Dual Wield value
    {1, 'Back', { Name = "Sucellos's Cape", Augment = { ['"Dual Wield"+10'] = true } }, 10},
    {2, 'Ear1', 'Eabani Earring', 4},
    {3, 'Ear2', 'Suppanomimi', 5},
    --{4, 'Waist', 'Reiki Yotai', 7},
}

local sets = {
    Idle = { --49 dt, total: 49 pdt 39 mdt
		Ammo = 'Staunch Tathlum +1', --3 dt
        Head = 'Viti. Chapeau +4',
        Neck = 'Warder\'s Charm +1',
        Ear1 = 'Eabani Earring',
        Ear2 = 'Hearty Earring',
        Body = 'Lethargy Sayon +3', --14 dt
        Hands = 'Nyame Gauntlets', --7 dt
        Ring1 = 'Stikini Ring +1',
        Ring2 = 'Shneddick Ring',
        Back = { Name = 'Sucellos\'s Cape', Augment = { [1] = 'Phys. dmg. taken -10%', [2] = 'Accuracy+30', [3] = 'Attack+20', [4] = '"Dual Wield"+10', [5] = 'DEX+20' } }, --10 pdt
        Waist = 'Carrier\'s Sash',
        Legs = 'Nyame Flanchard', --8 dt
        Feet = 'Nyame Sollerets', --7 dt
    },
    Resting = {},
    Idle_Regen = {
		Ring1 = 'Chirich Ring +1',
        Neck = 'Sanctity Necklace',
    },
    Idle_Refresh = {
		Neck = 'Loricate Torque +1',
		Hands = 'Volte Gloves',
		Legs = { Name = 'Chironic Hose', Augment = { [1] = '"Mag. Atk. Bns."+7', [2] = 'Mag. Acc.+7', [3] = 'Accuracy+10', [4] = '"Refresh"+2', [5] = 'AGI+8', [6] = 'Attack+12' } },
    },
	   Lockstyle = { 
	   --Head = 'Adenium Masque',
       -- Body = 'Adenium Suit',
		Head = 'Leth. Chappel +2',
		Body = 'Lethargy Sayon +3',
		Hands = 'Leth. Ganth. +3',
		Legs = 'Leth. Fuseau +3',
		Feet = 'Leth. Houseaux +3',

    },
    Town = {
        
    },

    Dt = {
		Ammo = 'Staunch Tathlum +1',
        Head = 'Nyame Helm',
		Body = 'Nyame Mail',
		Hands = 'Nyame Gauntlets',
        Back = { Name = 'Sucellos\'s Cape', Augment = { [1] = 'Phys. dmg. taken -10%', [2] = 'Accuracy+30', [3] = 'Attack+20', [4] = '"Dual Wield"+10', [5] = 'DEX+20' } }, --10 pdt
        Legs = 'Nyame Flanchard',
		Feet = 'Nyame Sollerets',
		Ring1 = 'Defending Ring',

    },

    Tp_Default = { --54 dt, total: 54 pdt 40 mdt
		Ammo = 'Coiste Bodhar',
		--Ammo = 'Sroda Tathlum',
        Head = 'Malignance Chapeau', --6 dt
        Neck = 'Anu Torque',
        Ear1 = 'Dedition Earring',
        Ear2 = 'Sherida Earring',
        Body = 'Lethargy Sayon +3', --14 dt
		--Hands = 'Aya. Manopolas +2', --3 dt
		Hands = 'Bunzi\'s Gloves', 
        Ring1 = 'Defending Ring', --10 dt
        Ring2 = 'Chirich Ring +1',
        Back = { Name = 'Sucellos\'s Cape', Augment = { [1] = 'Phys. dmg. taken -10%', [2] = 'Accuracy+30', [3] = 'Attack+20', [4] = '"Dual Wield"+10', [5] = 'DEX+20' } }, --10 pdt
        Waist = 'Sailfi Belt +1',
        Legs = 'Malignance Tights', --7 dt
        Feet = 'Carmine Greaves +1', --4 pdt
		
    },
    Tp_Hybrid = {
        
    },
    Tp_Acc = {

    },


    Precast = { --38 from traits, 42 needed from gear to cap(80).
		Ammo = 'Impatiens', --2 QUICKCAST
		Ring2 = 'Meridian Ring',
		Waist = 'Plat. Mog. Belt',
		Ear1 = 'Etiolation Earring', --1
		Feet = 'Nyame Sollerets',
		Hands = 'Nyame Gauntlets',
		Back = 'Twilight Cape', --replace with QUICKCAST cape when you can
		Head = 'Atro. Chapeau +4', --16
		Ear2 = 'Malignance Earring', --4
		Body = 'Viti. Tabard +3', --15
		Ring1 = 'Lebeche Ring', --2 QUICKCAST
		Waist = 'Witful Belt', --3, 3 QUICKCAST
		Legs = 'Aya. Cosciales +2', --6
		
    },
    Cure_Precast = {

    },
    Enhancing_Precast = {

    },
    Stoneskin_Precast = {

    },


    Cure = {--I cap is 50, II cap is 30
		Ammo = 'Clarus Stone',
		Ear2 = 'Odnowa Earring +1',
		Ring1 = 'Defending Ring',
		Waist = 'Plat. Mog. Belt',
		Ear1 = 'Eabani Earring',
		Neck = 'Sanctity Necklace',
		Head = 'Bunzi\'s Hat',
		Body = 'Bunzi\'s Robe', --15
        Hands = 'Kaykaus Cuffs +1', --11
		Back = { Name = 'Sucellos\'s Cape', Augment = { [1] = 'Weapon skill damage +10%', [2] = 'Magic Damage+20', [3] = 'MND+30', [4] = 'Mag. Acc.+20' } },
		Legs = 'Atro. Tights +4', --12
		Feet = 'Kaykaus Boots +1', --15
		Ring2 = 'Gelatinous Ring +1',
		
		
    },
    Self_Cure = {--cap 30
		Waist = 'Gishdubar Sash',
		
    },
    Regen = {
		Ammo = 'Clarus Stone',
		Body = { Name = 'Telchine Chas.', Augment = '"Regen" potency+3' },
		Hands = { Name = 'Taeon Gloves', Augment = '"Regen" potency+3' },
		Legs = { Name = 'Telchine Braconi', Augment = '"Regen" potency+3' },
		
    },
    Cursna = {
		Ammo = 'Clarus Stone',
		Ear1 = 'Eabani Earring',
	    Neck = 'Sanctity Necklace',
		Head = 'Viti. Chapeau +4',
		Body = 'Viti. Tabard +3',
		Hands = 'Nyame Gauntlets',
	    Ring1 = 'Stikini Ring +1',
		Ring2 = 'Menelaus\'s Ring',
		Legs = 'Carmine Cuisses +1',
		Feet = 'Nyame Sollerets',
		Back = { Name = 'Sucellos\'s Cape', Augment = { [1] = 'Weapon skill damage +10%', [2] = 'Magic Damage+20', [3] = 'MND+30', [4] = 'Mag. Acc.+20' } },
		Waist = 'Gishdubar Sash',
		Ear2 = 'Meili Earring',
		
    },

    Enhancing = {
		Ammo = 'Clarus Stone',
		Ear1 = 'Eabani Earring',
		Head = 'Lethargy Chappel +1',
		Neck = 'Dls. Torque +2',
		Body = 'Lethargy Sayon +3',
		Hands = 'Atro. Gloves +4',
        Ring1 = 'Stikini Ring +1',
        Ring2 = 'Mephitas\'s Ring +1',
		Ear2 = 'Leth. Earring +1',
		Waist = 'Embla Sash',
		Legs = 'Leth. Fuseau +3',
		Back = { Name = 'Sucellos\'s Cape', Augment = { [1] = 'Weapon skill damage +10%', [2] = 'Magic Damage+20', [3] = 'MND+30', [4] = 'Mag. Acc.+20' } },
		Feet = 'Leth. Houseaux +3',
    },
    Self_Enhancing = {
		Ammo = 'Clarus Stone',
		Head = 'Viti. Chapeau +4',
		Neck = 'Dls. Torque +2',
		Body = 'Viti. Tabard +3',
		Hands = 'Atro. Gloves +4',
        Ring1 = 'Stikini Ring +1',
        Ring2 = 'Mephitas\'s Ring +1',
		Ear2 = 'Leth. Earring +1',
		Waist = 'Embla Sash',
		Legs = 'Atro. Tights +4',
		Back = { Name = 'Sucellos\'s Cape', Augment = { [1] = 'Weapon skill damage +10%', [2] = 'Magic Damage+20', [3] = 'MND+30', [4] = 'Mag. Acc.+20' } },
		Feet = 'Leth. Houseaux +3',
	
	},
	Gain = {
		Ammo = 'Clarus Stone',
		Hands = 'Viti. Gloves +3',
		
	},
    Skill_Enhancing = {
		Ammo = 'Clarus Stone',
		Neck = 'Melic Torque',
		Ear1 = 'Mimir Earring',
		Hands = 'Viti. Gloves +3',
		Ring1 = 'Stikini Ring +1',
        Ring2 = 'Stikini Ring +1',
		Waist = 'Olympus Sash',
		Back = 'Ghostfyre Cape',

	},
    Stoneskin = {
		Ammo = 'Clarus Stone',
		Ring1 = 'Defending Ring',
		Waist = 'Siegel Sash',
    },
	
	
    Phalanx = {
		Ammo = 'Clarus Stone',
		Hands = 'Atro. Gloves +4' --capped, don't need +skill from relic
	},
	
	Self_Phalanx = {
		Ammo = 'Clarus Stone',
		Head = { Name = 'Taeon Chapeau', Augment = 'Phalanx +3' },
		Body = { Name = 'Taeon Tabard', Augment = 'Phalanx +3' },
		Hands = { Name = 'Taeon Gloves', Augment = 'Phalanx +3' },
		Legs = { Name = 'Taeon Tights', Augment = 'Phalanx +3' },
		Feet = { Name = 'Taeon Boots', Augment = 'Phalanx +3' },
	},
	
    Refresh = {
		Ammo = 'Clarus Stone',
		Head = 'Amalric Coif +1',
		Body = 'Atrophy Tabard +4',
		Legs = 'Leth. Fuseau +3',
		
    },
	
    Self_Refresh = {
		Ammo = 'Clarus Stone',
		Head = 'Amalric Coif +1',
		Body = 'Atrophy Tabard +4',
		Waist = 'Gishdubar Sash',
		Legs = 'Leth. Fuseau +3',
		
	},


    Enfeebling = {
        Head = 'Viti. Chapeau +4',
        Neck = 'Dls. Torque +2',
        Ear1 = 'Snotra Earring',
		Ear2 = 'Malignance Earring',
        Body = 'Atrophy Tabard +4',
        Hands = 'Leth. Ganth. +3',
        Ring1 = 'Stikini Ring +1',
        Ring2 = 'Kishar Ring',
        Back = { Name = 'Sucellos\'s Cape', Augment = { [1] = 'Weapon skill damage +10%', [2] = 'Magic Damage+20', [3] = 'MND+30', [4] = 'Mag. Acc.+20' } },
		Waist = 'Acuity Belt +1',
		Legs = { Name = 'Chironic Hose', Augment = { [1] = '"Resist Silence"+7', [2] = '"Mag. Atk. Bns."+3', [3] = 'MND+14', [4] = 'Mag. Acc.+30' } },
        Feet = 'Viti. Boots +4',
		
    },
    EnfeeblingACC = { --used when MACC toggle is on
    },
    Mind_Enfeebling = { --Paralyze, slow, addle
	
    },
    Int_Enfeebling = { --Poison
		Neck = 'Sibyl Scarf',
		Back = { Name = 'Sucellos\'s Cape', Augment = { [1] = '"Mag. Atk. Bns."+10', [2] = 'Magic Damage+20', [3] = 'INT+30', [4] = 'Mag. Acc.+20' } },
		Waist = 'Acuity Belt +1',
	
	},
    Potency_Enfeebling = { --Distract 1-3, Frazzle 3
		Body = 'Lethargy Sayon +3',
		Ring2 = 'Metamor. Ring +1',
		
	},
	

    Drain = {
        Head = 'Leth. Chappel +2',
        Neck = 'Erra Pendant',
        Ear1 = 'Malignance Earring',
        Ear2 = 'Leth. Earring +1',
        Body = 'Bunzi\'s Robe',
        Ring1 = 'Stikini Ring +1',
        Ring2 = 'Jhakri Ring',
        Back = { Name = 'Sucellos\'s Cape', Augment = { [1] = '"Mag. Atk. Bns."+10', [2] = 'Magic Damage+20', [3] = 'INT+30', [4] = 'Mag. Acc.+20' } },
        Waist = 'Acuity Belt +1',
        Legs = 'Leth. Fuseau +3',
        Feet = 'Leth. Houseaux +3',
		
    },
	
	AbsTP = {
		Ammo = 'Ghastly Tathlum +1',
		Head = 'Atro. Chapeau +4', 
		Neck = 'Erra Pendant',
		Ear1 = 'Malignance Earring',
		Ear2 = 'Leth. Earring +1',
		Body = 'Atrophy Tabard +4',
		Hands = 'Atro. Gloves +4',
		Ring1 = 'Stikini Ring +1',
		Ring2 = 'Stikini Ring +1',
		Back = 'Aurist\'s Cape +1',
		Waist = 'Acuity Belt +1',
		Legs = 'Atro. Tights +4',
		Feet = 'Atro. Boots +4',

	},

    Nuke = {
		Ammo = 'Ghastly Tathlum +1',
        Head = 'Ea Hat +1',
        Neck = 'Sibyl Scarf',
        Ear1 = 'Malignance Earring',
        Ear2 = 'Friomisi Earring',
        Body = 'Lethargy Sayon +3',
        Hands = 'Leth. Ganth. +3',
        Ring1 = 'Jhakri Ring',
		Ring2 = 'Metamor. Ring +1',
        Back = { Name = 'Sucellos\'s Cape', Augment = { [1] = '"Mag. Atk. Bns."+10', [2] = 'Magic Damage+20', [3] = 'INT+30', [4] = 'Mag. Acc.+20' } },
        Waist = 'Acuity Belt +1',
        Legs = 'Leth. Fuseau +3',
        Feet = 'Viti. Boots +4',
    },

    CureNuke = {
		Ammo = 'Ghastly Tathlum +1',
        Head = 'Leth. Chappel +2',
        Neck = 'Dls. Torque +2',
        Ear1 = 'Malignance Earring',
        Ear2 = 'Friomisi Earring',
        Body = 'Lethargy Sayon +3',
        Hands = 'Leth. Ganth. +3',
        Ring1 = 'Stikini Ring +1',
		Ring2 = 'Metamor. Ring +1',
        Back = { Name = 'Sucellos\'s Cape', Augment = { [1] = 'Weapon skill damage +10%', [2] = 'Magic Damage+20', [3] = 'MND+30', [4] = 'Mag. Acc.+20' } },
        Waist = 'Hachirin-no-Obi',
        Legs = 'Leth. Fuseau +3',
        Feet = 'Viti. Boots +4',
    },

    NukeACC = {};
    Burst = { --38 MB I without Bunzi's Rod, 48 with, (40 cap). Currently 20 MB II
		Ammo = 'Ghastly Tathlum +1',
        Head = 'Ea Hat +1', --7, 7 II
        Neck = 'Sibyl Scarf',
        Ear1 = 'Malignance Earring',
        Ear2 = 'Friomisi Earring', 
        Body = 'Ea Houppelande', --8, 8 II
        Hands = 'Bunzi\'s Gloves', --8
        Ring1 = 'Mujin Band', --5 II
		Ring2 = 'Metamor. Ring +1',
        Back = { Name = 'Sucellos\'s Cape', Augment = { [1] = '"Mag. Atk. Bns."+10', [2] = 'Magic Damage+20', [3] = 'INT+30', [4] = 'Mag. Acc.+20' } },
        Waist = 'Acuity Belt +1',
        Legs = 'Leth. Fuseau +3', --15
        Feet = 'Viti. Boots +4',
		
    },
    Helix = {
	
	},
    Mp_Body = {
	
	},

    Preshot = {
	
    },
    Midshot = {

    },

    Ws_Default = {
		Ammo = 'Oshasha\'s Treatise',
		Head = 'Viti. Chapeau +4',
        Neck = 'Rep. Plat. Medal',
        Ear1 = 'Sherida Earring',
        Ear2 = 'Ishvara Earring',
        Body = 'Viti. Tabard +3',
        Hands = 'Atro. Gloves +4',
        Ring1 = 'Cornelia\'s Ring',
        Ring2 = 'Rajas Ring',
        Back = { Name = 'Sucellos\'s Cape', Augment = { [1] = 'STR+20', [2] = 'Weapon skill damage +10%', [3] = 'Attack+20', [4] = 'Accuracy+20' } },
        Waist = 'Sailfi Belt +1',
        Legs = 'Viti. Tights +3',
        Feet = 'Leth. Houseaux +3',
		
    },
	
    Ws_Hybrid = {
	
    },
	
    Ws_Acc = {
	
    },
	Seraph_Default = {
		Ammo = 'Sroda Tathlum',
		Head = 'Viti. Chapeau +4',
		Neck = 'Sibyl Scarf',
		Ear1 = 'Malignance Earring',
        Ear2 = 'Friomisi Earring',
		Body = 'Lethargy Sayon +3',
		Hands = 'Jhakri Cuffs +2',
		Ring1 = 'Cornelia\'s Ring',
		Ring2 = 'Metamor. Ring +1',
		Back = { Name = 'Sucellos\'s Cape', Augment = { [1] = 'Weapon skill damage +10%', [2] = 'Magic Damage+20', [3] = 'MND+30', [4] = 'Mag. Acc.+20' } },
		Waist = 'Acuity Belt +1',
		Legs = 'Leth. Fuseau +3',
		Feet = 'Leth. Houseaux +3',
	},
	RedLotus_Default = {
		Ammo = 'Sroda Tathlum',
		Head = 'Viti. Chapeau +4',
		Neck = 'Sibyl Scarf',
		Ear1 ='Malignance Earring',
        Ear2 = 'Friomisi Earring',
		Body = 'Lethargy Sayon +3',
		Hands = 'Jhakri Cuffs +2',
		Ring1 = 'Cornelia\'s Ring',
		Ring2 = 'Jhakri Ring',
		Back = { Name = 'Sucellos\'s Cape', Augment = { [1] = 'STR+20', [2] = 'Weapon skill damage +10%', [3] = 'Attack+20', [4] = 'Accuracy+20' } },
		Waist = 'Acuity Belt +1',
		Legs = 'Leth. Fuseau +3',
		Feet = 'Leth. Houseaux +3',
	},
	Sanguine_Default = {
		Ammo = 'Sroda Tathlum',
		Head = 'Pixie Hairpin +1',
		Neck = 'Sibyl Scarf',
		Ear1 = 'Malignance Earring',
        Ear2 = 'Friomisi Earring',
		Body = 'Lethargy Sayon +3',
		Hands = 'Jhakri Cuffs +2',
		Ring1 = 'Cornelia\'s Ring',
		Ring2 = 'Archon Ring',
		Back = { Name = 'Sucellos\'s Cape', Augment = { [1] = 'Weapon skill damage +10%', [2] = 'Magic Damage+20', [3] = 'MND+30', [4] = 'Mag. Acc.+20' } },
		Waist = 'Acuity Belt +1',
		Legs = 'Leth. Fuseau +3',
		Feet = 'Leth. Houseaux +3',
		
	},
	
    Savage_Default = {
		Ammo = 'Oshasha\'s Treatise',
		Head = 'Viti. Chapeau +4',
        Neck = 'Rep. Plat. Medal',
        Ear1 = 'Sherida Earring',
        Ear2 = 'Ishvara Earring',
        Body = 'Nyame Mail',
        Hands = 'Atro. Gloves +4',
        Ring1 = 'Cornelia\'s Ring',
        Ring2 = 'Rajas Ring',
        Back = { Name = 'Sucellos\'s Cape', Augment = { [1] = 'STR+20', [2] = 'Weapon skill damage +10%', [3] = 'Attack+20', [4] = 'Accuracy+20' } },
        Waist = 'Sailfi Belt +1',
        Legs = 'Nyame Flanchard',
        Feet = 'Leth. Houseaux +3',

    },
	
    Savage_Hybrid = {
		Ammo = 'Crepuscular Pebble',
		Head = 'Nyame Helm',
        Neck = 'Rep. Plat. Medal',
        Ear1 = 'Sherida Earring',
        Ear2 = 'Ishvara Earring',
        Body = 'Nyame Mail',
        Hands = 'Nyame Gauntlets',
        Ring1 = 'Cornelia\'s Ring',
        Ring2 = 'Rajas Ring',
        Back = { Name = 'Sucellos\'s Cape', Augment = { [1] = 'STR+20', [2] = 'Weapon skill damage +10%', [3] = 'Attack+20', [4] = 'Accuracy+20' } },
        Waist = 'Sailfi Belt +1',
        Legs = 'Nyame Flanchard',
        Feet = 'Nyame Sollerets',

	},
	
    Savage_Acc = {

	},

    Chant_Default = {
		Ammo = 'Oshasha\'s Treatise',
	    Head = 'Viti. Chapeau +4',
        Neck = 'Fotia Gorget',
        Ear1 = 'Sherida Earring',
        Ear2 = 'Leth. Earring +1',
        Body = 'Nyame Mail',
        Hands = 'Bunzi\'s Gloves',
        Ring1 = 'Epona\'s Ring',
        Ring2 = 'Rajas Ring',
        Back = { Name = 'Sucellos\'s Cape', Augment = { [1] = 'STR+20', [2] = 'Weapon skill damage +10%', [3] = 'Attack+20', [4] = 'Accuracy+20' } },
        Waist = 'Fotia Belt',
        Legs = 'Nyame Flanchard',
        Feet = 'Nyame Sollerets',
    },
	
    Chant_Hybrid = {
		Ammo = 'Crepuscular Pebble',
		Head = 'Nyame Helm',
        Neck = 'Rep. Plat. Medal',
        Ear1 = 'Sherida Earring',
        Ear2 = 'Leth. Earring +1',
        Body = 'Nyame Mail',
        Hands = 'Bunzi\'s Gloves',
        Ring1 = 'Cornelia\'s Ring',
        Ring2 = 'Rajas Ring',
        Back = { Name = 'Sucellos\'s Cape', Augment = { [1] = 'STR+20', [2] = 'Weapon skill damage +10%', [3] = 'Attack+20', [4] = 'Accuracy+20' } },
        Waist = 'Sailfi Belt +1',
        Legs = 'Nyame Flanchard',
        Feet = 'Leth. Houseaux +3',
	},
	
    Chant_Acc = {
	
	},
	
	BlackHalo_Default = {
		Ammo = 'Oshasha\'s Treatise',
		Head = 'Viti. Chapeau +4',
        Neck = 'Rep. Plat. Medal',
        Ear1 = 'Sherida Earring',
        Ear2 = 'Ishvara Earring',
        Body = 'Nyame Mail',
        Hands = 'Atro. Gloves +4',
        Ring1 = 'Cornelia\'s Ring',
        Ring2 = 'Rajas Ring',
        Back = { Name = 'Sucellos\'s Cape', Augment = { [1] = 'STR+20', [2] = 'Weapon skill damage +10%', [3] = 'Attack+20', [4] = 'Accuracy+20' } },
        Waist = 'Sailfi Belt +1',
        Legs = 'Nyame Flanchard',
        Feet = 'Leth. Houseaux +3',
    },
	
    BlackHalo_Hybrid = {
		Ammo = 'Crepuscular Pebble',
		Head = 'Nyame Helm',
        Neck = 'Rep. Plat. Medal',
        Ear1 = 'Sherida Earring',
        Ear2 = 'Ishvara Earring',
        Body = 'Nyame Mail',
        Hands = 'Nyame Gauntlets',
        Ring1 = 'Cornelia\'s Ring',
        Ring2 = 'Rajas Ring',
        Back = { Name = 'Sucellos\'s Cape', Augment = { [1] = 'STR+20', [2] = 'Weapon skill damage +10%', [3] = 'Attack+20', [4] = 'Accuracy+20' } },
        Waist = 'Sailfi Belt +1',
        Legs = 'Nyame Flanchard',
        Feet = 'Leth. Houseaux +3',
	},
	
    BlackHalo_Acc = {
	
	},

    AeolianEdge_Default = {
		Ammo = 'Oshasha\'s Treatise',
		Head = 'Viti. Chapeau +4',
		Neck = 'Sibyl Scarf',
		Ear1 = 'Hecate\'s Earring',
        Ear2 = 'Friomisi Earring',
		Body = 'Lethargy Sayon +3',
		Hands = 'Jhakri Cuffs +2',
		Ring1 = 'Cornelia\'s Ring',
		Ring2 = 'Jhakri Ring',
        Back = { Name = 'Sucellos\'s Cape', Augment = { [1] = 'Weapon skill damage +10%', [2] = 'Magic Damage+20', [3] = 'MND+30', [4] = 'Mag. Acc.+20' } },
		Waist = 'Acuity Belt +1',
		Legs = 'Leth. Fuseau +3',
		Feet = 'Leth. Houseaux +3',
    },

    AeolianEdge_Hybrid = {

    },

    AeolianEdge_Acc = {

    },

    CS = {
		Body = 'Viti. Tabard +3',
		
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
    Naegling = {
        Main = 'Naegling',
    },
    Crocea = {
        Main = 'Crocea Mors',
    },
    Maxentius = {
        Main = 'Maxentius',
    },
    Tauret = {
        Main = 'Tauret',
    },
    TPBonusOH = {
        Sub = 'Thibron',
    },
    Bunzi = {
        Sub = 'Bunzi\'s Rod',
    },
    Degen = {
        Sub = 'Demers. Degen +1',
    },
    Ullr = {
        Range = 'Ullr',
        Ammo = 'Horn Arrow',
    },
    WakeUp = {
        Main = 'Caliburnus',
    }


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

    AshitaCore:GetChatManager():QueueCommand(1, '/macro book 1');
    AshitaCore:GetChatManager():QueueCommand(1, '/macro set 10');
end


profile.OnUnload = function()
    gcinclude.Unload()
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
    local asleep = math.min(gData.GetBuffCount(2) + gData.GetBuffCount(193) + gData.GetBuffCount(19), 1);
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
        -- Optional debug message
        -- print(chat.header('GCinclude'):append(chat.message('DW Needed: ' .. JHaste.dwNeeded .. ', Equipped DW: ' .. totalDW)))
        if (gcdisplay.GetToggle('TH') == true) then 
            gFunc.EquipSet(sets.TH) 
        end
    elseif (player.Status == 'Resting') then
        gFunc.EquipSet(sets.Resting);
    elseif (player.IsMoving == true) then
		gFunc.EquipSet(sets.Movement)
    end

    --main wep
    local mainHandSets = {
    ['Naegling']  = sets.Naegling,
    ['Crocea']    = sets.Crocea,
    ['Maxentius'] = sets.Maxentius,
    ['Tauret']    = sets.Tauret,
    }

    -- Off Hand weapon sets
    local offHandSets = {
    ['TP Bonus'] = sets.TPBonusOH,
    ['Degen']    = sets.Degen,
    ['Bunzi']    = sets.Bunzi,
    }

    -- Equip main hand set if it exists
    local mhSet = mainHandSets[gcdisplay.GetCycle('MH')]
    if mhSet then gFunc.EquipSet(mhSet) end
    
    -- Equip off hand set if it exists
    if player.SubJob == 'NIN' or player.SubJob == 'DNC' then
        local ohSet = offHandSets[gcdisplay.GetCycle('OH')]
        gFunc.EquipSet(ohSet) 
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
	
    gcinclude.CheckDefault ();
    if (gcdisplay.GetToggle('DTset') == true) then gFunc.EquipSet(sets.Dt) end;
    if (gcdisplay.GetToggle('Kite') == true) then gFunc.EquipSet(sets.Movement) end;
end

profile.HandleAbility = function()
    local ability = gData.GetAction();

    if ability.Name == 'Chainspell' then
        gFunc.EquipSet(sets.CS);
    end

    gcinclude.CheckCancels();
end

profile.HandleItem = function()
    local item = gData.GetAction();

	if string.match(item.Name, 'Holy Water') then gFunc.EquipSet(gcinclude.sets.Holy_Water) end
end

profile.HandlePrecast = function()
    local spell = gData.GetAction();
    gFunc.EquipSet(sets.Precast)

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
    local spell = gData.GetAction()
    local target = gData.GetActionTarget()
    local me = AshitaCore:GetMemoryManager():GetParty():GetMemberName(0)
    local player = gData.GetPlayer()

    local skill = spell.Skill
    local spellName = spell.Name
    local targetIsSelf = target.Name == me

    ------------------------------------------------------------
    -- Enhancing Magic
    ------------------------------------------------------------
    if skill == 'Enhancing Magic' then
        gFunc.EquipSet(sets.Enhancing)
        if targetIsSelf then gFunc.EquipSet(sets.Self_Enhancing) end

        local enhancingCases = {
            Phalanx = function()
                gFunc.EquipSet(sets.Phalanx)
                if targetIsSelf then gFunc.EquipSet(sets.Self_Phalanx) end
            end,
            Stoneskin = function() gFunc.EquipSet(sets.Stoneskin) end,
            Temper = function() gFunc.EquipSet(sets.Skill_Enhancing) end,
            Regen = function() gFunc.EquipSet(sets.Regen) end,
            Refresh = function()
                gFunc.EquipSet(sets.Refresh)
                if targetIsSelf then gFunc.EquipSet(sets.Self_Refresh) end
            end,
            En = function()
                if targetIsSelf then gFunc.EquipSet(sets.Skill_Enhancing) end
            end,
            Gain = function()
                if targetIsSelf then gFunc.EquipSet(sets.Gain) end
            end,
        }

        for key, handler in pairs(enhancingCases) do
            if spellName:contains(key) then
                handler()
                break
            end
        end

    ------------------------------------------------------------
    -- Healing Magic
    ------------------------------------------------------------
    elseif skill == 'Healing Magic' then
        if spellName:contains('Cure') or spellName:contains('Curaga') then
            gFunc.EquipSet(sets.Cure)
            if targetIsSelf then gFunc.EquipSet(sets.Self_Cure) end
            profile.Hachirin(spell.Element)
        end

        if target.Name == 'Skomora' or target.Name == 'Triboulex' then
            if spellName:match('Cure') then
                gFunc.EquipSet(sets.CureNuke)
                profile.Hachirin(spell.Element)
            end
        end

        if spellName:match('Cursna') then
            gFunc.EquipSet(sets.Cursna)
        end

    ------------------------------------------------------------
    -- Elemental Magic
    ------------------------------------------------------------
    elseif skill == 'Elemental Magic' then
        gFunc.EquipSet(sets.Nuke)

        if gcdisplay.GetToggle('NukeSet') == 'Macc' then
            gFunc.EquipSet(sets.NukeACC)
        end
        if gcdisplay.GetToggle('Burst') then
            gFunc.EquipSet(sets.Burst)
        end
        if spellName:match('helix') then
            gFunc.EquipSet(sets.Helix)
        end
        if player.MPP <= 40 then
            gFunc.EquipSet(sets.Mp_Body)
        end

        profile.Hachirin(spell.Element)

    ------------------------------------------------------------
    -- Enfeebling Magic
    ------------------------------------------------------------
    elseif skill == 'Enfeebling Magic' then
        gFunc.EquipSet(sets.Enfeebling)
        if gcdisplay.GetToggle('NukeSet') == 'Macc' then
            gFunc.EquipSet(sets.EnfeeblingACC)
        end

        local enfeeblingCases = {
            Paralyze = sets.Mind_Enfeebling,
            Slow = sets.Mind_Enfeebling,
            Addle = sets.Mind_Enfeebling,
            Poison = sets.Int_Enfeebling,
            Distract = sets.Potency_Enfeebling,
            ['Frazzle III'] = sets.Potency_Enfeebling,
        }

        for key, set in pairs(enfeeblingCases) do
            if spellName:contains(key) then
                gFunc.EquipSet(set)
                break
            end
        end

        profile.Hachirin(spell.Element)

    ------------------------------------------------------------
    -- Dark Magic
    ------------------------------------------------------------
    elseif skill == 'Dark Magic' then
        gFunc.EquipSet(sets.AbsTP) -- Base MACC
        if spellName:contains('Aspir') or spellName:contains('Drain') then
            gFunc.EquipSet(sets.Drain)
        end
        profile.Hachirin(spell.Element)
    end

    ------------------------------------------------------------
    -- TH Toggle
    ------------------------------------------------------------
    if gcdisplay.GetToggle('TH') then
        gFunc.EquipSet(sets.TH)
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
        --Sword
        ['Chant du Cygne']  = { set = 'Chant',    element = nil,       moonshade = false },
        ['Savage Blade']    = { set = 'Savage', element = nil,         moonshade = true },
        ['Sanguine Blade']  = { set = 'Sanguine', element = 'Dark',    moonshade = false },
        ['Seraph Blade']    = { set = 'Seraph', element = 'Light',     moonshade = true },
        ['Shining Blade']   = { set = 'Seraph', element = 'Light',     moonshade = true },
        ['Red Lotus Blade'] = { set = 'RedLotus', element = 'Fire',    moonshade = true },
        ['Burning Blade']   = { set = 'RedLotus',    element = 'Fire', moonshade = true },
        --Mace
        ['Black Halo']      = { set = 'BlackHalo', element = nil,      moonshade = true },
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