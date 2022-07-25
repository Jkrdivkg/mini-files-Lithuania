local alavalot = false
ESX = exports['es_extended']:getSharedObject()


RegisterCommand('neonai', function()
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, false)
	local driver  = GetPedInVehicleSeat(vehicle, -1)
    local alavalotkiinni = IsVehicleNeonLightEnabled(vehicle, 1)
		
    if IsPedInVehicle(ped,vehicle, true) and driver == ped then
		if alavalotkiinni then
			if alavalot == false then
				alavalot = true
				DisableVehicleNeonLights(vehicle, true)
				exports['okokNotify']:Alert('Sistema', 'Neonai Išjungti', 3000, 'info')
				Wait(2000)
			elseif alavalot == true then
				alavalot = false
				DisableVehicleNeonLights(vehicle, false)
				exports['okokNotify']:Alert('Sistema', 'Neonai Įjungti', 3000, 'info')
				Wait(2000)
			end
		else
			ESX.ShowNotification('Ši mašina neturi neonų')
			Wait(2000)
        end
    end
end)
