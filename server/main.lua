ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('basia:revive')
AddEventHandler('basia:revive', function()
    TriggerClientEvent('esx_ambulancejob:revive', source)
end)

RegisterNetEvent('basia:pay')
AddEventHandler('basia:pay', function(data)
    xPlayer = ESX.GetPlayerFromId(source)


    if Config.removeMoney then
        if data == 10 then
            xPlayer.removeMoney(Config.money)
        elseif data == 20 then        
        xPlayer.removeAccountMoney('bank', Config.money)
        end
    else
        return
    end
end)

RegisterNetEvent('basia:revivepay')
AddEventHandler('basia:revivepay', function(data)
    xPlayer = ESX.GetPlayerFromId(source)
    if Config.removeMoney then
        if Config.revivefee then
            if data == 10 then
                xPlayer.removeMoney(Config.revivemoney)
            elseif data == 20 then
             xPlayer.removeAccountMoney('bank', Config.revivemoney)
          end
       else
            if data == 10 then
                xPlayer.removeMoney(Config.Money)
            elseif data == 20 then
        xPlayer.removeAccountMoney('bank', Config.money)
            end   
        end
    else
        return
    end
end)