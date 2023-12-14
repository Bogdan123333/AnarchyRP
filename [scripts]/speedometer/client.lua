local ind = {l = false, r = false}
local spds = {
	[0] = "",
	[1] = "0",
	[2] = "00"
}

Citizen.CreateThread(function()
	while true do
		local Ped = GetPlayerPed(-1)
		if(IsPedInAnyVehicle(Ped)) then
			local PedCar = GetVehiclePedIsIn(Ped, false)
			if PedCar and GetPedInVehicleSeat(PedCar, -1) == Ped then

				-- Speed
				carSpeed = math.ceil(GetEntitySpeed(PedCar) * 3.6)
				local rpm = GetVehicleCurrentRpm(PedCar)*100
				-- print(rpm)
				SendNUIMessage({
					showhud = true,
					speed = (spds[3 - #tostring(carSpeed)] or "").."<font color = '#FFF'>"..carSpeed.."</font>",
					speedn = rpm,
					-- speedn = carSpeed,
					health = GetVehicleEngineHealth(PedCar)/38
				})

				-- Lights
				_,feuPosition,feuRoute = GetVehicleLightsState(PedCar)
				local c = 0
				if(feuPosition == 1 and feuRoute == 0) then
					c = 1
				else
					c = 0
				end
				if(feuPosition == 1 and feuRoute == 1) then
					c = 2
				end

				SendNUIMessage({
					c = c
				})

				-- Turn signal
				-- SetVehicleIndicatorLights (1 left -- 0 right)
				local VehIndicatorLight = GetVehicleIndicatorLights(GetVehiclePedIsUsing(PlayerPedId()))
				if IsControlJustPressed(1, 57) then -- F9 is pressed
					ind.l = not ind.l
					SetVehicleIndicatorLights(GetVehiclePedIsUsing(GetPlayerPed(-1)), 0, ind.l)
				end
				if IsControlJustPressed(1, 56) then -- F10 is pressed
					ind.r = not ind.r
					SetVehicleIndicatorLights(GetVehiclePedIsUsing(GetPlayerPed(-1)), 1, ind.r)
				end

				if(VehIndicatorLight == 0) then
					SendNUIMessage({
						clignotantGauche = false,
						clignotantDroite = false,
					})
				elseif(VehIndicatorLight == 1) then
					SendNUIMessage({
						clignotantGauche = true,
						clignotantDroite = false,
					})
				elseif(VehIndicatorLight == 2) then
					SendNUIMessage({
						clignotantGauche = false,
						clignotantDroite = true,
					})
				elseif(VehIndicatorLight == 3) then
					SendNUIMessage({
						clignotantGauche = true,
						clignotantDroite = true,
					})
				end

			else
				SendNUIMessage({
					showhud = false
				})
			end
		else
			SendNUIMessage({
				showhud = false
			})
			Wait(1000)
		end

		Citizen.Wait(30)
	end
end)

-- Consume fuel factor
Citizen.CreateThread(function()
	while true do
		local Ped = GetPlayerPed(-1)
		if(IsPedInAnyVehicle(Ped)) then
			local PedCar = GetVehiclePedIsIn(Ped, false)
			if PedCar and GetPedInVehicleSeat(PedCar, -1) == Ped then
				carSpeed = math.ceil(GetEntitySpeed(PedCar) * 3.6)
				fuel = GetVehicleFuelLevel(PedCar)


				SendNUIMessage({
			showfuel = true,
					fuel = fuel
				})
			end
		end

		Citizen.Wait(750)
	end
end)