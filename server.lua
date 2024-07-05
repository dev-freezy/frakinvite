pendingInvites = {}



RegisterCommand('frakinvite', function(source, args)
    local xPlayer = ESX.GetPlayerFromId(source)
    local job = xPlayer.getJob()
    local grade = xPlayer.getJob().grade
    local targetId = tonumber(args[1])
    local xTarget = ESX.GetPlayerFromId(targetId)
    if xTarget then
        if targetId ~= source then
            if isPlayerDead(targetId) == false then
                if not pendingInvites[targetId] then
                    if config.allowedGrades[job.name] <= grade then
                        local targetJob = xTarget.getJob().name
                        if xTarget.getJob().name == config.unemployedname then
                                if targetJob ~= job.name then
                                    TriggerClientEvent('frakinvite:sendInvite', targetId, xPlayer ,job)
                                    pendingInvites[xTarget.source] = job
                                    config.sendNotify(source,"success","Frakinvite","Einladung erfolgreich verschickt!",5000)
                                else
                                    config.sendNotify(source ,"warning","Frakinvite","Dieser Spieler ist bereits in deiner fraktion",5000)
                                end
                        else
                            config.sendNotify(source,"warning","Frakinvite","Der Spieler hat breits einen job",5000)
                        end
                    else
                        config.sendNotify(source,"warning","Frakinvite","Dein Fraktionsrang ist nicht hochgenug um jemanden einzuladen",5000) 
                    end
                else
                    config.sendNotify(source,"warning","Frakinvite","Du hast bereits eine Einladung",5000)
                end
            else
                config.sendNotify(source,"warning","Frakinvite","Diesen Spieler geht es gerade nicht so gut",5000)
            end

        else
            config.sendNotify(source,"warning","Frakinvite","Du kannst dich nicht selber einladen",5000)
        end
    else
        config.sendNotify(source,"warning","Frakinvite", "Keine gültige ID eigegeben.", 5000)      
    end

end, false)








RegisterServerEvent('frakinvite:handleInvite')
AddEventHandler('frakinvite:handleInvite', function(data,accept)
    local xPlayer = ESX.GetPlayerFromId(source)
    local inviterID = data.inviterId
    local jobname = data.jobname
    if xPlayer then
        if pendingInvites[source] then
            
            if accept then
                xPlayer.setJob(pendingInvites[source],0)
                config.sendNotify(source ,"success", "Frakinvite", "Du hast den Job erfolgreich angenommen!", 5000)
                if ESX.GetPlayerFromId(inviterID) then
                    config.sendNotify(inviterID , "warning", "Frakinvite", "Der Spieler " .. xPlayer.getName() .. " hat deine Frations einladung angenommen!", 5000)
                end
            else
                config.sendNotify(source, "info","Frakinvite","Du hast den invite von der Fraktion  " .. jobname .. " abgelehnt!",5000)
                if ESX.GetPlayerFromId(inviterID) then
                    config.sendNotify(inviterID ,  "warning", "Frakinvite", "Der Spieler " .. xPlayer.getName() .. " hat deine Frations einladung abgelehnt!", 5000)
                end
            end
            clearPending(source)
        end
    end 

end)





AddEventHandler('playerDropped', function(reason)
    clearPending(source)
end)






AddEventHandler('esx:onPlayerDeath', function(data)
   TriggerClientEvent("frakinvite:closeUI",source)
   clearPending(source)
end)

function clearPending(id)
    if pendingInvites[id] then
        pendingInvites[id] = nil
   end
end


function isPlayerDead(netId)
    local ped = GetPlayerPed(netId)
    local health = GetEntityHealth(ped)
    return health <= 0
end


