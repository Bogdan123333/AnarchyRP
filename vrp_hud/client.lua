Citizen.CreateThread(function()
  while true do
      Citizen.Wait(1000)
          TriggerServerEvent('GetAlexxInfo')
  end
end)


RegisterNetEvent('Lsv1:updategetPlayers', function(newPlayers)
  SendNUIMessage({action = "setValue", divId = "players", value = newPlayers.." / 250"})
end)

RegisterNetEvent('Lsv1:updateID', function(newId)
  SendNUIMessage({action = "setValue", divId = "info-id", value = ""..newId})
end)

RegisterNetEvent("hud:updateGreenZone", function(bool)
    SendNUIMessage({ action = "setSafeZone", display = bool });
end);

RegisterNetEvent('Lsv1:updateMoney', function(newBani)
  SendNUIMessage{action = "setValue", divId = "info-cash", value = newBani..""}
end)

RegisterNetEvent('Lsv1:updateMoneyBank', function(newBBani)
  SendNUIMessage{action = "setValue", divId = "info-bank", value = newBBani..""}
end)

RegisterNetEvent('Lsv1:updateMoneyCoins', function(newCoins)
   SendNUIMessage{action = "setValue", divId = "info-coins", value = newCoins.." "}
end)

local jucatoriOnline = 0
RegisterNetEvent('Lsv1:updateConnectedPlayers')
AddEventHandler('Lsv1:updateConnectedPlayers',function(connectedPlayers)
    jucatoriOnline = connectedPlayers
end)
Citizen.CreateThread(function()
	while true do
        Wait(1)
        SendNUIMessage({
            action = 'updateOnlinePlayers',
            players = jucatoriOnline       
         })
        Citizen.Wait(1500)
	end
end)

RegisterNetEvent("hud:setStaff", function()
    SendNUIMessage({ action = "setStaff" });
end);

CreateThread(function()
    while true do
      local viata = GetEntityHealth(PlayerPedId())
      SendNUIMessage({action = "update", part = "viata", value = viata - 100});
      Citizen.Wait(2000)
    end
  end)


  Citizen.CreateThread(function()
    while true do
        playerArmor = GetPedArmour(_GPED)
        Citizen.Wait(2000)
        SendNUIMessage({action = "update", part = "armura", value = playerArmor});
    end
  end)

  
_GPED = PlayerPedId()
_PLAYERCOORDS = GetEntityCoords(_GPED)


RegisterNetEvent("hud:sendAdminAnn", function(pName, uidd, mess)
    print("awdadw")
    SendNUIMessage({ action = "sendAdminAnn", name = pName, uid = uidd, mes = mess });
end);

RegisterNetEvent("alpha:TicketsUpdate", function(tks)
    SendNUIMessage({ action = "update", part = "ticketsNum", value = tks });
end);

  
  RegisterNetEvent("hud:Frame", function(v)
    SendNUIMessage({ togHud = v, wy = "frame" });
  end);
  

RegisterCommand("hud", function()
  SendNUIMessage({
      type = "togglehud",
  })
end)

RegisterKeyMapping("hud", "Toggle Hud", "keyboard", "F1")


Citizen.CreateThread(function()
  ReplaceHudColourWithRgba(116, 19, 107, 255, 0.8)
  SetMapZoomDataLevel(0, 1.6, 0.9, 0.08, 0.0, 0.0) -- Level 0
  SetMapZoomDataLevel(1, 1.6, 0.9, 0.08, 0.0, 0.0) -- Level 1
  SetMapZoomDataLevel(2, 8.6, 0.9, 0.08, 0.0, 0.0) -- Level 2
  SetMapZoomDataLevel(3, 12.3, 0.9, 0.08, 0.0, 0.0) -- Level 3
  SetMapZoomDataLevel(4, 22.3, 0.9, 0.08, 0.0, 0.0) -- Level 4
  SetMapZoomDataLevel(5, 55.0, 0.0, 0.1, 2.0, 1.0) -- ZOOM_LEVEL_GOLF_COURSE
  SetMapZoomDataLevel(6, 450.0, 0.0, 0.1, 1.0, 1.0) -- ZOOM_LEVEL_INTERIOR
  SetMapZoomDataLevel(7, 4.5, 0.0, 0.0, 0.0, 0.0) -- ZOOM_LEVEL_GALLERY
  SetMapZoomDataLevel(8, 11.0, 0.0, 0.0, 2.0, 3.0) -- ZOOM_LEVEL_GALLERY_MAXIMIZE
  while true do
      if IsPedOnFoot(PlayerPedId()) then 
          SetRadarZoom(1100)
      elseif IsPedInAnyVehicle(PlayerPedId(), true) then
          SetRadarZoom(1100)
      end

      Citizen.Wait(5)
  end
end)