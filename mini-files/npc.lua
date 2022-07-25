DensityMultiplier = 0.1
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        SetVehicleDensityMultiplierThisFrame(DensityMultiplier)
        SetPedDensityMultiplierThisFrame(DensityMultiplier)
        SetRandomVehicleDensityMultiplierThisFrame(DensityMultiplier)
        SetParkedVehicleDensityMultiplierThisFrame(DensityMultiplier)
        SetScenarioPedDensityMultiplierThisFrame(DensityMultiplier, DensityMultiplier)
    end
end)

-- in any client side
AddEventHandler('gameEventTriggered', function(name, args)
    if name == 'CEventNetworkEntityDamage' then
        if args[6] == 1 then
            SetPedDropsWeaponsWhenDead(args[1], false)
        end
    end
end)

Citizen.CreateThread(function()
    SetCreateRandomCops(false) -- disable random cops walking/driving around
    SetCreateRandomCopsNotOnScenarios(false) -- stop random cops (not in a scenario) from spawning
    SetCreateRandomCopsOnScenarios(false) -- stop random cops (in a scenario) from spawning
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(800)
        local playerPed = PlayerPedId()
        local vehicle = GetVehiclePedIsTryingToEnter(playerPed)

        if vehicle and DoesEntityExist(vehicle) then
            local driverPed = GetPedInVehicleSeat(vehicle, -1)

            if GetVehicleDoorLockStatus(vehicle) == 7 then
                SetVehicleDoorsLocked(vehicle, 2)
            end

            if driverPed and DoesEntityExist(driverPed) then
                SetPedCanBeDraggedOut(driverPed, false)
            end
        end
    end
end)
