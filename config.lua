config = {}

config.unemployedname = "unemployed"
config.allowedGrades = {
    ["police"] = 1,
    ["ambulance"] = 7,
    ["fib"] = 5
}



config.sendNotify = function(player,type, title ,message,time)
    TriggerClientEvent('b_notify', player ,type, title, message, time)
end






