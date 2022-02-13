local QBCore = exports['qb-core']:GetCoreObject()





SQL = function(query, parameters, cb)
    local res = nil
    local IsBusy = true
    exports.oxmysql:execute(query, parameters, function(result)
        if cb then
            cb(result)
        else
            res = result
            IsBusy = false
        end
    end)
    while IsBusy do
        Citizen.Wait(0)
    end
    return res
end

QBCore.Functions.CreateCallback('boosting:GetExpireTime', function(source, cb)
    local shit = (os.time() + 6 * 3600)
    cb(shit)
end)


QBCore.Functions.CreateCallback('boosting:getCurrentBNE', function(source, cb)
    local src = source
    local pData = QBCore.Functions.GetPlayer(src)
    local cid = pData.PlayerData.citizenid
    if pData ~= nil then
        local sql = SQL('SELECT * FROM boosting WHERE citizenid=@citizenid', {['@citizenid'] = cid})
        if sql[1] == nil then
            SQL('INSERT INTO boosting (citizenid) VALUES (?)',{cid})
            cb({BNE = 0, background = tostring(Config['Utils']["Laptop"]["DefaultBackground"]) , vin = nil})
        else
            if sql[1].BNE ~= nil then
                cb({BNE = sql[1].BNE , background = sql[1].background , vin = sql[1].vin})
            else
                cb({BNE = 0 , background =  tostring(Config['Utils']["Laptop"]["DefaultBackground"]) , vin = nil})
            end
        end
    end
end)

  




RegisterNetEvent("boosting:server:setBacgkround")
AddEventHandler("boosting:server:setBacgkround" , function(back)
    local src = source
    local pData = QBCore.Functions.GetPlayer(src)
    local cid = pData.PlayerData.citizenid
    local sql = SQL('UPDATE boosting SET background=@b WHERE citizenid=@citizenid', {['@citizenid'] = cid , ['@b'] = back})
end)

QBCore.Functions.CreateCallback('boosting:removeBNE', function(source, cb , amount)
    local src = source
    local pData = QBCore.Functions.GetPlayer(src)
    local cid = pData.PlayerData.citizenid
    if pData ~= nil then
        local sql = SQL('SELECT * FROM boosting WHERE citizenid=@citizenid', {['@citizenid'] = cid})
        if sql[1].BNE ~= nil then
            local pBNE = sql[1].BNE
            RemoveBNE(cid, pBNE, amount)
        else
            cb(0)
        end
    end
end)


QBCore.Functions.CreateCallback('boosting:addBne', function(source, cb , amount)
    local src = source
    local pData = QBCore.Functions.GetPlayer(src)
    local cid = pData.PlayerData.citizenid
    if pData ~= nil then
        local sql = SQL('SELECT * FROM boosting WHERE citizenid=@citizenid', {['@citizenid'] = cid})
        if sql[1].BNE ~= nil then
            local pBNE = sql[1].BNE
            local sql = SQL('UPDATE boosting SET BNE=@bne WHERE citizenid=@citizenid', {['@citizenid'] = cid , ['@bne'] = pBne + amount})
        else
            cb(0)
        end
    end
end)


QBCore.Functions.CreateCallback('boosting:server:checkVin', function(source, cb , data)
    local src = source
    local pData = QBCore.Functions.GetPlayer(src)
    local cid = pData.PlayerData.citizenid

    if pData ~= nil then
        local sql = SQL('SELECT * FROM boosting WHERE citizenid=@citizenid', {['@citizenid'] = cid})
        if(sql[1] ~= nil) then
            if(sql[1].vin == 0) then
                value = true
                SQL('UPDATE boosting SET vin=@vin WHERE citizenid=@citizenid', {['@citizenid'] = cid , ['@vin'] = os.time()})
            else
                local d1 = os.date("*t",   os.time())
                local d2 = os.date("*t", sql[1].vin)
                local zone_diff = os.difftime(os.time(d1), os.time(d2))
                if(math.floor(zone_diff  / 86400) >= Config['Utils']["VIN"] ["VinDays"]) then
                    cb(true)
                    SQL('UPDATE boosting SET vin=@vin WHERE citizenid=@citizenid', {['@citizenid'] = cid , ['@vin'] = os.time()})
                end
            end
        end
    end
end)


QBCore.Functions.CreateCallback('boosting:GetTimeLeft', function(source, cb , data)
        local shit = 2
        cb(shit)
    end)





