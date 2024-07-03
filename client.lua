
RegisterNetEvent('frakinvite:sendInvite')
AddEventHandler('frakinvite:sendInvite', function(inviterId,xjobname)
    SetNuiFocus(true, true)
   
    SendNUIMessage({
        type = "showInvite",
        inviterId = inviterId,
        jobname = xjobname
    })
end)

RegisterNetEvent('frakinvite:closeUI')
AddEventHandler('frakinvite:closeUI', function(inviterId,xjobname)
    SetNuiFocus(false, false)
   
    SendNUIMessage({
        type = "close",
    })
end)


RegisterNUICallback('acceptInvite', function(data, cb)
  
    TriggerServerEvent('frakinvite:handleInvite', data,true)
    SetNuiFocus(false, false)
end)

RegisterNUICallback('declineInvite', function(data, cb)
   
    TriggerServerEvent('frakinvite:handleInvite', data,false)
    SetNuiFocus(false, false)
end)