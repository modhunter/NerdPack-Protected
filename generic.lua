NeP.Listener.register("ADDON_ACTION_FORBIDDEN", function(...)
	local addon, event = ...
	if addon == 'NerdPack-Protected' then
		StaticPopup1:Hide()
		NeP.Core.Print('Didnt find any unlocker, using facerool.')
	end
end)

NeP.Engine.generic_check = false
pcall(RunMacroText, "/run NeP.Engine.generic_check = true")

function NeP.Engine.Generic()
	if NeP.Engine.generic_check then

		NeP.Engine.Unlocker = 'Generic'
		NeP.Core.Print('Found Generic Unlocker')

		-- cast on ground
		function NeP.Engine.CastGround(spell, target)
			local stickyValue = GetCVar("deselectOnClick")
			SetCVar("deselectOnClick", "0")
			CameraOrSelectOrMoveStart(1)
			NeP.Engine.Cast(spell)
			CameraOrSelectOrMoveStop(1)
			SetCVar("deselectOnClick", "1")
			SetCVar("deselectOnClick", stickyValue)
		end

		-- Cast
		function NeP.Engine.Cast(spell, target)
			if type(spell) == "number" then
				CastSpellByID(spell, target)
			else
				CastSpellByName(spell, target)
			end
		end

		-- Macro
		function NeP.Engine.Macro(text)
			RunMacroText(text)
		end

		function NeP.Engine.UseItem(name, target)
			UseItemByName(name, target)
        end

        function NeP.Engine.UseInvItem(slot)
			UseInventoryItem(slot)
        end

	end
end