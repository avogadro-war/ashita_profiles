local gcinclude = T{};
local S = function(list)
    local set = {}
    for _, v in ipairs(list) do
        set[v] = true
    end
    return {
        contains = function(_, val)
            return set[val]
        end
    }
end

--[[
Only edit the next two small sections here. See the readme on my github for more information on usages for my profiles.

These are universal sets for things like doomed or asleep; avoid main/sub/range/ammo here.
The second section is a couple basic settings to decide on whether or not to use you the automatic equiping function of idle regen, idle refresh, DT gear etc.
More details in each section.
]]
gcinclude.sets = T{
	Doomed = { -- this set will equip any time you have the doom status
		Ring1 = 'Purity Ring',
		Waist = 'Gishdubar Sash',
    },
	Holy_Water = { -- update with whatever gear you use for the Holy Water item
		Ring1 = 'Purity Ring',
		Neck = 'Nicander\'s Necklace',
		Ring2 = 'Blenmot\'s Ring',
    },
	Sleeping = { -- this set will auto equip if you are asleep
    },
	Reraise = { -- this set will try to equip when weakened if AutoGear variable is true below or you can force it with /rrset in game
		Head = 'Crepuscular Helm',
		Body = 'Crepuscular Mail',
    },
	Crafting = { -- this set is meant as a default set for crafting, equip using /craftset, be sure to dbl check what rings you want to use
		Head = 'Midras\'s Helm +1',
		Body = 'Tanner\'s Apron',
		Hands = 'Tanner\'s Gloves',
		Ring1 = 'Artificer\'s Ring',
		Ring2 = 'Craftmaster\'s Ring',
    },
	Zeni = { -- this set is meant as a default set for pictures, equip using /zeniset
		Range = 'Soultrapper 2000',
		Ammo = 'Blank Soulplate',
		Head = 'Malignance Chapeau',
        Neck = 'Bathy Choker +1';
        Ear1 = 'Eabani Earring',
        Ear2 = 'Infused Earring',
        Body = 'Nyame Mail',
        Hands = 'Malignance Gloves',
        Ring1 = 'Vengeful Ring',
        Ring2 = 'Ilabrat Ring',
		Back = 'Solemnity Cape',
        Waist = 'Svelt. Gouriz +1',
        Legs = 'Nyame Flanchard',
        Feet = 'Nyame Sollerets',
    },
	Fishing = { -- this set is meant as a default set for fishing, equip using /fishset
		Range = 'Halcyon Rod',
		Ring2 = 'Pelican Ring',
    },
	
};
gcinclude.settings = {
	--[[
	You can also set any of these on a per job basis in the job file in the OnLoad function. See my COR job file to see how this is done
	but as an example you can just put 'gcinclude.settings.RefreshGearMPP = 50;' in your job files OnLoad function to modify for that job only
	]]
	Messages = false; --set to true if you want chat log messages to appear on any /gc command used such as DT, TH, or KITE gear toggles, certain messages will always appear
	AutoGear = true; --set to false if you dont want DT/Regen/Refresh/PetDT gear to come on automatically at the defined %'s here
	WScheck = true; --set to false if you dont want to use the WSdistance safety check
	WSdistance = 4.7; --default max distance (yalms) to allow non-ranged WS to go off at if the above WScheck is true
	RegenGearHPP = 60; -- set HPP to have your idle regen set to come on
	RefreshGearMPP = 70; -- set MPP to have your idle refresh set to come on
	DTGearHPP = 0; -- set HPP to have your DT set to come on
	PetDTGearHPP = 50; -- set pet HPP to have your PetDT set to come on
	MoonshadeTP = 2250; -- this is the TP amount you want to equip EAR2 with moonshade earring when you have less than this amount, set to 0 if you dont want to use at all
	Tele_Ring = 'Dim. Ring (Dem)'; -- put your tele ring in here
	killingBlow = false; -- enable WS to only be useable if target is below the killing blow HPP%
	killingBlowPercent = 10; -- HPP of target when killing blow is toggled on for a weaponskill to activate
	killingBlowWS = 'Atonement';
	vagarySC = 0;
	HPSet = false;
	mythic = false;
	empyrean = false;
	aeonic = false;
	tpBonusWeapon = false;
	wakeUp = false;
};

--[[
Everything else in this file should not be editted by anyone trying to use my profiles. You really just want to update the various gear sets
in each individual job lua file. Unless you know what you're doing then it is best to leave everything below this line alone, the rest here are various functions and arrays etc.
]]

local gcdisplay = require('common/gcdisplay')
local JHaste = require('common/J-Haste')

gcinclude.AliasList = T{'gcmessages','zz','autodw','autoDW','autohasso','automa','autoMA','autohaste','dncparty','brdbonus','geobonus','vagarysc','liquefaction','liq','scission', 'sci', 'reverberation', 'reverb', 'rev', 'detonation', 'det', 
						'induration', 'ind','impaction','imp','transfixtion', 'tra', 'compression', 'com', 'fragmentation', 'frag', 
						'fra', 'gravitation', 'grav', 'gra', 'distortion', 'dis', 'fusion','fus','MH','mh','sub','Sub','oh','OH','curecheat',
						'externalphalanx','phalanxset','hpset','weaponlock','plap','wsdistance','setcycle','killingblow','dt','th','kite',
						'meleeset','gcdrain','gcaspir','nukeset','burst','weapon','element','helix','weather','nuke','death','fight',
						'sir','tankset','proc','cj','shield','pupmode','cormsg','forcestring','siphon','warpring','telering','rrset',
						'craftset','zeniset','fishset','skillchains','ammo','aeonic','empyrean','mythic','rwep','gun','mwep','ullr','bullet',};
