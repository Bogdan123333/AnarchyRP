vRP = Proxy.getInterface("vRP")


vRPSnpc = Tunnel.getInterface("fpt-npc","fpt-npc")

vRPCnpc = {}
Tunnel.bindInterface("fpt-npc",vRPCnpc)

Proxy.addInterface("fpt-npc",vRPCnpc)

PlayerData = {}
local pedList = {}
local cam = nil
local name = ''
local waitMore = true
local inMenu = false
local hasEntered = false

CreateThread(function()
	local pedInfo = {}
	local camCoords = nil
	local camRotation = nil

	for k, v in pairs(Config.TalkToNPC) do
		RequestModel(GetHashKey(v.npc))
		while not HasModelLoaded(GetHashKey(v.npc)) do
			Wait(1)
		end

		RequestAnimDict("mini@strip_club@idles@bouncer@base")
		while not HasAnimDictLoaded("mini@strip_club@idles@bouncer@base") do
			Wait(1)
		end

		ped = CreatePed(4, v.npc, v.coordinates[1], v.coordinates[2], v.coordinates[3], v.heading, false, true)
		SetEntityHeading(ped, v.heading)
		FreezeEntityPosition(ped, true)
		SetEntityInvincible(ped, true)
		SetBlockingOfNonTemporaryEvents(ped, true)
		if v.anim then 
			RequestAnimDict(v.anim.dict)
			while not HasAnimDictLoaded(v.anim.dict) do
				Wait(1)
			end
			TaskPlayAnim(ped,v.anim.dict,v.anim.anim, 8.0, 0.0, -1, 1, 0, 0, 0, 0)
		elseif v.scenario then
			TaskStartScenarioInPlace(ped, v.scenario, 0, false)
		else
			TaskPlayAnim(ped,"mini@strip_club@idles@bouncer@base","base", 8.0, 0.0, -1, 1, 0, 0, 0, 0)
		end

		if v.face then
			SetPedHeadBlendData(ped, v.face, v.face, 0, v.facetexture, v.facetexture, 0, 1.0, 0.1, 0.0, false)
			SetPedHeadOverlay(ped, 2, 12, 1.0)
			SetPedHeadOverlayColor(ped, 2, 1, 1, 0)
		end

		if v.ruj then
			SetPedHeadOverlay(ped, 8, v.ruj, 1.0)
			SetPedHeadOverlayColor(ped, 8, 1, v.culoareruj, 0)
		end

		if v.barba then
			SetPedHeadOverlay(ped, 1, v.barba, 1.0)
    		SetPedHeadOverlayColor(ped, 1, 1, 1, 0)
		end

		if v.machiaj then
			SetPedHeadOverlay(ped, 4, v.machiaj, 1.0)
			SetPedHeadOverlayColor(ped, 4, 1, v.culoaremachiaj, 0)
		end



		if v.face then
			SetPedHeadBlendData(ped, v.face, v.face, 0, v.facetexture, v.facetexture, 0, 1.0, 0.1, 0.0, false)
			SetPedHeadOverlay(ped, 2, 12, 1.0)
			SetPedHeadOverlayColor(ped, 2, 1, 1, 0)
		end

		if v.ruj then
			SetPedHeadOverlay(ped, 8, v.ruj, 1.0)
			SetPedHeadOverlayColor(ped, 8, 1, v.culoareruj, 0)
		end

		if v.barba then
			SetPedHeadOverlay(ped, 1, v.barba, 1.0)
    		SetPedHeadOverlayColor(ped, 1, 1, 1, 0)
		end

		if v.machiaj then
			SetPedHeadOverlay(ped, 4, v.machiaj, 1.0)
			SetPedHeadOverlayColor(ped, 4, 1, v.culoaremachiaj, 0)
		end
		
		if v.piele then
			SetPedHeadOverlay(ped, 6, v.piele, 1.0)
			SetPedHeadOverlayColor(ped, 6, 1, v.culoarepiele, 0)
		end
		
		if v.riduri then
			SetPedHeadOverlay(ped, 3, v.riduri, 1.0)
			SetPedHeadOverlayColor(ped, 3, 1, v.culoareriduri, 0)
		end


		if Config.AutoCamPosition then
			local px, py, pz = table.unpack(GetEntityCoords(ped, true))
			local x, y, z = px + GetEntityForwardX(ped) * 1.2, py + GetEntityForwardY(ped) * 1.2, pz + 0.52

			camCoords = vector3(x, y, z)
		end

		if Config.AutoCamRotation then
			local rx = GetEntityRotation(ped, 2)

			camRotation = rx + vector3(0.0, 0.0, 181)
		end

		pedInfo = {
			name = v.name,
			model = v.npc,
			pedCoords = v.coordinates,
			entity = ped,
			camCoords = camCoords,
			camRotation = camRotation,
		}

		table.insert(pedList, pedInfo)
	end
end)

-- CHECK DISTANCE & JOB

