local profile = {};
gcinclude = gFunc.LoadFile('common\\gcinclude.lua');


local sets = {
    Idle = {
        Head = 'Nyame Helm',
        Neck = 'Sanctity Necklace',
        --'Bathy Choker +1',
        Ear1 = 'Eabani Earring',
        Ear2 = '',
        Body = 'Nyame Mail',
        Hands = 'Nyame Gauntlets',
        Ring1 = 'Moonlight Ring',
        Ring2 = 'Moonlight Ring',
        Back = 'Solemnity Cape',
        Waist = 'Flume Belt +1',
        Legs = 'Nyame Flanchard',
        Feet = 'Nyame Sollerets',
    },
    Lockstyle = {
        Head = 'Mummu Bonnet +2',
        Body = 'Plunderer\'s Vest',
        Hands = 'Plun. Armlets +3',
        Legs = 'Plun. Culottes +2',
        Feet = 'Mummu Gamash. +2',
    },
    Resting = {},
    Idle_Regen = {
        Head = 'Meghanada Visor +2',
        Neck = 'Bathy Choker +1',
        Ear1 = 'Infused Earring',
        Hands = 'Meg. Gloves +2',
        Ring2 = 'Chirich Ring +1',
        Feet = 'Meg. Jam. +2',
    },
    Idle_Refresh = {},
    Town = {
        Main = 'Tauret',
        Sub = { Name = 'Shijo', AugPath='D' },
        Ammo = 'Coiste Bodhar',
        Feet = 'Pill. Poulaines +3',
    },
    TownNight = {
        Main = 'Tauret',
        Sub = { Name = 'Shijo', AugPath='D' },
        Ammo = 'Coiste Bodhar',
        Feet = 'Pill. Poulaines +3',
    },

    Dt = {
        Head = 'Nyame Helm',
        Neck ='Bathy Choker +1',
        Ear1 = 'Odnowa Earring +1',
        Ear2 = 'Etiolation Earring',
        Body = 'Nyame Mail',
        Hands = 'Nyame Gauntlets',
        Ring1 = 'Moonbeam Ring',
        Ring2 = 'Gelatinous Ring +1',
        Back = { Name = 'Toutatis\'s Cape', Augment = { [1] = 'Damage taken-5%', [2] = 'Accuracy+30', [3] = 'Attack+20', [4] = '"Store TP"+10', [5] = 'DEX+20' } },
        Waist = 'Sailfi Belt +1',
        Legs = 'Nyame Flanchard',
        Feet = 'Nyame Sollerets',
    },

    Tp_Default = {
        Head = 'Nyame Helm',
        Neck = 'Asn. Gorget +1',
        Ear1 = 'Eabani Earring',
        Ear2 = 'Brutal Earring',
        Body = 'Mummu Jacket +2',
        Hands = 'Nyame Gauntlets',
        Ring1 = 'Moonlight Ring',
        Ring2 = 'Moonlight Ring',
        Back = { Name = 'Toutatis\'s Cape', Augment = { [1] = 'Damage taken-5%', [2] = 'Accuracy+30', [3] = 'Attack+20', [4] = '"Store TP"+10', [5] = 'DEX+20' } },
        Waist = { Name = 'Sailfi Belt +1', AugPath='A' },
        Legs = 'Nyame Flanchard',
        Feet = 'Nyame Sollerets',
        Ammo = 'Yetshila +1',
    },
    Tp_Hybrid = {
        Head = 'Malignance Chapeau',
        Body = 'Gleti\'s Cuirass',
        Hands = 'Malignance Gloves',
        Legs = 'Gleti\'s Breeches',
        Feet = 'Gleti\'s Boots',
        Ammo = 'Staunch Tathlum +1',
    },
    Tp_Acc = {
        Head = 'Malignance Chapeau',
        Neck = 'Sanctity Necklace',
        Ear1 = 'Mache Earring +1',
        Body = 'Gleti\'s Cuirass',
        Hands = 'Malignance Gloves',
        Ring1 = 'Cacoethic Ring +1',
        Ring2 = 'Chirich Ring +1',
        Legs = 'Gleti\'s Breeches',
        Feet = 'Gleti\'s Boots',
    },


    Precast = {
        Head = 'Haruspex Hat',
        Neck = 'Baetyl Pendant',
        Ear2 = 'Etiolation Earring',
        Body = 'Taeon Tabard',
        Hands = 'Leyline Gloves',
        Ring1 = 'Prolix Ring',
        Legs = 'Enif Cosciales',
    },

    Preshot = {
    },
    Midshot = {
        Head = 'Malignance Chapeau',
        Neck = 'Iskur Gorget',
        Ear1 = 'Telos Earring',
        Ear2 = 'Crep. Earring',
        Body = 'Mummu Jacket +2',
        Hands = 'Plun. Armlets +3',
        Ring2 = 'Dingir Ring',
        Waist = 'Eschan Stone',
    },

    Ws_Default = {
        Head = { Name = 'Adhemar Bonnet +1', AugPath='B' },
        Neck = 'Fotia Gorget',
        Ear1 = 'Odr Earring',
        Ear2 = 'Mache Earring +1',
        Body = { Name = 'Plunderer\'s Vest +3', AugTrial=5477 },
        Hands = 'Meg. Gloves +2',
        Ring1 = 'Beithir Ring',
        Ring2 = 'Karieyh Ring +1',
        Back = { Name = 'Toutatis\'s Cape', Augment = { [1] = 'Accuracy+20', [2] = 'Weapon skill damage +10%', [3] = 'Attack+20', [4] = 'DEX+20' } },
        Waist = 'Fotia Belt',
        Legs = 'Plun. Culottes +2',
        Feet = { Name = 'Herculean Boots', Augment = { [1] = 'Accuracy+30', [2] = 'Weapon skill damage +8%', [3] = 'Attack+6', [4] = 'Mag. Acc.+2' } },
    },
    Ws_Default_SA = {
    },
    Ws_Default_TA = {
    },
    Ws_Default_SATA = {
    },
    Ws_Hybrid = {
        Head = 'Nyame Helm',
        Body = 'Gleti\'s Cuirass',
        Legs = 'Gleti\'s Breeches',
        Feet = 'Gleti\'s Boots',
    },
    Ws_Hybrid_SA = {},
    Ws_Hybrid_TA = {},
    Ws_Hybrid_SATA = {},
    Ws_Acc = {
    },
    Ws_Acc_SA = {},
    Ws_Acc_TA = {},
    Ws_Acc_SATA = {},

    Evis_Default = {
        Head = 'Mummu Bonnet +2',
        Neck = 'Fotia Gorget',
        Ear1 = '',
        Ear2 = 'Odr Earring',
        Body = 'Mummu Jacket +2',
        Hands = 'Mummu Wrists +2',
        Ring1 = 'Beithir Ring',
        Ring2 = 'Mummu Ring',
        Back = { Name = 'Toutatis\'s Cape', Augment = { [1] = 'Accuracy+20', [2] = 'Weapon skill damage +10%', [3] = 'Attack+20', [4] = 'DEX+20' } },
        Waist = 'Fotia Belt',
        Legs = 'Mummu Kecks +2',
        Feet = 'Mummu Gamash. +2',
        Ammo = 'Yetshila +1',
    },
    Evis_Default_SA = {
    },
    Evis_Default_TA = {
        
    },
    Evis_Default_SATA = {
    },
    Evis_Hybrid = {
    },
    Evis_Hybrid_SA = {},
    Evis_Hybrid_TA = {},
    Evis_Hybrid_SATA = {},
    Evis_Acc = {
    },
    Evis_Acc_SA = {},
    Evis_Acc_TA = {},
    Evis_Acc_SATA = {},
    
    Aeolian_Edge = {
        Head = 'Nyame Helm',
        Body = 'Nyame Mail',
        Hands = 'Nyame Gauntlets',
        Legs = 'Nyame Flanchard',
        Feet = 'Nyame Sollerets',
        Ear1 = 'Moldavite Earring',
        Ear2 = 'Friomisi Earring',
    },
    Rudra_Default = {
        Head = 'Nyame Helm',
        Body = 'Nyame Mail',
        Hands = 'Nyame Gauntlets',
        Legs = 'Nyame Flanchard',
        Feet = 'Nyame Sollerets',
    },
    Rudra_SA = {
        Head = 'Nyame Helm',
        Body = 'Nyame Mail',
        Hands = 'Nyame Gauntlets',
        Legs = 'Nyame Flanchard',
        Feet = 'Nyame Sollerets',
    },
    Rudra_TA = {
        Head = 'Nyame Helm',
        Body = 'Nyame Mail',
        Hands = 'Nyame Gauntlets',
        Legs = 'Nyame Flanchard',
        Feet = 'Nyame Sollerets',
    },
    Rudra_Hybrid = {
        Head = 'Nyame Helm',
        Body = 'Nyame Mail',
        Hands = 'Nyame Gauntlets',
        Legs = 'Nyame Flanchard',
        Feet = 'Nyame Sollerets',
    },

    SATA = {
        
    },
    Steal = {

    },
    SA = {
        
    },
    TA = {
    
    },
    TH = {
        Hands = 'Plun. Armlets +3',
        Feet = 'Skulk. Poulaines',
        Ammo = "Per. Lucky Egg",
    },
    Flee = {
        Feet = 'Pill. Poulaines +3',
    },
    Movement = {
        Feet = 'Pill. Poulaines +3',
	},
    ['copypaste'] = {
        Main = 'Kaja Knife',
        Sub = { Name = 'Shijo', AugPath='D' },
        Range = 'Raider\'s Bmrng.',
        Head = 'Mummu Bonnet +2',
        Neck = 'Pentalagus Charm',
        Ear1 = 'Eabani Earring',
        Ear2 = 'Suppanomimi',
        Body = 'Mummu Jacket +2',
        Hands = 'Mummu Wrists +2',
        Ring1 = 'Warp Ring',
        Ring2 = 'Mummu Ring',
        Back = { Name = 'Toutatis\'s Cape', Augment = { [1] = 'Accuracy+20', [2] = '"Store TP"+10', [3] = 'Attack+20', [4] = 'DEX+20' } },
        Waist = 'Cetl Belt',
        Legs = 'Mummu Kecks +2',
        Feet = 'Pill. Poulaines +1',
    },
};
profile.Sets = sets;