gcinclude.Towns = T{'Tavnazian Safehold','Al Zahbi','Aht Urhgan Whitegate','Nashmau','Southern San d\'Oria [S]','Bastok Markets [S]','Windurst Waters [S]','San d\'Oria-Jeuno Airship','Bastok-Jeuno Airship','Windurst-Jeuno Airship','Kazham-Jeuno Airship','Southern San d\'Oria','Northern San d\'Oria','Port San d\'Oria','Chateau d\'Oraguille','Bastok Mines','Bastok Markets','Port Bastok','Metalworks','Windurst Waters','Windurst Walls','Port Windurst','Windurst Woods','Heavens Tower','Ru\'Lude Gardens','Upper Jeuno','Lower Jeuno','Port Jeuno','Rabao','Selbina','Mhaura','Kazham','Norg','Mog Garden','Celennia Memorial Library','Western Adoulin','Eastern Adoulin'};
gcinclude.LockingRings = T{'Echad Ring', 'Trizek Ring', 'Endorsement Ring', 'Capacity Ring', 'Warp Ring','Facility Ring','Dim. Ring (Dem)','Dim. Ring (Mea)','Dim. Ring (Holla)'};
gcinclude.DistanceWS = T{'Flaming Arrow','Piercing Arrow','Dulling Arrow','Sidewinder','Blast Arrow','Arching Arrow','Empyreal Arrow','Refulgent Arrow','Apex Arrow','Namas Arrow','Jishnu\'s Randiance','Hot Shot','Split Shot','Sniper Shot','Slug Shot','Blast Shot','Heavy Shot','Detonator','Numbing Shot','Last Stand','Coronach','Wildfire','Trueflight','Leaden Salute','Myrkr','Dagan','Moonlight','Starlight'};
gcinclude.BstPetAttack = T{'Foot Kick','Whirl Claws','Big Scissors','Tail Blow','Blockhead','Sensilla Blades','Tegmina Buffet','Lamb Chop','Sheep Charge','Pentapeck','Recoil Dive','Frogkick','Queasyshroom','Numbshroom','Shakeshroom','Nimble Snap','Cyclotail','Somersault','Tickling Tendrils','Sweeping Gouge','Grapple','Double Claw','Spinning Top','Suction','Tortoise Stomp','Power Attack','Rhino Attack','Razor Fang','Claw Cyclone','Crossthrash','Scythe Tail','Ripper Fang','Chomp Rush','Pecking Flurry','Sickle Slash','Mandibular Bite','Wing Slap','Beak Lunge','Head Butt','Wild Oats','Needle Shot','Disembowel','Extirpating Salvo','Mega Scissors','Back Heel','Hoof Volley','Fluid Toss','Fluid Spread'};
gcinclude.BstPetMagicAttack = T{'Gloom Spray','Fireball','Acid Spray','Molting Plumage','Cursed Sphere','Nectarous Deluge','Charged Whisker','Nepenthic Plunge'};
gcinclude.BstPetMagicAccuracy = T{'Toxic Spit','Acid Spray','Leaf Dagger','Venom Spray','Venom','Dark Spore','Sandblast','Dust Cloud','Stink Bomb','Slug Family','Intimidate','Gloeosuccus','Spider Web','Filamented Hold','Choke Breath','Blaster','Snow Cloud','Roar','Palsy Pollen','Spore','Brain Crush','Choke Breath','Silence Gas','Chaotic Eye','Sheep Song','Soporific','Predatory Glare','Sudden Lunge','Numbing Noise','Jettatura','Bubble Shower','Spoil','Scream','Noisome Powder','Acid Mist','Rhinowrecker','Swooping Frenzy','Venom Shower','Corrosive Ooze','Spiral Spin','Infrasonics','Hi-Freq Field','Purulent Ooze','Foul Waters','Sandpit','Infected Leech','Pestilent Plume'};
gcinclude.SmnSkill = T{'Shining Ruby','Glittering Ruby','Crimson Howl','Inferno Howl','Frost Armor','Crystal Blessing','Aerial Armor','Hastega II','Fleet Wind','Hastega','Earthen Ward','Earthen Armor','Rolling Thunder','Lightning Armor','Soothing Current','Ecliptic Growl','Heavenward Howl','Ecliptic Howl','Noctoshield','Dream Shroud','Altana\'s Favor','Reraise','Reraise II','Reraise III','Raise','Raise II','Raise III','Wind\'s Blessing'};
gcinclude.SmnMagical = T{'Searing Light','Meteorite','Holy Mist','Inferno','Fire II','Fire IV','Meteor Strike','Conflag Strike','Diamond Dust','Blizzard II','Blizzard IV','Heavenly Strike','Aerial Blast','Aero II','Aero IV','Wind Blade','Earthen Fury','Stone II','Stone IV','Geocrush','Judgement Bolt','Thunder II','Thunder IV','Thunderstorm','Thunderspark','Tidal Wave','Water II','Water IV','Grand Fall','Howling Moon','Lunar Bay','Ruinous Omen','Somnolence','Nether Blast','Night Terror','Level ? Holy'};
gcinclude.SmnHealing = T{'Healing Ruby','Healing Ruby II','Whispering Wind','Spring Water'};
gcinclude.SmnHybrid = T{'Flaming Crush','Burning Strike'};
gcinclude.SmnEnfeebling = T{'Diamond Storm','Sleepga','Shock Squall','Slowga','Tidal Roar','Pavor Nocturnus','Ultimate Terror','Nightmare','Mewing Lullaby','Eerie Eye'};
gcinclude.BluMagPhys = T{'Foot Kick','Sprout Smack','Wild Oats','Power Attack','Queasyshroom','Battle Dance','Feather Storm','Helldive','Bludgeon','Claw Cyclone','Screwdriver','Grand Slam','Smite of Rage','Pinecone Bomb','Jet Stream','Uppercut','Terror Touch','Mandibular Bite','Sickle Slash','Dimensional Death','Spiral Spin','Death Scissors','Seedspray','Body Slam','Hydro Shot','Frenetic Rip','Spinal Cleave','Hysteric Barrage','Asuran Claws','Cannonball','Disseverment','Ram Charge','Vertical Cleave','Final Sting','Goblin Rush','Vanity Dive','Whirl of Rage','Benthic Typhoon','Quad. Continuum','Empty Thrash','Delta Thrust','Heavy Strike','Quadrastrike','Tourbillion','Amorphic Spikes','Barbed Crescent','Bilgestorm','Bloodrake','Glutinous Dart','Paralyzing Triad','Thrashing Assault','Sinker Drill','Sweeping Gouge','Saurian Slide'};
gcinclude.BluMagDebuff = T{'Filamented Hold','Cimicine Discharge','Demoralizing Roar','Venom Shell','Light of Penance','Sandspray','Auroral Drape','Frightful Roar','Enervation','Infrasonics','Lowing','CMain Wave','Awful Eye','Voracious Trunk','Sheep Song','Soporific','Yawn','Dream Flower','Chaotic Eye','Sound Blast','Blank Gaze','Stinking Gas','Geist Wall','Feather Tickle','Reaving Wind','Mortal Ray','Absolute Terror','Blistering Roar','Cruel Joke'};
gcinclude.BluMagStun = T{'Head Butt','Frypan','Tail Slap','Sub-zero Smash','Sudden Lunge'};
gcinclude.BluMagBuff = T{'Cocoon','Refueling','Feather Barrier','Memento Mori','Zephyr Mantle','Warm-Up','Amplification','Triumphant Roar','Saline Coat','Reactor Cool','Plasma Charge','Regeneration','Animating Wail','Battery Charge','Winds of Promy.','Barrier Tusk','Orcish Counterstance','Pyric Bulwark','Nat. Meditation','Restoral','Erratic Flutter','Carcharian Verve','Harden Shell','Mighty Guard'};
gcinclude.BluMagSkill = T{'Metallic Body','Diamondhide','Magic Barrier','Occultation','Atra. Libations'};
gcinclude.BluMagDiffus = T{'Erratic Flutter','Carcharian Verve','Harden Shell','Mighty Guard'};
gcinclude.BluMagCure = T{'Pollen','Healing Breeze','Wild Carrot','Magic Fruit','Plenilune Embrace'};
gcinclude.BluMagEnmity = T{'Actinic Burst','Exuviation','Fantod','Jettatura','Temporal Shift'};
gcinclude.BluMagTH = T{'Actinic Burst','Dream Flower','Subduction'};
gcinclude.Elements = T{'Thunder', 'Blizzard', 'Fire', 'Stone', 'Aero', 'Water', 'Light', 'Dark'};
gcinclude.HelixSpells = T{'Ionohelix', 'Cryohelix', 'Pyrohelix', 'Geohelix', 'Anemohelix', 'Hydrohelix', 'Luminohelix', 'Noctohelix'};
gcinclude.StormSpells = T{'Thunderstorm', 'Hailstorm', 'Firestorm', 'Sandstorm', 'Windstorm', 'Rainstorm', 'Aurorastorm', 'Voidstorm'};
gcinclude.NinNukes = T{'Katon: Ichi', 'Katon: Ni', 'Katon: San', 'Hyoton: Ichi', 'Hyoton: Ni', 'Hyoton: San', 'Huton: Ichi', 'Huton: Ni', 'Huton: San', 'Doton: Ichi', 'Doton: Ni', 'Doton: San', 'Raiton: Ichi', 'Raiton: Ni', 'Raiton: San', 'Suiton: Ichi', 'Suiton: Ni', 'Suiton: San'};
gcinclude.Rolls = T{
    {'Fighter\'s Roll', 5, 9, 'WAR'},
    {'Monk\'s Roll', 3, 7, 'MNK'},
    {'Healer\'s Roll', 3, 7, 'WHM'},
    {'Corsair\'s Roll', 5, 9, 'COR'},
    {'Ninja Roll', 4, 8, 'NIN'},
    {'Hunter\'s Roll', 4, 8, 'RNG'},
    {'Chaos Roll', 4, 8, 'WAR'},
    {'Magus\'s Roll', 2, 6, 'BLU'},
    {'Drachen Roll', 4, 8, 'DRG'},
    {'Choral Roll', 2, 6, 'BRD'},
    {'Beast Roll', 4, 8, 'BST'},
    {'Samurai Roll', 2, 6, 'SAM'},
    {'Evoker\'s Roll', 5, 9, 'SMN'},
    {'Rogue\'s Roll', 5, 9, 'THF'},
    {'Warlock\'s Roll', 4, 8, 'RDM'},
    {'Puppet Roll', 3, 7, 'PUP'},
    {'Gallant\'s Roll', 3, 7, 'PLD'},
    {'Wizard\'s Roll', 5, 9, 'BLM'},
    {'Dancer\'s Roll', 3, 7, 'DNC'},
    {'Scholar\'s Roll', 2, 6, 'SCH'},
    {'Naturalist\'s Roll', 3, 7, 'GEO'},
    {'Runeist\'s Roll', 4, 8, 'RUN'},
    {'Bolter\'s Roll', 3, 9, '--'},  -- No specific job
    {'Caster\'s Roll', 2, 7, '--'},  -- No specific job
    {'Courser\'s Roll', 3, 9, '--'},  -- No specific job
    {'Blitzer\'s Roll', 4, 9, '--'},  -- No specific job
    {'Tactician\'s Roll', 5, 8, '--'},  -- No specific job
    {'Allies\' Roll', 3, 10, '--'},  -- No specific job
    {'Miser\'s Roll', 5, 7, '--'},  -- No specific job
    {'Companion\'s Roll', 2, 10, '--'},  -- No specific job
    {'Avenger\'s Roll', 4, 8, '--'},  -- No specific job
};
gcinclude.RRSET = false;
gcinclude.CraftSet = false;
gcinclude.ZeniSet = false;
gcinclude.FishSet = false;
gcinclude.CORmsg = true;
gcinclude.Lockstyle = false;
gcinclude.CureCheat = false;
gcinclude.externalPhalanx = false;
gcinclude.weaponLock = false;
gcinclude.phalanxSet = false; 

