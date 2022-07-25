

local disableShuffle = true
function disableSeatShuffle(flag)
	disableShuffle = flag
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsPedInAnyVehicle(GetPlayerPed(-1), false) and disableShuffle then
			if GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0) == GetPlayerPed(-1) then
				if GetIsTaskActive(GetPlayerPed(-1), 165) then
					SetPedIntoVehicle(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1), false), 0)
				end
			end
		end
	end
end)

RegisterNetEvent("SeatShuffle")
AddEventHandler("SeatShuffle", function()
	if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
		disableSeatShuffle(false)
		Citizen.Wait(5000)
		disableSeatShuffle(true)
	else
		CancelEvent()
	end
end)

RegisterNetEvent("SeatShuffleDriver")
AddEventHandler("SeatShuffleDriver", function()
	if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
		if GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1), false), -1) == GetPlayerPed(-1) then
			SetPedIntoVehicle(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1), false), 0)
			disableSeatShuffle(true)
		end
	end
end)

RegisterNetEvent("SeatShuffleBack")
AddEventHandler("SeatShuffleBack", function()
	if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
		if GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1), false), 1) == GetPlayerPed(-1) then
			SetPedIntoVehicle(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1), false), 2)
		elseif GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1), false), 2) == GetPlayerPed(-1) then
			SetPedIntoVehicle(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1), false), 1)
		end
	end
end)

RegisterCommand("persesti", function(source, args, raw) --change command here
    TriggerEvent("SeatShuffle")
	TriggerEvent("SeatShuffleDriver")
	TriggerEvent("SeatShuffleBack")
end, false) 