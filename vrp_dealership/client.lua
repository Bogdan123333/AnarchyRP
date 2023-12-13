local ugFont = RegisterFontId("Freedom Font")
local function drawText(text, x, y, scale, r, g, b, font)
	if font then
		SetTextFont(font)
	else
		SetTextFont(ugFont)
	end
	if font ~= 4 then
		SetTextCentre(1)
	end
	SetTextProportional(0)
	SetTextScale(scale, scale)
	SetTextDropShadow(30, 5, 5, 5, 255)
	SetTextEntry("STRING")
	SetTextColour(r, g, b, 255)
	AddTextComponentString(text)
	DrawText(x, y)
end

local function DrawText3D(x,y,z, text, scl, font, colors) 

    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
 
    local scale = (1/dist)*scl
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
   
    if onScreen then
        SetTextScale(0.0*scale, 1.1*scale)
        SetTextFont(font)
        SetTextProportional(1)
        SetTextColour(colors[1], colors[2], colors[3], 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end

local showVehicle = nil
local testDrive = false

local function loadDealershipInterior()

	local controlsGui = "~g~E ~w~- Cumpara~n~~r~Q ~w~- Spawneaza~n~~b~R ~w~- Categorii~n~~y~U ~w~- Test Drive~n~H - Deschide Usi"

	local evs = {}
	local loaded = true
	local vehData = nil
	local doorStatus = false

	local index = 0
	local mIndex = 0
	local topSpeed = 0.0

	table.insert(evs, RegisterNetEvent("ples-dealership:getMenuVeh", function(curIndex, maxIndex, vehDbData)
		vehData = vehDbData
		index = curIndex
		if maxIndex then
			mIndex = maxIndex
		end

		topSpeed = math.floor(GetVehicleModelEstimatedMaxSpeed(GetHashKey(vehData.model)) * 3.7) + 10
	end))

	function formatMoney(amount)
		local left,num,right = string.match(tostring(amount),'^([^%d]*%d)(%d*)(.-)$')
		return left..(num:reverse():gsub('(%d%d%d)','%1.'):reverse())..right
	  end
	
	Citizen.CreateThread(function()
		local changeCar = {-33.904907226562,-1101.7618408203,26.422369003296}
		while loaded do
			
			DrawMarker(21, changeCar[1], changeCar[2], changeCar[3], 0, 0, 0, 0, 0, 0, 0.401, 0.401, 0.401, 106, 90, 205, 180, 0, 0, 0, 1)
			if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), changeCar[1], changeCar[2], changeCar[3], false) <= 0.8 then
				drawText("Apasa ~r~E~w~ pentru a intra in ~b~showroom", 0.5, 0.90, 0.35, 255, 255, 255)
				if IsControlJustPressed(0, 38) then
					TriggerServerEvent("ples-dealership:requestCategory")
					Citizen.Wait(1000)
				end
			end

			while vehData and loaded do

				DisableControlAction(0, 44)
				DisableControlAction(0, 140)
				DisableControlAction(0, 104)
				DisableControlAction(0, 303)
				
				drawText(vehData.category, 0.5, 0.78, 0.3, 252, 45, 38)
				drawText(vehData.title, 0.5, 0.8, 0.35, 255, 255, 255)
				drawText(index.."/"..mIndex, 0.5, 0.8325, 0.25, 255, 255, 255)
				drawText("←", 0.4, 0.8, 0.4, 38, 177, 252, 0)
				drawText("→", 0.6, 0.8, 0.4, 38, 177, 252, 0)

				drawText(formatMoney(vehData.formPrice).."~g~$", 0.45, 0.83, 0.35, 255, 255, 255)
				drawText("Stock ~r~"..math.max(vehData.stock, 0), 0.55, 0.83, 0.35, 255, 255, 255)

				drawText("Top Speed ~b~"..topSpeed.." km/h", 0.5, 0.86, 0.3, 255, 255, 255)

				drawText(controlsGui, 0.01, 0.5, 0.35, 255, 255, 255,4)
				drawText("Backspace - ~r~Iesi", 0.01, 0.603, 0.35, 255, 255, 255,4)


				if IsControlJustPressed(0, 174) then -- Left

					index = index - 1

					if index == 0 then index = mIndex end
					TriggerServerEvent("ples-dealership:getVeh", index, vehData.category)

				elseif IsControlJustPressed(0, 175) then -- Right

					index = index + 1

					if index == mIndex + 1 then index = 1 end
					TriggerServerEvent("ples-dealership:getVeh", index, vehData.category)

				elseif IsDisabledControlJustPressed(0, 44) then -- Spawn Veh

					if showVehicle and DoesEntityExist(showVehicle) then
						DeleteEntity(showVehicle)
					end

					local i, mhash = 0, GetHashKey(vehData.model)
					while not HasModelLoaded(mhash) and i < 500 do
						if i % 50 == 0 then
							RequestModel(mhash)
						end
						Citizen.Wait(1)
						if i >= 50 then
							drawText("Se incarca...", 0.5, 0.8, 0.4, 255, 255, 255, fontId)
						end
						i = i+1
					end

					showVehicle = CreateVehicle(mhash, -47.412261962891, -1096.1405029297, 26.42236328125, 200.0, false, false)
					SetVehicleMaxSpeed(showVehicle, 0.0)
					NetworkFadeInEntity(showVehicle, 0)
					SetVehicleOnGroundProperly(showVehicle)
					SetEntityInvincible(showVehicle, true)
					FreezeEntityPosition(showVehicle, true)
					SetVehicleDirtLevel(showVehicle, 0.0)

					doorStatus = false

				elseif IsDisabledControlJustPressed(0, 104) then -- All doors

					if doorStatus then
						SetVehicleDoorsShut(showVehicle, true)
					else
						for i = 0, 5 do
						  SetVehicleDoorOpen(showVehicle, i, false, false)
						end
					end
					doorStatus = not doorStatus

				elseif IsDisabledControlJustPressed(0, 140) then -- Change Categories

					if showVehicle and DoesEntityExist(showVehicle) then
						DeleteEntity(showVehicle)
					end

					showVehicle = nil
					vehData = nil

					TriggerServerEvent("ples-dealership:requestCategory")
					Citizen.Wait(1000)

				elseif IsControlJustPressed(0, 38) then -- Buy

					TriggerServerEvent("ples-dealership:tryBuyCar", vehData.category, index)

					if showVehicle and DoesEntityExist(showVehicle) then
						DeleteEntity(showVehicle)
					end
					showVehicle = nil
					vehData = nil
				elseif IsDisabledControlJustPressed(0, 202) or IsDisabledControlJustPressed(0, 199) then
					if showVehicle and DoesEntityExist(showVehicle) then
						DeleteEntity(showVehicle)
					end
					showVehicle = nil
					vehData = nil
				elseif IsDisabledControlJustPressed(0, 303) then -- Test Drive

					

					if not showVehicle then
						local i, mhash = 0, GetHashKey(vehData.model)
						while not HasModelLoaded(mhash) and i < 500 do
							if i % 50 == 0 then
								RequestModel(mhash)
							end
							Citizen.Wait(1)
							if i >= 50 then
								drawText("Se incarca...", 0.5, 0.8, 0.4, 255, 255, 255, 0)
							end
							i = i+1
						end

						showVehicle = CreateVehicle(mhash, -47.412261962891, -1096.1405029297, 26.42236328125, 200.0, false, false)
						SetVehicleMaxSpeed(showVehicle, 0.0)
						NetworkFadeInEntity(showVehicle, 0)
						SetVehicleOnGroundProperly(showVehicle)
						SetEntityInvincible(showVehicle, true)
						FreezeEntityPosition(showVehicle, true)
						SetVehicleDirtLevel(showVehicle, 0.0)

						doorStatus = false
					end

					

					if DoesEntityExist(showVehicle) then

						testDrive = true

						DoScreenFadeOut(700)
						Citizen.Wait(800)
						SetPedIntoVehicle(GetPlayerPed(-1), showVehicle, -1)
						Citizen.Wait(100)
						FreezeEntityPosition(showVehicle, false)
						SetEntityCoordsNoOffset(showVehicle, -49.6057472229,-1078.03515625,26.839670181274)
						SetEntityHeading(showVehicle, 70.0)
						SetPedCanBeKnockedOffVehicle(PlayerPedId(), testDrive)

						Citizen.Wait(1000)
						DoScreenFadeIn(1000)

						local untilTime = GetGameTimer() + 200000

						while GetGameTimer() < untilTime do
							Citizen.Wait(1)

							DisableControlAction(0, 75)

							if IsDisabledControlJustPressed(0, 75) or not DoesEntityExist(showVehicle) then
								break
							end

							drawText("Test Drive ~b~"..math.floor((untilTime - GetGameTimer()) / 1000).."s", 0.5, 0.88, 0.3, 255, 255, 255)

						end

						DoScreenFadeOut(700)
						Citizen.Wait(800)
						SetEntityCoordsNoOffset(GetPlayerPed(-1), -38.125823974609,-1100.0412597656,26.422374725342)
						SetEntityHeading(GetPlayerPed(-1), 80.0)

						SetEntityCoordsNoOffset(showVehicle, -47.412261962891, -1096.1405029297, 25.92236328125)
						SetEntityHeading(showVehicle, 200.0)
						SetVehicleFixed(showVehicle)
						SetVehicleOnGroundProperly(showVehicle)
						FreezeEntityPosition(showVehicle, true)
						
						Citizen.Wait(1000)
						DoScreenFadeIn(1000)

						testDrive = false
						SetPedCanBeKnockedOffVehicle(PlayerPedId(), testDrive)

					end

				end

				Citizen.Wait(1)
			end

			Citizen.Wait(1)
		end
	end)


	return function()
		loaded = false

		if showVehicle and DoesEntityExist(showVehicle) then
			DeleteEntity(showVehicle)
		end

		showVehicle = nil

		for _, ev in pairs(evs) do
			RemoveEventHandler(ev)
		end

		DoScreenFadeOut(700)

		Citizen.Wait(800)
		TriggerServerEvent("ples-dealership:exitDealership")

		Citizen.Wait(1000)
		DoScreenFadeIn(1000)
	end
end

local locked = false

RegisterNetEvent("ples-dealership:setLocked", function(tog)
	locked = tog
end)

Citizen.CreateThread(function()
	local ped = GetPlayerPed(-1)
	local lastInterior = 0

	local unloadF = nil

	while true do
		Citizen.Wait(2000)

		if not testDrive then

			ped = GetPlayerPed(-1)
			local interiorId = GetInteriorFromEntity(ped)

			if locked and interiorId == 7170 then
				DoScreenFadeOut(100)
				Citizen.Wait(150)
				SetEntityCoordsNoOffset(GetPlayerPed(-1), -64.700355529785,-1110.2834472656,26.287536621094)
				Citizen.Wait(100)
				DoScreenFadeIn(500)
			else

				if lastInterior ~= interiorId then

					if unloadF then
						unloadF()
						unloadF = nil
					end

					if interiorId == 7170 then
						unloadF = loadDealershipInterior()
					end

				end
			end
			lastInterior = interiorId
		end
	end
end)