function gcinclude.Message(toggle, status)
	if toggle ~= nil and status ~= nil then
		print(chat.header('GCinclude'):append(chat.message(toggle .. ' is now ' .. tostring(status))))
	end
end

function gcinclude.SetAlias()
	for _, v in ipairs(gcinclude.AliasList) do
		AshitaCore:GetChatManager():QueueCommand(-1, '/alias /' .. v .. ' /lac fwd ' .. v);
	end
end

function gcinclude.ClearAlias()
	for _, v in ipairs(gcinclude.AliasList) do
		AshitaCore:GetChatManager():QueueCommand(-1, '/alias del /' .. v);
	end
end

function gcinclude.SetVariables()
    local player = gData.GetPlayer()
    local mainJob = player.MainJob
    local subJob = player.SubJob

    -- Core toggles and cycles
    gcdisplay.CreateToggle('DTset', false)
    gcdisplay.CreateToggle('Kite', false)
    gcdisplay.CreateToggle('TH', false)

    -- AutoDW jobs
    local autoDWJobs = { NIN=true, DNC=true, BLU=true, THF=true }
    if autoDWJobs[mainJob] or autoDWJobs[subJob] then
        gcdisplay.CreateToggle('AutoDW', true)
    end

    gcdisplay.CreateCycle('MeleeSet', { 'Default', 'Hybrid', 'Acc' })

	-- AutoMA jobs
	local autoMAJobs = { MNK = true, PUP = true }
	if autoMAJobs[mainJob] then
		gcdisplay.CreateToggle('AutoMA', true)
	end

    -- Nuking jobs
    local nukeJobs = { RDM=true, BLM=true, SCH=true, GEO=true }
    if nukeJobs[mainJob] then
        gcdisplay.CreateToggle('Burst', true)
        gcdisplay.CreateCycle('NukeSet', { 'Power', 'Macc' })
        if mainJob == 'BLM' or mainJob == 'SCH' then
            gcdisplay.CreateCycle('Element', { 'Thunder', 'Blizzard', 'Fire', 'Stone', 'Aero', 'Water', 'Light', 'Dark' })
            if mainJob == 'BLM' then
                gcdisplay.CreateToggle('Death', false)
            end
        end
    end

    -- Support jobs
    if mainJob == 'BRD' or mainJob == 'GEO' or mainJob == 'WHM' then
        gcdisplay.CreateToggle('Fight', false)
    end

    -- PLD setup
    if mainJob == 'PLD' then
        gcdisplay.CreateToggle('SIR', true)
        gcdisplay.CreateCycle('TankSet', { 'Main', 'MEVA', 'None' })
        gcdisplay.CreateCycle('OH', { 'Duban', 'Aegis' })
        gcdisplay.CreateCycle('MH', { 'Burtgang', 'Naegling' })
    end

    -- RUN setup
    if mainJob == 'RUN' then
        gcdisplay.CreateToggle('SIR', true)
        gcdisplay.CreateCycle('TankSet', { 'Main', 'MEVA', 'None' })
    end

    -- SAM setup
    if mainJob == 'SAM' then
        gcdisplay.CreateToggle('PROC', false)
        gcdisplay.CreateToggle('AutoHasso', true)
        gcdisplay.CreateCycle('MWep', { 'Doji', 'Masa', 'Pole', 'Prime' })
    end

    -- PUP setup
    if mainJob == 'PUP' then
        gcdisplay.CreateCycle('PupMode', { 'Tank', 'Melee', 'Ranger', 'Mage' })
    end

    -- BRD setup
    if mainJob == 'BRD' then
        gcdisplay.CreateToggle('String', false)
    end

    -- COR setup
    if mainJob == 'COR' then
        gcdisplay.CreateCycle('MH', { 'Naegling', 'Melee Rostam', 'Range Rostam' })
        gcdisplay.CreateCycle('RWep', { 'Death Penalty', 'Fomalhaut.', 'TP Bonus' })
        gcdisplay.CreateCycle('Ammo', { 'MAB', 'Phys.', 'Brz.' })
        if subJob == 'DNC' or subJob == 'NIN' then
            gcdisplay.CreateCycle('OH', { 'Gleti', 'Tauret', 'Roll Rostam' })
        end
    end

    -- BLU setup
    if mainJob == 'BLU' then
        gcdisplay.CreateToggle('CJmode', false)
    end

    -- RDM setup
    if mainJob == 'RDM' then
        gcdisplay.CreateCycle('MH', { 'Crocea', 'Naegling', 'Maxentius', 'Tauret' })
        gcdisplay.CreateToggle('Ullr', false)
        if subJob == 'DNC' or subJob == 'NIN' then
            gcdisplay.CreateCycle('OH', { 'Degen', 'TPBonus', 'Bunzi' })
        end
    end
