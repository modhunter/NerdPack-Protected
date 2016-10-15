local _, glb = ...

NeP.Protected:AddUnlocker('EasyWoWToolBox', function ()
	return EWT
end, glb.Generic, glb.FireHack, glb.FireHack_OM)