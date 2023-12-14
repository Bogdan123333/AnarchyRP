vRP = Proxy.getInterface("vRP")
vRPserver = Tunnel.getInterface("illusion_banking", "illusion_banking")

local inMenu = false

Citizen.CreateThread(function()
    local ticks = 1000
    local inZona, shown = false, false
    while true do
        local ped = PlayerPedId()
        local pedcoords = GetEntityCoords(ped)
        for i = 1, #Config.Banci do
            local coordonate = Config.Banci[i].coords
            if #(coordonate - pedcoords) <= 5 then
                ticks = 0
                if Config.Setari.Marker then
                    r, g, b, a = table.unpack(Config.Setari.Culori)
                    DrawMarker(21, coordonate, 0, 0, 0, 0, 0, 0, 0.6, 0.6, 0.6, r, g, b, a, 1, 0, 0, 1)
                end
                if #(coordonate - pedcoords) <= 2 then
                    inZona = true
                    if IsControlJustPressed(0, 38) then
                        OpenMenu()
                    end
                end
            end
        end
        if Config.Setari.OkOkTextUI then
            if inZona and not shown and not inMenu then
                exports["okokTextUI"]:Open("Apasa [E] Pentru a deschide meniul", "darkblue", "left")
                shown = true
            elseif not inZona and shown or inMenu then
                exports["okokTextUI"]:Close()
                shown = false
            end
        else
            if inZona and not shown and not inMenu then
                ShowHelpNotification("Apasa ~INPUT_CONTEXT~ Pentru a deschide meniul.")
                shown = true
            end
        end
        Wait(ticks)
        ticks = 1000
        inZona = false
        shown = false
    end
end)

if Config.Setari.Blip then
    Citizen.CreateThread(function()
        for i = 1, #Config.Banci do
            local blipdata = Config.Banci[i]
            blip = AddBlipForCoord(blipdata.coords)
            SetBlipSprite(blip, blipdata.blipid)
            SetBlipDisplay(blip, 4)
            SetBlipScale(blip, blipdata.blipscale)
            SetBlipColour(blip, blipdata.blipcolor)
            SetBlipAsShortRange(blip, true)
    		BeginTextCommandSetBlipName("STRING")
    		AddTextComponentString(blipdata.bliptext)
    		EndTextCommandSetBlipName(blip)
        end
    end)
end

function OpenMenu()
    inMenu = true
    SetNuiFocus(true, true)
    vRPserver.getInfo({}, function(data)
        SendNUIMessage({
            action = "openMenuBanking",
            iban = data.iban,
            balance = data.balance
        })
    end)
end

function CloseMenu()
    inMenu = false
    SetNuiFocus(false, false)
end

function ShowHelpNotification(mesaj)
    AddTextEntry(GetCurrentResourceName(), mesaj)
    DisplayHelpTextThisFrame(GetCurrentResourceName(), false)
end

RegisterNUICallback("close", function()
    CloseMenu()
end)

RegisterNUICallback("getBalance", function(_, cb)
    vRPserver.getInfo({}, function(data)
        cb(data.balance)
    end)
end)

RegisterNUICallback("bank", function(data)
    TriggerServerEvent("banking:Action", data)
end)