end
--;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
--  SCH skill-chain helper (already present, kept for completeness)
--;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
function gcinclude.DoSCHSkillchain(cmd)
    local msgs = {
        sci = {"Fire → Stone", "Aero → Stone", "MB: Stone"},
        liq = {"Stone → Fire", "Thunder → Fire", "MB: Fire"},
        rev = {"Stone → Water", "Luminohelix → Water", "MB: Water"},
        det = {"Stone → Aero", "Thunder → Wind", "MB: Aero"},
        ind = {"Water → Blizzard", "MB: Blizzard"},
        imp = {"Water → Thunder", "Blizzard → Thunder", "MB: Thunder"},
        tra = {"Noctohelix → Luminohelix", "MB: Light"},
        com = {"Blizzard → Noctohelix", "MB: Dark"},
        fra = {"Blizzard → Water", "MB: Wind/Lightning"},
        fus = {"Fire → Thunder", "MB: Fire/Light"},
        gra = {"Aero → Noctohelix", "MB: Stone/Dark"},
        dis = {"Luminohelix → Stone", "MB: Blizzard/Water"},
        scs = {
            "/sci or /scission       || /liq or /liquefaction",
            "/rev or /reverberation  || /det or /detonation",
            "/ind or /induration     || /imp or /impaction",
            "/tra or /transfixion    || /com or /compression",
            "/fra or /fragmentation  || /fus or /fusion",
            "/gra or /gravitation    || /dis or /distortion"
        }
    }
    local key = (cmd == "skillchains") and "scs" or cmd
    local header = chat.header(key:gsub("^%l", string.upper))
    if msgs[key] then
        for _, m in ipairs(msgs[key]) do
            print(header:append(chat.message(m)))
        end
    else
        print(header:append(chat.message("Unknown skill-chain command.")))
    end
end

--;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
--  Helper: weapon based weaponskill selection
--;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

if cmd == 'plap' then
    local main = gData.GetEquipment().Main.Name
    local wsMap = {
        ['Naegling']     = 'Savage Blade',
        ['Crocea Mors']  = 'Savage Blade',
        ['Tizona']       = 'Savage Blade',
        ['Maxentius']    = 'Black Halo',
        ['Tauret']       = 'Evisceration'
    }
    local ws = wsMap[main]
    if ws then
        print(chat.header('GCinclude'):append(chat.message('Sending '..ws..' plap.')))
        AshitaCore:GetChatManager():QueueCommand(-1, '/ws "'..ws..'" <t>')
    else
        print(chat.header('GCinclude'):append(chat.message('Invalid plap weapon.')))
    end
    return
end

--;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
--  Helper: generic boolean toggle with chat feedback
--;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
local function toggleBool(container, field, onMsg, offMsg)
    container[field] = not container[field]
    local msg = container[field] and onMsg or offMsg
    print(chat.header('GCinclude'):append(chat.message(msg)))
end

--;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
--  Helper: run a series of /lac commands
--;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
local function runLac(cmds)
    for _,c in ipairs(cmds) do
        AshitaCore:GetChatManager():QueueCommand(-1, c)
    end
end

