ESX          = nil

local seatbeltInput = 182                   -- Toggle seatbelt on/off with K or DPAD down (controller)
local seatbeltPlaySound = true              -- Play seatbelt sound
local seatbeltDisableExit = true            -- Disable vehicle exit when seatbelt is enabled
local seatbeltEjectSpeed = 40.0             -- Speed threshold to eject player (MPH)
local seatbeltEjectAccel = 100.0            -- Acceleration threshold to eject player (G's)
local seatbeltColorOn = {160, 255, 160}     -- Color used when seatbelt is on
local seatbeltColorOff = {255, 96, 96}      -- Color used when seatbelt is off
local segimas = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)


local pedInVeh = false
local seatbeltIsOn = false
Citizen.CreateThread(function()
	local currSpeed = 0.0
	while true do
		Citizen.Wait(0)
		local player = GetPlayerPed(-1)
		local position = GetEntityCoords(player)
		local vehicle = GetVehiclePedIsIn(player, false)

		-- Set vehicle states
		if IsPedInAnyVehicle(player, false) then
			pedInVeh = true
		else
			-- Reset states when not in car
			pedInVeh = false
			cruiseIsOn = false
			seatbeltIsOn = false
		end
		
		local vehicleClass = GetVehicleClass(vehicle)
		if pedInVeh and vehicleClass ~= 13 then
			local prevSpeed = currSpeed
			currSpeed = GetEntitySpeed(vehicle)

			-- Set PED flags
			SetPedConfigFlag(PlayerPedId(), 32, true)
			--if IsControlJustReleased(0, seatbeltInput) and (enableController or GetLastInputMethod(0)) and vehicleClass ~= 8 then
			if segimas and vehicleClass ~= 8 then
				-- Toggle seatbelt status and play sound when enabled
				if seatbeltIsOn then
                    exports.rprogress:Start("Atsisegi saugos dirza..", 1400)
				else
                    exports.rprogress:Start("Užsisegi saugos dirza..", 1400)
				end
				seatbeltIsOn = not seatbeltIsOn
				segimas = false
				if seatbeltIsOn then
					TriggerServerEvent('3dme:shareDisplay', "*Užsisega saugos diržą*")
                    exports['okokNotify']:Alert('Sistema', 'Diržas užsegtas', 3000, 'info')
                end
				
				if not seatbeltIsOn then
					segimas = false
					TriggerServerEvent('3dme:shareDisplay', "*Atsisega saugos diržą*")
                    exports['okokNotify']:Alert('Sistema', 'Diržas atsegtas', 3000, 'info')
                end					
				if seatbeltPlaySound then
					PlaySoundFrontend(-1, "Faster_Click", "RESPAWN_ONLINE_SOUNDSET", 1)
					Citizen.Wait(100)
					PlaySoundFrontend(-1, "Faster_Click", "RESPAWN_ONLINE_SOUNDSET", 1)
					Citizen.Wait(1)
					PlaySoundFrontend(-1, "Faster_Click", "RESPAWN_ONLINE_SOUNDSET", 1)
				end
			end
			if not seatbeltIsOn then
				-- Eject PED when moving forward, vehicle was going over 45 MPH and acceleration over 100 G's
				local vehIsMovingFwd = GetEntitySpeedVector(vehicle, true).y > 1.0
				local vehAcc = (prevSpeed - currSpeed) / GetFrameTime()
				if (vehIsMovingFwd and (prevSpeed > (seatbeltEjectSpeed/2.237)) and (vehAcc > (seatbeltEjectAccel*9.81))) then
					SetEntityCoords(player, position.x, position.y, position.z + 0.47, true, true, true)
					SetEntityVelocity(player, prevVelocity.x, prevVelocity.y, prevVelocity.z)
					Citizen.Wait(1)
					SetPedToRagdoll(player, 1000, 1000, 0, 0, 0, 0)
				else
					-- Update previous velocity for ejecting player
					prevVelocity = GetEntityVelocity(vehicle)
				end
			elseif seatbeltDisableExit then
				-- Disable vehicle exit when seatbelt is on
				DisableControlAction(0, 75)
			end
			Citizen.Wait(0)
		else
			Citizen.Wait(400)
		end
	end
end)

RegisterCommand('dirzas', function()
  	if segimas then
		segimas = false
	else
		segimas = true
	end
end)	