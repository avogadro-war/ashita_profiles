local profile = {}
gcinclude = gFunc.LoadFile('common\\gcinclude.lua')

-- Move static weapon/cycle tables outside functions for reuse
local MHWep = {
    ['Naegling'] = 'Naegling',
    ['Melee Rostam'] = { Name = 'Rostam', AugPath = 'B' },
    ['Range Rostam'] = { Name = 'Rostam', AugPath = 'A' },
}
local OHWep = {
    ['Gleti'] = 'Gleti\'s Knife',
    ['Degen'] = 'Demersal Degen +1',
    ['Tauret'] = 'Tauret',
    ['Roll Rostam'] = { Name = 'Rostam', AugPath = 'C' },
}
local RWep = {
    ['Death Penalty'] = 'Death Penalty',
    ['Fomalhaut'] = 'Fomalhaut',
    ['TP Bonus'] = 'Anarchy +2',
}
local Ammo = {
    ['MAB'] = 'Living Bullet',
    ['Phys.'] = 'Chrono Bullet',
    ['Brz.'] = 'Bronze Bullet',
}
local exactGearSets = {
    ['Wild Card'] = 'WildCard',
    ['Fold'] = 'Fold',
    ['Random Deal'] = 'RandomDeal',
    ['Snake Eye'] = 'SnakeEye',
}