--;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
--  Main command handler – COMPLETE FEATURE SET
--;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
function gcinclude.HandleCommands(args)
    if args == nil or #args == 0 then return end
    local cmd = string.lower(args[1] or '')
    local player = gData.GetPlayer()

    -------------------------------------------------------------
    --  QUICK-EXIT for alias mismatches
    -------------------------------------------------------------
    if not gcinclude.AliasList:contains(cmd) then return end

    -------------------------------------------------------------
    --  SIMPLE UTILITY COMMANDS (no gear logic)
    -------------------------------------------------------------
    local simpleMap = {
        gcaspir  = function() gcinclude.DoAspir() end,
        gcdrain  = function() gcinclude.DoDrain()  end,
        warpring = function() gcinclude.DoWarpRing() end,
        telering = function() gcinclude.DoTeleRing() end,
        zz       = function()
            gcinclude.settings.wakeUp = true
            print(chat.header('GCinclude'):append(chat.message('Wake up plap.')))
        end,
        vagarysc = function()
            gcinclude.settings.vagarySC = (gcinclude.settings.vagarySC == 0) and 1 or 0
            local txt = (gcinclude.settings.vagarySC==1) and 'Vagary SC set toggled ON.'
                                                          or  'Vagary SC set toggled OFF.'
            print(chat.header('GCinclude'):append(chat.message(txt)))
        end,
    }
    if simpleMap[cmd] then simpleMap[cmd](); return end

    -------------------------------------------------------------
    --  MESSAGE TOGGLE
    -------------------------------------------------------------
    if cmd == 'gcmessages' then
        toggleBool(gcinclude.settings, 'Messages',
            'Chat messages are enabled', 'Chat messages are disabled')
        return
    end

    -------------------------------------------------------------
    --  WS-DISTANCE COMMAND
    -------------------------------------------------------------
    if cmd == 'wsdistance' then
        local dist = tonumber(args[2])
        if dist then
            gcinclude.settings.WScheck   = true
            gcinclude.settings.WSdistance = dist
            print(chat.header('GCinclude')
                 :append(chat.message('WS distance set to '.. dist)))
        else
            toggleBool(gcinclude.settings, 'WScheck',
                'WS distance check is now true', 'WS distance check is now false')
            print(chat.header('GCinclude')
                 :append(chat.message('Use /wsdistance ## to set a value')))
        end
        return
    end

    -------------------------------------------------------------
    --  QUICK MAPPINGS (boolean Toggles & Cycles that require
    --  only gcdisplay wrapper calls – avoids 100s of if-blocks)
    -------------------------------------------------------------
    local toggleDisplay = {
        autodw       = 'AutoDW',
        autohasso    = 'AutoHasso',
		automa		 = 'AutoMA',
        dt           = 'DTset',
        aeolian      = 'Aeolian',
        kite         = 'Kite',
        th           = 'TH',
        rrset        = 'Reraise Set',
        curecheat    = 'Cure Cheat Set',
        craftset     = 'Crafting Set',
        zeniset      = 'Zeni Pictures Set',
        fishset      = 'Fishing Set',
        burst        = 'Burst',
        death        = 'Death',
        sir          = 'SIR',
        proc         = 'PROC',
        cj           = 'CJmode',
        string       = 'String',  -- BRD /forcestring
    }
    if toggleDisplay[cmd] then
        gcdisplay.AdvanceToggle(toggleDisplay[cmd])
        if gcinclude.settings.Messages then
            gcinclude.Message(toggleDisplay[cmd],
                              gcdisplay.GetToggle(toggleDisplay[cmd]))
        end
        return
    end

    local cycleDisplay = {
        meleeset  = 'MeleeSet',
        nukeset   = 'NukeSet',
        weapon    = 'Weapon',
        element   = 'Element',
        mh        = 'MH',
        oh        = 'OH',
		sub		  = 'OH',
        mwep      = 'MWep',
        tankset   = 'TankSet',
        pupmode   = 'PupMode',
        ammo      = 'Ammo',
        bullet    = 'Ammo',
        gun       = 'RWep',
        rwep      = 'RWep',
        rw        = 'RWep',
    }
    if cycleDisplay[cmd] then
        gcdisplay.AdvanceCycle(cycleDisplay[cmd])
        if gcinclude.settings.Messages then
            local status = gcdisplay.GetCycle(cycleDisplay[cmd])
            gcinclude.Message(cycleDisplay[cmd], status)
        end
        return
    end

    -------------------------------------------------------------
    --  HP-SET & EXTERNAL PHALANX, PHALANX SET, WEAPONLOCK etc.
    -------------------------------------------------------------
    if cmd == 'hpset' then
        toggleBool(gcinclude.settings,'HPSet','HP set toggled ON.','HP set toggled OFF.')
        return
    elseif cmd == 'externalphalanx' then
        toggleBool(gcinclude,'externalPhalanx',
            'External phalanx toggled on.','External phalanx toggled off.')
        return
    elseif cmd == 'phalanxset' then
        toggleBool(gcinclude,'phalanxSet',
            'Phalanx set toggled ON.','Phalanx set toggled OFF.')
        if gcinclude.phalanxSet then
            AshitaCore:GetChatManager():QueueCommand(-1,'/p Phalanx set on. <call21>')
        end
        return
    elseif cmd == 'weaponlock' then
        toggleBool(gcinclude,'weaponLock','Weapon lock toggled ON.','Weapon lock toggled OFF.')
        if gcinclude.weaponLock then
            runLac{ '/lac disable Main', '/lac disable Sub' }
        else
            runLac{ '/lac enable Main',  '/lac enable Sub'  }
        end
	elseif cmd == 'plap' then
		local main = gData.GetEquipment().Main.Name
		local swords = T{'naegling', 'crocea mors','tizona','caliburnus','burtgang','excalibur',}
		local wsMap = {
			['Naegling']     = 'Savage Blade',
			['Crocea Mors']  = 'Savage Blade',
			['Tizona']       = 'Savage Blade',
			['Maxentius']    = 'Black Halo',
			['Tauret']       = 'Evisceration'
		}
		local ws = wsMap[main]
		if ws then
			print(chat.header('GCinclude'):append(chat.message('Sending '..ws..' plap.')))
			AshitaCore:GetChatManager():QueueCommand(-1, '/ws "'..ws..'" <t>')
		else
			print(chat.header('GCinclude'):append(chat.message('Invalid plap weapon.')))
		end
        return
    end

    -------------------------------------------------------------
    --  AUTOHASTE (brdbonus / geobonus / debug)
    -------------------------------------------------------------
 	if cmd == 'autohaste' or cmd == 'jhaste' then
		local sub = (args[2] or ''):lower()
		local thirdArg = tonumber(args[3])

		local function printMsg(text)
			print(chat.header('GCinclude'):append(chat.message(text)))
		end

		if sub == '' or sub == 'help' then
			printMsg('"/autohaste toggle" toggles auto-haste detection')
			printMsg('"/autohaste brdbonus 0-8"  | "/autohaste geobonus #"')
			return
		end

		if sub == 'brdbonus' then
			if thirdArg and thirdArg >= 0 and thirdArg <= 8 then
				JHaste.brdBonus = thirdArg
				printMsg('Bard song bonus set to ' .. thirdArg)
				gcdisplay.Update()
			else
				printMsg('Invalid bard bonus. Must be 0–8.')
			end
			return
		elseif sub == 'geobonus' then
			if thirdArg and thirdArg >= 0 then
				JHaste.geoBonus = thirdArg
				printMsg('Geomancy bonus set to ' .. thirdArg)
				gcdisplay.Update()
			else
				printMsg('Invalid Geomancy bonus. Must be ≥ 0.')
			end
			return
		elseif sub == 'debug' then			
			local total = JHaste and JHaste.totalHaste or 0
			local dw    = JHaste and JHaste.dwNeeded or 'N/A'
			local h2h   = JHaste and JHaste.maNeeded or 'N/A'
			local ja    = JHaste and JHaste.jobHaste or 0
			local ma = JHaste and JHaste.magicHaste or 'Error'

			local function printMsg(text)
				print(chat.header('GCinclude'):append(chat.message(text)))
			end

			printMsg(('Total Haste: %.1f%%'):format( (total / 1024) * 100 ) )
			if S{'DNC','THF','NIN','BLU'}:contains(player.MainJob) or S{'NIN','DNC'}:contains(player.SubJob) then
				printMsg('DW Needed: ' .. dw)
			end
			if S{'MNK','PUP'}:contains(player.MainJob) then
				printMsg('MA Needed: ' .. h2h)
			end
			printMsg(('Job Haste: %.1f%%'):format( (ja / 1024) * 100 ) )
			printMsg(('Magic Haste: %.1f%%'):format( (ma / 1024) * 100 ) )
		return
		end
	end

    -------------------------------------------------------------
    --  SETCYCLE (force specific cycle value)
    -------------------------------------------------------------
    if cmd == 'setcycle' and #args == 3 then
        if gcdisplay.SetCycle(args[2],args[3]) then
            if gcinclude.settings.Messages then
                gcinclude.Message(args[2], gcdisplay.GetCycle(args[2]))
            end
        end
        return
    end

    -------------------------------------------------------------
    --  KILLINGBLOW BLOCK (percent / ws / on / off / help)
    -------------------------------------------------------------
    if cmd == 'killingblow' or cmd == 'kb' then
        local sub = (args[2] or ''):lower()
        if sub == 'help' or sub == '' then
            local h = chat.header('GCinclude')
            print(h:append(chat.message('"/killingblow on|off" toggle')))
            print(h:append(chat.message('"/killingblow #" sets percent (0-100)')))
            print(h:append(chat.message('"/killingblow ws <name>" sets WS')))
            return
        elseif sub == 'on' then
            gcinclude.settings.killingBlow = true
            print(chat.header('GCinclude')
                :append(chat.message('Killing blow WS restriction is ON.')))
        elseif sub == 'off' then
            gcinclude.settings.killingBlow = false
            print(chat.header('GCinclude')
                :append(chat.message('Killing blow WS restriction is OFF.')))
        elseif sub == 'ws' and args[3] then
            gcinclude.settings.killingBlowWS = args[3]
            print(chat.header('GCinclude')
                :append(chat.message('Killing blow WS set to '..args[3])))
        elseif tonumber(args[2]) then
            local v = tonumber(args[2])
            if v>=0 and v<=100 then
                gcinclude.settings.killingBlowPercent = v
                gcinclude.settings.killingBlow = true
                print(chat.header('GCinclude')
                    :append(chat.message('Killing blow percent set to '..v)))
            else
                print(chat.header('GCinclude')
                    :append(chat.message('Percent must be 0-100.')))
            end
        else
            print(chat.header('GCinclude')
                :append(chat.message('Invalid killingblow sub-command.')))
        end
        return
    end

    -------------------------------------------------------------
    --  JOB-SPECIFIC BLOCKS (helpers keep file tidy)
    -------------------------------------------------------------
    local jobHandlers = {}

    --== SCH / BLM Mage helpers ==--
    jobHandlers.SCH = function()
        if cmd == 'skillchains' or cmd == 'scs' or
           S{'sci','liq','rev','det','ind','imp','tra','com','fra','fus','gra','dis'}:contains(cmd) then
            gcinclude.DoSCHSkillchain(cmd)
            return true
        elseif cmd == 'helix' or cmd == 'weather' then
            gcinclude.DoSCHspells(cmd)
            return true
        elseif cmd == 'nuke' then
            if not args[2] then
                print(chat.header('GCinclude')
                    :append(chat.message('Use: /nuke <tier#>')))
            else
                gcinclude.DoNukes(args[2])
            end
            return true
        end
    end
    jobHandlers.BLM = function()
        if cmd == 'helix' or cmd == 'weather' then
            gcinclude.DoSCHspells(cmd) return true end
        if cmd == 'nuke' then
            if not args[2] then
                print(chat.header('GCinclude')
                    :append(chat.message('Use: /nuke <tier#>')))
            else
                gcinclude.DoNukes(args[2])
            end
            return true
        end
        if cmd == 'death' then
            gcdisplay.AdvanceToggle('Death')
            if gcinclude.settings.Messages then
                gcinclude.Message('Death', gcdisplay.GetToggle('Death'))
            end
            return true
        end
    end

    --== COR helpers ==--
    jobHandlers.COR = function()
        if cmd == 'cormsg' then
            toggleBool(gcinclude,'CORmsg',
                'COR roll messages will show.',
                'COR roll messages will no longer show.')
            return true
        end
    end

    --== PLD helpers ==--
    jobHandlers.PLD = function()
        if S{'oh','shield','sub'}:contains(cmd) then
            gcdisplay.AdvanceCycle('OH')
            if gcinclude.settings.Messages then
                gcinclude.Message('OH', gcdisplay.GetCycle('OH'))
            end
            return true
        end
    end

    --== PUP helpers ==--
    jobHandlers.PUP = function()
        if cmd == 'pupmode' then
            gcdisplay.AdvanceCycle('PupMode')
            if gcinclude.settings.Messages then
                gcinclude.Message('PupMode', gcdisplay.GetCycle('PupMode'))
            end
            return true
        end
    end

    --== SMN helpers ==--
    jobHandlers.SMN = function()
        if cmd == 'siphon' then gcinclude.DoSiphon(); return true end
    end

    --== BRD / GEO / WHM – Fight toggle (mage weapon lock) ==--
    if S{'BRD','GEO','WHM'}:contains(player.MainJob) and cmd == 'fight' then
        local isLocked = gcdisplay.GetToggle('Fight')
        if not isLocked then
            runLac{
                '/lac disable Main',
                '/lac disable Sub',
                (S{'RDM','GEO'}:contains(player.MainJob)) and '/lac disable Range' or nil,
                (S{'GEO','WHM'}:contains(player.MainJob)) and '/lac disable Ammo' or nil
            }
        else
            runLac{
                '/lac enable Main',
                '/lac enable Sub',
                (S{'RDM','GEO'}:contains(player.MainJob)) and '/lac enable Range' or nil,
                (S{'GEO','WHM'}:contains(player.MainJob)) and '/lac enable Ammo' or nil
            }
        end
        gcdisplay.AdvanceToggle('Fight')
        if gcinclude.settings.Messages then
            gcinclude.Message('Mage Weapon Lock', not isLocked)
        end
        return
    end

    --== Apply job handler if present ==--
    if jobHandlers[player.MainJob] and jobHandlers[player.MainJob]() then return end

    -------------------------------------------------------------
    --  FALL-THROUGH: command not matched – print help if needed
    -------------------------------------------------------------
    print(chat.header('GCinclude')
        :append(chat.message('Unknown command: '..cmd)))
