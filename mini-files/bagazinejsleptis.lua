local inTrunk = false

ThreadInTrunk = function()
    while inTrunk do
        local vehicle = GetEntityAttachedTo(PlayerPedId())
        if DoesEntityExist(vehicle) or not IsPedDeadOrDying(PlayerPedId()) or not IsPedFatallyInjured(PlayerPedId()) then
            local coords = GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, 'boot'))
            SetEntityCollision(PlayerPedId(), false, false)
            DrawText3D(coords, '~b~[K] ~w~Islipti')
            exports['j-textui']:Help("Spauskite INPUT_K Kad Išlipti")

            if GetVehicleDoorAngleRatio(vehicle, 5) < 0.9 then
                SetEntityVisible(PlayerPedId(), false, false)
            else
                if not IsEntityPlayingAnim(PlayerPedId(), 'timetable@floyd@cryingonbed@base', 3) then
                    loadDict('timetable@floyd@cryingonbed@base')
                    TaskPlayAnim(PlayerPedId(), 'timetable@floyd@cryingonbed@base', 'base', 8.0, -8.0, -1, 1, 0, false, false, false)

                    SetEntityVisible(PlayerPedId(), true, false)
                end
            end
            if IsControlJustReleased(0, 311) and inTrunk then
                SetCarBootOpen(vehicle)
                SetEntityCollision(PlayerPedId(), true, true)
                Wait(750)
                inTrunk = false
                DetachEntity(PlayerPedId(), true, true)
                SetEntityVisible(PlayerPedId(), true, false)
                ClearPedTasks(PlayerPedId())
                SetEntityCoords(PlayerPedId(), GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, -0.5, -0.75))
                Wait(250)
                SetVehicleDoorShut(vehicle, 5)
            end
        else
            SetEntityCollision(PlayerPedId(), true, true)
            DetachEntity(PlayerPedId(), true, true)
            SetEntityVisible(PlayerPedId(), true, false)
            ClearPedTasks(PlayerPedId())
            SetEntityCoords(PlayerPedId(), GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, -0.5, -0.75))
        end
        Wait(10)
    end
end 

loadDict = function(dict)
    while not HasAnimDictLoaded(dict) do Wait(0) RequestAnimDict(dict) end
end

SetInTrunk = function(_vehicle)
    local vehicle = _vehicle
    local lockStatus = GetVehicleDoorLockStatus(vehicle)
    if not inTrunk then
        local playerPed = PlayerPedId()
        if lockStatus == 1 then --unlocked
            if DoesEntityExist(playerPed) then
                if not IsEntityAttached(playerPed) then
                    SetCarBootOpen(vehicle)
                    Wait(350)
                    AttachEntityToEntity(playerPed, vehicle, -1, 0.0, -2.2, 0.5, 0.0, 0.0, 0.0, false, false, false, false, 20, true)	
                    loadDict('timetable@floyd@cryingonbed@base')
                    TaskPlayAnim(playerPed, 'timetable@floyd@cryingonbed@base', 'base', 8.0, -8.0, -1, 1, 0, false, false, false)
                    Wait(50)
                    inTrunk = true

                    Wait(1500)
                    SetVehicleDoorShut(vehicle, 5)
                    ThreadInTrunk()
                else
                    exports['okokNotify']:Alert('Sistema', 'Kažkas jau slepiasi mašinoje', 3000, 'info')
                end
            end
        elseif lockStatus == 2 then -- locked
            exports['okokNotify']:Alert('Sistema', 'Mašina užrakinta', 3000, 'info')
        end
    end
end

AddEventHandler('hideintrunk:InTrunk', function(data)
    local vehicle = data.entity
    --Lockstatus
    local lockStatus = GetVehicleDoorLockStatus(vehicle)
    --Lockstatus End
    if DoesEntityExist(vehicle) and IsVehicleSeatFree(vehicle,-1) then
        if not inTrunk then
            if GetVehicleDoorAngleRatio(vehicle, 5) < 1.0 then
                if lockStatus == 1 then --unlocked
                    SetCarBootOpen(vehicle)
                    SetInTrunk(vehicle)
                elseif lockStatus == 2 then -- locked
                    exports['okokNotify']:Alert('Sistema', 'Mašina užrakinta', 3000, 'info')
                end
            end
        end
    end
end)

exports.qtarget:Vehicle({
	options = {
		{
			event = "hideintrunk:InTrunk",
			icon = "fas fa-box-eye-slash",
			label = "Ilipti į bagažinę",
			canInteract = function(entity)
                return GetEntityBoneIndexByName(entity, 'boot') ~= -1
            end
		},
	},
	distance = 1.5
})

function DrawText3D(coords, text)
    local onScreen, _x, _y = World3dToScreen2d(coords.x, coords.y, coords.z)
    local pX, pY, pZ = table.unpack(GetGameplayCamCoords())
  
    SetTextScale(0.4, 0.4)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextEntry("STRING")
    SetTextCentre(1)
    SetTextColour(255, 255, 255, 255)
    SetTextOutline()
  
    AddTextComponentString(text)
    DrawText(_x, _y)
end