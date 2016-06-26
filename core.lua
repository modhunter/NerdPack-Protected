NeP.Engine.Unlocker = nil

NeP.Listener.register("ADDON_ACTION_FORBIDDEN", function(...)
	local addon, event = ...
	if addon == 'NerdPack-Protected' then
		StaticPopup1:Hide()
		NeP.Core.Print('Didnt find any unlocker, using facerool.')
	end
end)

C_Timer.NewTicker(1, (function()
	if NeP.Engine.Unlocker == nil then
		NeP.Engine.Generic()
		NeP.Engine.FireHack()
	end
end), nil)