end


function gcinclude.CheckCommonDebuffs()
	local weakened = gData.GetBuffCount('Weakened');
	local sleep = gData.GetBuffCount('Sleep');
	local doom = (gData.GetBuffCount('Doom'))+(gData.GetBuffCount('Bane'));

	if (sleep >= 1) then gFunc.EquipSet(gcinclude.sets.Sleeping) end
	if (doom >= 1) then	gFunc.EquipSet(gcinclude.sets.Doomed) end
	if (weakened >= 1) then gFunc.EquipSet(gcinclude.sets.Reraise) end
end

function gcinclude.CheckAbilityRecast(check)
	local RecastTime = 0;

	for x = 0, 31 do
		local id = AshitaCore:GetMemoryManager():GetRecast():GetAbilityTimerId(x);
		local timer = AshitaCore:GetMemoryManager():GetRecast():GetAbilityTimer(x);

		if ((id ~= 0 or x == 0) and timer > 0) then
			local ability = AshitaCore:GetResourceManager():GetAbilityByTimerId(id);
			if ability == nil then return end
			if (ability.Name[1] == check) and (ability.Name[1] ~= 'Unknown') then
				RecastTime = timer;
			end
		end
	end

	return RecastTime;
end

function gcinclude.CheckLockingRings()
	local rings = gData.GetEquipment();
	if (rings.Ring1 ~= nil) and (gcinclude.LockingRings:contains(rings.Ring1.Name)) then
		local tempRing1 = rings.Ring1.Name;
		gFunc.Equip('Ring1', tempRing1);
	end
	if (rings.Ring2 ~= nil) and (gcinclude.LockingRings:contains(rings.Ring2.Name)) then
		local tempRing2 = rings.Ring2.Name;
		gFunc.Equip('Ring2', tempRing2);
	end
end

--[[ function gcinclude.SetTownGear()
	local zone = gData.GetEnvironment();
	if (zone.Area ~= nil) and (gcinclude.Towns:contains(zone.Area)) and ((zone.Time < 6.00) or (zone.Time > 18.00)) then 
			gFunc.EquipSet('TownNight') 
			end
	if (zone.Area ~= nil) and (gcinclude.Towns:contains(zone.Area)) and ((zone.Time >= 6.00) and (zone.Time <= 18.00)) then
			gFunc.EquipSet('Town') 
			end
end --]]

function gcinclude.SetRegenRefreshGear()
	if gcinclude.settings.AutoGear == false then return end

	local player = gData.GetPlayer();
	local pet = gData.GetPet();
	if (player.Status == 'Idle') then
		if (player.HPP < gcinclude.settings.RegenGearHPP ) then gFunc.EquipSet('Idle_Regen') end
		if (player.MPP < gcinclude.settings.RefreshGearMPP ) then gFunc.EquipSet('Idle_Refresh') end
	end
	if (player.HPP < gcinclude.settings.DTGearHPP) then gFunc.EquipSet('Dt') end
	if pet ~= nil then
		if (pet.HPP < gcinclude.settings.PetDTGearHPP) then gFunc.EquipSet('Pet_Dt') end
	end
end

