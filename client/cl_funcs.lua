----------------------------------------------------------------------------------------------------------------------------

local QBCore = exports['qb-core']:GetCoreObject()


----------------------------------------------------------------------------------------------------------------------------

BNEBoosting = {}


BNEBoosting['functions'] = {
    GetCurrentBNE = function()
        
            QBCore.Functions.TriggerCallback('boosting:getCurrentBNE', function(amount)
                value =  amount.BNE
                background =  amount.background
            end)
            Wait(200)
            return ({bne = value ,back =  background})
        
    end,
    RemoveBNE = function(amount)
            QBCore.Functions.TriggerCallback('boosting:removeBNE', function(amount) 
                end , amount)
                Wait(200)
            return true
    end,
    SetBackground = function(backgroundurl)
        TriggerServerEvent("boosting:server:setBacgkround" , backgroundurl)
    end,

    AddBne = function(amount)
            QBCore.Functions.TriggerCallback('boosting:addBne', function(amount)
                end , amount)
                Wait(200)
            return true
    end,
}