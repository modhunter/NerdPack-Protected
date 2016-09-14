NeP.Protected = {
	Version = 1.11,
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
		elseif pT.Generic_Check then
			foundU('Generic Unlocker')
			pT.Generic()
		end
		-- Things to execute after we found a unlocker
		if pT.Unlocker then
			-- Remove faceroll timer
			NeP.Timer.Unregister('nep_faceroll')
		end
		pcall(RunMacroText, '/run NeP.Protected.Generic_Check = true')
	end
end), nil)