RegisterServerEvent("boosting:joinQueue")
AddEventHandler("boosting:joinQueue", function()
  pSrc = source
  local Player = QBCore.Functions.GetPlayer(pSrc)
  local cid = Player.PlayerData.citizenid
  
    local result = SQL('SELECT * FROM boost_queue WHERE identifier = ?', {cid})
    if result[1] == nil then
      SQL("INSERT INTO boost_queue (identifier, pSrc) VALUES (@cid, @pSrc)", {['@cid'] = cid, ['@pSrc'] = pSrc })
	  print("added" .. " " .. "CID: " .. cid .. " " .."ID:".. pSrc .. " " .. "to boosting queue") 
    else
      print(cid.." already in queue")
    end
end)

RegisterServerEvent('boosting:leaveQueue')
AddEventHandler('boosting:leaveQueue', function()
  pSrc = source
  local Player = QBCore.Functions.GetPlayer(pSrc)
  local cid = Player.PlayerData.citizenid
  
    local result = SQL('SELECT * FROM boost_queue WHERE identifier = ?', {cid})
    if result[1] ~= nil then
      SQL("DELETE FROM boost_queue WHERE `identifier` = @cid", {['@cid'] = cid})
      print("removed" .. " " .. "CID: " .. cid .. " " .."ID:".. pSrc .. " " .. "from boosting queue") 
    end
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(Config['Utils']["Contracts"]["TimeBetweenContracts"])
    local result = SQL('SELECT * FROM boost_queue',{})
      if #result ~= 0 then
        local random = math.random(1, #result)
        if result[random] ~= nil then
          local pSrc = result[random].pSrc
          local cid = result[random].identifier
		  local shit = math.random(1,10)
          local DVTen = Config['Utils']["Contracts"]["ContractChance"] / 10
          if(shit <= DVTen) then
          TriggerClientEvent('boosting:CreateContract', pSrc, true)
		  else
		  TriggerClientEvent('boosting:CreateContract', pSrc)
		  end
        end
      end
  end
end)

RegisterServerEvent('boosting:transfercontract')
AddEventHandler('boosting:transfercontract', function(contract, target)
    TriggerClientEvent('boosting:ReceiveContract', target, contract)
end)
    
  

---------------- Cop Blip Thingy ------------------



RegisterServerEvent('boosting:alertcops')
AddEventHandler('boosting:alertcops', function(cx,cy,cz)
    for k, v in pairs(QBCore.Functions.GetPlayers()) do
        local Player = QBCore.Functions.GetPlayer(v)
        if Player ~= nil then
            if Player.PlayerData.job.name == Config['General']["PoliceJobName"] then
                TriggerClientEvent('boosting:setcopblip', Player.PlayerData.source, cx,cy,cz)
            end
        end
    end
end)




RegisterServerEvent('boosting:AddVehicle')
AddEventHandler('boosting:AddVehicle', function(model, plate, vehicleProps)
    local src = source
    local vehicle = model
    local pData = QBCore.Functions.GetPlayer(src)
    local cid = pData.PlayerData.citizenid
        exports.oxmysql:insert('INSERT INTO player_vehicles (license, citizenid, vehicle, hash, mods, plate, state) VALUES (?, ?, ?, ?, ?, ?, ?)', {
            pData.PlayerData.license,
            cid,
            vehicle,
            GetHashKey(vehicle),
            vehicleMods = vehicleMods,
            plate,
            0
        })
end)



RegisterServerEvent('boosting:removeblip')
AddEventHandler('boosting:removeblip', function()
    for k, v in pairs(QBCore.Functions.GetPlayers()) do
        local Player = QBCore.Functions.GetPlayer(v)
        if Player ~= nil then
            if Player.PlayerData.job.name == Config['General']["PoliceJobName"] then
                TriggerClientEvent('boosting:removecopblip', Player.PlayerData.source)
            end
        end
    end
end)

RegisterServerEvent('boosting:SetBlipTime')
AddEventHandler('boosting:SetBlipTime', function()
    for k, v in pairs(QBCore.Functions.GetPlayers()) do
        local Player = QBCore.Functions.GetPlayer(v)
        if Player ~= nil then
            if Player.PlayerData.job.name == Config['General']["PoliceJobName"] then
                TriggerClientEvent('boosting:setBlipTime', Player.PlayerData.source)
            end
        end
    end
end)

  


RegisterNetEvent('boosting:finished')
AddEventHandler('boosting:finished' , function()
    local src = source
    local ply = QBCore.Functions.GetPlayer(src)                   
    local worthamount = math.random(13000, 17000)
    local info = {
        worth = worthamount
    }
    if Config['Utils']["Rewards"]["Type"] == 'item' then
        ply.Functions.AddItem(Config['Utils']["Rewards"]["RewardItemName"], 1, false, info)
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items[Config['Utils']["Rewards"]["RewardItemName"]], "add")
    elseif Config['Utils']["Rewards"]["Type"] == 'money' then
        ply.Functions.AddMoney("bank",Config['Utils']["Rewards"]["RewardMoneyAmount"],"boosting-payment")
    end
end)