-- Copy sets and other static data from original COR.lua (not shown here for brevity)
local sets = {
    Idle = {
        Head = 'Nyame Helm',
        Neck = 'Warder\'s Charm +1',
        Ear1 = 'Eabani Earring',
        Ear2 = 'Hearty Earring',
        Body = 'Nyame Mail',
        Hands = 'Nyame Gauntlets',
        Ring1 = 'Shadow Ring',
        Ring2 = 'Shneddick Ring',
        Back = { Name = 'Camulus\'s Mantle', Augment = { [1] = 'Phys. dmg. taken -10%', [2] = 'Accuracy+20', [3] = 'DEX+30', [4] = 'Attack+20', [5] = '"Dual Wield"+10' } },
        Waist = 'Plat. Mog. Belt',
        Legs = 'Nyame Flanchard',
        Feet = 'Nyame Sollerets',
    },
    Idle_TPgun = {
        Range = 'Anarchy +2',
    },
    Resting = {},
    Idle_Regen = {
        Head = 'Meghanada Visor +2',
        Neck = 'Bathy Choker +1',
        Ear1 = 'Infused Earring',
        Body = 'Meg. Cuirie +2',
        Ring2 = 'Chirich Ring +1',
        Legs = 'Meg. Chausses +2',
        Feet = 'Meg. Jam. +2',
    },
    Idle_Refresh = {
        Head = 'Rawhide Mask',
        Ring1 = 'Stikini Ring +1',
    },
    Town = {
        Main = 'Naegling',
        Sub = 'Nusku Shield',
        Range = 'Death Penalty',
        Ammo = 'Living Bullet',
        Head = 'Chass. Tricorne +1',
        Neck = 'Bathy Choker +1',
        Body = 'Chasseur\'s Frac +1',
        Hands = 'Malignance Gloves',
        Ring1 = 'Stikini Ring +1',
        Ring2 = 'Chirich Ring +1',
        Legs = 'Carmine Cuisses +1',
        Feet = 'Chass. Bottes +1',
    },

    Dt = {
        Head = 'Nyame Helm',
        Neck = { Name = 'Loricate Torque +1', AugPath='A' },
        Ear1 = { Name = 'Odnowa Earring +1', AugPath='A' },
        Ear2 = 'Etiolation Earring',
        Body = 'Nyame Mail',
        Hands = 'Nyame Gauntlets',
        Ring1 = 'Defending Ring',
        Ring2 = { Name = 'Gelatinous Ring +1', AugPath='A' },
        Back = 'Solemnity Cape',
        Waist = 'Flume Belt +1',
        Legs = 'Nyame Flanchard',
        Feet = 'Nyame Sollerets',
    },

    Tp_Default = {
        Ammo = 'Decimating Bullet',
        Head = 'Chass. Tricorne +2',
        Neck = 'Iskur Gorget',
        Ear1 = 'Telos Earring',
        Ear2 = 'Cessance Earring',
        Body = 'Nisroch Jerkin',
        Hands = 'Malignance Gloves',
        Ring1 = 'Epona\'s Ring',
        Ring2 = 'Petrov Ring',
        Back = 'Cumulus\'s Mantle',
        Waist = 'Reiki Yotai',
        Legs = 'Chas. Culottes +3',
        Feet = 'Carmine Greaves +1',
    },
    Tp_Hybrid = {
        Head = 'Malignance Chapeau',
        Neck = 'Comm. Charm +1',
        Hands = 'Malignance Gloves',
    },
    Tp_Acc = {
        Head = 'Malignance Chapeau',
        Body = 'Nyame Mail',
        Hands = 'Malignance Gloves',
        Ring1 = 'Cacoethic Ring +1',
        Ring2 = 'Chirich Ring +1',
    },

    Precast = {
        Neck = 'Baetyl Pendant',
        Ear2 = 'Etiolation Earring',
        Body = 'Taeon Tabard',
        Hands = 'Leyline Gloves',
        Ring1 = 'Prolix Ring',
        Feet = 'Carmine Greaves +1',--8
    },
    DeathPenalty = {
        Range = 'Death Penalty',
    },

    Fomalhaut = {
        Range = 'Fomalhaut',
    },

    LivingBullet = {
        Ammo = 'Living Bullet',
    },

    ChronoBullet = {
        Ammo = 'Chrono Bullet',
    },

    BronzeBullett = {
        Ammo = 'Bronze Bullet',
    },

    TPGun = {
        Range = 'Anarchy +2',
    },

    Cure = {
        Neck = 'Incanter\'s Torque',
        Ear1 = 'Mendi. Earring',
        Ring1 = 'Stikini Ring +1',
        Ring2 = { Name = 'Metamor. Ring +1', AugPath='A' },
        Back = 'Solemnity Cape',
        Legs = 'Carmine Cuisses +1',
    },

    Enhancing = {
        Neck = 'Incanter\'s Torque',
        Ear1 = 'Mendi. Earring',
        Ear2 = 'Andoaa Earring',
        Ring2 = { Name = 'Metamor. Ring +1', AugPath='A' },
    },

    Enfeebling = {
        Neck = 'Erra Pendant',
        Ring2 = { Name = 'Metamor. Ring +1', AugPath='A' },
    },
    Macc = {},

    Drain = {
        Neck = 'Erra Pendant',
        Ring2 = { Name = 'Metamor. Ring +1', AugPath='A' },
    },

    Nuke = {
        Head = 'Nyame Helm',
        Neck = 'Baetyl Pendant',
        Ear1 = 'Friomisi Earring',
        Ear2 = 'Crematio Earring',
        Body = 'Nyame Mail',
        Hands = 'Nyame Gauntlets',
        Ring1 = 'Shiva Ring +1',
        Ring2 = { Name = 'Metamor. Ring +1', AugPath='A' },
        Legs = 'Nyame Flanchard',
        Feet = 'Nyame Sollerets',
    },

    Preshot = {--base preshot, no flurry, 70cap, 10 from gifts (only 1200 JP needed)
        Ammo = 'Decimating Bullet',
        Head = 'Chass. Tricorne +2',
        Neck = 'Comm. Charm +1',
        Body = 'Laksa. Frac +2',
        Hands = 'Carmine Fin. Ga. +1',--13
        Ring1 = 'Crepuscular Ring',--3
        Back = { Name = 'Camulus\'s Mantle', Augment = '"Snapshot"+10' },--10
        Waist = 'Impulse Belt',--3
        -- Legs = 'Ikenga\'s Trousers',--8
        Legs = 'Lanun Trews +3',--10
        Feet = 'Meg. Jam. +2',--10
    },
    Preshot_FlurryI = {--with flurry I on, gives 15
    },
    Preshot_FlurryII = {--with flurry II on, gives 30
        Hands = 'Carmine Fin. Ga. +1',--8
    },
    Midshot = {
        Ammo = 'Decimating Bullet',
        Head = 'Malignance Chapeau',
        Neck = 'Iskur Gorget',
        Ear1 = 'Telos Earring',
        Ear2 = 'Enervating Earring',
        Body = 'Laksa. Frac +2',
        Hands = 'Malignance Gloves',
        Ring1 = 'Dingir Ring',
        Ring2 = 'Ilabrat Ring',
        Back = { Name = 'Camulus\'s Mantle', Augment = { [1] = 'Rng.Acc.+20', [2] = '"Store TP"+10', [3] = 'AGI+20', [4] = 'Rng.Atk.+20' } },
        Waist = 'Eschan Stone',
        Legs = 'Ikenga\'s Trousers',
        Feet = 'Nyame Sollerets',
    },
    Midshot_Acc = {
        Ear1 = 'Telos Earring',
        Ear2 = 'Crep. Earring',
        Body = 'Laksa. Frac +2',
        Ring2 = 'Crepuscular Ring',
        Legs = 'Ikenga\'s Trousers',
    },
    TripleShot = {
        Ammo = 'Decimating Bullet',
        Body = 'Chasseur\'s Frac +1',
        Hands = 'Lanun Gants +3',
    },

    Ws_Default = {
        Head = 'Nyame Helm',
        Neck = 'Fotia Gorget',
        Body = 'Nyame Mail',
        Hands = 'Nyame Gauntlets',
        Ring1 = 'Petrov Ring',
        Ring2 = 'Karieyh Ring +1',
        Back = { Name = 'Camulus\'s Mantle', Augment = { [1] = 'Weapon skill damage +10%', [2] = 'Mag. Acc+20', [3] = 'AGI+30', [4] = 'Magic Damage +20' } },
        Waist = 'Fotia Belt',
        Legs = 'Nyame Flanchard',
        Feet = 'Lanun Bottes +4',
    },
    Ws_Hybrid = {
    },
    Ws_Acc = {
    },
    FlatBlade_Default = {
        Head = 'Chass. Tricorne +2',
        Neck = 'Sanctity Necklace',
        Ear1 = 'Dignitary\'s Earring',
        Ear2 = 'Chasseur\'s Earring +1',
        Body = 'Chasseur\'s Frac +2',
        Hands = 'Chasseur\'s Gants +3',
        Ring1 = 'Metamorph Ring',
        Ring2 = 'Stikini Ring',
        Back = { Name = 'Camulus\'s Mantle', Augment = { [1] = 'Weapon skill damage +10%', [2] = 'Magic Damage+20', [3] = 'AGI+30', [4] = 'Mag. Acc.+20' } },
        Waist = 'Eschan Stone',
        Legs = 'Chas. Culottes +3',
        Feet = 'Chass. Bottes +3'
    },
    FlatBlade_Hybrid = {
        Head = 'Chass. Tricorne +2',
        Neck = 'Sanctity Necklace',
        Ear1 = 'Dignitary\'s Earring',
        Ear2 = 'Chasseur\'s Earring +1',
        Body = 'Chasseur\'s Frac +2',
        Hands = 'Chasseur\'s Gants +3',
        Ring1 = 'Metamorph Ring',
        Ring2 = 'Stikini Ring',
        Back = { Name = 'Camulus\'s Mantle', Augment = { [1] = 'Weapon skill damage +10%', [2] = 'Magic Damage+20', [3] = 'AGI+30', [4] = 'Mag. Acc.+20' } },
        Waist = 'Eschan Stone',
        Legs = 'Chas. Culottes +3',
        Feet = 'Chass. Bottes +3'
    },
    FlatBlade_Acc = {
        Head = 'Chass. Tricorne +2',
        Neck = 'Sanctity Necklace',
        Ear1 = 'Dignitary\'s Earring',
        Ear2 = 'Chasseur\'s Earring +1',
        Body = 'Chasseur\'s Frac +2',
        Hands = 'Chasseur\'s Gants +3',
        Ring1 = 'Metamorph Ring',
        Ring2 = 'Stikini Ring',
        Back = { Name = 'Camulus\'s Mantle', Augment = { [1] = 'Weapon skill damage +10%', [2] = 'Magic Damage+20', [3] = 'AGI+30', [4] = 'Mag. Acc.+20' } },
        Waist = 'Eschan Stone',
        Legs = 'Chas. Culottes +3',
        Feet = 'Chass. Bottes +3'
    },
    MagicWS = {
        WsObi = {--puts elemental obi on for leaden/wildfire under dark/fire situations
            Waist = 'Hachirin-no-Obi',
        },
    },
    Savage_Default = {
        Head = 'Nyame Helm',
        Body = 'Laksa. Frac +4',
        Neck = 'Rep. Plat. Medal',
        Ear1 = 'Telos Earring',
        Ear2 = 'Moonshade Earring',
        Hands = 'Chasseur\'s Gants +3',
        Ring1 = 'Sroda Ring',
        Ring2 = 'Ephramad\'s Ring',
        Back = { Name = 'Camulus\'s Mantle', Augment = { [1] = 'Phys. dmg. taken -10%', [2] = 'STR+20', [3] = 'Accuracy+20', [4] = 'Attack+20', [5] = 'Weapon skill damage +10%' } },
        Waist = 'Sailfi Belt +1',
        Legs = 'Nyame Flanchard',
        Feet = 'Lanun Bottes +4',
    },
    Savage_Hybrid = {
    },
    Savage_Acc = {
        Ear1 = 'Telos Earring',
    },

    Evisceration_Default = {
        Head = 'Adhemar Bonnet +1',
        Neck = 'Fotia Gorget',
        Ear1 = 'Odr Earring',
        Ear2 = 'Mache Earring +1',
        -- Body = 'Mummu Jacket +2',
        Hands = 'Adhemar Wrist. +1',
        Ring1 = 'Ilabrat Ring',
        Ring2 = 'Begrudging Ring',
        Waist = 'Fotia Belt',
        -- Legs = 'Mummu Kecks +2',
        -- Feet = 'Mummu Gamash. +2',
    },
    Evisceration_Hybrid = {
    },
    Evisceration_Acc = {
        Head = 'Blistering Sallet +1',
    },

    Aedge_Default = {
        Ammo = 'Animikii Bullet',
        Head = 'Nyame Helm',
        Neck = 'Baetyl Pendant',
        Ear1 = 'Friomisi Earring',
        Ear2 = 'Crematio Earring',
        Body = 'Laksa. Frac +2',
        Hands = 'Carmine Fin. Ga. +1',
        Ring1 = 'Dingir Ring',
        Ring2 = 'Karieyh Ring +1',
        Back = { Name = 'Camulus\'s Mantle', Augment = { [1] = 'Weapon skill damage +10%', [2] = 'Mag. Acc+20', [3] = 'AGI+30', [4] = 'Magic Damage +20' } },
        Waist = 'Eschan Stone',
        Legs = 'Nyame Flanchard',
        Feet = 'Lanun Bottes +4',
    },
    Aedge_Hybrid = {
    },
    Aedge_Acc = {
    },

    Laststand_Default = {
        Head = 'Nyame Helm',
        Neck = 'Fotia Gorget',
        Ear1 = 'Telos Earring',
        Ear2 = 'Chasseur\'s Earring +1',
        Body = 'Nyame Mail',
        Hands = 'Chasseur\'s Gants +3',
        Ring2 = 'Ephramad\'s Ring',
        Ring1 = 'Ilabrat Ring',
        Back = { Name = 'Camulus\'s Mantle', Augment = { [1] = 'Weapon skill damage +10%', [2] = 'Mag. Acc+20', [3] = 'AGI+30', [4] = 'Magic Damage +20' } },
        Waist = 'Fotia Belt',
        Legs = 'Nyame Flanchard',
        Feet = 'Lanun Bottes +4',
    },
    Laststand_Hybrid = {
    },
    Laststand_Acc = {
    },

    Wildfire_Default = {
        Ammo = 'Living Bullet',
        Head = 'Adhemar Bonnet +1',
        Neck = 'Comm. Charm +1',
        Ear1 = 'Friomisi Earring',
        Ear2 = 'Crematio Earring',
        Body = 'Lanun Frac +3',
        Hands = 'Carmine Fin. Ga. +1',
        Ring1 = 'Dingir Ring',
        Ring2 = 'Karieyh Ring +1',
        Back = { Name = 'Camulus\'s Mantle', Augment = { [1] = 'Weapon skill damage +10%', [2] = 'Mag. Acc+20', [3] = 'AGI+30', [4] = 'Magic Damage +20' } },
        Waist = 'Eschan Stone',
        Legs = 'Nyame Flanchard',
        Feet = 'Lanun Bottes +4',
    },
    Wildfire_Hybrid = {
    },
    Wildfire_Acc = {
        Ear2 = 'Digni. Earring',
    },

    Leaden_Default = {
        Ammo = 'Living Bullet',
        Head = 'Pixie Hairpin +1',
        Neck = 'Comm. Charm +2',
        Ear1 = 'Friomisi Earring',
        Ear2 = 'Hecate\'s Earring',
        Body = 'Lanun Frac +3',
        Hands = 'Nyame Gauntlets',
        Ring1 = 'Dingir Ring',
        Ring2 = 'Archon Ring',
        Back = { Name = 'Camulus\'s Mantle', Augment = { [1] = 'Weapon skill damage +10%', [2] = 'Magic Damage+20', [3] = 'AGI+30', [4] = 'Mag. Acc.+20' } },
        Waist = 'Eschan Stone',
        Legs = 'Nyame Flanchard',
        Feet = 'Lanun Bottes +4',
    },
    Leaden_Hybrid = {
    },
    Leaden_Acc = {
        Ear2 = 'Digni. Earring',
        Waist = 'Eschan Stone',
    },
    Lockstyle = {
        Main = 'Rostam',
        Sub = 'Rostam',
        Range = 'Death Penalty',
        Head = 'Chass. Tricorne +2',
        Body = 'Adenium Suit',
        --Body = 'Chasseur\'s Frac +2',
        --Hands = 'Chasseur\'s Gants +3',
        --Legs = 'Chas. Culottes +3',
        --Feet = 'Chass. Bottes +3',
    },

    QD = {
        Ammo = 'Hauksbok Bullet',
        Head = 'Nyame Helm',
        Neck = 'Baetyl Pendant',
        Ear1 = 'Friomisi Earring',
        Ear2 = 'Hecate\'s Earring',
        Body = 'Lanun Frac +3',
        Hands = 'Carmine Fin. Ga. +1',
        Ring1 = 'Dingir Ring',
        Ring2 = 'Metamor. Ring +1',
        Back = { Name = 'Camulus\'s Mantle', Augment = { [1] = 'Weapon skill damage +10%', [2] = 'Mag. Acc+20', [3] = 'AGI+30', [4] = 'Magic Damage +20' } },
        Waist = 'Skrymir Cord',
        Legs = 'Nyame Flanchard',
        Feet = 'Chass. Bottes +3',
    },
    QD_Acc = {--with AF 2/3 and regal is better
        Ammo = 'Hauksbok Bullet',
        Head = 'Malignance Chapeau',
        Neck = 'Sanctity Necklace',
        Ear2 = 'Crep. Earring',
        Body = 'Nyame Mail',
        Hands = 'Malignance Gloves',
        Ring1 = 'Crepuscular Ring',
        Ring2 = 'Metamor. Ring +1',
        Legs = 'Nyame Flanchard',
        Feet = 'Chass. Bottes +3',
    },
    Rolls = { -- it will put on ur DT gear set first then layer this set on for phantom roll (not dbl up), use /dt if you think you need to lock dt set while rolling
        Main = { Name = 'Rostam', AugPath='C' },
        Range = 'Compensator',
        Head = 'Lanun Tricorne +2',
        Hands = 'Chasseur\'s Gants +3',
        Back = 'Camulus\'s Mantle',
        Ring1 = 'Luzaf\'s Ring',
    },
    Fold = {--Hands = 'Lanun Gants +1'
    },
    WildCard = {Feet = 'Lanun Bottes +4'},
    RandomDeal = {Body = 'Lanun Frac +1'},
    SnakeEye = {Legs = 'Lanun Trews +3'},
    TH = {
        Head = { Name = 'Herculean Helm', Augment = { ['"Treasure Hunter"+1'] = true } },
		Body = { Name = 'Herculean Vest', Augment = { ['"Treasure Hunter"+1'] = true } },
        Legs = 'Volte Hose',
        Feet = { Name = 'Herculean Boots', Augment = { [1] = 'Potency of "Cure" effect received+5%', [2] = 'Mag. Acc.+19', [3] = 'Accuracy+21', [4] = '"Mag. Atk. Bns."+19', [5] = '"Treasure Hunter"+2' } },
	},
    Movement = {
        Ring2 = 'Shneddick Ring',
    },
    Naegling = {
        Main = 'Naegling',
    },
    RangeRostam = {
        Main = { Name = 'Rostam', AugPath='A'},
    },
    MeleeRostam = {
        Main = { Name = 'Rostam', AugPath='B'},
    },
    RollRostam = {
        Sub = { Name = 'Rostam', AugPath='C'},
    },
    Tauret = {
        Sub = 'Tauret',
    },
    Degen = {
        Sub = 'Demersal Degen +1',
    },
    Gleti = {
        Sub = 'Gleti\'s Knife',
    },
}

