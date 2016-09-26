NeP.Protected = {
	Version = 1.12,
	Unlocker = nil,
	Generic_Check = false -- Loaded
}

-- Core version check
if NeP.Info.Version >= 71.1 then
	NeP.Core.Print('Loaded Protected Module v:'..NeP.Protected.Version)
else
	NeP.Core.Print('Failed to load Protected Module.\nYour Core is outdated.')
	return
end

local pT = NeP.Protected

local function foundU(name)
	pT.Unlocker = name
	NeP.Core.Print('|cffff0000Found:|r '..name)
end

NeP.Listener.register('ADDON_ACTION_FORBIDDEN', function(...)
	local addon, event = ...
	if addon == 'NerdPack-Protected' then
		StaticPopup1:Hide()
		NeP.Core.Print('Didnt find any unlocker, using faceroll.')
	end
end)

NeP.DSL.RegisterConditon('advancedGround', function()
	return CastAtPosition ~= nil
end)

NeP.Interface.CreatePlugin('|cffff0000Unlock! |rV:'..pT.Version, function()
	pT.Unlocker = nil
	pT.Generic_Check = false
	NeP.Engine.FaceRoll()
	pcall(RunMacroText, '/run NeP.Protected.Generic_Check = true')
end)

NeP.Listener.register("PLAYER_LOGIN", function(...)
	pcall(RunMacroText, '/run NeP.Protected.Generic_Check = true')
end)

C_Timer.NewTicker(1, (function()
	if not pT.Unlocker then
		--EasyWoWToolBox
		if EWT then
			foundU('EasyWoWToolBox')
			pT.Advanced()
		-- FireHack
		elseif FireHack then
			foundU('FireHack')
			pT.Advanced()
		-- Pixel Magic
		elseif pT.uPixelMagic then
			foundU('PixelMagic')
			NeP.Protected.PixelMagic()
		-- Generic
		elseif not pT.Generic_Check then
			local Running = NeP.DSL.Get('toggle')(nil, 'mastertoggle')
			if Running then
				pcall(RunMacroText, '/run NeP.Protected.Generic_Check = true')
			end
		elseif pT.Generic_Check then
			foundU('Generic Unlocker')
			pT.Generic()
		end
		-- Things to execute after we found a unlocker
		if pT.Unlocker then
			-- Remove faceroll timer
			NeP.Timer.Unregister('nep_faceroll')
		end
	end
end), nil)

--[[
	DESC: Checks if Object is a Blacklisted.
	This will remove the Object from the OM cache.
---------------------------------------------------]]
local BlacklistedObjects = {
	[76829] = '',		-- Slag Elemental (BrF - Blast Furnace)
	[78463] = '',		-- Slag Elemental (BrF - Blast Furnace)
	[60197] = '',		-- Scarlet Monastery Dummy
	[64446] = '',		-- Scarlet Monastery Dummy
	[93391] = '',		-- Captured Prisoner (HFC)
	[93392] = '',		-- Captured Prisoner (HFC)
	[93828] = '',		-- Training Dummy (HFC)
	[234021] = '',
	[234022] = '',
	[234023] = '',
}

function NeP.BlacklistedObject(ObjID)
	local ObjID = select(6,strsplit('-', UnitGUID(Obj)))
	return BlacklistedObjects[tonumber(ObjID)] ~= nil
end