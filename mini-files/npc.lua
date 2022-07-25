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