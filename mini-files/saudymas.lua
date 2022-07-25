local passengerDriveBy = false

Citizen.CreateThread(function()
	while true do
		Wait(500)
		
		local playerPed = PlayerPedId()
		local car = GetVehiclePedIsIn(playerPed, false)
		local inCar = GetPedInVehicleSeat(car,-1)
		local ped = GetPlayerPed(PlayerId())
		local fists = `WEAPON_UNARMED`
		local weapon = GetSelectedPedWeapon(ped)
			
		if weapon ~= fists then
			if car then
				if inCar == playerPed then
					SetPlayerCanDoDriveBy(PlayerId(),false)
				elseif passengerDriveBy then
					SetPlayerCanDoDriveBy(PlayerId(),true)
				else
					SetPlayerCanDoDriveBy(PlayerId(),false)
				end
			end
		else 
			if car then
				if inCar == playerPed then
					SetPlayerCanDoDriveBy(PlayerId(),true)
				end
			end
		end
	end
end)