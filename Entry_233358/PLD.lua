local profile = {};
gcinclude = gFunc.LoadFile('common\\gcinclude.lua');

local sets = {
    Idle = {
        Ammo = 'Staunch Tathlum +1',
        Head = 'Chev. Armet +2',
        Neck = 'Kgt. Beads +2',
        Ear1 = 'Eabani Earring',
        Ear2 = 'Odnowa Earring +1',
        Body = 'Sakpata\'s Plate',
        Hands = 'Sakpata\'s Gauntlets',
        Ring1 = 'Shneddick Ring',
        Ring2 = 'Moonlight Ring',
        Back = { Name = 'Rudianos\'s Mantle', Augment = { [1] = 'Occ. inc. resist. to stat. ailments+10', [2] = 'Accuracy+20', [3] = 'HP+60', [4] = 'Attack+20', [5] = '"Store TP"+10' } },
        Waist = 'Plat. Mog. Belt',
        Legs = 'Chev. Cuisses +2',
        Feet = 'Sakpata\'s Leggings',
    },
    Resting = {},
    Idle_Regen = {
        Head = 'Crepuscular Helm',
        Neck = 'Bathy Choker +1',
        Ear1 = 'Infused Earring',
        Ring1 = 'Shneddick Ring',
        Ring2 = 'Chirich Ring +1',
    },
    Idle_Refresh = {
        --Ammo = 'Homiliary',
        --Head = 'Jumalik Helm',
        --Ring1 = 'Stikini Ring +1',
    },
    Town = {
        Legs = 'Carmine Cuisses +1',
    },
    TownNight = {
        Legs = 'Carmine Cuisses +1',
    },

    Dt = {
        Ammo = 'Staunch Tathlum',
        Head = 'Nyame Helm',
        Neck ='Loricate Torque +1',
        Ear1 = 'Odnowa Earring +1',
        Ear2 = 'Etiolation Earring',
        Body = 'Nyame Mail',
        Hands = 'Sakpata\'s Gauntlets',
        Ring1 = 'Moonbeam Ring',
        Ring2 = 'Gelatinous Ring +1',
        Back = { Name = 'Rudianos\'s Mantle', Augment = { [1] = 'Phys. dmg. taken -10%', [2] = 'Mag. Eva.+20', [3] = 'Eva.+20', [4] = 'HP+60', [5] = 'Enmity+10' } },
        Waist = 'Flume Belt +1',
        Legs = 'Sakpata\'s Cuisses',
        Feet = 'Nyame Sollerets',
    },
    Tp_Default = {
        Ammo = 'Staunch Tathlum +1',
        Head = 'Sakpata\'s Helm',
        Neck = 'Kgt. Beads +2',
        Ear1 = 'Brutal Earring',
        Ear2 = 'Cessance Earring',
        Body = 'Sakpata\'s Plate',
        Hands = 'Sakpata\'s Gauntlets',
        Ring1 = 'Moonlight Ring',
        Ring2 = 'Moonlight Ring',
        Back = { Name = 'Rudianos\'s Mantle', Augment = { [1] = 'Occ. inc. resist. to stat. ailments+10', [2] = 'Accuracy+20', [3] = 'HP+60', [4] = 'Attack+20', [5] = '"Store TP"+10' } },
        Waist = 'Sailfi Belt +1',
        Legs = 'Sakpata\'s Cuisses',
        Feet = 'Sakpata\'s Leggings',
    },
    Tp_Hybrid = {
        Ammo = 'Coiste Bodhar',
        Head = 'Hjarrandi Helm',
        Neck ='Sanctity Necklace',
        Ear1 = 'Telos Earring',
        Ear2 = 'Cessance Earring',
        Body = 'Hjarrandi Breast.',
        Hands = 'Sakpata\'s Gauntlets',
        Ring1 = 'Moonbeam Ring',
        Ring2 = 'Petrov Ring',
        Back = { Name = 'Rudianos\'s Mantle', Augment = { [1] = 'Accuracy+20', [2] = '"Dbl.Atk."+10', [3] = 'Attack+20', [4] = 'DEX+20' } },
        Waist = 'Sailfi Belt +1',
        Legs = 'Sakpata\'s Cuisses',
        Feet = 'Flam. Gambieras +2',
    },
    empyrean = {
        Head = 'Chev. Armet +2',
        Body = 'Chev. Cuirass +2',
        Hands = 'Chev. Gauntlets +1',
        Legs = 'Chev. Cuisses +2',
        Feet = 'Chev. Sabatons +2',
    },
    Tp_Acc = {
        Ring1 = 'Cacoethic Ring +1',
        Ring2 = 'Chirich Ring +1',
    },

    --These will overwrite any above TP profile.Sets if /tankset is used
    Tank_Main = {--Default Tanking,  dt 
        Ammo = 'Staunch Tathlum +1',
        Head = 'Chev. Armet +2',
        Neck = 'Kgt. Beads +2',
        Ear1 = 'Tuisto Earring',
        Ear2 = 'Odnowa Earring +1',
        Body = 'Sakpata\'s Plate',
        Hands = 'Sakpata\'s Gauntlets',
        Ring1 = 'Moonlight Ring',
        Ring2 = 'Moonlight Ring',
        Back = { Name = 'Rudianos\'s Mantle', Augment = { [1] = 'Phys. dmg. taken -10%', [2] = 'Mag. Eva.+20', [3] = 'Eva.+20', [4] = 'HP+60', [5] = 'Enmity+10' } },
        Waist = 'Plat. Mog. Belt',
        Legs = 'Chev. Cuisses +2',
        Feet = 'Sakpata\'s Leggings',
        },
    Tank_MEVA = {
        Ammo = 'Staunch Tathlum',
        Head = 'Nyame Helm',
        Neck = 'Warder\'s Charm +1',
        Ear1 = 'Eabani Earring',
        Ear2 = 'Etiolation Earring',
        Body = 'Nyame Mail',
        Hands = 'Nyame Gauntlets',
        Ring1 = 'Vengeful Ring',
        Ring2 = 'Purity Ring',
        Back = { Name = 'Rudianos\'s Mantle', Augment = { [1] = 'Phys. dmg. taken -10%', [2] = 'Mag. Eva.+20', [3] = 'Eva.+20', [4] = 'HP+60', [5] = 'Enmity+10' } },
        Waist = 'Carrier\'s Sash',
        Legs = 'Nyame Flanchard',
        Feet = 'Nyame Sollerets',
    },

    Precast = {--44 w/o Loquac due to HP drop
        Ammo = 'Incantor Stone',--2
        Waist = 'Plat. Mog. Belt',
        Body = 'Rev. Surcoat +3',--10fc
        Ring1 = 'Moonlight Ring',
        Ear1 = 'Tuisto Earring',
        Ear2 = 'Etiolation Earring',
        Head = 'Chev. Armet +2',--14fc --38 hp; chev helmet big hp up
        Neck = 'Unmoving Collar +1',   
        Hands = 'Leyline Gloves',--6fc --25hp
        Ring2 = 'Kishar Ring',--4
        Back = { Name = 'Rudianos\'s Mantle', Augment = { [1] = '"Fast Cast"+10', [2] = 'HP+60' } },
        Legs = 'Enif Cosciales',--8fc --40hp
        Feet = 'Carmine Greaves +1',--8fc --95hp
    },
    Cure_Precast = {
        --Ear1 = 'Mendi. Earring',
        Ear2 = 'Nourish. Earring +1',
    },
    Enhancing_Precast = {
    },
    SIR = {--10 merits,101 gear
        Ammo = 'Staunch Tathlum +1', -- 11
        Head = 'Souv. Schaller +1', --20
        Waist = 'Plat. Mog. Belt',
        Ring1 = 'Moonlight Ring',
        Ring2 = 'Moonlight Ring',
        Body = 'Rev. Surcoat +3', 
        Ear1 = 'Odnowa Earring +1',
        Neck = 'Moonlight Necklace', -- 15
        Legs = 'Founder\'s Hose', -- 30
        Feet = 'Odyssean Greaves', -- 20
        Ear1 = 'Magnetic Earring', -- 8
    },
    Enmity = {
        Ammo = 'Sapience Orb',--2
        Waist = 'Creed Baudrier',--5
        Head = 'Loess Barbuta +1',--9
        Body = 'Souv. Cuirass +1',--10
        Legs = 'Souv. Diechlings +1',--9
        Feet = 'Chev. Sabatons +2',--13
        Back = { Name = 'Rudianos\'s Mantle', Augment = { [1] = 'Phys. dmg. taken -10%', [2] = 'Mag. Eva.+20', [3] = 'Eva.+20', [4] = 'HP+60', [5] = 'Enmity+10' } },--10
        Neck = 'Moonlight Necklace', -- 15
        Ring1 = 'Apeile Ring +1',--5~9
        Ring2 = 'Eihwaz Ring', --5
        Ear1 = 'Friomisi Earring',--2
        Ear2 = 'Cryptic Earring',--4
    },

    Cure = {
        Ammo = 'Staunch Tathlum +1',
        Head = 'Souv. Schaller +1', --15rec
        Body = 'Souv. Cuirass +1',--sir10
        Neck = 'Moonlight Necklace', -- 15
        Ear1 = 'Tuisto Earring',
        Ear2 = 'Odnowa Earring +1', -- 6
        Hands = 'Macabre Gaunt. +1', -- 11
        Ring1 = 'Eihwaz Ring',
        Ring2 = 'Gelatinous Ring +1',
        Back = 'Solemnity Cape', -- 7
        Waist = 'Plat. Mog. Belt',
        Legs = 'Founder\'s Hose',
        Feet = 'Odyssean Greaves', -- 7
    },
    PhalanxSet_Self = { --34 total atm
        Main = 'Sakpata\'s Sword', --5
        Sub = 'Priwen', --2
        Head = 'Valorous Mask',  --3/5
        Neck = 'Moonlight Necklace', 
        Ear2 = 'Odnowa Earring +1', 
        Ear1 = 'Etiolation Earring', 
        Body = 'Odyss. Chestplate', -- 5
        Hands = 'Souv. Handsch. +1', --5
        Ring1 = 'Moonbeam Ring',
        Ring2 = 'Moonbeam Ring',
        Back = 'Weard Mantle', --4/5
        Waist = 'Plat. Mog. Belt', 
        Legs = 'Sakpata\'s Cuisses', -- 5
        Feet = 'Souveran Schuhs +1', --5
    },
    PhalanxSet_Ext = {
        Main = 'Sakpata\'s Sword',
        Sub = 'Priwen',
        Head = 'Souv. Schaller +1',
        Neck = 'Moonlight Necklace',
        Ear1 = 'Odnowa Earring +1',
        Ear2 = 'Etiolation Earring',
        Body = 'Odyssean Chestplate', -- 3
        Hands = 'Souveran Handsch. +1', --3
        Ring1 = 'Moonbeam Ring',
        Ring2 = 'Moonbeam Ring',
        Back = 'Weard Mantle',
        Waist = 'Audumbla Sash',
        Legs = 'Sakpata\'s Cuisses', -- 5
        Feet = 'Souveran Schuhs +1',
    },
    Reprisal = {
        Ammo = 'Sapience Orb',
        Head = 'Souv. Schaller +1',
        Neck = 'Moonlight Necklace', -- 15
        Ear1 = 'Odnowa Earring +1',
        Ear2 = 'Cryptic Earring',
        Body = 'Shab. Cuirass +1',
        Ring1 = 'Eihwaz Ring',
        Ring2 = 'Gelatinous Ring +1',
        Back = { Name = 'Rudianos\'s Mantle', Augment = { [1] = 'Phys. dmg. taken -10%', [2] = 'Mag. Eva.+20', [3] = 'Eva.+20', [4] = 'HP+60', [5] = 'Enmity+10' } },--10
        Waist = 'Audumbla Sash',
        Legs = 'Founder\'s Hose',
        Feet = 'Eschite Greaves',
    },
    FullEnmity = {
        Ammo = 'Staunch Tathlum',
        Head = 'Loess Barbuta +1',
        Body = 'Souv. Cuirass +1',
        Legs = 'Souv. Diechlings +1',
        Hands = 'Souv. Handsch. +1',
        Neck = 'Moonlight Necklace', -- 15
        Ear1 = 'Trux Earring',
        Ear2 = 'Cryptic Earring',
        Ring1 = 'Apeile Ring +1',--5~9
        Ring2 = 'Apeile Ring',-- 5~9
        Back = { Name = 'Rudianos\'s Mantle', Augment = { [1] = 'Phys. dmg. taken -10%', [2] = 'Mag. Eva.+20', [3] = 'Eva.+20', [4] = 'HP+60', [5] = 'Enmity+10' } },
        Waist = 'Creed Baudrier',
        Feet = 'Chev. Sabatons +2',
    },

    Preshot = {},
    Midshot = {
        Ear1 = 'Telos Earring',
        Ear2 = 'Crep. Earring',
    },

    Ws_Default = {
        Ammo = 'Coiste Bodhar',
        Head = 'Nyame Helm',
        Neck = 'Fotia Gorget',
        Ear1 = 'Thrud Earring',
        Ear2 = 'Telos Earring',
        Body = 'Nyame Mail',
        Hands = 'Sakpata\'s Gauntlets',
        Ring1 = 'Beithir Ring',
        Ring2 = 'Karieyh Ring +1',
        Back = { Name = 'Rudianos\'s Mantle', Augment = { [1] = 'Accuracy+20', [2] = '"Dbl.Atk."+10', [3] = 'Attack+20', [4] = 'DEX+20' } },
        Waist = 'Fotia Belt',
        Legs = 'Sakpata\'s Cuisses',
        Feet = 'Valorous Greaves',
    },
    Ws_Hybrid = {
    },
    Ws_Acc = {
    },
    Chant_Default = {
        Ammo = 'Jukukik Feather',
        Head = 'Blistering Sallet +1',
        Ear1 = 'Mache Earring +1',
        Ear2 = 'Digni. Earring',
        Body = 'Hjarrandi Breast.',
        Hands = 'Flam. Manopolas +2',
        Ring2 = 'Begrudging Ring',
        Back = { Name = 'Rudianos\'s Mantle', Augment = { [1] = 'Accuracy+20', [2] = 'Crit.hit rate+10', [3] = 'Attack+20', [4] = 'DEX+20' } },
        Feet = 'Thereoid Greaves',
    },
    Chant_Hybrid = {
    },
    Chant_Acc = {
    },
    Savage_Default = {
        Head = 'Nyame Helm',
        Neck = 'Fotia Gorget',
        Ear1 = 'Thrud Earring',
        Ear2 = 'Digni. Earring',
        Body = 'Nyame Mail',
        Hands = 'Nyame Gauntlets',
        Ring1 = 'Beithir Ring',
        Ring2 = 'Karieyh Ring +1',
        Waist = 'Sailfi Belt +1',
        Legs = 'Nyame Flanchard',
        Feet = 'Nyame Sollerets',
    },
    Savage_Hybrid = {
    },
    Savage_Acc = {
    },
    Atone_Default = {
        Ammo = 'Staunch Tathlum +1',
        Head = 'Loess Barbuta +1',
        Body = 'Souv. Cuirass +1',
        Hands = 'Souv. Handsch. +1',
        Legs = 'Souv. Diechlings +1',
        Feet = 'Souv. Schuhs +1',
        Neck = 'Moonlight Necklace', -- 15
        Ear1 = 'Odnowa Earring +1',
        Ear2 = 'Digni. Earring',
        Ring1 = 'Eihwaz Ring',
        Ring2 = 'Supershear Ring',
        Back = { Name = 'Rudianos\'s Mantle', Augment = { [1] = 'Phys. dmg. taken -10%', [2] = 'Evasion+20', [3] = 'HP+60', [4] = 'Mag. Evasion+30', [5] = 'Enmity+10' } },
        Waist = 'Fotia Belt',
    },
    Atone_Hybrid = {
    },
    Atone_Acc = {
    },
    Aedge_Default = {
        Ammo = 'Pemphredo Tathlum',
        Head = 'Nyame Helm',
        Neck = 'Baetyl Pendant',
        Ear1 = 'Friomisi Earring',
        Ear2 = 'Crematio Earring',
        Body = 'Nyame Mail',
        Hands = 'Nyame Gauntlets',
        Ring1 = 'Shiva Ring +1',
        Ring2 = 'Karieyh Ring +1',
        Waist = 'Eschan Stone',
        Legs = 'Nyame Flanchard',
        Feet = 'Nyame Sollerets',
    },
    Aedge_Hybrid = {},
    Aedge_Acc = {},

    Fealty = {
        Body = 'Cab. Surcoat +3',
    },
    Sentinel = {
        Feet = 'Cab. Leggings +3',
    },
    Bash = {
        Hands = 'Cab. Gauntlets +2',
    },
    Invincible = {
        Legs = 'Cab. Breeches +3',
    },
    Cover = {
        Body = 'Cab. Surcoat +3',
        Head = 'Rev. Coronet +1',
    },
    Rampart = {
        Head = 'Cab. Coronet +1',
    },
    
    TH = {
        Ammo = 'Per. Lucky Egg',
		Waist = 'Chaac Belt',
	},
    Movement = {
        Legs = 'Carmine Cuisses +1',
	},
    Lockstyle = {
        Main = 'Burtgang',
        Sub = 'Aegis',
        Head = 'Cait Sith Cap +1',
        Body = 'Valor Surcoat',
        Hands = 'Souv. Handsch. +1',
        Legs = 'Souv. Diechlings +1',
        Feet = 'Cab. Leggings +3',
    },
    Duban = {
        Sub = 'Duban',
    },
    Aegis = {
        Sub = 'Aegis',
    },
    Burtgang = {
        Main = 'Burtgang',
    },
    Naegling = {
        Main = 'Naegling',
    },

    ['fastcastcloak'] = {
        Main = 'Burtgang',
        Sub = { Name = 'Priwen', AugPath='A' },
        Ammo = 'Staunch Tathlum +1',
        Head = { Name = 'Sakpata\'s Helm', AugPath='A' },
        Neck = 'Sanctity Necklace',
        Ear1 = 'Eabani Earring',
        Ear2 = 'Thureous Earring',
        Body = { Name = 'Sakpata\'s Plate', AugPath='A' },
        Hands = { Name = 'Sakpata\'s Gauntlets', AugPath='A' },
        Ring1 = 'Moonlight Ring',
        Ring2 = 'Moonlight Ring',
        Back = { Name = 'Rudianos\'s Mantle', Augment = { [1] = '"Fast Cast"+10', [2] = 'HP+60' } },
        Waist = { Name = 'Sailfi Belt +1', AugPath='A' },
        Legs = { Name = 'Carmine Cuisses +1', AugPath='A' },
        Feet = { Name = 'Sakpata\'s Leggings', AugPath='A' },
    },
    ['tpcloak'] = {
        Main = 'Burtgang',
        Sub = { Name = 'Priwen', AugPath='A' },
        Ammo = 'Staunch Tathlum +1',
        Head = { Name = 'Souv. Schaller +1', AugPath='C' },
        Neck = { Name = 'Kgt. Beads +2', AugPath='A' },
        Ear1 = 'Eabani Earring',
        Ear2 = 'Thureous Earring',
        Body = { Name = 'Sakpata\'s Plate', AugPath='A' },
        Hands = { Name = 'Sakpata\'s Gauntlets', AugPath='A' },
        Ring1 = 'Moonlight Ring',
        Ring2 = 'Moonlight Ring',
        Back = { Name = 'Rudianos\'s Mantle', Augment = { [1] = 'Occ. inc. resist. to stat. ailments+10', [2] = 'Accuracy+20', [3] = 'HP+60', [4] = 'Attack+20', [5] = '"Store TP"+10' } },
        Waist = { Name = 'Sailfi Belt +1', AugPath='A' },
        Legs = { Name = 'Carmine Cuisses +1', AugPath='A' },
        Feet = { Name = 'Sakpata\'s Leggings', AugPath='A' },
    },
    ['enmitycloak'] = {
        Main = { Name = 'Sakpata\'s Sword', AugPath='A' },
        Sub = { Name = 'Priwen', AugPath='A' },
        Ammo = 'Staunch Tathlum +1',
        Head = { Name = 'Sakpata\'s Helm', AugPath='A' },
        Neck = { Name = 'Kgt. Beads +2', AugPath='A' },
        Ear1 = 'Eabani Earring',
        Ear2 = 'Thureous Earring',
        Body = { Name = 'Sakpata\'s Plate', AugPath='A' },
        Hands = { Name = 'Sakpata\'s Gauntlets', AugPath='A' },
        Ring1 = 'Moonlight Ring',
        Ring2 = 'Moonlight Ring',
        Back = { Name = 'Rudianos\'s Mantle', Augment = { [1] = 'Phys. dmg. taken -10%', [2] = 'Evasion+20', [3] = 'HP+60', [4] = 'Mag. Evasion+30', [5] = 'Enmity+10' } },
        Waist = { Name = 'Sailfi Belt +1', AugPath='A' },
        Legs = { Name = 'Carmine Cuisses +1', AugPath='A' },
        Feet = { Name = 'Sakpata\'s Leggings', AugPath='A' },
    },
};
profile.Sets = sets;

