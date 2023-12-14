vRP = Proxy.getInterface("vRP")
vRPserver = Tunnel.getInterface("vRP","esk_dealership")
vRPds = Tunnel.getInterface("esk_dealership","esk_dealership")
vRPdsC = {}
Tunnel.bindInterface("esk_dealership",vRPdsC)
vRPSds = Tunnel.getInterface("esk_dealership","esk_dealership")


local inShowroom = false
local inTesting = false
local showroomID = nil
local testVehicle = nil
local cam = nil

-- local inRemat = false;
-- RegisterNetEvent('vRP:openRemat',function(bool)
--     inRemat = bool;
-- end)

-- CreateThread(function()
--     while true do
--         while (#(GetEntityCoords(PlayerPedId()) - vector3(-39.115673065186,-1099.5111083984,26.422344207764)) <= 2.0) do
--             exports['vrp_textui']:Open("[E] - Remat", "left", "darkblue");
--             if IsControlJustPressed(0, 38) then
--                 TriggerServerEvent('rematVehicle')
--                 exports['vrp_textui']:Close();
--             end

--             Wait(1);
--         end
--         Wait(800)
--     end
-- end)

function findNearestDealership()
    local player = GetPlayerPed(-1)
	local playerloc = GetEntityCoords(player, 0)

	for k, v in pairs(config.dealerships) do
		local distance = #(v.coordsPed - playerloc);

		if distance <= 3 then
			return true, k, v.name;
		end
	end
end

CreateThread(function()
    for k,v in pairs (config.dealerships) do 
        RequestModel(v.ped)
        while not HasModelLoaded(v.ped) do
          Wait(1)
        end
		shPed = CreatePed(4, v.ped,v.coordsPed,v.heading,false,true)
		FreezeEntityPosition(shPed, true)
		SetEntityInvincible(shPed, true)
		SetBlockingOfNonTemporaryEvents(shPed, true)
        -- blip
        local blip = AddBlipForCoord(v.coordsPed)
        SetBlipSprite(blip, v.blipid)
        SetBlipAsShortRange(blip, true)
        SetBlipColour(blip, 2)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(v.name)
        EndTextCommandSetBlipName(blip)
    end
    local inRange = false;
    while true do 
        local sleep = config.defaultWaitTime
        local ok, showroom,shName = findNearestDealership();
        if ok then 
            inRange = true;
            sleep = 5;
            exports['vrp_textui']:Open("[E] - "..shName, 'darkblue', 'left');
            if IsControlJustPressed(0, 38) then
                exports['vrp_textui']:Close();
                openShowroom(showroom)
            end
        end
        
        if inRange and not ok then
            inRange = false;
            exports['vrp_textui']:Close()
        end

        Wait(sleep)
    end
end)

openShowroom = function(id)
    SetEntityVisible(PlayerPedId(), false)
    SetEntityCoords(PlayerPedId(),config.dealerships[id].coordsVehicle)
    inShowroom = true
    showroomID = id
    inTestingTime = 0
    cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    TriggerServerEvent('enterCx')
    if config.dealerships[id].type == "car" then
        SetCamCoord(cam, config.dealerships[id].coordsCam[1], config.dealerships[id].coordsCam[2], config.dealerships[id].coordsCam[3])
        PointCamAtCoord(cam, config.dealerships[id].coordsVehicle[1]+1.0, config.dealerships[id].coordsVehicle[2]+1.0, config.dealerships[id].coordsVehicle[3])
        RenderScriptCams(1, 0, 0, 1, 1)
    elseif config.dealerships[id].type == "air" then 
        SetCamCoord(cam, config.dealerships[id].coordsCam[1], config.dealerships[id].coordsCam[2], config.dealerships[id].coordsCam[3])
        PointCamAtCoord(cam, config.dealerships[id].coordsVehicle[1], config.dealerships[id].coordsVehicle[2], config.dealerships[id].coordsVehicle[3])
        RenderScriptCams(1, 0, 0, 1, 1)
    elseif config.dealerships[id].type == "boat" then 
        SetCamCoord(cam, config.dealerships[id].coordsCam[1], config.dealerships[id].coordsCam[2], config.dealerships[id].coordsCam[3])
        PointCamAtCoord(cam, config.dealerships[id].coordsVehicle[1], config.dealerships[id].coordsVehicle[2], config.dealerships[id].coordsVehicle[3])
        RenderScriptCams(1, 0, 0, 1, 1)
    end

    SetNuiFocus(true, true)
    
    vRPSds.getAllVehicleStocks({},function(server_stocks)
        local _GSTOCKS = server_stocks
        SendNUIMessage({
            action = "openShowroonJS",
            sh_name = config.dealerships[id].name,
            sh_type = config.dealerships[id].type,
            veh_table = config.dealerships[id].vehicles,
            veh_stocks = server_stocks
        })
        --print(json.encode(server_stocks))
    end)
end

function ShowHelpNotification(text)
    SetTextComponentFormat("STRING")
    AddTextComponentString(text)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

--NUI

RegisterNUICallback('closeShowroom', function(data, cb)
    DestroyCam(cam, false)
    SetCamActive(cam, false)
    RenderScriptCams(0, false, 100, false, false)
    SetNuiFocus(false, false)

    rablactuala = GetVehiclePedIsUsing(PlayerPedId())
    DeleteEntity(rablactuala)
    TriggerServerEvent('leaveCx')
    SetEntityCoords(PlayerPedId(),config.dealerships[showroomID].coordsPed[1]-1.0, config.dealerships[showroomID].coordsPed[2], config.dealerships[showroomID].coordsPed[3])

    inShowroom = false
    showroomID = nil
    SetEntityVisible(PlayerPedId(), true)
end)


RegisterNUICallback('changeVehicleColors', function(data, cb)
    if inShowroom then
        r, g, b = data.colours[1]:match("([^,]+),([^,]+),([^,]+)")
        rablactuala = GetVehiclePedIsUsing(PlayerPedId())
        if rablactuala ~= nil then
            SetVehicleCustomPrimaryColour(rablactuala, tonumber(r),tonumber(g),tonumber(b))
        end
    end
end)


RegisterNUICallback('spawnTheVehicle', function(data, cb)
    for k,v in pairs (config.dealerships[showroomID]["vehicles"][data.selectedCat]) do 
        if v.vehID == data.id then 
            model = v.spawncode
            RequestModel(model)
            local timpfake = 0
            while not HasModelLoaded(model) and timpfake < 500 do
                Wait(0)
                SetNuiFocus(false, false)
                timpfake = timpfake + 1
            end
            SetNuiFocus(true, true)
            rablactuala = GetVehiclePedIsUsing(PlayerPedId())
            if rablactuala == nil then
                local nveh = CreateVehicle(model, config.dealerships[showroomID].coordsVehicle[1], config.dealerships[showroomID].coordsVehicle[2], config.dealerships[showroomID].coordsVehicle[3], 220.0, false, false)
                SetPedIntoVehicle(PlayerPedId(),nveh,-1)
                SetVehicleEngineOn(nveh,false,false,0)
                SetVehicleDirtLevel(nveh,0.0)
                SetEntityHeading(nveh, config.dealerships[showroomID].headingVehicle)

                SetVehicleCustomPrimaryColour(nveh, 255,255,255)
                SetVehicleCustomSecondaryColour(nveh, 255,255,255)
            else
                DeleteEntity(rablactuala)
                local nveh = CreateVehicle(model, config.dealerships[showroomID].coordsVehicle[1], config.dealerships[showroomID].coordsVehicle[2], config.dealerships[showroomID].coordsVehicle[3], 220.0, false, false)
                SetPedIntoVehicle(PlayerPedId(),nveh,-1)
                SetVehicleEngineOn(nveh,false,true,true)
                SetVehicleDirtLevel(nveh,0.0)
                SetEntityHeading(nveh, config.dealerships[showroomID].headingVehicle)

                SetVehicleCustomPrimaryColour(nveh, 255,255,255)
                SetVehicleCustomSecondaryColour(nveh, 255,255,255)
            end
            testPrice = v.price/config.TestDrivePrice
            SendNUIMessage({
                action = "updateVehicleSpecifications",
                speed = v.speed,
                acceleration = v.acceleration,
                brakes = v.brakes,
                seats = v.seats,
                testPrice = testPrice
            })
        end
    end
end)

function SecondsToClock(seconds,whatReturn)
    local seconds = tonumber(seconds)
  
    if seconds <= 0 then
      return "00:00:00";
    else
      hours = string.format("%02.f", math.floor(seconds/3600));
      mins = string.format("%02.f", math.floor(seconds/60 - (hours*60)));
      secs = string.format("%02.f", math.floor(seconds - hours*3600 - mins *60));
      if whatReturn == "hours" then
        return hours..":"..mins..":"..secs
      elseif whatReturn == "minutes" then
        return mins..":"..secs
      else
        return hours..":"..mins..":"..secs
      end
    end
end

RegisterNUICallback('spawnTheVehicleForTesting', function(data, cb)
    if inShowroom then
        for k,v in pairs (config.dealerships[showroomID]["vehicles"][data.selectedCat]) do 
            if v.vehID == data.selectedVehicle then
                vRPSds.checkMoneyForTesting({},function(haveMoney)

                    if haveMoney then

                        SendNUIMessage({action = "startTestingTheVehicle"})

                        model = v.spawncode
                        rablactuala = GetVehiclePedIsUsing(PlayerPedId())
                        DeleteEntity(rablactuala)

                        local nveh = CreateVehicle(model, config.dealerships[showroomID].testVehicleSpawn[1], config.dealerships[showroomID].testVehicleSpawn[2], config.dealerships[showroomID].testVehicleSpawn[3], config.dealerships[showroomID].testVehicleSpawnHeading, false, false)
                        SetPedIntoVehicle(PlayerPedId(),nveh,-1)
                        SetVehicleEngineOn(nveh,true,true,true)
                        SetVehicleDirtLevel(nveh,0.0)
                        -- SetEntityRoutingBucket(nveh, bucket)

                        testVehicle = nveh

                        if data.selectedColor == 0 then
                            SetVehicleCustomPrimaryColour(nveh, 255,255,255)
                        else
                            r, g, b = data.selectedColor[1]:match("([^,]+),([^,]+),([^,]+)")
                            rablactuala = GetVehiclePedIsUsing(PlayerPedId())
                            if rablactuala ~= nil then
                                SetVehicleCustomPrimaryColour(nveh, tonumber(r),tonumber(g),tonumber(b))
                            end
                        end

                        inShowroom = false
                        SetEntityVisible(PlayerPedId(), true)
                        DestroyCam(cam, false)
                        SetCamActive(cam, false)
                        RenderScriptCams(0, false, 100, false, false)
                        SetNuiFocus(false, false)

                        inTesting = true
                        inTestingTime = config.dealerships[showroomID].testVehicleTime

                        CreateThread(function()
                            while true do 
                                Wait(1000)
                                if inTesting then
                                    
                                    if not DoesEntityExist(testVehicle) then 
                                        DeleteEntity(testVehicle)
                                        inTestingTime = 0
                                    end

                                    if GetEntityHealth(PlayerPedId()) < 121 then 
                                        SetEntityHealth(PlayerPedId(),200)
                                        DeleteEntity(testVehicle)
                                        inTestingTime = 0
                                    end

                                    if inTestingTime == 0 then 

                                        DeleteEntity(GetVehiclePedIsUsing(PlayerPedId()))
                                        inTesting = false
                                        openShowroom(showroomID)
                                        break
                                    else
                                        SendNUIMessage({
                                            action = "timeRemaining",
                                            timeRemaining = SecondsToClock(inTestingTime,"minutes")
                                        })

                                        inTestingTime = inTestingTime - 1
                                        
                                    end
                                
                                end
                            end
                        end)
                    else
                        vRP.notify({"You don't have enough money for testing this vehcle."})
                    end
                end)
            end
        end
    end
end)


RegisterNUICallback('buyVehicle', function(data, cb)
    vRPSds.checkMoneyForBuyingVehicle({showroomID,data.selectedVehicle},function(haveMoney)
        if haveMoney then
            TriggerServerEvent('leaveCx')
            SendNUIMessage({action = "closeShowroom"})
        end
    end)
end)


vRPdsC.closeShowroom = function()
    TriggerServerEvent('leaveCx')
    SendNUIMessage({action = "closeShowroom"})
end
