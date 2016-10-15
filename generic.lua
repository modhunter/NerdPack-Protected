local n_name, glb = ...

NeP.Listener:Add('NeP_Unlocker','ADDON_ACTION_FORBIDDEN', function(addon)
	if addon == n_name then
		StaticPopup1:Hide()
	end
end)

-- Generic
glb.Generic = {
	Cast = function(spell, target)
		CastSpellByName(spell, target)
	end,
	CastGround = function(spell, target)
		local stickyValue = GetCVar("deselectOnClick")
		SetCVar("deselectOnClick", "0")
		CameraOrSelectOrMoveStart(1)
		NeP.Protected.Cast(spell)
		CameraOrSelectOrMoveStop(1)
		SetCVar("deselectOnClick", "1")
		SetCVar("deselectOnClick", stickyValue)
	end,
	Macro = function(text)
		RunMacroText(text)
	end,
	UseItem = function(name, target)
		UseItemByName(name, target)
	end,
	UseInvItem = function(name)
		UseInventoryItem(name)
	end
}

NeP.Protected:AddUnlocker('Generic', function ()
	pcall(RunMacroText, '/run NeP.Unlocked = true')
	return NeP.Unlocked
end, glb.Generic)