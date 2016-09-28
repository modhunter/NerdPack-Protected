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

	-- Distance
	local FallBack_Distance = NeP.Engine.Distance
	function NeP.Engine.Distance(unit1, unit2)
		local y1, x1, z1, instance1 = UnitPosition(unit1)
		local y2, x2, z2, instance2 = UnitPosition(unit2)
		if y2 and instance1 == instance2 then
			return ((x2 - x1) ^ 2 + (y2 - y1) ^ 2) ^ 0.5
		end
		return FallBack_Distance(unit1, unit2)
	end

	-- Macro
	function NeP.Engine.Macro(text)
		RunMacroText(text)
	end

	function NeP.Engine.UseItem(name, target)
		NeP.Engine.insertToLog('Item', item, target)
		UseItemByName(name, target)
	end

	function NeP.Engine.UseInvItem(slot)
		NeP.Engine.insertToLog('Item', item, target)
		UseInventoryItem(slot)
	end

end