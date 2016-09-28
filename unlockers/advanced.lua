local LibBoss = LibStub("LibBossIDs-1.0")

function NeP.Protected.Advanced()

	-- Cast on ground
	if CancelPendingSpell and CastAtPosition and IsAoEPending then
		local fallbackGround = NeP.Engine.CastGround
		function NeP.Engine.CastGround(spell, target)
			NeP.Engine:insertToLog('Spell', spell, target)
			local stickyValue = GetCVar("deselectOnClick")
			if UnitExists(target) then
				local rX, rY = math.random(), math.random()
				local oX, oY, oZ = ObjectPosition(target)
				if oX then oX = oX + rX; oY = oY + rY end
				NeP.Engine.Cast(spell)
				if oX then CastAtPosition(oX, oY, oZ) end
				CancelPendingSpell()
			else
				fallbackGround(spell, target)
			end
		end
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

	-- Distance
	function NeP.Engine.Distance(a, b)
		if ObjectExists(a) and ObjectExists(b) then
			local ax, ay, az = ObjectPosition(b)
			local bx, by, bz = ObjectPosition(a)
			return math.sqrt(((bx-ax)^2) + ((by-ay)^2) + ((bz-az)^2))
		end
		return 0
	end

	-- Infront
	function NeP.Engine.Infront(a, b)
		if ObjectExists(a) and ObjectExists(b) then
			local aX, aY, aZ = ObjectPosition(b)
			local bX, bY, bZ = ObjectPosition(a)
			local playerFacing = GetPlayerFacing()
			local facing = math.atan2(bY - aY, bX - aX) % 6.2831853071796
			return math.abs(math.deg(math.abs(playerFacing - (facing)))-180) < 90
		end
		return false
	end

	if UnitCombatReach then

		function NeP.Engine.UnitCombatRange(unitA, unitB)
			if UnitExists(unitA) and UnitExists(unitB) then
				local Distance = NeP.Engine.Distance(unitA, unitB)
				return Distance - (UnitCombatReach(unitA) + UnitCombatReach(unitB))
			end
			return 0
		end

		local rangeTable = {
			melee = 1.5,
			ranged = 40,
		}
		function NeP.Engine.UnitAttackRange(unitA, unitB, rType)
			if rangeTable[rType] and UnitExists(unitA) and UnitExists(unitB) then
				return rangeTable[rType] + UnitCombatReach(unitA) + UnitCombatReach(unitB)
			end
			return 0
		end
		
	end

	local losFlags = bit.bor(0x10, 0x100)
		
	function NeP.Engine.LineOfSight(a, b)
		if ObjectExists(a) and ObjectExists(b) then
			-- Dont Check LoS on Boss's
			if LibBoss.BossIDs[UnitID(a)] then return true end
			if LibBoss.BossIDs[UnitID(b)] then return true end
				
			local ax, ay, az = ObjectPosition(a)
			local bx, by, bz = ObjectPosition(b)
			return not TraceLine(ax, ay, az+2.25, bx, by, bz+2.25, losFlags)
		end
		return false
	end

	-- Advanced OM
	if not NeP.Interface.fetchKey('NePSettings', 'fOM_Generic', false) then
		function NeP.OM.Maker()
			local totalObjects = ObjectCount()
			for i=1, totalObjects do
				local Obj = ObjectWithIndex(i)
				if UnitGUID(Obj) and ObjectExists(Obj)
				and not NeP.BlacklistedObject(Obj) then
					NeP.OM.addToOM(Obj)
				end
			end
		end
	end

end