CreateThread(function()
	local inZone = false
	local hasSetName = false
	local nearPed = false
	local checkedJob = false
	local hasJob = false
	local npcModel = nil
	local npcName = nil
	local npcKey = 0
	
	while true do
		Wait(20)
		local playerCoords = GetEntityCoords(PlayerPedId())
		
		inZone = false
		nearPed = false

		if npcName == nil and npcModel == nil then
			for k,v in pairs(Config.TalkToNPC) do
				local distance = GetDistanceBetweenCoords(playerCoords.x, playerCoords.y, playerCoords.z, v.coordinates[1], v.coordinates[2], v.coordinates[3])
			
				if nearPed then

					if distance < v.interactionRange + 2 then
						npcName = v.name
						npcModel = v.npc
						npcKey = k
						nearPed = true

					elseif not waitMore and not nearPed then
						waitMore = true
					elseif checkedJob then
						checkedJob = false
					end
				else
					if distance < v.interactionRange + 2 then
						npcName = v.name
						npcModel = v.npc
						npcKey = k
						nearPed = true
						if not inMenu then
							waitMore = false
						end
						
					elseif not waitMore and not nearPed then
						waitMore = true
					end
				end
			end
		else
			v = Config.TalkToNPC[npcKey]
			if v ~= nil then
				local distance = GetDistanceBetweenCoords(playerCoords.x, playerCoords.y, playerCoords.z, v.coordinates[1], v.coordinates[2], v.coordinates[3])
				local zDistance = playerCoords.z - v.coordinates[3]
				
				if zDistance < 0 then
					zDistance = zDistance * -1
				end
				if zDistance < 2 then
					if nearPed then

						if distance < v.interactionRange + 3 then
							-- if not checkedJob then
							-- 	hasJob = false
							-- 	checkedJob = true
							-- 	for k2,v2 in pairs(v.jobs) do
							-- 		if ESX.GetPlayerData().job.name == v2 then
							-- 			hasJob = true
							-- 		end
							-- 	end
							-- end
							
							if nearPed then
								if not nearPed then
									nearPed = true
								end
								if not inMenu then
									waitMore = false
								end
								if distance < v.interactionRange then
									if not hasSetName then
										name = v.uiText
										hasSetName = true
									end
									if not inZone then
										inZone = true
									end
									if not Config.UseOkokTextUI and not inMenu then
										HelpText('[G] - Acceseaza '..name)
									end
									if IsControlJustReleased(0, Config.Key) then
										inMenu = true
										waitMore = true
										StartCam(v.coordinates, v.camOffset, v.camRotation, v.npc, v.name)
										if Config.UseOkokTextUI then
											exports['fpt-scripts']:Close()
										end
										Wait(500)
										if Config.HideMinimap then
											DisplayRadar(false)
										end
										SetNuiFocus(true, true)
										SendNUIMessage({
											action = 'openDialog',
											name = v.name,
											dialog = v.dialog,
											options = v.options,
										})
									end
								elseif hasSetName then
									hasSetName = false
								end
							end
						elseif not waitMore and not nearPed then
							waitMore = true
						elseif checkedJob then
							checkedJob = false
						end
						if distance > v.interactionRange + 2 and npcName ~= nil and npcModel ~= nil then
							npcModel = nil
							npcName = nil
							npcKey = 0
						end
					else
						if distance < v.interactionRange + 3 then
							if not nearPed then
								nearPed = true
							end
							if not inMenu then
								waitMore = false
							end
							if distance < v.interactionRange then
								if not hasSetName then
									name = v.uiText
									hasSetName = true
								end
								if not inZone then
									inZone = true
								end
								if not Config.UseOkokTextUI and not inMenu then
									HelpText('[G] - Acceseaza ')
								end
								if IsControlJustReleased(0, Config.Key) then
									inMenu = true
									waitMore = true
									StartCam(v.coordinates, v.camOffset, v.camRotation, v.npc, v.name)
									if Config.UseOkokTextUI then
										exports['fpt-scripts']:Close()
									end
									Wait(500)
									if Config.HideMinimap then
										DisplayRadar(false)
									end
									SetNuiFocus(true, true)
									SendNUIMessage({
										action = 'openDialog',
										header = v.header,
										name = v.name,
										dialog = v.dialog,
										options = v.options,
									})
								end
							elseif hasSetName then
								hasSetName = false
							end
						elseif not waitMore and not nearPed then
							waitMore = true
						end
						if distance > v.interactionRange + 2 and npcName ~= nil and npcModel ~= nil then
							npcModel = nil
							npcName = nil
							npcKey = 0
						end
					end
				end
			end
		end

		

		if inZone and not hasEntered then
			if Config.UseOkokTextUI then
				exports['fpt-scripts']:Open('[G] - Acceseaza '..name, 'darkblue', 'left') 
			end
			hasEntered = true
		elseif not inZone and hasEntered then
			if Config.UseOkokTextUI then
				exports['fpt-scripts']:Close()
			end
			hasEntered = false
		end 

		if waitMore then
			Wait(1000)
		end
	end
end)

-- ACTIONS

RegisterNUICallback('action', function(data, cb)
	if data.action == 'close' then
		SetNuiFocus(false, false)
		if Config.HideMinimap then
			DisplayRadar(true)
		end
		hasEntered = true
		if Config.UseOkokTextUI then
			exports['fpt-scripts']:Open('[G] - Acceseaza '..name, 'darkblue', 'left') 
		end
		EndCam()
		inMenu = false
		waitMore = false
	elseif data.action == 'option' then
		SetNuiFocus(false, false)
		if Config.HideMinimap then
			DisplayRadar(true)
		end
		hasEntered = true
		if Config.UseOkokTextUI then
		exports['fpt-scripts']:Open('[G] - Acceseaza '..name, 'darkblue', 'left') 
		end
		EndCam()
		inMenu = false
		waitMore = false

		if data.options[3] == 'c' then
			TriggerEvent(data.options[2])
		elseif data.options[3] ~= nil then
			TriggerServerEvent(data.options[2])
		end
	end
end)

