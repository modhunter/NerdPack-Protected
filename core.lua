NeP.Protected = {
	Version = '1.0.0',
	Unlocker = nil,
	uGeneric = false,
	uAdvanced = false
}

local pT = NeP.Protected

NeP.Listener.register('ADDON_ACTION_FORBIDDEN', function(...)
	local addon, event = ...
	if addon == 'NerdPack-Protected' then
		StaticPopup1:Hide()
		NeP.Core.Print('Didnt find any unlocker, using faceroll.')
	end
end)

NeP.Interface.CreatePlugin('|cffff0000Unlock!', function() 
	pcall(RunMacroText, '/run NeP.Protected.Generic = true')
	if not pT.Generic then 
		NeP.Core.Print('Failed to Unlock...')
		NeP.Engine.FaceRoll()
	end
end)

local function Tainted_Check()
	if pT.uGeneric or pT.uAdvanced then return false end
	return true
end

-- Try to find a generic unlocker
pcall(RunMacroText, '/run NeP.Protected.Generic = true')

C_Timer.NewTicker(1, (function()
	local Running = NeP.Config.Read('bStates_MasterToggle', false)
	local tainted = Tainted_Check()
	if tainted and Running then
		-- Advanced
		if IsHackEnabled then
			pT.Advanced()
			pT.uAdvanced = true
			pT.Unlocker = 'FireHack'
			NeP.Core.Print('Found: Advanced Unlocker')
		-- Generic
		elseif Generic then
			pT.Generic()
			pT.uGeneric = true
			pT.Unlocker = 'Generic'
			NeP.Core.Print('Found: Generic Unlocker')
		end
	end
end), nil)