----------------------------------------------
-- External Vehicle Commands, Made by FAXES --
----------------------------------------------

function ShowInfo(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, false)
end

RegisterCommand("bagazine", function(source, args, raw)
    local ped = GetPlayerPed(-1)
    local veh = GetVehiclePedIsUsing(ped)
    local vehLast = GetPlayersLastVehicle()
    local distanceToVeh = GetDistanceBetweenCoords(GetEntityCoords(ped), GetEntityCoords(vehLast), 1)
    local door = 5

    if IsPedInAnyVehicle(ped, false) then
        if GetVehicleDoorAngleRatio(veh, door) > 0 then
            SetVehicleDoorShut(veh, door, false)
            exports['okokNotify']:Alert('Sistema', 'Bagazine uzdaryta', 3000, 'info')
        else	
            SetVehicleDoorOpen(veh, door, false, false)
            exports['okokNotify']:Alert('Sistema', 'Bagazine atidaryta', 3000, 'info')
            
        end
    else
        if distanceToVeh < 6 then
            if GetVehicleDoorAngleRatio(vehLast, door) > 0 then
                SetVehicleDoorShut(vehLast, door, false)
                exports['okokNotify']:Alert('Sistema', 'Bagazine uzdaryta', 3000, 'info')
            else
                SetVehicleDoorOpen(vehLast, door, false, false)
                exports['okokNotify']:Alert('Sistema', 'Bagazine atidaryta', 3000, 'info')
            end
        else
            exports['okokNotify']:Alert('Sistema', 'Esi per toli nuo tr. priemones', 3000, 'info')
        end
    end
end)

RegisterCommand("kapotas", function(source, args, raw)
    local ped = GetPlayerPed(-1)
    local veh = GetVehiclePedIsUsing(ped)
    local vehLast = GetPlayersLastVehicle()
    local distanceToVeh = GetDistanceBetweenCoords(GetEntityCoords(ped), GetEntityCoords(vehLast), 1)
    local door = 4

    if IsPedInAnyVehicle(ped, false) then
        if GetVehicleDoorAngleRatio(veh, door) > 0 then
            SetVehicleDoorShut(veh, door, false)
            exports['okokNotify']:Alert('Sistema', 'Kapotas uzdarytas', 3000, 'info')
			TriggerServerEvent('3dme:shareDisplay', ' uždaro kapotą ')
        else	
            SetVehicleDoorOpen(veh, door, false, false)
            exports['okokNotify']:Alert('Sistema', 'Kapotas atidarytas', 3000, 'info')
			TriggerServerEvent('3dme:shareDisplay', ' atidaro kapotą ')
        end
    else
        if distanceToVeh < 4 then
            if GetVehicleDoorAngleRatio(vehLast, door) > 0 then
                SetVehicleDoorShut(vehLast, door, false)
                exports['okokNotify']:Alert('Sistema', 'Kapotas uzdarytas', 3000, 'info')
				TriggerServerEvent('3dme:shareDisplay', ' uždaro kapotą ')
            else	
                SetVehicleDoorOpen(vehLast, door, false, false)
                exports['okokNotify']:Alert('Sistema', 'Kapotas atidarytas', 3000, 'info')
				TriggerServerEvent('3dme:shareDisplay', ' atidaro kapotą ')
            end
        else
            exports['okokNotify']:Alert('Sistema', 'Esi per toli nuo tr. priemones', 3000, 'info')
        end
    end
end)

RegisterCommand("durys", function(source, args, raw)
    local ped = GetPlayerPed(-1)
    local veh = GetVehiclePedIsUsing(ped)
    local vehLast = GetPlayersLastVehicle()
    local distanceToVeh = GetDistanceBetweenCoords(GetEntityCoords(ped), GetEntityCoords(vehLast), 1)
    
    if args[1] == "1" then -- Front Left Door
        door = 0
    elseif args[1] == "2" then -- Front Right Door
        door = 1
    elseif args[1] == "3" then -- Back Left Door
        door = 2
    elseif args[1] == "4" then -- Back Right Door
        door = 3
    else
        door = nil
        exports['okokNotify']:Alert('Sistema', 'Naudojimas: HUD_COLOUR_PINK~/durys [kurios durys]', 3000, 'info')
        exports['okokNotify']:Alert('Sistema', 'Imanomos durys:', 3000, 'info')
        exports['okokNotify']:Alert('Sistema', '1(Priekine kairios durys), 2(Priekines desinios durys)', 3000, 'info')
        exports['okokNotify']:Alert('Sistema', '3(Galines kairios durys), 4(Galines desinios durys)', 3000, 'info')
    end

    if door ~= nil then
        if IsPedInAnyVehicle(ped, false) then
            if GetVehicleDoorAngleRatio(veh, door) > 0 then
                SetVehicleDoorShut(veh, door, false)
                exports['okokNotify']:Alert('Sistema', 'Durys uzdarytos', 3000, 'info')
				TriggerServerEvent('3dme:shareDisplay', ' uždaro duris ')
            else	
                SetVehicleDoorOpen(veh, door, false, false)
                exports['okokNotify']:Alert('Sistema', 'Durys atidarytos', 3000, 'info')
				TriggerServerEvent('3dme:shareDisplay', ' atidaro duris ')
            end
        else
            if distanceToVeh < 4 then
                if GetVehicleDoorAngleRatio(vehLast, door) > 0 then
                    SetVehicleDoorShut(vehLast, door, false)
                    exports['okokNotify']:Alert('Sistema', 'Durys uzdarytos', 3000, 'info')
					TriggerServerEvent('3dme:shareDisplay', ' uždaro duris ')
                else	
                    SetVehicleDoorOpen(vehLast, door, false, false)
                    exports['okokNotify']:Alert('Sistema', 'Durys atidarytos', 3000, 'info')
					TriggerServerEvent('3dme:shareDisplay', ' atidaro duris ')
                end
            else
                exports['okokNotify']:Alert('Sistema', 'Esi per toli nuo tr. priemones', 3000, 'info')
            end
        end
    end
end)

RegisterCommand('langas', function()
    WindowsFront()
end, false)

local Windows1 = 0

function WindowsFront()
    print(Windows1)
    local playerPed = GetPlayerPed(-1)
    local playerVeh = GetVehiclePedIsIn(playerPed, false)
    if ( IsPedSittingInAnyVehicle( playerPed ) ) and Windows1 == 0 then
      RollUpWindow(playerVeh, 1)
      RollUpWindow(playerVeh, 0)
      Windows1 = 1
    else
        RollDownWindow(playerVeh, 1)
        RollDownWindow(playerVeh, 0)
        Windows1 = 0
    end
end