profile.Packer = {
    {Name = 'Om. Sandwich', Quantity = 'all'},
    {Name = 'Black Curry Bun', Quantity = 'all'},
};

profile.OnLoad = function()
	gSettings.AllowAddSet = true;
    gcinclude.Initialize();

    AshitaCore:GetChatManager():QueueCommand(1, '/macro book 11');
    AshitaCore:GetChatManager():QueueCommand(1, '/macro set 10');
end

profile.OnUnload = function()
    gcinclude.Unload();
end

profile.HandleCommand = function(args)
    gcinclude.HandleCommands(args);
end

profile.HandleDefault = function()
    local MH = gcinclude.MH;
    local Sub = gcinclude.Sub;
    if (gcinclude.phalanxSet == true) and (gcinclude.externalPhalanx == false) then
        gFunc.EquipSet(sets.PhalanxSet_Self);
    elseif (gcinclude.phalanxSet == true) and (gcinclude.externalPhalanx == true) then
        gFunc.EquipSet(sets.PhalanxSet_Ext);
    else
        gFunc.EquipSet(sets.Idle);
    end
	
	local player = gData.GetPlayer();
    if (player.Status == 'Engaged') then
        gFunc.EquipSet(sets.Tp_Default)
        if (gcdisplay.GetCycle('MeleeSet') ~= 'Default') then
			gFunc.EquipSet('Tp_' .. gcdisplay.GetCycle('MeleeSet')) 
            if (gcinclude.settings.killingBlow == true) then
                gcinclude.DoKillingBlow();
            end
        end
		if (gcdisplay.GetToggle('TH') == true) then gFunc.EquipSet(sets.TH) end
        if (gcdisplay.GetCycle('TankSet') ~= 'None') then
			gFunc.EquipSet('Tank_' .. gcdisplay.GetCycle('TankSet')) end
        if (gcinclude.phalanxSet == true) and (gcinclude.externalPhalanx == false) then
            gFunc.EquipSet(sets.PhalanxSet_Self);
        end
        if (gcinclude.phalanxSet == true) and (gcinclude.externalPhalanx == true) then
            gFunc.EquipSet(sets.PhalanxSet_Ext);
        end
    elseif (player.Status == 'Resting') then
        gFunc.EquipSet(sets.Resting);
    elseif (player.IsMoving == true) then
		if (gcinclude.phalanxSet == true) and (gcinclude.externalPhalanx == false) then
            gFunc.EquipSet(sets.PhalanxSet_Self)
        elseif (gcinclude.phalanxSet == true) and (gcinclude.externalPhalanx == true) then
            gFunc.EquipSet(sets.PhalanxSet_Ext)
        else
            gFunc.EquipSet(sets.Idle);
        end
    end
	
    local cover = gData.GetBuffCount('Cover');
	if (cover >= 1) then
		gFunc.EquipSet(sets.Fealty); -- same set as fealty
	end

    --main wep
    local mainHandSets = {
    ['Burtgang']  = sets.Burtgang,
    ['Naegling']  = sets.Naegling,
    }

    -- Off Hand weapon sets
    local offHandSets = {
    ['Duban'] = sets.Duban,
    ['Aegis'] = sets.Aegis,
    }

    -- Equip main hand set if it exists
    local mhSet = mainHandSets[gcdisplay.GetCycle('MH')]
    if mhSet then gFunc.EquipSet(mhSet) end

    -- Equip off hand set if it exists
    local ohSet = offHandSets[gcdisplay.GetCycle('OH')]
    if ohSet then gFunc.EquipSet(ohSet) end
	
    gcinclude.CheckDefault();
    if (gcdisplay.GetToggle('DTset') == true) then gFunc.EquipSet(sets.Dt) end;
    if (gcdisplay.GetToggle('Kite') == true) then gFunc.EquipSet(sets.Movement) end;
