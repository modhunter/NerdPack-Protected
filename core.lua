NeP.Protected = {
<<<<<<< HEAD
	Version = 1.3,
=======
	Version = '1.1.1',
>>>>>>> origin/master
	Unlocker = nil,
	cGeneric = false, -- Pcall
	uGeneric = false, -- Loaded
	uAdvanced = false -- Loaded
}

-- Core version check
if NeP.Info.Version >= 70.1 then
	NeP.Core.Print('Loaded Protected Module v:'..NeP.Protected.Version)
else
	NeP.Core.Print('Failed to load Protected Module.\nYour Core is outdated.')
	return
end

local pT = NeP.Protected
local ranOnce = false

NeP.Listener.register('ADDON_ACTION_FORBIDDEN', function(...)
	local addon, event = ...
	if addon == 'NerdPack-Protected' then
		StaticPopup1:Hide()
		NeP.Core.Print('Didnt find any unlocker, using faceroll.')
	end
end)

NeP.Interface.CreatePlugin('|cffff0000Unlock! |rV:'..pT.Version, function()
	pT.cGeneric = false
	pT.uGeneric = false
	pT.uAdvanced = false
	pcall(RunMacroText, '/run NeP.Protected.cGeneric = true')
	if not pT.cGeneric then 
		NeP.Core.Print('Failed to Unlock...')
		NeP.Engine.FaceRoll()
	end
end)

NeP.DSL.RegisterConditon("advanced", function()
	return IsHackEnabled ~= nil
end)

C_Timer.NewTicker(1, (function()
	--local Running = NeP.Config.Read('bStates_MasterToggle', false)
	if not pT.uGeneric and not pT.uAdvanced then
		-- Everthing in here will only run once
		if not ranOnce then
			pcall(RunMacroText, '/run NeP.Protected.cGeneric = true')
			ranOnce = true
		end
		-- Advanced
		if IsHackEnabled then
			pT.Advanced()
			pT.uAdvanced = true
			pT.Unlocker = 'FireHack'
			if EWT then
				NeP.Core.Print('|cffff0000Found:|r EasyWoWToolBox')
			else
				NeP.Core.Print('|cffff0000Found:|r Advanced Unlocker')
			end
		-- Generic
		elseif pT.uGeneric then
			pT.Generic()
			pT.uGeneric = true
			pT.Unlocker = 'Generic'
			NeP.Core.Print('|cffff0000Found:|r Generic Unlocker')
		end
	end
end), nil)