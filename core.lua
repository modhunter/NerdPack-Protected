NeP.Engine.Unlocker = nil

NeP.Interface.CreatePlugin('|cffff0000Unlock!', function() 
	pcall(RunMacroText, "/run NeP.Engine.generic_check = true")
	if not NeP.Engine.generic_check then NeP.Core.Print('Failed to Unlock...') end
end)

C_Timer.NewTicker(1, (function()
	if NeP.Engine.Unlocker == nil then
		NeP.Engine.Generic()
		NeP.Engine.FireHack()
	end
end), nil)