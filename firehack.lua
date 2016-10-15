local _, glb = ...
local LibBoss = LibStub('LibBossIDs-1.0')

local losFlags = bit.bor(0x10, 0x100)

glb.FireHack = {
	Distance = function (a, b)
		return GetDistanceBetweenObjects(a,b)
	end,
	Infront = function (a, b)
		return ObjectIsFacing(a,b)
	end,
	CastGround = function (spell, target)
		local stickyValue = GetCVar('deselectOnClick')
		if UnitExists(target) then
			local rX, rY = math.random(), math.random()
			local oX, oY, oZ = ObjectPosition(target)
			if oX then oX = oX + rX; oY = oY + rY end
			glb.Generic.Cast(spell)
			if oX then CastAtPosition(oX, oY, oZ) end
			CancelPendingSpell()
		else
			glb.Generic.CastGround(spell, target)
		end
	end,
	UnitCombatRange = function (unitA, unitB)
		if UnitExists(unitA) and UnitExists(unitB) then
			local Distance = NeP.Protected.Distance(unitA, unitB)
			return Distance - (UnitCombatReach(unitA) + UnitCombatReach(unitB))
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

function glb.FireHack_OM()
	for i=1, ObjectCount() do
		local Obj = ObjectWithIndex(i)
		NeP.OM:Add(Obj)
	end
end

NeP.Protected:AddUnlocker('FireHack', function ()
	return FireHack
end, glb.Generic, glb.FireHack, glb.FireHack_OM)