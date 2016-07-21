NeP.Engine.Unlocker = nil

NeP.Interface.CreatePlugin('|cffff0000Unlock!', function() 
	pcall(RunMacroText, "/run NeP.Engine.generic_check = true")
	if not NeP.Engine.generic_check then 
		NeP.Core.Print('Failed to Unlock...')
		NeP.Engine.FaceRoll()
	end
end)

C_Timer.NewTicker(1, (function()
	local tainted = NeP.Engine.Unlocker == nil
	local Running = NeP.Config.Read('bStates_MasterToggle', false)
	if tainted and Running then
		NeP.Engine.Generic()
		NeP.Engine.FireHack()
	end
end), nil)