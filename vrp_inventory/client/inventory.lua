local vRP = Proxy.getInterface("vRP")

RegisterCommand("deschideInventar", function()
    if IsPedFalling(PlayerPedId()) then return end
    
    TriggerServerEvent("fp-inventory:openInventory")
end)

RegisterKeyMapping("deschideInventar", "Deschide inventarul", "keyboard", "i")

RegisterNetEvent('fp-inventory:openInventory', function(inventory, totalWeight, maxWeight, chestData, playerInventory)
    if not vRP.isHandcuffed{} then
        
        SetNuiFocus(true, true)
        TriggerScreenblurFadeIn(1000)

        SendNUIMessage({
            action = "openInventory",
            inventory = inventory,
            totalWeight = math.floor(totalWeight),
            maxWeight = math.floor(maxWeight),
            other = chestData,
            playerData = playerInventory,
            NearPlayer = vRP.getNearestPlayer({5}),
            isInVehicle = IsPedInAnyVehicle(PlayerPedId(), false),
        })
    
    end
end)

RegisterNetEvent("fp-inventory:refreshInventory", function(inventory, totalWeight, maxWeight, chestData, playerInventory)
    SendNUIMessage({
        action = "refresh",
        inventory = inventory,
        totalWeight = math.floor(totalWeight),
        maxWeight = math.floor(maxWeight),
        other = chestData,
        playerData = playerInventory,
    })
end)



RegisterNUICallback("GiveItem", function(data, cb)
    TriggerServerEvent("fp-inventory:giveItem", data.item, data.amount)
end)

RegisterNUICallback("DropItem", function(data)
    TriggerServerEvent("fp-inventory:trashItem", data.item, data.label, data.amount)
end)

RegisterNUICallback("UseItem", function(data, cb)
    TriggerServerEvent("fp-inventory:useItem", data.item)
end)


-- OTHERS

RegisterNUICallback("storeUserWeapons", function(_, cb)
    TriggerServerEvent("vRP:storeWeapons")
    cb("www.fairplay-rp.ro")
end)

RegisterNetEvent("fp-inventory:forceClose", function()
    SendNUIMessage{
        action = "close",
    }
end)

RegisterNUICallback("CloseInventory", function(data, cb)
    TriggerScreenblurFadeOut(1000)
    SetNuiFocus(false, false)
    TriggerServerEvent("fp-inventory:closeChest")
end)

RegisterNUICallback("SetInventoryData", function(data, cb)
    if data.frominventory == "other" then
        TriggerServerEvent("fp-inventory:fromChestToPlayer", data.item, tonumber(data.amount), data.isPlayer);
    else
        TriggerServerEvent("fp-inventory:fromPlayerToChest", data.item, tonumber(data.amount), data.isPlayer)
    end
    cb("ok")
end)

RegisterNUICallback("CerePortbagaj", function(data, cb)
    TriggerServerEvent("fp-inventory:CerePortbagaj")
    cb("ok")
end)

RegisterNUICallback("CereTorpedou", function(data, cb)
    TriggerServerEvent("fp-inventory:CereTorpedou")
    cb("ok")
end)

RegisterNUICallback("Perchezitioneaza", function(data, cb)
    TriggerServerEvent("fp-inventory:PerchezitioneazaJucator")
    cb("ok")
end)

RegisterNUICallback("StrangeArmele", function(data, cb)
    TriggerServerEvent("fp-inventory:storeWeapons")
    cb("ok")
end)

RegisterNUICallback("GiveMoney", function(data, cb)
    TriggerServerEvent("fp-inventory:OferaBani")
    cb("ok")
end)