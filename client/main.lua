ESX = nil
local PlayerData = {}

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj)
            ESX = obj
        end)
        Citizen.Wait(Config.Wait)
    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(30)

        local ped = GetPlayerPed(-1)
        local vector = vector3(Config.interactcoords.x, Config.interactcoords.y, Config.interactcoords.z)
        local vector = vector3(Config.szpitalsandy.x, Config.szpitalsandy.y, Config.szpitalsandy.z)
        local playercoord = GetEntityCoords(ped)

        if Vdist2(vector, playercoord) < 5 then

			
			if IsControlJustPressed(1, Config.activatebutton) then
	
				OpenPayMenu()

            end
        end
    end
end)


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(30)

        local ped = GetPlayerPed(-1)
        local vector = vector3(Config.interactcoords.x, Config.interactcoords.y, Config.interactcoords.z)
        local vector = vector3(Config.szpitalsandy.x, Config.szpitalsandy.y, Config.szpitalsandy.z)
        local playercoord = GetEntityCoords(ped)

        if Vdist2(vector, playercoord) < 5 then

			Citizen.Wait(1000)
            xPlayer.ShowNotification('Kliknij E aby się uleczyć')
           -- exports.mythic_notify:DoHudText('Inform', _U('powitanie_msg'))
			Citizen.Wait(3000)
			
			if IsControlJustPressed(1, Config.activatebutton) then
	
				OpenPayMenu()

            end
        end
    end
end)




function OpenPayMenu()
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'plc', {
		title = "Doktorek",
		allign = 'top-right',
		elements = {
			{label = "pieniadze", value = '10'},
			{label = "karta", value = '20'}
		}
	},  function(data, menu)

		if data.current.value == '10' then 
		       TriggerEvent('basia:heal', 10)
		  elseif data.current.value == '20' then
		      TriggerEvent('basia:heal', 20)
		 end
 end,  function(data, menu)
      menu.close()
   end)
 end

AddEventHandler('basia:heal', function(data)
	
	local ped = GetPlayerPed(-1)
	
	FreezeEntityPosition(ped, true)


    TriggerEvent("esx:showNotification","Doktor cię leczy")

	Citizen.Wait(Config.Wait)

    TriggerEvent("esx:showNotification","Poczekaj 15 sekund")

	Citizen.Wait(Config.Wait)

    TriggerEvent("esx:showNotification","Poczekaj 10 sekund")
	Citizen.Wait(Config.Wait)

    TriggerEvent("esx:showNotification","Poczekaj 5 sekund")

	Citizen.Wait(Config.Wait)

    TriggerEvent("esx:showNotification","Doktor cie uleczyl")

	FreezeEntityPosition(ped, false)

	TriggerServerEvent('basia:revive')


	if GetEntityHealth(ped) == 0 then
		TriggerServerEvent('basia:revivepay', data)
	elseif GetEntityHealth(ped) >= 20 then
		TriggerServerEvent('basia:pay', data)
	end
end)

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(7)
            for i = 1, #BlipOdBaski, 1 do
                loc = BlipOdBaski[i]
                DrawMarker(
                    loc.marker,
                    Config.interactcoords.x,
                    Config.interactcoords.y,
                    Config.interactcoords.z-0.75,
                    0.0,
                    0.0,
                    0.0,
                    0.0,
                    0.0,
                    0.0,
                    loc.scale,
                    loc.scale,
                    loc.scale,
                    loc.rgba[1],
                    loc.rgba[2],
                    loc.rgba[3],
                    loc.rgba[4],
                    false,
                    true,
                    2,
                    nil,
                    nil,
                    false
                )
                DrawMarker(
                    loc.marker,
                    Config.szpitalsandy.x,
                    Config.szpitalsandy.y,
                    Config.szpitalsandy.z-0.75,
                    0.0,
                    0.0,
                    0.0,
                    0.0,
                    0.0,
                    0.0,
                    loc.scale,
                    loc.scale,
                    loc.scale,
                    loc.rgba[1],
                    loc.rgba[2],
                    loc.rgba[3],
                    loc.rgba[4],
                    false,
                    true,
                    2,
                    nil,
                    nil,
                    false
                )
                if loc.submarker ~= nil then DrawMarker(
                    loc.submarker.marker,Config.interactcoords.x,Config.interactcoords.y,loc.submarker.posz,
                    loc.submarker.marker,Config.szpitalsandy.x,Config.szpitalsandy.y,loc.submarker.posz,
					
                    0.0,0.0,0.0,0.0,0.0,0.0,
                    loc.scale/2,loc.scale/2,loc.scale/2,
                    loc.rgba[1],loc.rgba[2],loc.rgba[3],loc.rgba[4],
                    false,true,2,nil,nil,false) end
                local playerCoord = GetEntityCoords(PlayerPedId(), false)
                if Vdist2(playerCoord, locVector) < loc.scale*1.12 and GetVehiclePedIsIn(PlayerPedId(), false) == 0 then
                    SetEntityHeading(PlayerPedId(), 0)    
                end
            end
        end
    end
)
BlipOdBaski = {
    {
        pos={ Config.interactcoords.x, Config.interactcoords.y, Config.interactcoords.z	},
        
		marker= 27,
        scale = 2.0,
        rgba = {120, 255, 120,155}
	},
    {
        pos={ Config.szpitalsandy.x, Config.szpitalsandy.y, Config.szpitalsandy.z	},
        
		marker= 27,
        scale = 2.0,
        rgba = {120, 255, 120,155}
	}
}