local dwGearPool = {
    -- Priority, Gear Slot, Item Name, Dual Wield value
    {1, 'Back', { Name = "Camulus\'s Cape", Augment = { ['"Dual Wield"+10'] = true } }, 10},
    {2, 'Ear1', 'Eabani Earring', 4},
    {4, 'Ear2', 'Suppanomimi', 5},
    {3, 'Waist', 'Reiki Yotai', 7},
}

profile.Sets = sets

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

profile.Packer = {
    {Name = 'Decimating Bullet', Quantity = 'all'},
    {Name = 'Dec. Bul. Pouch', Quantity = 'all'},
    {Name = 'Trump Card', Quantity = 'all'},
    {Name = 'Trump Card Case', Quantity = 'all'},
}

profile.OnLoad = function()
    gSettings.AllowAddSet = true
    gcinclude.Initialize()
    AshitaCore:GetChatManager():QueueCommand(1, '/macro book 10')
    AshitaCore:GetChatManager():QueueCommand(1, '/macro set 10')
    gcinclude.settings.RefreshGearMPP = 50
    gcinclude.CORmsg = false
end

profile.OnUnload = function()
    gcinclude.Unload()
end

profile.HandleCommand = function(args)
    gcinclude.HandleCommands(args)
end

profile.HandleDefault = function()
    gFunc.EquipSet(sets.Idle)
    local player = gData.GetPlayer()
    local mh = gcdisplay.GetCycle('MH')
    local oh = gcdisplay.GetCycle('OH')
    local rwep = gcdisplay.GetCycle('RWep')
    local ammo = gcdisplay.GetCycle('Ammo')
    local meleeset = gcdisplay.GetCycle('MeleeSet')

    if (player.Status == 'Engaged') then
        gFunc.EquipSet(sets.Tp_Default)
        if (meleeset ~= 'Default') then
            gFunc.EquipSet('Tp_' .. meleeset)
        end
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
        if gcdisplay.GetToggle('TH') then gFunc.EquipSet(sets.TH) end
    elseif (player.Status == 'Resting') then
        gFunc.EquipSet(sets.Resting)
    elseif (player.IsMoving) then
        gFunc.EquipSet(sets.Movement)
    end

    gFunc.Equip('Main', MHWep[mh])
    gFunc.Equip('Sub', OHWep[oh])
    gFunc.Equip('Range', RWep[rwep])
    gFunc.Equip('Ammo', Ammo[ammo])

    gcinclude.CheckDefault()
    if gcdisplay.GetToggle('DTset') then gFunc.EquipSet(sets.Dt) end
    if gcdisplay.GetToggle('Kite') then gFunc.EquipSet(sets.Movement) end
