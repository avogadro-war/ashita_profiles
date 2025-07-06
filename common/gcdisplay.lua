gcdisplay = {};
JHaste = gFunc.LoadFile('common\\J-Haste.lua')

local fonts = require('fonts');
local Toggles = {};
local ToggleOrder = {};
local TogglePriority = {};
local Cycles = {};
local CycleOrder = {};
local CyclePriority = {};
local Def = 0;
local Attk = 0;
local MainLV = 0;
local SubLV = 0;
local Main = 'FOO';
local Sub = 'BAR';

local fontSettings = T{
	visible = true,
	font_family = 'Arial',
	font_height = 12,
	color = 0xFFFFFFFF,
	position_x = 300,
	position_y = 0,
	background = T{
		visible = true,
		color = 0xFF000000,
	}
};

function gcdisplay.AdvanceCycle(name)
	local ctable = Cycles[name];
	if (type(ctable) ~= 'table') then
		return;
	end
	
	ctable.Index = ctable.Index + 1;
	if (ctable.Index > #ctable.Array) then
		ctable.Index = 1;
	end
end

function gcdisplay.SetCycle(name,val)
	local ctable = Cycles[name];
	if (type(ctable) ~= 'table') then
		return;
	end
	
	for k,v in pairs(ctable.Array) do
		if val == v then
			ctable.Index = k
			return true
		end
	end
	return false
end

function gcdisplay.AdvanceToggle(name)
	if (type(Toggles[name]) ~= 'boolean') then
		return;
	elseif Toggles[name] then
		Toggles[name] = false;
	else
		Toggles[name] = true;
	end
end

function gcdisplay.Update()
	local player = AshitaCore:GetMemoryManager():GetPlayer();
	
	local MID = player:GetMainJob();
	local SID = player:GetSubJob();
	Def = player:GetDefense();
	Attk = player:GetAttack();
	MainLV =player:GetMainJobLevel();
	SubLV = player:GetSubJobLevel();
	Main = AshitaCore:GetResourceManager():GetString("jobs.names_abbr", MID);
	Sub = AshitaCore:GetResourceManager():GetString("jobs.names_abbr", SID);
end

function gcdisplay.CreateToggle(name, default, priority)
	Toggles[name] = default;
    TogglePriority[name] = priority or 1000;
    -- Only add to order if not already present
    for _, v in ipairs(ToggleOrder) do
        if v == name then return end
    end
    table.insert(ToggleOrder, name)
end

function gcdisplay.GetToggle(name)
	if (Toggles[name] ~= nil) then
		return Toggles[name];
	else
		return false;
	end
end

function gcdisplay.CreateCycle(name, values, priority)
	local newCycle = {
		Index = 1,
		Array = values
	};
	Cycles[name] = newCycle;
    CyclePriority[name] = priority or 1000;
    -- Only add to order if not already present
    for _, v in ipairs(CycleOrder) do
        if v == name then return end
    end
    table.insert(CycleOrder, name)
end

function gcdisplay.GetCycle(name)
	local ctable = Cycles[name];
	if (type(ctable) == 'table') then
		return ctable.Array[ctable.Index];
	else
		return 'Unknown';
	end
end

function gcdisplay.Unload()
	if (gcdisplay.FontObject ~= nil) then
		gcdisplay.FontObject:destroy();
	end
	ashita.events.unregister('d3d_present', 'gcdisplay_present_cb');
	ashita.events.unregister('command', 'gcdisplay_cb');
end

function gcdisplay.Initialize()
	gcdisplay.FontObject = fonts.new(fontSettings);	
	ashita.events.register('d3d_present', 'gcdisplay_present_cb', function ()
	local display = MainLV .. Main .. '/' .. SubLV .. Sub ..'   Attk:' .. Attk .. '   Def:' .. Def .. '   BrdBonus: ' .. (JHaste and JHaste.brdBonus or 'Error') .. '   GeoBonus: ' .. (JHaste and JHaste.geoBonus or 'Error');
	-- Sort toggles by priority
	table.sort(ToggleOrder, function(a, b) return (TogglePriority[a] or 1000) < (TogglePriority[b] or 1000) end)
	for _, k in ipairs(ToggleOrder) do
	local v = Toggles[k]
	display = display .. '   ';
	if (v == true) then
	display = display .. '|cFF00FF00|' .. k .. '|r';
	else
	display = display .. '|cFFFF0000|' .. k .. '|r';
	end
	end
	-- Sort cycles by priority
	table.sort(CycleOrder, function(a, b) return (CyclePriority[a] or 1000) < (CyclePriority[b] or 1000) end)
	for _, key in ipairs(CycleOrder) do
	local value = Cycles[key]
	display = display .. '  ' .. key .. ': ' .. '|cFF00FF00|' .. value.Array[value.Index] .. '|r';
	end
	gcdisplay.FontObject.text = display;
	end);
	end

ashita.events.register('command', 'gcdisplay_cb', function (e)
	local args = e.command:args()
    if #args == 0 or args[1] ~= '/gcdisplay' then
        return
    end

    e.blocked = true

    if #args == 1 then
        gcdisplay.FontObject.visible = not gcdisplay.FontObject.visible;
    end
end)

return gcdisplay;