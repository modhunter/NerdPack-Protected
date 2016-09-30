function NeP.Protected.Generic()

	-- Cast on ground
	function NeP.Engine.CastGround(spell, target)
		NeP.Engine:insertToLog('Spell', spell, target)
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
		NeP.Engine:insertToLog('Spell', spell, target)
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
		NeP.Engine:insertToLog('Item', name, target)
		UseItemByName(name, target)
	end

	function NeP.Engine.UseInvItem(name)
		NeP.Engine:insertToLog('Item', name, target)
		UseInventoryItem(name)
	end

end