end

profile.HandleAbility = function()
    local ability = gData.GetAction()
    if ability.Name:contains('Roll') then
        gFunc.EquipSet(sets.Dt)
        gFunc.EquipSet(sets.Rolls)
        gcinclude.DoCORmsg(ability.Name)
    elseif exactGearSets[ability.Name] then
        gFunc.EquipSet(sets[exactGearSets[ability.Name]])
    elseif ability.Name:contains('Shot') and ability.Name ~= 'Triple Shot' then
        gFunc.EquipSet(sets.QD)
        if gcdisplay.GetCycle('Melee') == 'Acc' or ability.Name == 'Dark Shot' or ability.Name == 'Light Shot' then
            gFunc.EquipSet(sets.QD_Acc)
        end
    end
    gcinclude.CheckCancels()
end

profile.HandleItem = function()
    local item = gData.GetAction()
    if string.match(item.Name, 'Holy Water') then gFunc.EquipSet(gcinclude.sets.Holy_Water) end
end

profile.HandlePrecast = function()
    local spell = gData.GetAction()
    gFunc.EquipSet(sets.Precast)
    gcinclude.CheckCancels()
end

profile.HandleMidcast = function()
    local weather = gData.GetEnvironment()
    local spell = gData.GetAction()
    local skillSets = {
        ['Enhancing Magic'] = sets.Enhancing,
        ['Healing Magic'] = sets.Cure,
        ['Elemental Magic'] = sets.Nuke,
        ['Enfeebling Magic'] = sets.Enfeebling,
        ['Dark Magic'] = sets.Macc,
    }
    local gearSet = skillSets[spell.Skill]
    if gearSet then
        gFunc.EquipSet(gearSet)
    end
    if spell.Skill == 'Elemental Magic' and (spell.Element == weather.WeatherElement or spell.Element == weather.DayElement) then
        gFunc.Equip('Waist', 'Hachirin-no-Obi')
    elseif spell.Skill == 'Dark Magic' and (spell.Name:contains('Aspir') or spell.Name:contains('Drain')) then
        gFunc.EquipSet(sets.Drain)
    end
