RegisterCommand('+handsup', function()
    local dict = "missminuteman_1ig_2"

    local lib, anim = 'anim@heists@narcotics@funding@gang_idle', 'gang_chatting_idle01' -- TODO better animations
	local playerPed = PlayerPedId()

    if IsEntityPlayingAnim(playerPed, lib, anim, 3) then return end

	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Wait(100)
	end

    local Ped = PlayerPedId()

    ClearPedTasks(Ped)
    TaskPlayAnim(Ped, dict, "handsup_enter", 8.0, 8.0, -1, 50, 0, false, false, false)
end)

RegisterCommand('-handsup', function()
    local lib, anim = 'anim@heists@narcotics@funding@gang_idle', 'gang_chatting_idle01' -- TODO better animations
	local playerPed = PlayerPedId()

    if IsEntityPlayingAnim(playerPed, lib, anim, 3) then return end
    ClearPedTasks(playerPed)
end)

RegisterKeyMapping('+handsup', 'Pakelti rankas', 'keyboard', 'x')

RegisterCommand('alga', function()
    value = 100
    print(value)
    print(value/100*90)
end)