profile.Packer = {
    'Odious Blood',
    'Odious Pen',
    'Odious Skull',
    'Odious Horn',
    {Name = 'Forgotten Hope', Quantity = 'all'},
    {Name = 'Frgtn. Thought', Quantity = 'all'},
    'Shrouded Bijou',
    {Name = 'T. Whiteshell', Quantity = 'all'},
    {Name = 'O. Bronzepiece', Quantity = 'all'},
    {Name = '1 Byne Bill', Quantity = 'all'},
};

profile.OnLoad = function()
	gSettings.AllowAddSet = true;
    gcinclude.Initialize();

    --Lockstyle
    AshitaCore:GetChatManager():QueueCommand(1, '/lac Lockstyle Lockstyle');

    --[[ Set you job macro defaults here]]
    AshitaCore:GetChatManager():QueueCommand(1, '/macro book 2');
    AshitaCore:GetChatManager():QueueCommand(1, '/macro set 2');
end

profile.OnUnload = function()
    gcinclude.Unload();
end

profile.HandleCommand = function(args)
    gcinclude.HandleCommands(args);
end

profile.HandleDefault = function()
    gFunc.EquipSet(sets.Idle);
    local sa = gData.GetBuffCount('Sneak Attack');
    local ta = gData.GetBuffCount('Trick Attack');
	
	local player = gData.GetPlayer();
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
	
    if (sa == 1) and (ta == 1) then
        gFunc.EquipSet('SATA');
    elseif (sa == 1) then
        gFunc.EquipSet('SA');
    elseif (ta == 1) then
        gFunc.EquipSet('TA');
    end
    
    gcinclude.CheckDefault ();
    if (gcdisplay.GetToggle('DTset') == true) then gFunc.EquipSet(sets.Dt) end;
    if (gcdisplay.GetToggle('Kite') == true) then gFunc.EquipSet(sets.Movement) end;