QBCore.Functions.CreateUseableItem("pixellaptop", function(source, item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.Functions.GetItemByName(item.name) then
        TriggerClientEvent("boosting:DisplayUI", source)
    end
end)





RegisterNetEvent('boosting:usedlaptop')
AddEventHandler('boosting:usedlaptop' , function()
    TriggerClientEvent("boosting:DisplayUI", source)
end)

RegisterNetEvent('boosting:useddisabler')
AddEventHandler('boosting:useddisabler' , function()
    TriggerClientEvent("boosting:DisablerUsed", source)
end)


QBCore.Functions.CreateUseableItem("disabler", function(source, item)
        local Player = QBCore.Functions.GetPlayer(source)
        if Player.Functions.GetItemByName(item.name) then
            TriggerClientEvent("boosting:DisablerUsed", source)
        end
end)



QBCore.Functions.CreateCallback('boosting:server:GetActivity', function(source, cb)
    local PoliceCount = 0
    for k, v in pairs(QBCore.Functions.GetPlayers()) do
        local Player = QBCore.Functions.GetPlayer(v)
        if Player ~= nil then 
            if (Player.PlayerData.job.name == Config['General']["PoliceJobName"] and Player.PlayerData.job.onduty) then
                PoliceCount = PoliceCount + 1
            end
        end
    end
    cb(PoliceCount)
end)



RegisterNetEvent('boosting:server:synccontracts')
AddEventHandler('boosting:server:synccontracts' , function(OtherUserContracts)
	syncedcontracts = OtherUserContracts
end)

QBCore.Functions.CreateCallback('boosting:getusercontracts', function(source, cb, target)
    TriggerClientEvent('boosting:client:synccontracts', target)
    Citizen.Wait(1000)
    cb(syncedcontracts)
end)


local color_msg = 195000

RegisterNetEvent('boosting:logs')
AddEventHandler('boosting:logs' , function(class, vehiclename)
	sendToDiscordBoostingLogs(class, discord_msg, color_msg,identifier)
end)

function sendToDiscordBoostingLogs(class,message,color,identifier)
    local src = source
    local name = GetPlayerName(src)
    if not color then
        color = color_msg
    end
    local sendD = {
        {
            ["color"] = color,
            ["title"] = message,
            ["description"] = "`Player Recieved a new contract with the class of`: **"..name.."**\nSteam: **"..identifier.steam.."** \nIP: **"..identifier.ip.."**\nDiscord: **"..identifier.discord.."**\nFivem: **"..identifier.license.."**",
            ["footer"] = {
                ["text"] = "Â© </BroPixel > - "..os.date("%x %X %p")
            },
        }
    }

    PerformHttpRequest(logs, function(err, text, headers) end, 'POST', json.encode({username = "</BroPixel > - boosting", embeds = sendD}), { ['Content-Type'] = 'application/json' })
end

local authorized = true

RegisterNetEvent('boosting:loadNUI')
AddEventHandler('boosting:loadNUI' , function()
    local source = source
    TriggerClientEvent('boosting:StartUI', source)
end)


RegisterServerEvent("boosting:CallCopsNotify" , function(plate , model , color , streetLabel)
    for k, v in pairs(QBCore.Functions.GetPlayers()) do
        local src = source
        local Ped = GetPlayerPed(src)
        local PlayerCoords = GetEntityCoords(Ped)
        local Player = QBCore.Functions.GetPlayer(src)
        if Player ~= nil then
            if Player.PlayerData.job.name == Config['General']["PoliceJobName"] then
                TriggerEvent(
                "core_dispatch:addCall",
                "10-34", -- Change to your liking
                "Possible Vehicle Boosting", -- Change to your liking
                {
                    {icon = "car", info = model},
                    {icon = "fa-map-pin", info = streetLabel},
        {icon = "fa-map-pin", info = plate},
        {icon = "fa-map-pin", info = color}

                },
                {PlayerCoords[1], PlayerCoords[2], PlayerCoords[3]},
                "police", -- Job receiving alert
                5000, -- Time alert stays on screen
                458, -- Blip Icon
                3 -- Blip Color
            )
            end
        end
    end
end)