end

profile.HandleAbility = function()
    local ability = gData.GetAction();
    local name = ability.Name

    gFunc.EquipSet(sets.Enmity)

    local abilityMap = {
        ['Fealty']          = sets.Fealty,
        ['Sentinel']        = sets.Sentinel,
        ['Shield Bash']     = sets.Bash,
        ['Chivalry']        = sets.Bash,
        ['Invincible']      = sets.Invincible,
        ['Cover']           = sets.Cover,
        ['Rampart']         = sets.Rampart,
    }

    for key, set in pairs(abilityMap) do
        if string.match(name, key) then
            gFunc.EquipSet(set)
            break
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
    gFunc.EquipSet(sets.Precast)

    if (spell.Skill == 'Enhancing Magic') then
        gFunc.EquipSet(sets.Enhancing_Precast);
    elseif (spell.Skill == 'Healing Magic') then
        gFunc.EquipSet(sets.Cure_Precast);
    end

    gcinclude.CheckCancels();
end

profile.HandleMidcast = function()
    local spell = gData.GetAction();
    local name = spell.Name

    local spellMap = {
        ['Cur']       = sets.Cure,
        ['Phalanx']   = sets.PhalanxSet_Self,
        ['Reprisal']  = sets.Reprisal,
        ['Flash']     = sets.Enmity,
        ['Jettatura'] = sets.Enmity,
        ['Foil']      = sets.Enmity,
    }

    for key, set in pairs(spellMap) do
        if string.match(name, key) then
            gFunc.EquipSet(set)
            -- Handle early return cases
            if key == 'Reprisal' or key == 'Flash' then return end
            break
        end
    end

    -- Default fallback if no match found above
    if not (string.match(name, 'Cur') or string.match(name, 'Phalanx') or
            string.match(name, 'Reprisal') or string.match(name, 'Flash') or
            string.match(name, 'Jettatura') or string.match(name, 'Foil')) then
        gFunc.EquipSet(sets.Enmity)
    end

    if gcdisplay.GetToggle('SIR') == true then
        gFunc.EquipSet(sets.SIR);
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
    if not gcinclude.CheckWsBailout() then
        gFunc.CancelAction()
        return
    end

    local ws = gData.GetAction()
    local wsName = ws.Name:lower()
    local meleeSet = gcdisplay.GetCycle('MeleeSet')

    local function equipSet(setPrefix)
        gFunc.EquipSet(sets[setPrefix .. '_Default'])
        if meleeSet ~= 'Default' and sets[setPrefix .. '_' .. meleeSet] then
            gFunc.EquipSet(sets[setPrefix .. '_' .. meleeSet])
        end
    end

    local wsMap = {
        ['chant du cygne']    = 'Chant',
        ['savage blade']      = 'Savage',
        ['knights of round']  = 'Savage',
        ['atonement']         = 'Atone',
        ['aeolian edge']      = 'Aedge'
    }

    -- Default WS set
    gFunc.EquipSet(sets.Ws_Default)
    if meleeSet ~= 'Default' and sets['Ws_' .. meleeSet] then
        gFunc.EquipSet(sets['Ws_' .. meleeSet])
    end

    -- Specific WS overrides
    for key, setPrefix in pairs(wsMap) do
        if wsName:match(key) then
            equipSet(setPrefix)
            break
        end
    end

    -- Optional: Add Hachirin logic for elemental WS
    if ws.Element then
        profile.Hachirin(ws.Element)
    end
end

return profile;