end

profile.HandleAbility = function()
    local ability = gData.GetAction();
	if string.match(ability.Name, 'Flee') then
		gFunc.EquipSet(sets.Flee);
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
    if (canWS == false) then gFunc.CancelAction() return;
    else
        local ws = gData.GetAction();
        local sa = gData.GetBuffCount('Sneak Attack');
        local ta = gData.GetBuffCount('Trick Attack');
    
        gFunc.EquipSet(sets.Ws_Default)
        if (gcdisplay.GetCycle('MeleeSet') ~= 'Default') then
        gFunc.EquipSet('Ws_' .. gcdisplay.GetCycle('MeleeSet')) end
        if (sa == 1) and (ta == 1) then
            gFunc.EquipSet('Ws_' .. gcdisplay.GetCycle('MeleeSet') .. '_SATA');
        elseif (sa == 1) then
            gFunc.EquipSet('Ws_' .. gcdisplay.GetCycle('MeleeSet') .. '_SA');
        elseif (ta == 1) then
            gFunc.EquipSet('Ws_' .. gcdisplay.GetCycle('MeleeSet') .. '_TA');
        end

        if string.match(ws.Name, 'Evisceration') then
            gFunc.EquipSet(sets.Evis_Default)
            if (gcdisplay.GetCycle('MeleeSet') ~= 'Default') then
            gFunc.EquipSet('Evis_' .. gcdisplay.GetCycle('MeleeSet')); end
            if (sa == 1) and (ta == 1) then
                gFunc.EquipSet('Evis_' .. gcdisplay.GetCycle('MeleeSet') .. '_SATA');
            elseif (sa == 1) then
                gFunc.EquipSet('Evis_' .. gcdisplay.GetCycle('MeleeSet') .. '_SA');
            elseif (ta == 1) then
                gFunc.EquipSet('Evis_' .. gcdisplay.GetCycle('MeleeSet') .. '_TA');
            end
        end
        if string.match(ws.Name, 'Aeolian Edge') then
            gFunc.EquipSet(sets.Aeolian_Edge)
        end
        if string.match(ws.Name, 'Evisceration') then
            gFunc.EquipSet(sets.Evis_Default)
            if (gcdisplay.GetCycle('MeleeSet') ~= 'Default') then
            gFunc.EquipSet('Rudra_' .. gcdisplay.GetCycle('MeleeSet')); end
            if (sa == 1) and (ta == 1) then
                gFunc.EquipSet('Rudra_' .. gcdisplay.GetCycle('MeleeSet') .. '_SATA');
            elseif (sa == 1) then
                gFunc.EquipSet('Rudra_' .. gcdisplay.GetCycle('MeleeSet') .. '_SA');
            elseif (ta == 1) then
                gFunc.EquipSet('Rudra_' .. gcdisplay.GetCycle('MeleeSet') .. '_TA');
            end
        end
    end
end

return profile;