end

profile.HandlePreshot = function()
    local flurryI = gData.GetBuffCount(265)
    local flurryII = gData.GetBuffCount(581)
    gFunc.EquipSet(sets.Preshot)
    if flurryII > 0 then
        gFunc.EquipSet(sets.Preshot_FlurryII)
    elseif flurryI > 0 then
        gFunc.EquipSet(sets.Preshot_FlurryI)
    end
end

profile.HandleMidshot = function()
    local triple = gData.GetBuffCount('Triple Shot')
    gFunc.EquipSet(sets.Midshot)
    if triple > 0 then
        gFunc.EquipSet(sets.TripleShot)
    end
    if (gcdisplay.GetCycle('MeleeSet') == 'Acc') then
        gFunc.EquipSet(sets.Midshot_Acc)
    end
    if (gcdisplay.GetToggle('TH') == true) then gFunc.EquipSet(sets.TH) end
end

profile.Moonshade = function(wsData, TP)
    local threshold = 3000
    local equipment = gData.GetEquipment()
    -- Example: If you want to adjust for a specific offhand, change the name below
    if equipment.Range and equipment.Range.Name == 'Anarchy +2' then
        threshold = 2000
    end
    if equipment.Range and equipment.Range.Name == 'Fomalhaut' then
        threshold = 2500
    end
    if wsData.moonshade and TP < threshold then
        gFunc.Equip('Ear2', 'Moonshade Earring')
    end
