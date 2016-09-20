function NeP.Protected.PixelMagic()

	local activeFrame = CreateFrame('Frame', 'activeCastFrame', UIParent)
	activeFrame:SetSize(32, 32)
	activeFrame.texture = activeFrame:CreateTexture()
	activeFrame.texture:SetColorTexture(0,255,0,1)
	activeFrame.texture:SetAllPoints(activeFrame)
	activeFrame:SetFrameStrata('HIGH')
	activeFrame:Hide()

	local function showActiveSpell(spell)
		local spellButton = NeP.Faceroll.buttonMap[spell]
		if spellButton and spell then
			activeFrame:Show()
			activeFrame:SetPoint("CENTER", spellButton, "CENTER")
		end
	end

	-- Hide it
	NeP.Timer.Sync("nep_PixelMagic", 1, function()
		activeFrame:Hide()
	end, 0)

	-- cast on ground
	function NeP.Engine.CastGround(spell, target)
		showActiveSpell(spell)
	end

	-- Cast
	function NeP.Engine.Cast(spell, target)
		showActiveSpell(spell)
	end

end