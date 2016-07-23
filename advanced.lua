function NeP.Engine.FireHack()
	if IsHackEnabled then

		NeP.Engine.Unlocker = 'FireHack'
		NeP.Core.Print('Found An Advanced Unlockerr')

		if CancelPendingSpell then
			-- Cast on ground
			function NeP.Engine.CastGround(spell, target)
				if UnitExists(target) then
					NeP.Engine.Cast(spell, target)
					CastAtPosition(ObjectPosition(target))
					CancelPendingSpell()
				end
				if not NeP.timeOut.check('groundCast') then
					NeP.timeOut.set('groundCast', 0.05, function()
						NeP.Engine.Cast(spell)
						if IsAoEPending() then
							SetCVar("deselectOnClick", "0")
							CameraOrSelectOrMoveStart(1)
							CameraOrSelectOrMoveStop(1)
							SetCVar("deselectOnClick", "1")
							SetCVar("deselectOnClick", stickyValue)
							CancelPendingSpell()
						end
					end)
				end
			end
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

		local ignoreLOS = {
			[76585] = '',	-- Ragewing the Untamed (UBRS)
			[77063] = '',	-- Ragewing the Untamed (UBRS)
			[77182] = '',	-- Oregorger (BRF)
			[77891] = '',	-- Grasping Earth (BRF)
			[77893] = '',	-- Grasping Earth (BRF)
			[78981] = '',	-- Iron Gunnery Sergeant (BRF)
			[81318] = '',	-- Iron Gunnery Sergeant (BRF)
			[83745] = '',	-- Ragewing Whelp (UBRS)
			[86252] = '',	-- Ragewing the Untamed (UBRS)
			[56173] = '',	-- Deathwing (DragonSoul)
			[56471] = '',	-- Mutated Corruption (Dragon Soul: The Maelstrom)
			[57962] = '',	-- Deathwing (Dragon Soul: The Maelstrom)
			[55294] = '',	-- Ultraxion (DragonSoul)
			[56161] = '',	-- Corruption (DragonSoul)
			[52409] = '',	-- Ragnaros (FireLands)
			[87761] = '',
		}
		local losFlags =	bit.bor(0x10, 0x100)
		
		function NeP.Engine.LineOfSight(a, b)
			if ObjectExists(a) and ObjectExists(b) then
				-- Workaround LoS issues.
				local aCheck = select(6,strsplit('-',UnitGUID(a)))
				local bCheck = select(6,strsplit('-',UnitGUID(b)))
				if ignoreLOS[tonumber(aCheck)] ~= nil then return true end
				if ignoreLOS[tonumber(bCheck)] ~= nil then return true end
				
				local ax, ay, az = ObjectPosition(a)
				local bx, by, bz = ObjectPosition(b)
				return not TraceLine(ax, ay, az+2.25, bx, by, bz+2.25, losFlags)
			end
			return false
		end

		-- Firehack OM
		function NeP.OM.Maker()
			local totalObjects = ObjectCount()
			for i=1, totalObjects do
				local Obj = ObjectWithIndex(i)
				if UnitGUID(Obj) ~= nil and ObjectExists(Obj) then
					if ObjectIsType(Obj, ObjectTypes.Unit) or ObjectIsType(Obj, ObjectTypes.GameObject) then
						if NeP.Engine.Distance('player', Obj) <= 100 then
							NeP.OM.addToOM(Obj)
						end
					end
				end
			end
		end

	end
end