function gcinclude.CheckWsBailout()
	local player = gData.GetPlayer();
	local ws = gData.GetAction();
	local target = gData.GetActionTarget();
	local sleep = gData.GetBuffCount('Sleep');
	local petrify = gData.GetBuffCount('Petrification');
	local stun = gData.GetBuffCount('Stun');
	local terror = gData.GetBuffCount('Terror');
	local amnesia = gData.GetBuffCount('Amnesia');
	local charm = gData.GetBuffCount('Charm');

	if gcinclude.settings.WScheck and not gcinclude.DistanceWS:contains(ws.Name) and (tonumber(target.Distance) > gcinclude.settings.WSdistance) then
		print(chat.header('GCinclude'):append(chat.message('Distance to mob is too far! Move closer or increase WS distance')));
		print(chat.header('GCinclude'):append(chat.message('Can change WS distance allowed by using /wsdistance ##')));
		return false;
	elseif (player.TP <= 999) or (sleep+petrify+stun+terror+amnesia+charm >= 1) then
		return false;
	elseif (tonumber(target.HPP) > gcinclude.settings.killingBlowPercent) and (gcinclude.settings.killingBlow == true) then
		--print(chat.header('GCinclude'):append(chat.message('Target HP above killing blow percent.')));
		return false;
	elseif (tonumber(target.HPP) <= gcinclude.settings.killingBlowPercent) and (gcinclude.settings.killingBlow == true) then
		print(chat.header('GCinclude'):append(chat.message('Attempting killing blow.')));
		AshitaCore:GetChatManager():QueueCommand(-1, '//' .. gcinclude.settings.killingBlowWS);
	end
		
	return true;
end

function gcinclude.CheckSpellBailout()
	local sleep = gData.GetBuffCount('Sleep');
	local petrify = gData.GetBuffCount('Petrification');
	local stun = gData.GetBuffCount('Stun');
	local terror = gData.GetBuffCount('Terror');
	local silence = gData.GetBuffCount('Silence');
	local charm = gData.GetBuffCount('Charm');

	if (sleep+petrify+stun+terror+silence+charm >= 1) then
		return false;
	else
		return true;
	end
end

function gcinclude.DoKilingBlow()
	local target = gData.GetTarget();

	if (tonumber(target.HPP) <= gcinclude.settings.killingBlowPercent) and (gcinclude.settings.killingBlow == true) then
		print(chat.header('GCinclude'):append(chat.message('Attempting killing blow.')));
		AshitaCore:GetChatManager():QueueCommand(-1, '//' .. gcinclude.settings.killingBlowWS);
	end
end


function gcinclude.DoWarpRing()
	AshitaCore:GetChatManager():QueueCommand(1, '/lac equip ring2 "Warp Ring"');

	local function usering()
		local function forceidleset()
			AshitaCore:GetChatManager():QueueCommand(1, '/lac set Idle');
		end
		AshitaCore:GetChatManager():QueueCommand(1, '/item "Warp Ring" <me>');
		forceidleset:once(8);
	end
	
	usering:once(11);
end

function gcinclude.DoLockstyle()
	AshitaCore:GetChatManager():QueueCommand(1, '/lac set Lockstyle');
end

function gcinclude.DoTeleRing()
	AshitaCore:GetChatManager():QueueCommand(1, '/lac equip ring2 "' .. gcinclude.settings.Tele_Ring .. '"');
	
	local function usering()
		local function forceidleset()
			AshitaCore:GetChatManager():QueueCommand(1, '/lac set Idle');
		end
		AshitaCore:GetChatManager():QueueCommand(1, '/item "' .. gcinclude.settings.Tele_Ring .. '" <me>');	
		forceidleset:once(8);
	end
	usering:once(11);
end

function gcinclude.DoNukes(tier)
	local cast = gcdisplay.GetCycle('Element');
	if tier == "1" then tier = 'I'
	elseif tier == "2" then tier = 'II'
	elseif tier == "3" then tier = 'III'
	elseif tier == "4" then tier = 'IV'
	elseif tier == "5" then tier = 'V'
	elseif tier == "6" then tier = 'VI'
	end

	if tier == "I" then
		AshitaCore:GetChatManager():QueueCommand(1, '/ma "' .. cast .. '" <t>');
	else
		AshitaCore:GetChatManager():QueueCommand(1, '/ma "' .. cast .. ' ' .. tier .. '" <t>');
	end
end

function gcinclude.DoCORmsg(roll)
	if gcinclude.CORmsg == false then return end

	for n = 1, #gcinclude.Rolls do
		if gcinclude.Rolls[n][1] == roll then
			-- Append the job from the table to the message
			local job = gcinclude.Rolls[n][4] or '--'  -- Default to '--' if no job is specified
			print(chat.header('GCinclude'):append('[' .. chat.warning(roll) .. ']' .. 
				'  [Lucky: ' .. chat.success(gcinclude.Rolls[n][2]) .. ']' .. 
				'  [Unlucky: ' .. chat.error(gcinclude.Rolls[n][3]) .. ']' .. 
				'  [Job: ' .. chat.success(gcinclude.Rolls[n][4]) .. ']'));
		end
	end
end

function gcinclude.DoAspir()
	local player = AshitaCore:GetMemoryManager():GetPlayer();
	local recast1 = AshitaCore:GetMemoryManager():GetRecast():GetSpellTimer(247);
	local recast2 = AshitaCore:GetMemoryManager():GetRecast():GetSpellTimer(248);
	local recast3 = AshitaCore:GetMemoryManager():GetRecast():GetSpellTimer(881);
	
	if (player:GetMainJob() == 4 and player:GetJobPointsSpent(4) >= 550) or (player:GetMainJob() == 21 and player:GetJobPointsSpent(21) >= 550) then
		if (recast3 == 0) then
			AshitaCore:GetChatManager():QueueCommand(1, '/ma "Aspir III" <t>');
		elseif (recast2 == 0) then
			AshitaCore:GetChatManager():QueueCommand(1, '/ma "Aspir II" <t>');
		elseif (recast1 == 0) then
			AshitaCore:GetChatManager():QueueCommand(1, '/ma "Aspir" <t>');
		end
	elseif (player:GetMainJob() == 4 and player:GetMainJobLevel() >= 83) or (player:GetMainJob() == 8 and player:GetMainJobLevel() >= 78) or (player:GetMainJob() == 20 and player:GetMainJobLevel() >= 97) or (player:GetMainJob() == 21 and player:GetMainJobLevel() >= 90) then
		if (recast2 == 0) then
			AshitaCore:GetChatManager():QueueCommand(1, '/ma "Aspir II" <t>');
		elseif (recast1 == 0) then
			AshitaCore:GetChatManager():QueueCommand(1, '/ma "Aspir" <t>');
		end
	elseif (recast1 == 0) then
		AshitaCore:GetChatManager():QueueCommand(1, '/ma "Aspir" <t>');
	end
end

function gcinclude.DoDrain()
	local player = AshitaCore:GetMemoryManager():GetPlayer();
	local recast1 = AshitaCore:GetMemoryManager():GetRecast():GetSpellTimer(245);
	local recast2 = AshitaCore:GetMemoryManager():GetRecast():GetSpellTimer(246);
	
	if (player:GetMainJob() == 8) then
		if (recast2 == 0) then
			AshitaCore:GetChatManager():QueueCommand(1, '/ma "Drain II" <t>');
		elseif (recast1 == 0) then
			AshitaCore:GetChatManager():QueueCommand(1, '/ma "Drain" <t>');
		end
	elseif (recast1 == 0) then
		AshitaCore:GetChatManager():QueueCommand(1, '/ma "Drain" <t>');
	end
end

