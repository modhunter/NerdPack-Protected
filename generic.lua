local n_name, glb = ...

NeP.Listener:Add('NeP_Unlocker','ADDON_ACTION_FORBIDDEN', function(addon)
	if addon == n_name then StaticPopup1:Hide() end
end)

-- Generic
glb.Generic = {}
	
function glb.Generic.Cast(spell, target)
	CastSpellByName(spell, target)
end

function glb.Generic.CastGround(spell, target)
	local stickyValue = GetCVar("deselectOnClick")
	SetCVar("deselectOnClick", "0")
	CameraOrSelectOrMoveStart(1)
	self.Cast(spell)
	CameraOrSelectOrMoveStop(1)
	SetCVar("deselectOnClick", "1")
	SetCVar("deselectOnClick", stickyValue)
end

function glb.Generic.Macro(text)
	RunMacroText(text)
end

function glb.Generic.UseItem(name, target)
	UseItemByName(name, target)
end

function glb.Generic.UseInvItem(name)
	UseInventoryItem(name)
end

NeP:AddUnlocker('Generic', function()
	pcall(RunMacroText, '/run NeP.Unlocked = true')
	return NeP.Unlocked
end, glb.Generic)