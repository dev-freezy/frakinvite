
RegisterNetEvent('frakinvite:sendInvite')
AddEventHandler('frakinvite:sendInvite', function(inviter,job)
    SetNuiFocus(true, true)
   
    SendNUIMessage({
        type = "showInvite",
        inviterId = inviter.source,
        inviterName = inviter.name,
        joblabel = job.label,
        jobname = job.name
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