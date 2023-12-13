ServerCallbacks = {}
CurrentRequestId = 0
vRP = Proxy.getInterface("vRP")

vRPSgarage = {}
Tunnel.bindInterface("vsGarages", vRPSgarage)
Proxy.addInterface("vsGarages", vRPSgarage)
vRPSgarage = Tunnel.getInterface("vsGarages", "vsGarages")

local config = module(GetCurrentResourceName(), "config")
local garages = config.garages
local garage_types = config.garage_types

function TriggerServerCallback(name, cb, ...)
    ServerCallbacks[CurrentRequestId] = cb
    TriggerServerEvent(GetCurrentResourceName() .. ':triggerServerCallback', name, CurrentRequestId, ...)
    if CurrentRequestId < 65535 then
        CurrentRequestId = CurrentRequestId + 1
    else
        CurrentRequestId = 0
    end
end

RegisterNetEvent(GetCurrentResourceName() .. ':serverCallback')
AddEventHandler(GetCurrentResourceName() .. ':serverCallback', function(requestId, ...)
    ServerCallbacks[requestId](...)
    ServerCallbacks[requestId] = nil
end)



for k, v in pairs(garages) do
    if garage_types[v[1]] ~= nil then
        vRP.addBlip({ v[2], v[3], v[4], garage_types[v[1]]._config.blipid, garage_types[v[1]]._config.blipcolor, v[1] })
    end
end

local textui = false
Citizen.CreateThread(function()
    Wait(150)

    while true do
        tick = 500
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped, true)
        for k, v in pairs(garages) do
            if (GetDistanceBetweenCoords(pos.x, pos.y, pos.z, v[2], v[3], v[4]) < 15.0) then

                tick = 1
                DrawMarker(25, v[2], v[3], v[4] - 0.95, 4, 9, 9, 9, 9, 9, 2.0001, 2.0001, 0.0000, 255, 255, 255, 200, false, 0, 
                    0,
                    true)
                if (GetDistanceBetweenCoords(pos.x, pos.y, pos.z, v[2], v[3], v[4]) < 2) then
                    if textui == true then
                        exports['vrp_textui']:Open('Apasa [E] pentru a accesa garajul', 'darkblue', 'left')
                        textui = false
                    end
                    --job_DisplayHelpText("Apasa E pentru a deschide " .. v[1] .. "!")
                    if IsControlJustPressed(0, 38) then

                        exports['vrp_textui']:Close()
                        textui = true
                        TriggerServerCallback("getuvehs", function(vehs)
                            DisplayRadar(false)
                            tabelmasini = {}

                            for k1, v1 in pairs(vehs) do


                                local speed = math.ceil(GetVehicleModelEstimatedMaxSpeed(v1.vehicle) * 5)

                                if type(garage_types[v[1]][v1.vehicle]) == "table" then

                                    table.insert(tabelmasini,
                                        { garage_types[v[1]][v1.vehicle][1], v1.vehicle_plate, v1.vehicle, speed,
                                            garage_types[v[1]][v1.vehicle][4] })
                                    --print(garage_types[v[1]][v1.vehicle][1])
                                    -- print(speed)
                                end
                            end
                            SetDisplay(true, tabelmasini)
                        end)

                    end
                    --SetDisplay(true)

                else
                    exports['vrp_textui']:Close()
                    textui = true
                end
            end
        end
        Citizen.Wait(tick)


    end
end)

function SetDisplay(bool, masina1, pret1, prettt)
    display = bool
    SetNuiFocus(bool, bool)



    SendNUIMessage({
        type = "ui",
        status = bool,
        masini = masina1,
    })

end

RegisterNUICallback("exit", function()

    DisplayRadar(true)
    SetDisplay(false)
    tabelmasini = {}
end)



RegisterNUICallback("spawnvehicle", function(data)

    tabelmasini = {}
    vRP.spawnGarageVehicle({ data.plate, data.veh, data.plate })
    DisplayRadar(true)
    SetDisplay(false)

end)
