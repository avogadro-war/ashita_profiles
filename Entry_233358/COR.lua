local profile = {};
gcinclude = gFunc.LoadFile('common\\gcinclude.lua');
JHaste = gFunc.LoadFile('common\\J-Haste.lua');

local sets = {
    Idle = {
        Head = 'Nyame Helm',
        Neck = 'Loricate Torque +1',
        Ear1 = 'Eabani Earring',
        Ear2 = 'Hearty Earring',
        Body = 'Nyame Mail',
        Hands = 'Nyame Gauntlets',
        Ring1 = 'Shadow Ring',
        Ring2 = 'Shneddick Ring',
        Back = 'Solemnity Cape',
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
        Body = 'Nyame Mail',
        Hands = 'Mrigavyadha Gloves',
        Ring1 = 'Ilabrat Ring',
        Ring2 = 'Chirich Ring +1',
        Back = 'Cumulus\'s Mantle',
        Waist = 'Reiki Yotai',
        Legs = 'Chas. Culottes +2',
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
    WsObi = {--puts elemental obi on for leaden/wildfire under dark/fire situations
        Waist = 'Hachirin-no-Obi',
    },

    Savage_Default = {
        Head = 'Nyame Helm',
        Neck = 'Repub. Plat. Medal',
        Ear1 = 'Telos Earring',
        Ear2 = 'Moonshade Earring',
        Hands = 'Chasseur\'s Gants +3',
        Ring1 = 'Sroda Ring',
        Ring2 = 'Ephramad\'s Ring',
        Back = { Name = 'Camulus\'s Mantle', Augment = { [1] = 'Weapon skill damage +10%', [2] = 'Mag. Acc+20', [3] = 'AGI+30', [4] = 'Magic Damage +20' } },
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
        Ear2 = 'Chasseur\'s Earring',
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
        Neck = 'Sibyl Scarf',
        Ear1 = 'Friomisi Earring',
        Ear2 = 'Hecate\'s Earring',
        Body = 'Lanun Frac +3',
        Hands = 'Nyame Gauntlets',
        Ring1 = 'Dingir Ring',
        Ring2 = 'Archon Ring',
        Back = { Name = 'Camulus\'s Mantle', Augment = { [1] = 'Weapon skill damage +10%', [2] = 'Mag. Acc+20', [3] = 'AGI+30', [4] = 'Magic Damage +20' } },
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
        Head = 'Chass. Tricorne +2',
        Body = 'Chasseur\'s Frac +2',
        Hands = 'Chasseur\'s Gants +3',
        Legs = 'Chas. Culottes +2',
        Feet = 'Chass. Bottes +2',
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
        Feet = 'Chass. Bottes +2',
    },
    QD_Acc = {--with AF 2/3 and regal is better
        Ammo = 'Hauksbok Bullett',
        Head = 'Malignance Chapeau',
        Neck = 'Sanctity Necklace',
        Ear2 = 'Crep. Earring',
        Body = 'Nyame Mail',
        Hands = 'Malignance Gloves',
        Ring1 = 'Crepuscular Ring',
        Ring2 = 'Metamor. Ring +1',
        Legs = 'Nyame Flanchard',
        Feet = 'Chass. Bottes +1',
    },
    Rolls = { -- it will put on ur DT gear set first then layer this set on for phantom roll (not dbl up), use /dt if you think you need to lock dt set while rolling
        Main = { Name = 'Rostam', AugPath='C' },
        Range = 'Compensator',
        Head = 'Lanun Tricorne +2',
        Hands = 'Chasseur\'s Gants +3',
        Back = 'Camulus\'s Mantle',
        Ring1 = 'Luzaf\'s Ring',
    },
    Fold = {Hands = 'Lanun Gants +1'},
    WildCard = {Feet = 'Lanun Bottes +4'},
    RandomDeal = {Body = 'Lanun Frac +1'},
    SnakeEye = {Legs = 'Lanun Trews +3'},
    TH = {
		Waist = 'Chaac Belt',
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

    ['bronzebullet'] = {
        Main = 'Naegling',
        Range = 'Awilda\'s Gun',
        Ammo = 'Bronze Bullet',
        Head = 'Guide Beret',
        Neck = { Name = 'Loricate Torque +1', AugPath='A' },
        Ear1 = 'Eabani Earring',
        Ear2 = 'Brutal Earring',
        Body = { Name = 'Nyame Mail', AugPath='B' },
        Hands = { Name = 'Nyame Gauntlets', AugPath='B' },
        Ring1 = 'Ephramad\'s Ring',
        Ring2 = 'Warp Ring',
        Waist = 'Eschan Stone',
        Legs = { Name = 'Nyame Flanchard', AugPath='B' },
        Feet = { Name = 'Nyame Sollerets', AugPath='B' },
    },
    ['bronze'] = {
        Main = 'Naegling',
        Range = 'Awilda\'s Gun',
        Ammo = 'Bronze Bullet',
        Head = 'Guide Beret',
        Neck = { Name = 'Loricate Torque +1', AugPath='A' },
        Ear1 = 'Eabani Earring',
        Ear2 = 'Brutal Earring',
        Body = { Name = 'Nyame Mail', AugPath='B' },
        Hands = { Name = 'Nyame Gauntlets', AugPath='B' },
        Ring1 = 'Ephramad\'s Ring',
        Ring2 = 'Warp Ring',
        Waist = 'Eschan Stone',
        Legs = { Name = 'Nyame Flanchard', AugPath='B' },
        Feet = { Name = 'Nyame Sollerets', AugPath='B' },
    },
    ['corbulletbronze'] = {
        Main = 'Naegling',
        Range = 'Awilda\'s Gun',
        Ammo = 'Bronze Bullet',
        Head = 'Guide Beret',
        Neck = { Name = 'Loricate Torque +1', AugPath='A' },
        Ear1 = 'Eabani Earring',
        Ear2 = 'Brutal Earring',
        Body = { Name = 'Nyame Mail', AugPath='B' },
        Hands = { Name = 'Nyame Gauntlets', AugPath='B' },
        Ring1 = 'Ephramad\'s Ring',
        Ring2 = 'Warp Ring',
        Waist = 'Eschan Stone',
        Legs = { Name = 'Nyame Flanchard', AugPath='B' },
        Feet = { Name = 'Nyame Sollerets', AugPath='B' },
    },
    ['rostam'] = {
        Main = 'Naegling',
        Sub = { Name = 'Rostam', AugPath='C' },
        Range = 'Molybdosis',
        Ammo = 'Eminent Bullet',
        Head = { Name = 'Nyame Helm', AugPath='B' },
        Neck = { Name = 'Loricate Torque +1', AugPath='A' },
        Ear1 = 'Eabani Earring',
        Ear2 = 'Hearty Earring',
        Body = { Name = 'Nyame Mail', AugPath='B' },
        Hands = 'Chasseur\'s Gants +3',
        Ring1 = 'Shadow Ring',
        Ring2 = 'Shneddick Ring',
        Back = { Name = 'Camulus\'s Mantle', Augment = { [1] = 'Accuracy+20', [2] = 'Attack+20', [3] = 'Phys. dmg. taken -10%' } },
        Waist = 'Plat. Mog. Belt',
        Legs = { Name = 'Nyame Flanchard', AugPath='B' },
        Feet = { Name = 'Nyame Sollerets', AugPath='B' },
    },
    ['th_egg'] = {
        Main = 'Naegling',
        Sub = { Name = 'Gleti\'s Knife', AugPath='A' },
        Ammo = 'Per. Lucky Egg',
        Head = 'Wh. Rarab Cap +1',
        Neck = 'Iskur Gorget',
        Ear1 = 'Telos Earring',
        Ear2 = 'Cessance Earring',
        Body = { Name = 'Herculean Vest', Augment = { [1] = 'Pet: Rng. Acc.+30', [2] = '"Treasure Hunter"+1', [3] = 'Accuracy+18', [4] = '"Mag. Atk. Bns."+9', [5] = 'Pet: Accuracy+30', [6] = 'Mag. Acc.+9' } },
        Hands = 'Mrigavyadha Gloves',
        Ring1 = 'Ilabrat Ring',
        Ring2 = 'Chirich Ring +1',
        Back = { Name = 'Camulus\'s Mantle', Augment = { [1] = 'Phys. dmg. taken -10%', [2] = 'Accuracy+20', [3] = 'DEX+20', [4] = 'Attack+20', [5] = '"Dual Wield"+1' } },
        Waist = 'Reiki Yotai',
        Legs = 'Volte Hose',
        Feet = { Name = 'Carmine Greaves +1', AugPath='D' },
    },
};
profile.Sets = sets;

profile.Packer = {
    {Name = 'Decimating Bullet', Quantity = 'all'},
    {Name = 'Dec. Bul. Pouch', Quantity = 'all'},
    {Name = 'Trump Card', Quantity = 'all'},
    {Name = 'Trump Card Case', Quantity = 'all'},
};

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
    {1, 'Back', { Name = "Camulus\'s Cape", Augment = { ['"Dual Wield"+10'] = true } }, 10},
    {2, 'Ear1', 'Eabani Earring', 4},
    {3, 'Ear2', 'Suppanomimi', 5},
    {4, 'Waist', 'Reiki Yotai', 7},
}


profile.OnLoad = function()
	gSettings.AllowAddSet = true;
    gcinclude.Initialize();

    AshitaCore:GetChatManager():QueueCommand(1, '/macro book 10');
    AshitaCore:GetChatManager():QueueCommand(1, '/macro set 10');

    gcinclude.settings.RefreshGearMPP = 50;
    gcinclude.CORmsg = false; -- set this to false if you do not want to see lucky/unlucky # messages, can also do /cormsg in game to change on the fly
end

profile.OnUnload = function()
    gcinclude.Unload();
end

profile.HandleCommand = function(args)
    gcinclude.HandleCommands(args);
end

profile.HandleDefault = function()
    gFunc.EquipSet(sets.Idle);
	
	local player = gData.GetPlayer();
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
                    --etc
                end
                for slot, item in pairs(dwSet) do
                    gFunc.Equip(slot, item)
                end
            end
        end
		if (gcdisplay.GetToggle('TH') == true) then gFunc.EquipSet(sets.TH) end
    elseif (player.Status == 'Resting') then
        gFunc.EquipSet(sets.Resting);
    elseif (player.IsMoving == true) then
		gFunc.EquipSet(sets.Movement);
    end
    
    --main wep
    local MHWep = {
        ['Naegling'] = 'Naegling',
        ['Melee Rostam'] = { Name = 'Rostam', AugPath = 'B' },
        ['Range Rostam'] = { Name = 'Rostam', AugPath = 'A' },
    }
    gFunc.Equip('Main', MHWep[gcdisplay.GetCycle('MH')]);
    --offhand
    local OHWep = {
        ['Gleti'] = 'Gleti\'s Knife',
        ['Degen'] = 'Demersal Degen +1',
        ['Tauret'] = 'Tauret',
        ['Roll Rostam'] = { Name = 'Rostam', AugPath = 'C' },
    }
    gFunc.Equip('Sub', OHWep[gcdisplay.GetCycle('OH')]);

	--gun
    local RWep = {
        ['Death Penalty'] = 'Death Penalty',
        ['Fomalhaut'] = 'Fomalhaut',
        ['TP Bonus'] = 'Anarchy +2',
    }
    gFunc.Equip('Range', RWep[gcdisplay.GetCycle('RWep')]);
    --ammo
    local Ammo = {
        ['MAB'] = 'Living Bullet',
        ['Phys.'] = 'Chrono Bullet',
        ['Brz.'] = 'Bronze Bullet',
    }
    gFunc.Equip('Ammo', Ammo[gcdisplay.GetCycle('Ammo')]);

    gcinclude.CheckDefault ();
    if (gcdisplay.GetToggle('DTset') == true) then 
        gFunc.EquipSet(sets.Dt) 
    end;
    if (gcdisplay.GetToggle('Kite') == true) then 
        gFunc.EquipSet(sets.Movement) 
    end; 
end

profile.HandleAbility = function()
    local ability = gData.GetAction();

    if (ability.Name:contains('Roll')) then
        gFunc.EquipSet(sets.Dt);
        gFunc.EquipSet(sets.Rolls);
        gcinclude.DoCORmsg(ability.Name);
    elseif (ability.Name == 'Wild Card') then gFunc.EquipSet(sets.WildCard);
    elseif (ability.Name == 'Fold') then gFunc.EquipSet(sets.Fold);
    elseif (ability.Name == 'Random Deal') then gFunc.EquipSet(sets.RandomDeal);
    elseif (ability.Name == 'Snake Eye') then gFunc.EquipSet(sets.SnakeEye);
    elseif (ability.Name:contains('Shot')) and (ability.Name ~= 'Triple Shot') then
        gFunc.EquipSet(sets.QD);
        if (gcdisplay.GetCycle('Melee') == 'Acc') or (ability.Name == 'Dark Shot') or (ability.Name == 'Light Shot') then
            gFunc.EquipSet(sets.QD_Acc);
        end
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

    gcinclude.CheckCancels();
end

profile.HandleMidcast = function()
    local weather = gData.GetEnvironment();
    local spell = gData.GetAction();
    local target = gData.GetActionTarget();

    if (spell.Skill == 'Enhancing Magic') then
        gFunc.EquipSet(sets.Enhancing);
    elseif (spell.Skill == 'Healing Magic') then
        gFunc.EquipSet(sets.Cure);
    elseif (spell.Skill == 'Elemental Magic') then
        gFunc.EquipSet(sets.Nuke);
        if (spell.Element == weather.WeatherElement) or (spell.Element == weather.DayElement) then
            gFunc.Equip('Waist', 'Hachirin-no-Obi');
        end
    elseif (spell.Skill == 'Enfeebling Magic') then
        gFunc.EquipSet(sets.Enfeebling);
    elseif (spell.Skill == 'Dark Magic') then
        gFunc.EquipSet(sets.Macc);
        if (string.contains(spell.Name, 'Aspir') or string.contains(spell.Name, 'Drain')) then
            gFunc.EquipSet(sets.Drain);
        end
    end
	if (gcdisplay.GetToggle('TH') == true) then gFunc.EquipSet(sets.TH) end
end

profile.HandlePreshot = function()
    local flurryI = gData.GetBuffCount(265);
    local flurryII = gData.GetBuffCount(581);

    gFunc.EquipSet(sets.Preshot);

    if flurryII > 0 then
        gFunc.EquipSet(sets.Preshot_FlurryII);
    elseif flurryI > 0 then
        gFunc.EquipSet(sets.Preshot_FlurryI);
    end
end

profile.HandleMidshot = function()
    local triple = gData.GetBuffCount('Triple Shot');
    gFunc.EquipSet(sets.Midshot);

    if triple > 0 then
        gFunc.EquipSet(sets.TripleShot);
    end

    if (gcdisplay.GetCycle('MeleeSet') == 'Acc') then
        gFunc.EquipSet(sets.Midshot_Acc);
    end
	if (gcdisplay.GetToggle('TH') == true) then gFunc.EquipSet(sets.TH) end
end

profile.HandleWeaponskill = function()
    local canWS = gcinclude.CheckWsBailout();
    if (canWS == false) then gFunc.CancelAction() return;
    else
        local ws = gData.GetAction();
        local weather = gData.GetEnvironment();
    
        gFunc.EquipSet(sets.Ws_Default)
        if (gcdisplay.GetCycle('MeleeSet') ~= 'Default') then
        gFunc.EquipSet('Ws_' .. gcdisplay.GetCycle('MeleeSet')) end
        
        if string.match(ws.Name, 'Savage Blade') then
            gFunc.EquipSet(sets.Savage_Default)
            if (gcdisplay.GetCycle('MeleeSet') ~= 'Default') then
            gFunc.EquipSet('Savage_' .. gcdisplay.GetCycle('MeleeSet')); end
        elseif string.match(ws.Name, 'Evisceration') then
            gFunc.EquipSet(sets.Evisceration_Default)
            if (gcdisplay.GetCycle('MeleeSet') ~= 'Default') then
            gFunc.EquipSet('Evisceration_' .. gcdisplay.GetCycle('MeleeSet')); end
        elseif string.match(ws.Name, 'Aeolian Edge') then
            gFunc.EquipSet(sets.Aedge_Default)
            if (gcdisplay.GetCycle('MeleeSet') ~= 'Default') then
            gFunc.EquipSet('Aedge_' .. gcdisplay.GetCycle('MeleeSet')); end
            if (gcdisplay.GetCycle('MeleeSet') == 'Default') then gcinclude.DoMoonshade() end;
            profile.Hachirin(Wind);
        elseif string.match(ws.Name, 'Last Stand') then
            gFunc.EquipSet(sets.Laststand_Default)
            if (gcdisplay.GetCycle('MeleeSet') ~= 'Default') then
            gFunc.EquipSet('Laststand_' .. gcdisplay.GetCycle('MeleeSet')); end
        elseif string.match(ws.Name, 'Wildfire') then
            gFunc.EquipSet(sets.Wildfire_Default)
            if (gcdisplay.GetCycle('MeleeSet') ~= 'Default') then
                gFunc.EquipSet('Wildfire_' .. gcdisplay.GetCycle('MeleeSet')); 
            end
            profile.Hachirin('Fire');
        elseif string.match(ws.Name, 'Leaden Salute') then
            gFunc.EquipSet(sets.Leaden_Default)
            if (gcdisplay.GetCycle('MeleeSet') ~= 'Default') then
            gFunc.EquipSet('Leaden_' .. gcdisplay.GetCycle('MeleeSet')); end
            if (gcdisplay.GetCycle('MeleeSet') == 'Default') then gcinclude.DoMoonshade() end
            profile.Hachirin('Dark');
        end
    end
end

return profile;
