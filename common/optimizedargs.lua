function gcinclude.HandleCommands(args)
	if not gcinclude.AliasList:contains(args[1]) then return end

	local player = gData.GetPlayer();
	local toggle = nil;
	local status = nil;
	
	if args[1] == 'gcmessages' then
		if gcinclude.settings.Messages then
			gcinclude.settings.Messages = false;
			print(chat.header('GCinclude'):append(chat.message('Chat messanges are disabled')));
		else
			gcinclude.settings.Messages = true;
			print(chat.header('GCinclude'):append(chat.message('Chat messanges are enabled')));
		end
	elseif (args[1] == 'wsdistance') then
		if (tonumber(args[2])) then 
			gcinclude.settings.WScheck = true;
			gcinclude.settings.WSdistance = tonumber(args[2]);
			print(chat.header('GCinclude'):append(chat.message('WS Distance is on and set to ' .. gcinclude.settings.WSdistance)));
		else
			gcinclude.settings.WScheck = not gcinclude.settings.WScheck;
			print(chat.header('GCinclude'):append(chat.message('WS distance check is now ' .. tostring(gcinclude.settings.WScheck))));
			print(chat.header('GCinclude'):append(chat.message('Can change WS distance allowed by using /wsdistance ##')));
		end
	elseif (args[1] == 'zz') then
		gcinclude.settings.wakeUp = true;
		print(chat.header('GCinclude'):append(chat.message('Wake up plap.')));
	elseif (string.lower(args[1]) == 'vagarysc') then
		if gcinclude.settings.vagarySC == 0 then
			gcinclude.settings.vagarySC = 1 
			print(chat.header('GCinclude'):append(chat.message('Vagary SC set toggled ON.')));
		elseif gcinclude.settings.vagarySC == 1 then
			gcinclude.settings.vagarySC = 0
			print(chat.header('GCinclude'):append(chat.message('Vagary SC set toggled OFF.')));
		end
	elseif string.lower(args[1]) == 'autohaste' then
		if string.lower(args[2]) == 'help' or args[2] == '' then
			print(chat.header('GCinclude'):append(chat.message('\"/autohaste toggle\" to toggle autohaste detection to on or off.')))
			print(chat.header('GCinclude'):append(chat.message('Other commands: /autohaste brdbonus (0-8) | /autohaste geobonus (0-x)' )))
		elseif string.lower(args[2]) == 'brdbonus' then
			if tonumber(args[3]) and tonumber(args[3]) >= 0 and tonumber(args[3]) < 9 then
				JHaste.metatable.brdBonus = tonumber(args[3])
				print(chat.header('GCinclude'):append(chat.message('Bard song bonus set to ' .. JHaste.metatable.brdBonus)))
			else
				print(chat.header('GCinclude'):append(chat.message('Invalid amount for bard song bonus. Try a number between 0 and 8.')))
			end																		
		elseif string.lower(args[2]) == 'geobonus' then
			if tonumber(args[3]) and tonumber(args[3]) >= 0 then
				JHaste.metatable.geoBonus = tonumber(args[3])
				print(chat.header('GCinclude'):append(chat.message('Geomancy bonus set to ' .. JHaste.metatable.geoBonus)))
			else
				print(chat.header('GCinclude'):append(chat.message('Invalid amount for Geomancy bonus. Try 0 or a positive number.')))
			end
		elseif string.lower(args[2]) == 'debug' then
			local total = JHaste and JHaste.metatable.totalHaste or 'N/A';        -- calls getTotalHaste()
			local dw = JHaste and JHaste.metatable.dwNeeded or 'N/A';             -- calls getDwNeeded()
			local h2h = JHaste and JHaste.metatable.maNeeded or 'N/A';            -- calls getMANeeded
			local ja = JHaste and JHaste.metatable.jobHaste or 'N/A';             -- calls getJaHaste()
			local ma = JHaste and JHaste.metatable.magicHaste or 'N/A';			  -- calls getMaHaste()
			print(chat.header('GCinclude'):append(chat.message('Total Haste: ' .. (total / 1024) * 100 .. '%')));
			if player.MainJob == 'DNC' or player.MainJob == 'THF' or player.MainJob == 'NIN' or player.MainJob == 'BLU' or player.SubJob == 'NIN' or player.SubJob == 'DNC' then
				print(chat.header('GCinclude'):append(chat.message('DW Needed: ' .. dw)));
			end
			if player.MainJob == 'MNK' or player.MainJob == 'PUP' then
				print(chat.header('GCinclude'):append(chat.message('Weapon: ' .. gData.GetEquipment().Main.Name)));
				print(chat.header('GCinclude'):append(chat.message('MA Needed: ' .. h2h)));
			end
			print(chat.header('GCinclude'):append(chat.message('Job Haste: ' .. (ja / 1024) * 100 .. '%')));
			print(chat.header('GCinclude'):append(chat.message('Magic Haste: ' .. (ma / 1024) * 100 .. '%')));
		end
	elseif string.lower(args[1]) == 'autodw' then
		gcdisplay.AdvanceToggle('AutoDW');
		toggle = 'AutoDW';
		status = gcdisplay.GetToggle('AutoDW');
	elseif string.lower(args[1]) == 'autohasso' then
		gcdisplay.AdvanceToggle('AutoHasso');
		toggle = 'AutoHasso';
		status = gcdisplay.GetToggle('AutoHasso');
	elseif (string.lower(args[1]) == 'aeonic') then
		gcinclude.settings.mythic = false
		gcinclude.settings.empyrean = false
		gcinclude.settings.tpBonusWeapon = false
		if gcinclude.settings.aeonic == false then
			gcinclude.settings.aeonic = true 
			print(chat.header('GCinclude'):append(chat.message('Aeonic weapon set toggled ON.')));
		else
			gcinclude.settings.aeonic = false
			print(chat.header('GCinclude'):append(chat.message('Aeonic weapon set toggled OFF.')));
		end
	elseif (string.lower(args[1]) == 'mythic') then
		gcinclude.settings.aeonic = false
		gcinclude.settings.empyrean = false
		gcinclude.settings.tpBonusWeapon = false
		if gcinclude.settings.mythic == false then
			gcinclude.settings.mythic = true
			print(chat.header('GCinclude'):append(chat.message('Mythic weapon set toggled ON.')));
		else
			gcinclude.settings.mythic = false
			print(chat.header('GCinclude'):append(chat.message('Mythic weapon set toggled OFF.')));
		end
	
	elseif (string.lower(args[1]) == 'empyrean') then
		gcinclude.settings.aeonic = false
		gcinclude.settings.mythic = false
		gcinclude.settings.tpBonusWeapon = false
		if gcinclude.settings.empyrean == false then
			gcinclude.settings.empyrean = true 
			print(chat.header('GCinclude'):append(chat.message('Empyrean weapon set toggled ON.')));
		else
			gcinclude.settings.empyrean = false
			print(chat.header('GCinclude'):append(chat.message('Empyrean weapon set toggled OFF.')));
		end
	
	elseif (string.lower(args[1]) == 'killingblow') then
		local subCmd = args[2] and string.lower(args[2]) or nil
	
		if subCmd == 'help' then
			print(chat.header('GCinclude'):append(chat.message('"/killingblow on" to toggle HPP WS restriction ON.')))
			print(chat.header('GCinclude'):append(chat.message('"/killingblow off" to toggle HPP WS restriction OFF.')))
			print(chat.header('GCinclude'):append(chat.message('"/killingblow #" to set the HPP % for a WS to be used under.')))
			print(chat.header('GCinclude'):append(chat.message('e.g.: /killingblow 20 sets WS to only trigger when target is at or below 20%.')))
			print(chat.header('GCinclude'):append(chat.message('"/killingblow ws [name]" sets the weaponskill.')))
		elseif subCmd == 'on' then
			if not gcinclude.settings.killingBlow then
				gcinclude.settings.killingBlow = true
				print(chat.header('GCinclude'):append(chat.message('Killing blow WS restriction is ON.')))
			else
				print(chat.header('GCinclude'):append(chat.message('Killing blow restriction already active. Nothing changed.')))
			end
		elseif subCmd == 'off' then
			if gcinclude.settings.killingBlow then
				gcinclude.settings.killingBlow = false
				print(chat.header('GCinclude'):append(chat.message('Killing blow WS restriction is OFF.')))
			else
				print(chat.header('GCinclude'):append(chat.message('Killing blow restriction not active. Nothing changed.')))
			end
		elseif subCmd == 'ws' and args[3] then
			gcinclude.settings.killingBlowWS = args[3]
			print(chat.header('GCinclude'):append(chat.message('Killing blow WS set to ' .. gcinclude.settings.killingBlowWS .. '.')))
		elseif tonumber(args[2]) ~= nil then
			local value = tonumber(args[2])
			if value <= 100 then
				gcinclude.settings.killingBlowPercent = value
				gcinclude.settings.killingBlow = true
				print(chat.header('GCinclude'):append(chat.message('Killing blow percent set to ' .. value)))
			else
				print(chat.header('GCinclude'):append(chat.message('Please enter a valid percent value (0–100).')))
			end
		else
			print(chat.header('GCinclude'):append(chat.message('Invalid secondary command. Try "/killingblow help" for more information.')))
		end
	elseif (args[1] == 'dt') then
		gcdisplay.AdvanceToggle('DTset');
		toggle = 'DT Set';
		status = gcdisplay.GetToggle('DTset');
	elseif (args[1] == 'aeolian') then
		gcdisplay.AdvanceToggle('Aeolian');
		toggle = 'Aeolian';
		status = gcdisplay.GetToggle('Aeolian');
    elseif (args[1] == 'meleeset') then
		gcdisplay.AdvanceCycle('MeleeSet');
		toggle = 'Melee Set';
		status = gcdisplay.GetCycle('MeleeSet');
	elseif (#args == 3 and args[1] == 'setcycle') then
		if gcdisplay.SetCycle(args[2], args[3]) then
			toggle = args[2];
			status = gcdisplay.GetCycle(args[2]);
		end
	elseif (args[1] == 'kite') then
		gcdisplay.AdvanceToggle('Kite');
		toggle = 'Kite Set';
		status = gcdisplay.GetToggle('Kite');
	elseif (args[1] == 'th') then
		gcdisplay.AdvanceToggle('TH');
		toggle = 'TH Set';
		status = gcdisplay.GetToggle('TH');	
	elseif (args[1] == 'gcaspir') then
		gcinclude.DoAspir();
	elseif (args[1] == 'gcdrain') then
		gcinclude.DoDrain();
	elseif (args[1] == 'warpring') then
		gcinclude.DoWarpRing();
	elseif (args[1] == 'telering') then
		gcinclude.DoTeleRing();
	elseif (args[1] == 'rrset') then
		gcinclude.RRSET = not gcinclude.RRSET;
		toggle = 'Reraise Set';
		status = gcinclude.RRSET;
	elseif (args[1] == 'externalphalanx') then
		if gcinclude.externalPhalanx == false then
			gcinclude.externalPhalanx = true;
			print(chat.header('GCinclude'):append(chat.message('External phalanx toggled o n.')));
		else
			gcinclude.externalPhalanx = false;
			print(chat.header('GCinclude'):append(chat.message('External phalanx toggled o f f.')));
		end
	elseif (args[1] == 'weaponlock') then
		if gcinclude.weaponLock == false then
			gcinclude.weaponLock = true;
			AshitaCore:GetChatManager():QueueCommand(-1, '/lac disable Main') 
			AshitaCore:GetChatManager():QueueCommand(-1, '/lac disable Sub')
			print(chat.header('GCinclude'):append(chat.message('Weapon lock toggled ON.')));
		else
			gcinclude.weaponLock= false;
			AshitaCore:GetChatManager():QueueCommand(-1, '/lac enable Main') 
			AshitaCore:GetChatManager():QueueCommand(-1, '/lac enable Sub')
			print(chat.header('GCinclude'):append(chat.message('Weapon lock toggled OFF.')));
		end
	elseif (args[1] == 'phalanxset') then
		if gcinclude.phalanxSet == false then
			gcinclude.phalanxSet = true;
			print(chat.header('GCinclude'):append(chat.message('Phalanx set toggled ON.')));
			AshitaCore:GetChatManager():QueueCommand(-1, '/p Phalanx set on. <call21>') 
		else
			gcinclude.phalanxSet= false;
			print(chat.header('GCinclude'):append(chat.message('Phalanx set toggled OFF.')));
		end
	elseif (string.lower(args[1])  == 'hpset') then
		if gcinclude.settings.HPSet == true then
			gcinclude.settings.HPSet = false
			print(chat.header('GCinclude'):append(chat.message('HP set toggled OFF.')));
		elseif gcinclude.settings.HPSet == false then
			gcinclude.settings.HPSet = true
			print(chat.header('GCinclude'):append(chat.message('HP set toggled ON.')));
		end
	elseif (args[1] == 'curecheat') then
		gcinclude.CureCheat = not gcinclude.CureCheat;
		toggle = 'Cure Cheat Set';
		status = gcinclude.CureCheat;
	elseif (args[1]) == 'plap' then
		local main = gData.GetEquipment();
		if main.Main.Name == 'Naegling' then
			print(chat.header('GCinclude'):append(chat.message('Sending sword plap.')));
			AshitaCore:GetChatManager():QueueCommand(-1, '/ws "Savage Blade" <t>');
		elseif main.Main.Name == 'Crocea Mors' then
			print(chat.header('GCinclude'):append(chat.message('Sending sword plap.')));
			AshitaCore:GetChatManager():QueueCommand(-1, '/ws "Savage Blade" <t>');
		elseif main.Main.Name == 'Tizona' then
			print(chat.header('GCinclude'):append(chat.message('Sending sword plap.')));
			AshitaCore:GetChatManager():QueueCommand(-1, '/ws "Savage Blade" <t>');
		elseif main.Main.Name == 'Maxentius' then
			print(chat.header('GCinclude'):append(chat.message('Sending club plap.')));
			AshitaCore:GetChatManager():QueueCommand(-1, '/ws "Black Halo" <t>');
		elseif main.Main.Name == 'Tauret' then
			print(chat.header('GCinclude'):append(chat.message('Sending dagger plap.')));
			AshitaCore:GetChatManager():QueueCommand(-1, '/ws "Evisceration" <t>');
		else
			print(chat.header('GCinclude'):append(chat.message('Invalid plap weapon.')));
		end
	elseif (args[1] == 'craftset') then
		gcinclude.CraftSet = not gcinclude.CraftSet;
		toggle = 'Crafting Set';
		status = gcinclude.CraftSet;
	elseif (args[1] == 'zeniset') then
		gcinclude.ZeniSet = not gcinclude.ZeniSet;
		toggle = 'Zeni Pictures Set';
		status = gcinclude.ZeniSet;
	elseif (args[1] == 'fishset') then
		gcinclude.FishSet = not gcinclude.FishSet;
		toggle = 'Fishing Set';
		status = gcinclude.FishSet;
    end
	if (player.MainJob == 'RDM') or (player.MainJob == 'BLM') or (player.MainJob == 'SCH') or (player.MainJob == 'GEO') then
		if (args[1] == 'nukeset') then
			gcdisplay.AdvanceCycle('NukeSet');
			toggle = 'Nuking Gear Set';
			status = gcdisplay.GetCycle('NukeSet');
		elseif (args[1] == 'burst') then
			gcdisplay.AdvanceToggle('Burst');
			toggle = 'Magic Burst Set';
			status = gcdisplay.GetToggle('Burst');
		end
		if (player.MainJob == 'BLM') or (player.MainJob == 'SCH') then
			if (args[1] == 'weapon') then
				gcdisplay.AdvanceCycle('Weapon');
				toggle = 'Mage Weapon';
				status = gcdisplay.GetCycle('Weapon');
			elseif (args[1] == 'element') then
				gcdisplay.AdvanceCycle('Element');
				toggle = 'Spell Element';
				status = gcdisplay.GetCycle('Element');
			elseif (args[1] == 'helix') then
				gcinclude.DoSCHspells('helix');
			elseif (args[1] == 'weather') then
				gcinclude.DoSCHspells('weather');
			elseif (args[1] == 'nuke') then
				if args[2] == nil then
					print(chat.header('GCinclude'):append(chat.message('Include a nuke tier. \'/nuke 1\', \'/nuke 2\', etc.')));
				end
				gcinclude.DoNukes(args[2]);
			end
			if (player.MainJob == 'BLM') then
				if (args[1] == 'death') then
					gcdisplay.AdvanceToggle('Death');
					toggle = 'BLM Death Set';
					status = gcdisplay.GetToggle('Death');
				end
			end
		end
	end
	if (player.MainJob == 'BRD') or (player.MainJob == 'GEO') or (player.MainJob == 'WHM') then
		if (args[1] == 'fight') then
			if (gcdisplay.GetToggle('Fight') == false) then
				AshitaCore:GetChatManager():QueueCommand(-1, '/lac disable Main');
				AshitaCore:GetChatManager():QueueCommand(-1, '/lac disable Sub');
				if (player.MainJob == 'RDM') or (player.MainJob == 'GEO') then AshitaCore:GetChatManager():QueueCommand(-1, '/lac disable Range') end
				if (player.MainJob == 'GEO') or (player.MainJob == 'WHM') then AshitaCore:GetChatManager():QueueCommand(-1, '/lac disable Ammo') end
				gcdisplay.AdvanceToggle('Fight');
				toggle = 'Mage Weapon Lock';
				status = gcdisplay.GetToggle('Fight');
			else
				AshitaCore:GetChatManager():QueueCommand(-1, '/lac enable Main');
				AshitaCore:GetChatManager():QueueCommand(-1, '/lac enable Sub');
				if (player.MainJob == 'RDM') or (player.MainJob == 'GEO') then AshitaCore:GetChatManager():QueueCommand(-1, '/lac enable Range') end
				if (player.MainJob == 'GEO') or (player.MainJob == 'WHM') then AshitaCore:GetChatManager():QueueCommand(-1, '/lac disable Ammo') end
				gcdisplay.AdvanceToggle('Fight');
				toggle = 'Mage Weapon Lock';
				status = gcdisplay.GetToggle('Fight');
			end
			if string.lower(args[1]) == 'mh' then
				gcdisplay.AdvanceCycle('MH');
				toggle = 'MH';
				status = gcdisplay.GetCycle('MH');
			elseif string.lower(args[1]) == 'oh' then
				gcdisplay.AdvanceCycle('OH');
				toggle = 'OH';
				status = gcdisplay.GetCycle('OH');
			end
		end
	end
	if player.MainJob == 'SCH' then

		local input = (args[1] or ''):lower()

		if input == 'skillchains' or input == 'scs' then
			print(chat.header('Skillchains'):append(chat.message('/sci or /scission       || /liq or /liquefaction')))
			print(chat.header('Skillchains'):append(chat.message('/rev or /reverberation  || /det or /detonation')))
			print(chat.header('Skillchains'):append(chat.message('/ind or /induration     || /imp or /impaction')))
			print(chat.header('Skillchains'):append(chat.message('/tra or /transfixion    || /com or /compression')))
			print(chat.header('Skillchains'):append(chat.message('/fra or /fragmentation  || /fus or /fusion')))
			print(chat.header('Skillchains'):append(chat.message('/gra or /gravitation    || /dis or /distortion')))
		elseif input == 'sci' or input == 'scission' then
			print(chat.header('Scission'):append(chat.message('Fire -> Stone')))
			print(chat.header('Scission'):append(chat.message('Aero -> Stone')))
			print(chat.header('Scission'):append(chat.message('MB: Stone')))
		elseif input == 'liq' or input == 'liquefaction' then
			print(chat.header('Liquefaction'):append(chat.message('Stone -> Fire')))
			print(chat.header('Liquefaction'):append(chat.message('Thunder -> Fire')))
			print(chat.header('Liquefaction'):append(chat.message('MB: Fire')))
		elseif input == 'rev' or input == 'reverberation' or input == 'reverb' then
			print(chat.header('Reverberation'):append(chat.message('Stone -> Water')))
			print(chat.header('Reverberation'):append(chat.message('Luminohelix -> Water')))
			print(chat.header('Reverberation'):append(chat.message('MB: Water')))
		elseif input == 'det' or input == 'detonation' then
			print(chat.header('Detonation'):append(chat.message('Stone -> Aero')))
			print(chat.header('Detonation'):append(chat.message('Thunder -> Wind')))
			print(chat.header('Detonation'):append(chat.message('MB: Aero')))
		elseif input == 'ind' or input == 'induration' then
			print(chat.header('Induration'):append(chat.message('Water -> Blizzard')))
			print(chat.header('Induration'):append(chat.message('MB: Blizzard')))
		elseif input == 'imp' or input == 'impaction' then
			print(chat.header('Impaction'):append(chat.message('Water -> Thunder')))
			print(chat.header('Impaction'):append(chat.message('Blizzard -> Thunder')))
			print(chat.header('Impaction'):append(chat.message('MB: Thunder')))
		elseif input == 'tra' or input == 'transfixion' then
			print(chat.header('Transfixion'):append(chat.message('Noctohelix -> Luminohelix')))
			print(chat.header('Transfixion'):append(chat.message('MB: Light')))
		elseif input == 'com' or input == 'compression' then
			print(chat.header('Compression'):append(chat.message('Blizzard -> Noctohelix')))
			print(chat.header('Compression'):append(chat.message('MB: Dark')))
		elseif input == 'fra' or input == 'fragmentation' then
			print(chat.header('Fragmentation'):append(chat.message('Blizzard -> Water')))
			print(chat.header('Fragmentation'):append(chat.message('MB: Wind/Lightning')))
		elseif input == 'fus' or input == 'fusion' then
			print(chat.header('Fusion'):append(chat.message('Fire -> Thunder')))
			print(chat.header('Fusion'):append(chat.message('MB: Fire/Light')))
		elseif input == 'gra' or input == 'gravitation' then
			print(chat.header('Gravitation'):append(chat.message('Aero -> Noctohelix')))
			print(chat.header('Gravitation'):append(chat.message('MB: Stone/Dark')))
		elseif input == 'dis' or input == 'distortion' then
			print(chat.header('Distortion'):append(chat.message('Luminohelix -> Stone')))
			print(chat.header('Distortion'):append(chat.message('MB: Blizzard/Water')))
		end
	end
	if player.MainJob == 'PLD' then
		if string.lower(args[1]) == 'oh' or string.lower(args[1]) == 'shield' or string.lower(args[1]) == 'sub' then
			gcdisplay.AdvanceCycle('OH');
			toggle = 'OH';
			status = gcdisplay.GetCycle('OH');
		end
	end
	if (player.MainJob == 'PLD') or (player.MainJob == 'RUN') then
		if (args[1] == 'sir') then
			gcdisplay.AdvanceToggle('SIR');
			toggle = 'Spell Interupt Set';
			status = gcdisplay.GetToggle('SIR');
		end
		if (args[1] == 'tankset') then
			gcdisplay.AdvanceCycle('TankSet');
			toggle = 'Tank Gear Set';
			status = gcdisplay.GetCycle('TankSet');
		end
	end
	if (player.MainJob == 'SAM') or (player.MainJob == 'NIN') then
		if string.lower(args[1]) == 'mwep' then
			gcdisplay.AdvanceCycle('MWep');
			toggle = 'MWep';
			status = gcdisplay.GetCycle('MWep');
		end
		if (args[1] == 'proc') then
			gcdisplay.AdvanceToggle('PROC');
			toggle = 'Low Damage PROC Set';
			status = gcdisplay.GetToggle('PROC');
			if (player.MainJob == 'NIN') then
				if gcdisplay.GetToggle('PROC') == true then
					AshitaCore:GetChatManager():QueueCommand(-1, '/lac disable ammo');
				else
					AshitaCore:GetChatManager():QueueCommand(-1, '/lac enable ammo');
				end
			end
		end
	end
	if (player.MainJob == 'PUP') then
		if (args[1] == 'pupmode') then
			gcdisplay.AdvanceCycle('PupMode');
			toggle = 'Puppet Mode';
			status = gcdisplay.GetCycle('PupMode');
		end
	end
	if (player.MainJob == 'BRD') then
		if (args[1] == 'forcestring') then
			gcdisplay.AdvanceToggle('String');
			toggle = 'BRD Forced Harp';
			status = gcdisplay.GetToggle('String');
		end
	end
	if (player.MainJob == 'COR') then
		if string.lower(args[1]) == 'ammo' or string.lower(args[1]) == 'bullet' then
			gcdisplay.AdvanceCycle('Ammo');
			toggle = 'Ammo';
			status = gcdisplay.GetCycle('Ammo');
		elseif string.lower(args[1]) == 'gun' or string.lower(args[1]) == 'rwep' then
			gcdisplay.AdvanceCycle('RWep');
			toggle = 'RWep';
			status = gcdisplay.GetCycle('RWep');
		elseif (args[1] == 'cormsg') then
			if gcinclude.CORmsg == true then
				gcinclude.CORmsg = false;
				print(chat.header('GCinclude'):append(chat.message('COR Roll messages will no longer show')));
			else
				gcinclude.CORmsg = true;
				print(chat.header('GCinclude'):append(chat.message('COR Roll messages will show now')));
			end
		end
	end
	if (player.MainJob == 'BLU') then
		if (args[1] == 'cj') then
			gcdisplay.AdvanceToggle('CJmode');
			toggle = 'BLU Cruel Joke Set';
			status = gcdisplay.GetToggle('CJmode');
		end
	end
	if (player.MainJob == 'SMN') then
		if (args[1] == 'siphon') then
			gcinclude.DoSiphon();
		end
	end
	if player.MainJob == 'RDM' or player.MainJob == 'COR' or player.MainJob == 'PLD' then
		if string.lower(args[1]) == 'mh' then
			gcdisplay.AdvanceCycle('MH');
			toggle = 'MH';
			status = gcdisplay.GetCycle('MH');
		elseif string.lower(args[1]) == 'oh' and (player.SubJob == 'NIN' or player.SubJob == 'DNC') then
			gcdisplay.AdvanceCycle('OH');
			toggle = 'OH';
			status = gcdisplay.GetCycle('OH');
		end
	end
	if player.MainJob == 'RDM' then
		if string.lower(args[1]) == 'ullr' then
    -- Advance the toggle and get the new status
			gcdisplay.AdvanceToggle('Ullr');
			local status = gcdisplay.GetToggle('Ullr');

			-- Provide feedback
			toggle = 'Ullr toggled.';

			if status == true then
				-- Equip Ullr and lock the relevant slots
				AshitaCore:GetChatManager():QueueCommand(-1, '/lac disable Range');
				AshitaCore:GetChatManager():QueueCommand(-1, '/lac disable Ammo');
				gFunc.ForceEquip('Range', 'Ullr');
				gFunc.ForceEquip('Ammo', 'Horn Arrow');
			else
				-- Unlock the slots
				AshitaCore:GetChatManager():QueueCommand(-1, '/lac enable Range');
				AshitaCore:GetChatManager():QueueCommand(-1, '/lac enable Ammo');
			end
		end
	end

	if gcinclude.settings.Messages then
		gcinclude.Message(toggle, status)
	end
end