function gcinclude.DoSCHspells(spell)
	local player = gData.GetPlayer();
	local playerCore = AshitaCore:GetMemoryManager():GetPlayer();
	local e = gcdisplay.GetCycle('Element');
	local key = 0;
	local cast = 'cast';
	local type = {};
	local target = 'me';
	local points = 100;

	if (spell == 'helix') then 
		type = gcinclude.HelixSpells;
		target = '<t>';
		points = 1200;
	elseif (spell == 'weather') then
		type = gcinclude.StormSpells;
		target = '<me>';
		points = 100;
	end

	if (player.MainJob == "BLM") then
		if (player.SubJob == "SCH") then
			for k, v in pairs(gcinclude.Elements) do
				if (v == e) then
					key = k;
				end
			end
			for a, b in pairs(type) do
				if (a == key) then
					cast = b;
				end
			end
			AshitaCore:GetChatManager():QueueCommand(1, '/ma "' .. cast .. '" ' .. target);
		end
	elseif (player.MainJob == "SCH") then
		if playerCore:GetJobPointsSpent(20) >= points then
			for k, v in pairs(gcinclude.Elements) do
				if (v == e) then
					key = k;
				end
			end
			for a, b in pairs(type) do
				if (a == key) then
					cast = b;
				end
			end
			AshitaCore:GetChatManager():QueueCommand(1, '/ma "' .. cast .. ' II" ' .. target);
		else
			for k, v in pairs(gcinclude.Elements) do
				if (v == e) then
					key = k;
				end
			end
			for a, b in pairs(type) do
				if (a == key) then
					cast = b;
				end
			end
			AshitaCore:GetChatManager():QueueCommand(1, '/ma "' .. cast .. '" ' .. target);
		end
	end
end

function gcinclude.DoSiphon()
	local recast = gcinclude.CheckAbilityRecast('Elemental Siphon');
	if recast ~= 0 then 
		print(chat.header('GCinclude'):append(chat.warning('Elemental Siphon not available yet!')));
		return;
	end
	local pet = gData.GetPet();
	local oldpet = 'none';
	local spirit = 'none';
	local spirits = {['Firesday'] = 'Fire Spirit', ['Earthsday'] = 'Earth Spirit', ['Watersday'] = 'Water Spirit', ['Windsday'] = 'Air Spirit', ['Iceday'] = 'Ice Spirit', ['Lightningday'] = 'Thunder Spirit', ['Lightsday'] = 'Light Spirit', ['Darksday'] = 'Dark Spirit'};
	local e = gData.GetEnvironment();
	
	local function release()
		AshitaCore:GetChatManager():QueueCommand(1, '/ja "Release" <me>');
	end
	local function siphon()
		AshitaCore:GetChatManager():QueueCommand(1, '/ja "Elemental Siphon" <me>');
	end
	local function castavatar()
		AshitaCore:GetChatManager():QueueCommand(1, '/ma "' .. oldpet .. '" <me>');
	end
	local function castspirit()
		AshitaCore:GetChatManager():QueueCommand(1, '/ma "' .. spirit .. '" <me>');
		siphon:once(4);
		release:once(6);
		if oldpet ~= 'none' then
			castavatar:once(8);
		end
	end

	if pet ~= nil then
		oldpet = pet.Name;
		release:once(1);
	end

	for k,v in pairs(spirits) do
		if k == e.Day then
			if v ~= nil then
				spirit = v;
				castspirit:once(3);
			end
		end
	end
end

function gcinclude.DoShadows(spell) -- 1000% credit to zach2good for this function, copy and paste (mostly) from his ashita discord post
	if spell.Name == 'Utsusemi: Ichi' then
		local delay = 2.4
		if gData.GetBuffCount(66) == 1 then
			(function() AshitaCore:GetChatManager():QueueCommand(-1, '/cancel 66') end):once(delay)
		elseif gData.GetBuffCount(444) == 1 then
			(function() AshitaCore:GetChatManager():QueueCommand(-1, '/cancel 444') end):once(delay)
		elseif gData.GetBuffCount(445) == 1 then
			(function() AshitaCore:GetChatManager():QueueCommand(-1, '/cancel 445') end):once(delay)
		elseif gData.GetBuffCount(446) == 1 then
			(function() AshitaCore:GetChatManager():QueueCommand(-1, '/cancel 446') end):once(delay)
		end
	end

	if spell.Name == 'Utsusemi: Ni' then
		local delay = 0.5
		if gData.GetBuffCount(66) == 1 then
			(function() AshitaCore:GetChatManager():QueueCommand(-1, '/cancel 66') end):once(delay)
		elseif gData.GetBuffCount(444) == 1 then
			(function() AshitaCore:GetChatManager():QueueCommand(-1, '/cancel 444') end):once(delay)
		elseif gData.GetBuffCount(445) == 1 then
			(function() AshitaCore:GetChatManager():QueueCommand(-1, '/cancel 445') end):once(delay)
		elseif gData.GetBuffCount(446) == 1 then
			(function() AshitaCore:GetChatManager():QueueCommand(-1, '/cancel 446') end):once(delay)
		end
	end
end

function gcinclude.DoMoonshade()
	local player = gData.GetPlayer();
	if player.TP < gcinclude.settings.MoonshadeTP then gFunc.Equip('Ear2', 'Moonshade Earring') end
end

function gcinclude.CheckCancels()--tossed Stoneskin in here too
	local action = gData.GetAction();
	local sneak = gData.GetBuffCount('Sneak');
	local stoneskin = gData.GetBuffCount('Stoneskin');
	local target = gData.GetActionTarget();
	local me = AshitaCore:GetMemoryManager():GetParty():GetMemberName(0);
	
	local function do_jig()
		AshitaCore:GetChatManager():QueueCommand(1, '/ja "Spectral Jig" <me>');
	end
	local function do_sneak()
		AshitaCore:GetChatManager():QueueCommand(1, '/ma "Sneak" <me>');
	end
	local function do_ss()
		AshitaCore:GetChatManager():QueueCommand(1, '/ma "Stoneskin" <me>');
	end

	if (action.Name == 'Spectral Jig' and sneak ~=0) then
		gFunc.CancelAction();
		AshitaCore:GetChatManager():QueueCommand(1, '/cancel Sneak');
		do_jig:once(2);
	elseif (action.Name == 'Sneak' and sneak ~= 0 and target.Name == me) then
		gFunc.CancelAction();
		AshitaCore:GetChatManager():QueueCommand(1, '/cancel Sneak');
		do_sneak:once(1);
	elseif (action.Name == 'Stoneskin' and stoneskin ~= 0) then
		gFunc.CancelAction();
		AshitaCore:GetChatManager():QueueCommand(1, '/cancel Stoneskin');
		do_ss:once(1);
	end
end

function gcinclude.CheckDefault()
	gcinclude.SetRegenRefreshGear();
	--gcinclude.SetTownGear();
    gcinclude.CheckCommonDebuffs();
	gcinclude.CheckLockingRings();
	if (gcinclude.CraftSet == true) then gFunc.EquipSet(gcinclude.sets.Crafting) end
	if (gcinclude.ZeniSet == true) then gFunc.EquipSet(gcinclude.sets.Zeni) end
	if (gcinclude.FishSet == true) then gFunc.EquipSet(gcinclude.sets.Fishing) end
	if (gcinclude.RRSET == true) then gFunc.EquipSet(gcinclude.sets.Reraise) end
	gcdisplay.Update();
end

function gcinclude.Unload()
	gcinclude.ClearAlias();
	gcdisplay.Unload();
end

function gcinclude.Initialize()
	gcdisplay.Initialize:once(2);
	gcinclude.SetVariables:once(2);
	gcinclude.SetAlias:once(2);
end

return gcinclude;