-- CAMERA

function StartCam(coords, offset, rotation, model, name)
	ClearFocus()

	if Config.AutoCamRotation then
		for k,v in pairs(pedList) do
			if v.pedCoords == coords then
				if v.name == name and v.model == model then
					rotation = v.camRotation
				end
			end
		end
	end

	if Config.AutoCamPosition then
		for k,v in pairs(pedList) do
			if v.pedCoords == coords then
				if v.name == name and v.model == model then
					coords = v.camCoords
				end
			end
		end
	else
		coords = coords + offset
	end

	cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", coords, rotation, GetGameplayCamFov())

	SetCamActive(cam, true)
	RenderScriptCams(true, true, Config.CameraAnimationTime, true, false)
end

function EndCam()
	ClearFocus()

	RenderScriptCams(false, true, Config.CameraAnimationTime, true, false)
	DestroyCam(cam, false)

	cam = nil
end

-- ========================================================================================================================================== --
-- =====================================================> POLITIE DUTY ON / OFF <============================================================ --
-- ========================================================================================================================================== --

RegisterNetEvent("fpt-npc:hainepolitie")
AddEventHandler("fpt-npc:hainepolitie", function(grad)
    local ped = PlayerPedId()
    local model = GetEntityModel(ped)
	if grad == "Gardian Penitenciar" then
	progressBars(5000,"Imbraci uniforma...")
	playAnim('clothingtie', 'try_tie_negative_a', 3.0, -1, -1, 50, 0, false, false, false)
	Wait(1700)
	playAnim('re@construction', 'out_of_breath', 3.0, -1, -1, 50, 0, false, false, false)
	Wait(2000)
	ClearPedTasks(ped)
	Wait(1300)
	TriggerEvent("fpt-progres:enable")
	if model == maleModel then
		exports['fpt-pack']:Alert("Marcel", "Poftim uniforma domnule Gardian", 4500, 'info')
		SetPedPropIndex(ped, 0, 113,11) -- PALARIE
		SetPedComponentVariation(ped, 1, 121,0) -- MASCA
		SetPedComponentVariation(ped, 6, 24,0,0) -- INCALTAMINTE
		SetPedComponentVariation(ped, 4, 125,3,0) -- PANTALONI
		SetPedComponentVariation(ped, 10, 76,0,0) -- EXTRAS
		SetPedComponentVariation(ped, 5, 0,0,0) -- GEANTA
		SetPedComponentVariation(ped, 3, 4,0) -- MANI/MANUSi
		SetPedComponentVariation(ped, 8, 15,0,0) -- SUBHAINA
		SetPedComponentVariation(ped, 9, 0,0,0) -- VEST
		SetPedComponentVariation(ped, 11, 316,3,0) -- GEACA
	elseif model == femaleModel then
		exports['fpt-pack']:Alert("Marcel", "Poftiti uniforma domna Gardiana", 4500, 'info')
		SetPedPropIndex(ped, 0, 112,11) -- PALARIE
		SetPedComponentVariation(ped, 1, 121,0) -- MASCA
		SetPedComponentVariation(ped, 6, 24,0,0) -- INCALTAMINTE
		SetPedComponentVariation(ped, 4, 131,3,0) -- PANTALONI
		SetPedComponentVariation(ped, 10, 85,0,0) -- EXTRAS
		SetPedComponentVariation(ped, 5, 0,0,0) -- GEANTA
		SetPedComponentVariation(ped, 3, 3,0) -- MANI/MANUSi
		SetPedComponentVariation(ped, 8, 15,0,0) -- SUBHAINA
		SetPedComponentVariation(ped, 9, 0,0,0) -- VEST
		SetPedComponentVariation(ped, 11, 327,3,0) -- GEACA
	end
	elseif grad == "APS" then
		progressBars(5000,"Imbraci uniforma...")
		playAnim('clothingtie', 'try_tie_negative_a', 3.0, -1, -1, 50, 0, false, false, false)
		Wait(1700)
		playAnim('re@construction', 'out_of_breath', 3.0, -1, -1, 50, 0, false, false, false)
		Wait(2000)
		ClearPedTasks(ped)
		Wait(1300)
		TriggerEvent("fpt-progres:enable")
		if model == maleModel then
			exports['fpt-pack']:Alert("Marcel", "Poftim uniforma domnule APS", 4500, 'info')
			SetPedPropIndex(ped, 0, 39,0) -- PALARIE
			SetPedComponentVariation(ped, 1, 121,0) -- MASCA
			SetPedComponentVariation(ped, 6, 24,0,0) -- INCALTAMINTE
			SetPedComponentVariation(ped, 4, 125,0,0) -- PANTALONI	
			SetPedComponentVariation(ped, 10, 70,0,0) -- EXTRAS
			SetPedComponentVariation(ped, 5, 0,0,0) -- GEANTA
			SetPedComponentVariation(ped, 3, 31,0) -- MANI/MANUSi
			SetPedComponentVariation(ped, 8, 129,0,0) -- SUBHAINA
			SetPedComponentVariation(ped, 11, 320,0,0) -- GEACA
		elseif model == femaleModel then
			exports['fpt-pack']:Alert("Marcel", "Poftiti uniforma domna APS", 4500, 'info')
			SetPedPropIndex(ped, 0, 38,0) -- PALARIE
			SetPedComponentVariation(ped, 1, 121,0) -- MASCA
			SetPedComponentVariation(ped, 6, 24,0,0) -- INCALTAMINTE
			SetPedComponentVariation(ped, 4, 131,0,0) -- PANTALONI
			SetPedComponentVariation(ped, 10, 79,0,0) -- EXTRAS
			SetPedComponentVariation(ped, 5, 0,0,0) -- GEANTA
			SetPedComponentVariation(ped, 3, 36,0) -- MANI/MANUSi
			SetPedComponentVariation(ped, 8, 159,0,0) -- SUBHAINA
			SetPedComponentVariation(ped, 11, 331,0,0) -- GEACA
		end
	elseif grad == "Cadet" then
        progressBars(5000,"Imbraci uniforma...")
        playAnim('clothingtie', 'try_tie_negative_a', 3.0, -1, -1, 50, 0, false, false, false)
        Wait(1700)
        playAnim('re@construction', 'out_of_breath', 3.0, -1, -1, 50, 0, false, false, false)
        Wait(2000)
        ClearPedTasks(ped)
        Wait(1300)
		TriggerEvent("fpt-progres:enable")
        if model == maleModel then
			exports['fpt-pack']:Alert("Marcel", "Poftim uniforma domnule Cadet", 4500, 'info')
            SetPedPropIndex(ped, 0, 1,0) -- HAT
			SetPedComponentVariation(ped, 10, 0,0,0) -- EXTRAS
            SetPedComponentVariation(ped, 1, 121,0) -- MASK
            SetPedComponentVariation(ped, 6, 10,0,0) -- SHOES
            SetPedComponentVariation(ped, 4, 24,2,0) -- PANTS
            SetPedComponentVariation(ped, 3, 0,0) -- GLOVES
			SetPedComponentVariation(ped, 8, 2,0,0) -- SUBHAINA
            SetPedComponentVariation(ped, 9, 10,1,0) -- VEST
            SetPedComponentVariation(ped, 11, 190,0,0) -- SHIRT
        elseif model == femaleModel then
			exports['fpt-pack']:Alert("Marcel", "Poftiti uniforma doamna Cadeta", 4500, 'info')
            SetPedComponentVariation(ped, 1, 190,0) -- HAT
            SetPedComponentVariation(ped, 6, 29,0,0) -- SHOES
            SetPedComponentVariation(ped, 4, 37,0,0) -- PANTS
            SetPedComponentVariation(ped, 3, 2,0) -- GLOVES
            SetPedComponentVariation(ped, 8, 35,0,0) -- SUBHAINA
            SetPedComponentVariation(ped, 9, 19,1,0) -- VEST
            SetPedComponentVariation(ped, 11, 92,0,0) -- SHIRT
        end
    elseif grad == "Agent" then
        progressBars(5000,"Imbraci uniforma...")
        playAnim('clothingtie', 'try_tie_negative_a', 3.0, -1, -1, 50, 0, false, false, false)
        Wait(1700)
        playAnim('re@construction', 'out_of_breath', 3.0, -1, -1, 50, 0, false, false, false)
        Wait(2000)
        ClearPedTasks(ped)
        Wait(1300)
		TriggerEvent("fpt-progres:enable")
        if model == maleModel then
			exports['fpt-pack']:Alert("Marcel", "Poftiti uniforma domnule Agent", 4500, 'info')
            SetPedPropIndex(ped, 0, 1,0) -- PALARIE
			SetPedComponentVariation(ped, 10, 0,0,0) -- EXTRAS
            SetPedComponentVariation(ped, 1, 121,0) -- MASCA
            SetPedComponentVariation(ped, 6, 10,0,0) -- INCALTAMINTE
			SetPedComponentVariation(ped, 4, 24,2,0) -- PANTS
            SetPedComponentVariation(ped, 3, 0,0) -- MANI/MANUSi
			SetPedComponentVariation(ped, 8, 2,0,0) -- SUBHAINA
            SetPedComponentVariation(ped, 9, 58,0,0) -- VEST
            SetPedComponentVariation(ped, 11, 190,0,0) -- GEACA
        elseif model == femaleModel then
			exports['fpt-pack']:Alert("Marcel", "Poftiti uniforma doamna Agenta", 4500, 'info')
            SetPedComponentVariation(ped, 1, 190,0) -- MASCA
            SetPedComponentVariation(ped, 6, 29,0,0) -- INCALTAMINTE
            SetPedComponentVariation(ped, 4, 37,0,0) -- PANTALONI
            SetPedComponentVariation(ped, 3, 2,0) -- MANI/MANUSi
            SetPedComponentVariation(ped, 8, 190,0,0) -- SUBHAINA
            SetPedComponentVariation(ped, 9, 1,0,0) -- VEST
            SetPedComponentVariation(ped, 11, 92,0,0) -- GEACA
        end
    elseif grad == "Agent Principal" then
        progressBars(5000,"Imbraci uniforma...")
        playAnim('clothingtie', 'try_tie_negative_a', 3.0, -1, -1, 50, 0, false, false, false)
        Wait(1700)
        playAnim('re@construction', 'out_of_breath', 3.0, -1, -1, 50, 0, false, false, false)
        Wait(2000)
        ClearPedTasks(ped)
        Wait(1300)
		TriggerEvent("fpt-progres:enable")
        if model == maleModel then
			exports['fpt-pack']:Alert("Marcel", "Poftiti uniforma domnule Agent Principal", 4500, 'info')
            SetPedPropIndex(ped, 0, 1,0) -- PALARIE
			SetPedComponentVariation(ped, 10, 0,0,0) -- EXTRAS
            SetPedComponentVariation(ped, 1, 121,0) -- MASCA
            SetPedComponentVariation(ped, 6, 10,0,0) -- INCALTAMINTE
			SetPedComponentVariation(ped, 4, 24,2,0) -- PANTS
            SetPedComponentVariation(ped, 3, 0,0) -- MANI/MANUSi
			SetPedComponentVariation(ped, 8, 2,0,0) -- SUBHAINA
            SetPedComponentVariation(ped, 9, 6,0,0) -- VEST
            SetPedComponentVariation(ped, 11, 190,0,0) -- GEACA
        elseif model == femaleModel then
			exports['fpt-pack']:Alert("Marcel", "Poftiti uniforma doamna Agent Principala", 4500, 'info')
            SetPedComponentVariation(ped, 1, 190,0) -- MASCA
            SetPedComponentVariation(ped, 6, 29,0,0) -- INCALTAMINTE
            SetPedComponentVariation(ped, 4, 37,0,0) -- PANTALONI
            SetPedComponentVariation(ped, 3, 2,0) -- MANI/MANUSi
            SetPedComponentVariation(ped, 8, 35,0,0) -- SUBHAINA
            SetPedComponentVariation(ped, 9, 3,0,0) -- VEST
            SetPedComponentVariation(ped, 11, 92,0,0) -- GEACA
        end
    elseif grad == "Agent Sef" then
        progressBars(5000,"Imbraci uniforma...")
        playAnim('clothingtie', 'try_tie_negative_a', 3.0, -1, -1, 50, 0, false, false, false)
        Wait(1700)
        playAnim('re@construction', 'out_of_breath', 3.0, -1, -1, 50, 0, false, false, false)
        Wait(2000)
        ClearPedTasks(ped)
        Wait(1300)
		TriggerEvent("fpt-progres:enable")
        if model == maleModel then
			exports['fpt-pack']:Alert("Marcel", "Poftiti uniforma domnule Agent Sef", 4500, 'info')
            SetPedPropIndex(ped, 0, 1,0) -- PALARIE
			SetPedComponentVariation(ped, 10, 0,0,0) -- EXTRAS
            SetPedComponentVariation(ped, 1, 121,0) -- MASCA
            SetPedComponentVariation(ped, 6, 10,0,0) -- INCALTAMINTE
			SetPedComponentVariation(ped, 4, 24,2,0) -- PANTS
            SetPedComponentVariation(ped, 3, 0,0) -- MANI/MANUSi
			SetPedComponentVariation(ped, 8, 2,0,0) -- SUBHAINA
            SetPedComponentVariation(ped, 9, 3,0,0) -- VEST
            SetPedComponentVariation(ped, 11, 190,0,0) -- GEACA
        elseif model == femaleModel then
			exports['fpt-pack']:Alert("Marcel", "Poftiti uniforma doamna Agent Sefa", 4500, 'info')
            SetPedComponentVariation(ped, 1, 190,0) -- MASCA
            SetPedComponentVariation(ped, 6, 29,0,0) -- INCALTAMINTE
            SetPedComponentVariation(ped, 4, 37,0,0) -- PANTALONI
            SetPedComponentVariation(ped, 3, 2,0) -- MANI/MANUSi
            SetPedComponentVariation(ped, 8, 35,0,0) -- SUBHAINA
            SetPedComponentVariation(ped, 9, 60,0,0) -- VEST
            SetPedComponentVariation(ped, 11, 92,0,0) -- GEACA
        end
    elseif grad == "Inspector" then
		if model == femaleModel then return exports['fpt-pack']:Alert("Marcel", "Deocamdata nu avem costume si pentru femei la rankul de Inspectora, va urez o zi buna!", 4500, 'error') end
        progressBars(5000,"Imbraci uniforma...")
        playAnim('clothingtie', 'try_tie_negative_a', 3.0, -1, -1, 50, 0, false, false, false)
        Wait(1700)
        playAnim('re@construction', 'out_of_breath', 3.0, -1, -1, 50, 0, false, false, false)
        Wait(2000)
        ClearPedTasks(ped)
        Wait(1300)
		TriggerEvent("fpt-progres:enable")
        if model == maleModel then
			exports['fpt-pack']:Alert("Marcel", "Poftiti uniforma domnule Inspector", 4500, 'info')
            SetPedPropIndex(ped, 0, 10,1) -- PALARIE
			SetPedComponentVariation(ped, 10, 0,0,0) -- EXTRAS
            SetPedComponentVariation(ped, 1, 121,0) -- MASCA
            SetPedComponentVariation(ped, 6, 25,0,0) -- INCALTAMINTE
            SetPedComponentVariation(ped, 4, 87,0,0) -- PANTALONI
            SetPedComponentVariation(ped, 3, 0,0) -- MANI/MANUSi
			SetPedComponentVariation(ped, 8, 2,0,0) -- SUBHAINA
            SetPedComponentVariation(ped, 9, 25,0,0) -- VEST
            SetPedComponentVariation(ped, 11, 94,1,0) -- GEACA
		end
	elseif grad == "Diicot" then
		if model == femaleModel then return exports['fpt-pack']:Alert("Marcel", "Deocamdata nu avem costume si pentru femei la rankul de Diicota, va urez o zi buna!", 4500, 'error') end
        progressBars(5000,"Imbraci uniforma...")
        playAnim('clothingtie', 'try_tie_negative_a', 3.0, -1, -1, 50, 0, false, false, false)
        Wait(1700)
        playAnim('re@construction', 'out_of_breath', 3.0, -1, -1, 50, 0, false, false, false)
        Wait(2000)
        ClearPedTasks(ped)
        Wait(1300)
		TriggerEvent("fpt-progres:enable")
        if model == maleModel then
			exports['fpt-pack']:Alert("Marcel", "Poftiti uniforma domnule Diicot", 4500, 'info')
            SetPedPropIndex(ped, 0, 125,1) -- PALARIE
			SetPedComponentVariation(ped, 10, 0,0,0) -- EXTRAS
            SetPedComponentVariation(ped, 1, 126,0) -- MASCA
            SetPedComponentVariation(ped, 6, 24,0,0) -- INCALTAMINTE
            SetPedComponentVariation(ped, 4, 31,1,0) -- PANTALONI
            SetPedComponentVariation(ped, 3, 33,0) -- MANI/MANUSi
			SetPedComponentVariation(ped, 8, 2,0,0) -- SUBHAINA
            SetPedComponentVariation(ped, 9, 1,0,0) -- VEST
            SetPedComponentVariation(ped, 11, 53,1,0) -- GEACA
		end
	elseif grad == "Sef Diicot" then
		if model == femaleModel then return exports['fpt-pack']:Alert("Marcel", "Deocamdata nu avem costume si pentru femei la rankul de Diicota Sefa, va urez o zi buna!", 4500, 'error') end
        progressBars(5000,"Imbraci uniforma...")
        playAnim('clothingtie', 'try_tie_negative_a', 3.0, -1, -1, 50, 0, false, false, false)
        Wait(1700)
        playAnim('re@construction', 'out_of_breath', 3.0, -1, -1, 50, 0, false, false, false)
        Wait(2000)
        ClearPedTasks(ped)
        Wait(1300)
		TriggerEvent("fpt-progres:enable")
        if model == maleModel then
			exports['fpt-pack']:Alert("Marcel", "Poftiti uniforma domnule Sef Diicot", 4500, 'info')
            SetPedPropIndex(ped, 0, 125,1) -- PALARIE
			SetPedComponentVariation(ped, 10, 0,0,0) -- EXTRAS
            SetPedComponentVariation(ped, 1, 126,0) -- MASCA
            SetPedComponentVariation(ped, 6, 25,0,0) -- INCALTAMINTE
            SetPedComponentVariation(ped, 4, 130,1,0) -- PANTALONI
            SetPedComponentVariation(ped, 3, 178,0) -- MANI/MANUSi
			SetPedComponentVariation(ped, 8, 15,0,0) -- SUBHAINA
            SetPedComponentVariation(ped, 9, 1,0,0) -- VEST
            SetPedComponentVariation(ped, 11, 291,0,0) -- GEACA
		end
	elseif grad == "Lider Diicot" then
		if model == femaleModel then return exports['fpt-pack']:Alert("Marcel", "Deocamdata nu avem costume si pentru femei la rankul de Lidera Diicota, va urez o zi buna!", 4500, 'error') end
        progressBars(5000,"Imbraci uniforma...")
        playAnim('clothingtie', 'try_tie_negative_a', 3.0, -1, -1, 50, 0, false, false, false)
        Wait(1700)
        playAnim('re@construction', 'out_of_breath', 3.0, -1, -1, 50, 0, false, false, false)
        Wait(2000)
        ClearPedTasks(ped)
        Wait(1300)
		TriggerEvent("fpt-progres:enable")
        if model == maleModel then
			exports['fpt-pack']:Alert("Marcel", "Poftiti uniforma domnule Lider Diicot", 4500, 'info')
            SetPedPropIndex(ped, 0, 125,1) -- PALARIE
			SetPedComponentVariation(ped, 10, 0,0,0) -- EXTRAS
            SetPedComponentVariation(ped, 1, 126,0) -- MASCA
            SetPedComponentVariation(ped, 6, 25,0,0) -- INCALTAMINTE
            SetPedComponentVariation(ped, 4, 130,1,0) -- PANTALONI
            SetPedComponentVariation(ped, 3, 178,0) -- MANI/MANUSi
			SetPedComponentVariation(ped, 8, 2,0,0) -- SUBHAINA
            SetPedComponentVariation(ped, 9, 5,0,0) -- VEST
			SetPedComponentVariation(ped, 11, 291,0,0) -- GEACA
		end
	elseif grad == "Coordonator Diicot" then
		if model == femaleModel then return exports['fpt-pack']:Alert("Marcel", "Deocamdata nu avem costume si pentru femei la rankul de Coordonatoare Diicota, va urez o zi buna!", 4500, 'error') end
        progressBars(5000,"Imbraci uniforma...")
        playAnim('clothingtie', 'try_tie_negative_a', 3.0, -1, -1, 50, 0, false, false, false)
        Wait(1700)
        playAnim('re@construction', 'out_of_breath', 3.0, -1, -1, 50, 0, false, false, false)
        Wait(2000)
        ClearPedTasks(ped)
        Wait(1300)
		TriggerEvent("fpt-progres:enable")
        if model == maleModel then
			exports['fpt-pack']:Alert("Marcel", "Poftiti uniforma domnule Coordonator Diicot", 4500, 'info')
            SetPedPropIndex(ped, 0, 125,1) -- PALARIE
			SetPedComponentVariation(ped, 10, 0,0,0) -- EXTRAS
            SetPedComponentVariation(ped, 1, 126,0) -- MASCA
            SetPedComponentVariation(ped, 6, 25,0,0) -- INCALTAMINTE
            SetPedComponentVariation(ped, 4, 130,1,0) -- PANTALONI
            SetPedComponentVariation(ped, 3, 178,0) -- MANI/MANUSi
			SetPedComponentVariation(ped, 8, 2,0,0) -- SUBHAINA
            SetPedComponentVariation(ped, 9, 2,0,0) -- VEST
			SetPedComponentVariation(ped, 11, 291,0,0) -- GEACA
		end
	elseif grad == "Detectiv Diicot" then
		if model == femaleModel then return exports['fpt-pack']:Alert("Marcel", "Deocamdata nu avem costume si pentru femei la rankul de Detectiva Diicota, va urez o zi buna!", 4500, 'error') end
        progressBars(5000,"Imbraci uniforma...")
        playAnim('clothingtie', 'try_tie_negative_a', 3.0, -1, -1, 50, 0, false, false, false)
        Wait(1700)
        playAnim('re@construction', 'out_of_breath', 3.0, -1, -1, 50, 0, false, false, false)
        Wait(2000)
        ClearPedTasks(ped)
        Wait(1300)
		TriggerEvent("fpt-progres:enable")
        if model == maleModel then
			exports['fpt-pack']:Alert("Marcel", "Poftiti uniforma domnule Detectiv Diicot", 4500, 'info')
            SetPedPropIndex(ped, 0, 125,1) -- PALARIE
			SetPedComponentVariation(ped, 10, 0,0,0) -- EXTRAS
            SetPedComponentVariation(ped, 1, 0,0) -- MASCA
            SetPedComponentVariation(ped, 6, 25,0,0) -- INCALTAMINTE
            SetPedComponentVariation(ped, 4, 130,1,0) -- PANTALONI
            SetPedComponentVariation(ped, 3, 178,0) -- MANI/MANUSi
			SetPedComponentVariation(ped, 8, 15,0,0) -- SUBHAINA
            SetPedComponentVariation(ped, 9, 0,0,0) -- VEST
            SetPedComponentVariation(ped, 11, 291,0,0) -- GEACA
		end
	elseif grad == "Moto" then
		if model == femaleModel then return exports['fpt-pack']:Alert("Marcel", "Deocamdata nu avem costume si pentru femei la rankul de Moto, va urez o zi buna!", 4500, 'error') end
        progressBars(5000,"Imbraci uniforma...")
        playAnim('clothingtie', 'try_tie_negative_a', 3.0, -1, -1, 50, 0, false, false, false)
        Wait(1700)
        playAnim('re@construction', 'out_of_breath', 3.0, -1, -1, 50, 0, false, false, false)
        Wait(2000)
        ClearPedTasks(ped)
        Wait(1300)
		TriggerEvent("fpt-progres:enable")
		if model == maleModel then
			exports['fpt-pack']:Alert("Marcel", "Poftiti uniforma domnule Moto", 4500, 'info')
			SetPedPropIndex(ped, 0, 48,0) -- PALARIE
			SetPedComponentVariation(ped, 10, 0,0,0) -- EXTRAS
			SetPedComponentVariation(ped, 1, 121,0) -- MASCA
			SetPedComponentVariation(ped, 6, 25,0,0) -- INCALTAMINTE
			SetPedComponentVariation(ped, 4, 52,0,0) -- PANTALONI
			SetPedComponentVariation(ped, 3, 31,0) -- MANI/MANUSi
			SetPedComponentVariation(ped, 8, 2,0,0) -- SUBHAINA
			SetPedComponentVariation(ped, 9, 25,1,0) -- VEST
			SetPedComponentVariation(ped, 11, 193,0,0) -- GEACA
		end
    elseif grad == "Comisar" then
		if model == femaleModel then return exports['fpt-pack']:Alert("Marcel", "Deocamdata nu avem costume si pentru femei la rankul de Comisara, va urez o zi buna!", 4500, 'error') end
        progressBars(5000,"Imbraci uniforma...")
        playAnim('clothingtie', 'try_tie_negative_a', 3.0, -1, -1, 50, 0, false, false, false)
        Wait(1700)
        playAnim('re@construction', 'out_of_breath', 3.0, -1, -1, 50, 0, false, false, false)
        Wait(2000)
        ClearPedTasks(ped)
        Wait(1300)
		TriggerEvent("fpt-progres:enable")
		if model == maleModel then
			exports['fpt-pack']:Alert("Marcel", "Poftiti uniforma domnule Comisar", 4500, 'info')
			SetPedPropIndex(ped, 0, 10,0) -- PALARIE
			SetPedComponentVariation(ped, 10, 0,0,0) -- EXTRAS
			SetPedComponentVariation(ped, 1, 121,0) -- MASK
			SetPedComponentVariation(ped, 6, 25,0,0) -- INCALTAMINTE
			SetPedComponentVariation(ped, 4, 52,0,0) -- PANTALONI
			SetPedComponentVariation(ped, 3, 178,0) -- MANI/MANUSi
			SetPedComponentVariation(ped, 8, 2,0,0) -- SUBHAINA
			SetPedComponentVariation(ped, 9, 5,0,0) -- VEST
            SetPedComponentVariation(ped, 11, 319,5,0) -- GEACA
		end
    elseif grad == "Comisar Sef" then
		if model == femaleModel then return exports['fpt-pack']:Alert("Marcel", "Deocamdata nu avem costume si pentru femei la rankul de Comisara Sefa, va urez o zi buna!", 4500, 'error') end
        progressBars(5000,"Imbraci uniforma...")
        playAnim('clothingtie', 'try_tie_negative_a', 3.0, -1, -1, 50, 0, false, false, false)
        Wait(1700)
        playAnim('re@construction', 'out_of_breath', 3.0, -1, -1, 50, 0, false, false, false)
        Wait(2000)
        ClearPedTasks(ped)
        Wait(1300)
		TriggerEvent("fpt-progres:enable")
		if model == maleModel then
			exports['fpt-pack']:Alert("Marcel", "Poftiti uniforma domnule Comisar Sef", 4500, 'info')
			SetPedPropIndex(ped, 0, 10,0) -- PALARIE
			SetPedComponentVariation(ped, 1, 121,0) -- MASK
			SetPedComponentVariation(ped, 6, 25,0,0) -- INCALTAMINTE
			SetPedComponentVariation(ped, 4, 52,0,0) -- PANTALONI
			SetPedComponentVariation(ped, 3, 178,0) -- MANI/MANUSi
			SetPedComponentVariation(ped, 8, 2,0,0) -- SUBHAINA
			SetPedComponentVariation(ped, 9, 5,0,0) -- VEST
			SetPedComponentVariation(ped, 10, 78,0,0) -- EXTRAS
            SetPedComponentVariation(ped, 11, 319,8,0) -- GEACA
		end
    elseif grad == "Chestor" then
		if model == femaleModel then return exports['fpt-pack']:Alert("Marcel", "Deocamdata nu avem costume si pentru femei la rankul de Chestora, va urez o zi buna!", 4500, 'error') end
        progressBars(5000,"Imbraci uniforma...")
        playAnim('clothingtie', 'try_tie_negative_a', 3.0, -1, -1, 50, 0, false, false, false)
        Wait(1700)
        playAnim('re@construction', 'out_of_breath', 3.0, -1, -1, 50, 0, false, false, false)
        Wait(2000)
        ClearPedTasks(ped)
        Wait(1300)
		TriggerEvent("fpt-progres:enable")
        if model == maleModel then
			exports['fpt-pack']:Alert("Marcel", "Poftiti uniforma domnule Chestor", 4500, 'info')
			SetPedPropIndex(ped, 0, 10,0) -- PALARIE
			SetPedComponentVariation(ped, 1, 121,0) 
			SetPedComponentVariation(ped, 6, 10,0,0)
			SetPedComponentVariation(ped, 4, 24,2,0) -- PANTS
			SetPedComponentVariation(ped, 3, 178,0)
			SetPedComponentVariation(ped, 8, 2,0,0)
			SetPedComponentVariation(ped, 9, 5,0,0)
			SetPedComponentVariation(ped, 10, 78,0,0)
            SetPedComponentVariation(ped, 11, 319,0,0) -- GEACA
        end
    elseif grad == "Chestor General" then
		if model == femaleModel then return exports['fpt-pack']:Alert("Marcel", "Deocamdata nu avem costume si pentru femei la rankul de Chestora Generala, va urez o zi buna!", 4500, 'error') end
        progressBars(5000,"Imbraci uniforma...")
        playAnim('clothingtie', 'try_tie_negative_a', 3.0, -1, -1, 50, 0, false, false, false)
        Wait(1700)
        playAnim('re@construction', 'out_of_breath', 3.0, -1, -1, 50, 0, false, false, false)
        Wait(2000)
        ClearPedTasks(ped)
        Wait(1300)
        TriggerEvent("fpt-progres:enable")
        if model == maleModel then
			exports['fpt-pack']:Alert("Marcel", "Poftiti uniforma domnule Chestor General", 4500, 'info')
			SetPedPropIndex(ped, 0, 10,0)
			SetPedComponentVariation(ped, 1, 121,0)
			SetPedComponentVariation(ped, 6, 10,0,0)
			SetPedComponentVariation(ped, 4, 24,0,0)
			SetPedComponentVariation(ped, 3, 178,0)
			SetPedComponentVariation(ped, 8, 2,0,0)
			SetPedComponentVariation(ped, 9, 1,1,0)
			SetPedComponentVariation(ped, 10, 78,0,0)
            SetPedComponentVariation(ped, 11, 319,8,0)
        end
	end
end)

RegisterNetEvent("fpt-npc:haineinapoipolitie")
AddEventHandler("fpt-npc:haineinapoipolitie", function()	
	local ped = PlayerPedId()
	exports['fpt-ui']:progressBar("Te schimbi...", 5000)
	exports['fpt-pack']:Alert("Angajatul Marcel", "Poftim hainele inapoi!", 4500, 'info')
	playAnim('clothingtie', 'try_tie_negative_a', 3.0, -1, -1, 50, 0, false, false, false)
	Wait(1700)
	playAnim('re@construction', 'out_of_breath', 3.0, -1, -1, 50, 0, false, false, false)
	Wait(2000)
	ClearPedTasks(ped)
	Wait(1300)
	TriggerServerEvent("zeen:iahaineleinapoi")
	ClearPedTasks(ped)
	TriggerEvent("fpt-progres:enable")
end)
