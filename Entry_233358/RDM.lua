local profile = {};
gcinclude = gFunc.LoadFile('common\\gcinclude.lua');
JHaste = gFunc.LoadFile('common\\J-Haste.lua')

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
		Ring1 = 'Chirich Ring',
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

    Tp_Default = { --51 dt, total: 51 pdt 41 mdt
		Ammo = 'Coiste Bodhar',
		--Ammo = 'Sroda Tathlum',
        Head = 'Nyame Helm', --7 dt
        Neck = 'Anu Torque',
        Ear1 = 'Dedition Earring',
        Ear2 = 'Sherida Earring',
        Body = 'Lethargy Sayon +3', --14 dt
		--Hands = 'Aya. Manopolas +2', --3 dt
		Hands = 'Bunzi\'s Gloves', 
        Ring1 = 'Defending Ring', --10 dt
        Ring2 = 'Chirich Ring',
        Back = { Name = 'Sucellos\'s Cape', Augment = { [1] = 'Phys. dmg. taken -10%', [2] = 'Accuracy+30', [3] = 'Attack+20', [4] = '"Dual Wield"+10', [5] = 'DEX+20' } }, --10 pdt
        Waist = 'Sailfi Belt +1',
        Legs = 'Malignance Tights', --7 dt
        Feet = 'Leth. Houseaux +3', 
		
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
		Head = 'Atrophy Chapeau +3', --16
		Ear2 = 'Loquac. Earring', --2
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
		Ring1 = 'Meridian Ring',
		Waist = 'Plat. Mog. Belt',
		Ear1 = 'Eabani Earring',
		Neck = 'Sanctity Necklace',
		Head = 'Bunzi\'s Hat',
		Body = 'Bunzi\'s Robe', --15
        Hands = 'Telchine Gloves', --10
		Back = { Name = 'Sucellos\'s Cape', Augment = { [1] = 'Weapon skill damage +10%', [2] = 'Magic Damage+20', [3] = 'MND+30', [4] = 'Mag. Acc.+20' } },
		Legs = 'Atrophy Tights +3', --11
		Feet = 'Bunzi\'s Sabots',
		Ear2 = 'Meili Earring',
		Ring2 = 'Mephitas\'s Ring +1',
		
		
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
		Hands = 'Atrophy Gloves +3',
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
		Hands = 'Atrophy Gloves +3',
        Ring1 = 'Stikini Ring +1',
        Ring2 = 'Mephitas\'s Ring +1',
		Ear2 = 'Leth. Earring +1',
		Waist = 'Embla Sash',
		Legs = 'Atrophy Tights +3',
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
		Hands = 'Atrophy Gloves +3' --capped, don't need +skill from relic
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
		Ear2 = 'Vor Earring',
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
        Ear1 = 'Eabani Earring',
        Ear2 = 'Friomisi Earring',
        Body = 'Bunzi\'s Robe',
        Ring1 = 'Stikini Ring +1',
        Ring2 = 'Jhakri Ring',
        Back = { Name = 'Sucellos\'s Cape', Augment = { [1] = '"Mag. Atk. Bns."+10', [2] = 'Magic Damage+20', [3] = 'INT+30', [4] = 'Mag. Acc.+20' } },
        Waist = 'Acuity Belt +1',
        Legs = 'Leth. Fuseau +3',
        Feet = 'Leth. Houseaux +3',
		
    },

    Nuke = {
		Ammo = 'Ghastly Tathlum +1',
        Head = 'Ea Hat +1',
        Neck = 'Sibyl Scarf',
        Ear1 = 'Hecate\'s Earring',
        Ear2 = 'Friomisi Earring',
        Body = 'Lethargy Sayon +3',
        Hands = 'Leth. Ganth. +3',
        Ring1 = 'Jhakri Ring',
		Ring2 = 'Metamor. Ring +1',
        Back = { Name = 'Sucellos\'s Cape', Augment = { [1] = '"Mag. Atk. Bns."+10', [2] = 'Magic Damage+20', [3] = 'INT+30', [4] = 'Mag. Acc.+20' } },
        Waist = 'Acuity Belt +1',
        Legs = 'Leth. Fuseau +3',
        Feet = 'Leth. Houseaux +3',
    },

    CureNuke = {
		Ammo = 'Ghastly Tathlum +1',
        Head = 'Leth. Chappel +2',
        Neck = 'Dls. Torque +2',
        Ear1 = 'Hecate\'s Earring',
        Ear2 = 'Friomisi Earring',
        Body = 'Lethargy Sayon +3',
        Hands = 'Leth. Ganth. +3',
        Ring1 = 'Stikini Ring +1',
		Ring2 = 'Metamor. Ring +1',
        Back = { Name = 'Sucellos\'s Cape', Augment = { [1] = 'Weapon skill damage +10%', [2] = 'Magic Damage+20', [3] = 'MND+30', [4] = 'Mag. Acc.+20' } },
        Waist = 'Hachirin-no-Obi',
        Legs = 'Leth. Fuseau +3',
        Feet = 'Leth. Houseaux +3',
    },

    NukeACC = {};
    Burst = { --38 MB I without Bunzi's Rod, 48 with, (40 cap). Currently 20 MB II
		Ammo = 'Ghastly Tathlum +1',
        Head = 'Ea Hat +1', --7, 7 II
        Neck = 'Sibyl Scarf',
        Ear1 = 'Hecate\'s Earring',
        Ear2 = 'Friomisi Earring', 
        Body = 'Ea Houppelande', --8, 8 II
        Hands = 'Bunzi\'s Gloves', --8
        Ring1 = 'Mujin Band', --5 II
		Ring2 = 'Metamor. Ring +1',
        Back = { Name = 'Sucellos\'s Cape', Augment = { [1] = '"Mag. Atk. Bns."+10', [2] = 'Magic Damage+20', [3] = 'INT+30', [4] = 'Mag. Acc.+20' } },
        Waist = 'Acuity Belt +1',
        Legs = 'Leth. Fuseau +3', --15
        Feet = 'Leth. Houseaux +3',
		
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
        Ear1 = 'Brutal Earring',
        Ear2 = 'Sherida Earring',
        Body = 'Viti. Tabard +3',
        Hands = 'Atrophy Gloves +3',
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
		Ear1 = 'Hecate\'s Earring',
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
		Ear1 = 'Hecate\'s Earring',
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
		Ear1 = 'Hecate\'s Earring',
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
        Ear1 = 'Brutal Earring',
        Ear2 = 'Sherida Earring',
        Body = 'Nyame Mail',
        Hands = 'Atrophy Gloves +3',
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
        Ear1 = 'Brutal Earring',
        Ear2 = 'Sherida Earring',
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
        Ear1 = 'Brutal Earring',
        Ear2 = 'Sherida Earring',
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
        Ear1 = 'Brutal Earring',
        Ear2 = 'Sherida Earring',
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
        Ear1 = 'Brutal Earring',
        Ear2 = 'Sherida Earring',
        Body = 'Nyame Mail',
        Hands = 'Atrophy Gloves +3',
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
        Ear1 = 'Brutal Earring',
        Ear2 = 'Sherida Earring',
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
    local asleep = math.min(gData.GetBuffCount(2) + gData.GetBuffCount(193) + gData.GetBuffCount(19), 1);
    local player = gData.GetPlayer();

    gFunc.EquipSet(sets.Idle);
	
    if (player.Status == 'Engaged') then
        gFunc.EquipSet(sets.Tp_Default)
        if (gcdisplay.GetCycle('MeleeSet') ~= 'Default') then
            gFunc.EquipSet('Tp_' .. gcdisplay.GetCycle('MeleeSet')) end
        if gcdisplay.GetToggle('AutoDW') then
            local dwSet, totalDW = JHaste.GetDWGearSet(dwGearPool)
            if dwSet then
                if next(dwSet) == nil then
        -- Optionally unequip all slots that might have had DW gear.
                    gFunc.Equip('Ear1', nil)
                    gFunc.Equip('Ear2', nil)
                    gFunc.Equip('Back', nil)
                    gFunc.Equip('Waist', nil)
                    -- etc...
                end
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
    if gcdisplay.GetCycle('MH') == 'Naegling' then
        gFunc.EquipSet(sets.Naegling);
    elseif gcdisplay.GetCycle('MH') == 'Crocea' then
        gFunc.EquipSet(sets.Crocea);
    elseif gcdisplay.GetCycle('MH') == 'Maxentius' then
        gFunc.EquipSet(sets.Maxentius);
    elseif gcdisplay.GetCycle('MH') == 'Tauret' then
        gFunc.EquipSet(sets.Tauret);
    end
    --offhand
    if gcdisplay.GetCycle('OH') == 'TP Bonus' then
        gFunc.EquipSet(sets.TPBonusOH);
    elseif gcdisplay.GetCycle('OH') == 'Degen' then
        gFunc.EquipSet(sets.Degen);
    elseif gcdisplay.GetCycle('OH') == 'Bunzi' then
        gFunc.EquipSet(sets.Bunzi);
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

    local spell = gData.GetAction();
    local target = gData.GetActionTarget();
    local me = AshitaCore:GetMemoryManager():GetParty():GetMemberName(0);
    local player = gData.GetPlayer();

    if (spell.Skill == 'Enhancing Magic') then
        gFunc.EquipSet(sets.Enhancing);
        if (target.Name == me) then
            gFunc.EquipSet(sets.Self_Enhancing);
        end

        if string.match(spell.Name, 'Phalanx') then
            gFunc.EquipSet(sets.Phalanx);
			if (target.Name == me) then
				gFunc.EquipSet(sets.Self_Phalanx);
			end
        elseif string.match(spell.Name, 'Stoneskin') then
            gFunc.EquipSet(sets.Stoneskin);
        elseif string.contains(spell.Name, 'Temper') then
            gFunc.EquipSet(sets.Skill_Enhancing);
        elseif string.contains(spell.Name, 'Regen') then
            gFunc.EquipSet(sets.Regen);
        elseif string.contains(spell.Name, 'Refresh') then
            gFunc.EquipSet(sets.Refresh);
            if (target.Name == me) then
                gFunc.EquipSet(sets.Self_Refresh);
            end
        elseif (target.Name == me) and string.contains(spell.Name, 'En') then
            gFunc.EquipSet(sets.Skill_Enhancing);
		elseif (target.Name == me) and string.contains(spell.Name, 'Gain') then
            gFunc.EquipSet(sets.Gain);
        end
    elseif (spell.Skill == 'Healing Magic') then
        if string.contains(spell.Name, 'Cure') or string.contains(spell.Name, 'Curaga') then
            gFunc.EquipSet(sets.Cure);

            if (target.Name == me) then
             gFunc.EquipSet(sets.Self_Cure);
            end

            profile.Hachirin(spell.Element);

        end

        if target.Name == 'Skomora' or target.Name == 'Triboulex' then
            if string.match(spell.Name, 'Cure') then
                gFunc.EquipSet(sets.CureNuke);
                profile.Hachirin(spell.Element);
            end 
        end

        if string.match(spell.Name, 'Cursna') then
            gFunc.EquipSet(sets.Cursna);
        end
    elseif (spell.Skill == 'Elemental Magic') then
        gFunc.EquipSet(sets.Nuke);

        if (gcdisplay.GetToggle('NukeSet') == 'Macc') then
            gFunc.EquipSet(sets.NukeACC);
        end
        if (gcdisplay.GetToggle('Burst') == true) then
            gFunc.EquipSet(sets.Burst);
        end
        if string.match(spell.Name, 'helix') then
            gFunc.EquipSet(sets.Helix);
        end
        if (player.MPP <= 40) then
            gFunc.EquipSet(sets.Mp_Body);
        end
        --hachirin with storms
        profile.Hachirin(spell.Element);

    elseif (spell.Skill == 'Enfeebling Magic') then
        gFunc.EquipSet(sets.Enfeebling);
        if (gcdisplay.GetToggle('NukeSet') == 'Macc') then
            gFunc.EquipSet(sets.EnfeeblingACC);
        end
        if string.contains(spell.Name, 'Paralyze') or string.contains(spell.Name, 'Slow') or string.contains(spell.Name, 'Addle') then
            gFunc.EquipSet(sets.Mind_Enfeebling);
        elseif string.contains(spell.Name, 'Poison') then
            gFunc.EquipSet(sets.Int_Enfeebling);
        elseif string.contains(spell.Name, 'Distract') or string.match(spell.Name, 'Frazzle III') then
            gFunc.EquipSet(sets.Potency_Enfeebling);
        end
        --hachirin with storms
        profile.Hachirin(spell.Element);
    elseif (spell.Skill == 'Dark Magic') then
        gFunc.EquipSet(sets.EnfeeblingACC); -- mostly MACC anyways
        if (string.contains(spell.Name, 'Aspir') or string.contains(spell.Name, 'Drain')) then
            gFunc.EquipSet(sets.Drain);
        end
        profile.Hachirin(spell.Element);
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
    local canWS = gcinclude.CheckWsBailout();
    local weather = gData.GetEnvironment();
    if (canWS == false) then gFunc.CancelAction() return;
    else
        local ws = gData.GetAction();
    
        gFunc.EquipSet(sets.Ws_Default)
        if (gcdisplay.GetCycle('MeleeSet') ~= 'Default') then
        gFunc.EquipSet('Ws_' .. gcdisplay.GetCycle('MeleeSet')) end
   
        if string.match(ws.Name, 'Chant du Cygne') then
            gFunc.EquipSet(sets.Chant_Default)
            if (gcdisplay.GetCycle('MeleeSet') ~= 'Default') then
            gFunc.EquipSet('Chant_' .. gcdisplay.GetCycle('MeleeSet')); end
	    elseif string.match(ws.Name, 'Savage Blade') then
            gFunc.EquipSet(sets.Savage_Default)
            if (gcdisplay.GetCycle('MeleeSet') ~= 'Default') then
            gFunc.EquipSet('Savage_' .. gcdisplay.GetCycle('MeleeSet')); end
		elseif string.match(ws.Name, 'Black Halo') then
            gFunc.EquipSet(sets.BlackHalo_Default)
            if (gcdisplay.GetCycle('MeleeSet') ~= 'Default') then
            gFunc.EquipSet('BlackHalo_' .. gcdisplay.GetCycle('MeleeSet')); end
		elseif string.match(ws.Name, 'Sanguine Blade') then
            gFunc.EquipSet(sets.Sanguine_Default)
            profile.Hachirin('Dark');
            
		elseif string.match(ws.Name, 'Seraph Blade') or string.match(ws.Name, 'Shining Blade') then
            gFunc.EquipSet(sets.Seraph_Default);
            profile.Hachirin('Light');
            
		elseif string.match(ws.Name, 'Red Lotus Blade') or string.match(ws.Name, 'Burning Blade') then
            gFunc.EquipSet(sets.RedLotus_Default)
            profile.Hachirin("Fire");

        elseif string.match(ws.Name, 'Aeolian Edge') then
            gFunc.EquipSet(sets.AeolianEdge_Default)
            if (gcdisplay.GetCycle('MeleeSet') ~= 'Default') then
                gFunc.EquipSet('AeolianEdge_' .. gcdisplay.GetCycle('MeleeSet')); 
            end
            
            profile.Hachirin('Wind');

        end
    end
end

return profile;