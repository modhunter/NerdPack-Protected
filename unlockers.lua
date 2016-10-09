local LibBoss = LibStub('LibBossIDs-1.0')


local losFlags = bit.bor(0x10, 0x100)
local rangeTable = {
	melee = 1.5,
	ranged = 40
}

-- Generic
local Generic_t = {
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

local FireHack_T = {
	Distance = function (a, b)
		if ObjectExists(a) and ObjectExists(b) then
			local ax, ay, az = ObjectPosition(b)
			local bx, by, bz = ObjectPosition(a)
			return math.sqrt(((bx-ax)^2) + ((by-ay)^2) + ((bz-az)^2))
		end
		return 0
	end,
	Infront = function (a, b)
		if ObjectExists(a) and ObjectExists(b) then
			local aX, aY, aZ = ObjectPosition(b)
			local bX, bY, bZ = ObjectPosition(a)
			local playerFacing = GetPlayerFacing()
			local facing = math.atan2(bY - aY, bX - aX) % 6.2831853071796
			return math.abs(math.deg(math.abs(playerFacing - (facing)))-180) < 90
		end
		return false
	end,
	CastGround = function (spell, target)
		local stickyValue = GetCVar('deselectOnClick')
		if UnitExists(target) then
			local rX, rY = math.random(), math.random()
			local oX, oY, oZ = ObjectPosition(target)
			if oX then oX = oX + rX; oY = oY + rY end
			Generic_t.Cast(spell)
			if oX then CastAtPosition(oX, oY, oZ) end
			CancelPendingSpell()
		else
			Generic_t.CastGround(spell, target)
		end
	end,
	UnitCombatRange = function (unitA, unitB)
		if UnitExists(unitA) and UnitExists(unitB) then
			local Distance = NeP.Engine.Distance(unitA, unitB)
			return Distance - (UnitCombatReach(unitA) + UnitCombatReach(unitB))
		end
		return 0
	end,
	UnitCombatRange = function (unitA, unitB)
		if UnitExists(unitA) and UnitExists(unitB) then
			local Distance = NeP.Engine.Distance(unitA, unitB)
			return Distance - (UnitCombatReach(unitA) + UnitCombatReach(unitB))
		end
		return 0
	end,
	UnitAttackRange = function (unitA, unitB, rType)
		if rangeTable[rType] and UnitExists(unitA) and UnitExists(unitB) then
			return rangeTable[rType] + UnitCombatReach(unitA) + UnitCombatReach(unitB)
		end
		return 0
	end,
	LineOfSight = function (a, b)
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
}

NeP.Protected:AddUnlocker('EasyWoWToolBox', function ()
	return EWT
end, Generic_t, FireHack_T)

NeP.Protected:AddUnlocker('FireHack', function ()
	return FireHack
end, Generic_t, FireHack_T)

NeP.Protected:AddUnlocker('Generic', function ()
	pcall(RunMacroText, '/run NeP.Unlocked = true')
	return NeP.Unlocked
end, Generic_t)