end

profile.HandleWeaponskill = function()
    if not gcinclude.CheckWsBailout() then
        gFunc.CancelAction()
        return
    end

    local ws = gData.GetAction()
    local wsName = ws.Name
    local meleeSet = gcdisplay.GetCycle('MeleeSet')
    local player = gData.GetPlayer()
    local defaultSet = sets.Ws_Default

    gFunc.EquipSet(defaultSet)
    if meleeSet ~= 'Default' then
        gFunc.EquipSet('Ws_' .. meleeSet)
    end

    local wsTable = {
        -- Dagger
        ['Gust Slash']        = { set = 'MagicWS',      element = 'Wind',   moonshade = true },
        ['Aeolian Edge']      = { set = 'MagicWS',      element = 'Wind',   moonshade = true },
        ['Evisceration']      = { set = 'Evisceration', element = nil,      moonshade = false },
        -- Sword
        ['Burning Blade']     = { set = 'MagicWS',      element = 'Fire',   moonshade = true },
        ['Red Lotus Blade']   = { set = 'MagicWS',      element = 'Fire',   moonshade = true },
        ['Flat Blade']        = { set = 'FlatBlade',    element = 'Thunder',moonshade = true },
        ['Shining Blade']     = { set = 'MagicWS',      element = 'Light',  moonshade = true },
        ['Seraph Blade']      = { set = 'MagicWS',      element = 'Light',  moonshade = true },
        ['Savage Blade']      = { set = 'Savage',       element = nil,      moonshade = true },
        -- Marksmanship (Gun)
        ['Last Stand']        = { set = 'LastStand',    element = nil,      moonshade = true },
        ['Hot Shot']          = { set = 'Hotshot',      element = 'Fire',   moonshade = true },
        ['Wildfire']          = { set = 'Wildfire',     element = 'Fire',   moonshade = true },
        ['Leaden Salute']     = { set = 'Leaden',       element = 'Dark',   moonshade = true },
        -- Add more as needed
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

return profile
