local crouched = false

RegisterCommand('crouch', function(source)
    local Ped = PlayerPedId()
    RequestAnimSet( "move_ped_crouched" )
    while not HasAnimSetLoaded( "move_ped_crouched" ) do 
        Wait(100)
    end
    
    if DoesEntityExist(Ped) and not IsEntityDead(Ped) and not IsPauseMenuActive() then
        DisableControlAction( 0, 36, true )
        if crouched then
            ResetPedMovementClipset(Ped, 0)
            crouched = false 
        elseif not crouched then
            SetPedMovementClipset(Ped, "move_ped_crouched", 0.25)
            crouched = true 
        end
    end

end)

RegisterKeyMapping('crouch','Atsitupti', 'keyboard', 'LCONTROL')