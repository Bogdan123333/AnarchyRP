do return (function ()
    local Tunnel, Proxy  = module("vrp", "lib/Tunnel"), module("vrp", "lib/Proxy")
    local vRP, vRPclient  = Proxy.getInterface("vRP"), Tunnel.getInterface("vRP","fire-inventory")

    local cfg_inventory = {}

    cfg_inventory.default_vehicle_chest_weight = 50
    cfg_inventory.vehicle_chest_weights = {
        ["pista"] = 20,
        ["tdf"] = 20,
        ["sf90"] = 15,
        ["f812"] = 15,
        ["rmodveneno"] =18,
        ["urus"] = 35,
        ["lp770r"] = 18,
        ["720spider"] = 20,
        ["ast"] = 15,
        ["db11"] = 22,
        ["r820"] = 20,
        ["rs7"] = 25,
        ["audirs6tk"] = 30,
        ["17m760i"] = 30,
        ["745le"] = 30,
        ["m6f13"] = 25,
        ["bugatti"] = 20,
        ["divo"] = 20,
        ["bbentayga"] = 40,
        ["ben17"] = 25,
        ["contgt13"] = 20,
        ["c7"] = 20,
        ["limoxts"] = 35,
        ["fct"] = 15,
        ["gtc4"] = 25,
        ["17jamb"] = 60,
        ["gt17"] = 20,
        ["fgt"] = 15,
        ["918"] = 20,
        ["911t4s2"] =20,
        ["lamboavj"] = 25,
        ["lp610"] = 25,
        ["rmodsian"] = 25,
        ["c63s"] = 35,
        ["g65amg"] = 55,
        ["s500w222"] = 25,
        ["mers63c"] = 25,
        ["amggtsmansory"] = 25,
        ["amggtrr20"] = 25,
        ["e63amg"] = 25,
        ["brabus850"] = 28,
        ["19S63"] = 30,
        ["mp412c"] = 20,
        ["morgan"] = 15,
        ["rmodskyline"] = 20,
        ["tulenis"] = 58,
        ["rmodpagani"] = 20,
        ["cullinan"] = 54,
        ["rrphantom"] = 25,
        ["ph8m"] = 25,
        ["dawnonyx"] = 20,
        ["agerars"] = 20,
        ["2018s650p"] = 35,
        ["regalia"] = 20,
        ["a6avant"] = 25,
        ["evo9mr"] = 20,
        ["rs52018"] = 25,
        ["as7"] = 25,
        ["audiq8"] = 45,
        ["a8fsi"] = 25,
        ["ttrs"] = 20,
        ["m3f80"] = 25,
        ["f82"] = 25,
        ["m4c"] = 22,
        ["m516"] = 30,
        ["48is"] = 45,
        ["440i"] = 25,
        ["530d"] = 25,
        ["m2"] = 25,
        ["m3e92"] = 22,
        ["czr2"] = 65,
        ["16ss"] = 25,
        ["can"] = 15,
        ["16challenger"] = 25,
        ["nspeedo"] = 90,
        ["mgt"] = 25,
        ["fastback"] = 20,
        ["f150"] = 80,
        ["18macan"] = 25,
        ["gmc1500"] = 75, 
        ["denalihd"] =70,
        ["jeep2012"] = 65,
        ["jp12"] = 65,
        ["jeepg"] = 45,
        ["mlbrabus"] = 40,
        ["e400"] = 30,
        ["cls2015"] = 30,
        ["gl63"] = 45,
        ["cla45"] = 30,
        ["evo10"] = 25,
        ["370z"] = 25,
        ["rrst"] = 55,
        ["fjcruiser"] = 55,
        ["golf7gti"] = 25,
        ["a8audi"] = 20,
        ["c5rs6"] = 20,
        ["b5s4"] = 25,
        ["e46"] = 25,
        ["m3e36"] = 25,
        ["850"] = 25,
        ["m3e30"] = 25,
        ["bmwe39"] = 30,
        ["M5E28"] = 30,
        ["e34"] = 25,
        ["m5e60"] = 30,
        ["bmwe90"] = 30,
        ["sobol"] = 85,
        ["e15082"] = 90,
        ["speedo"] = 100,
        ["steed2"] = 95,
        ["1310s"] = 15,
        ["logan"] = 18,
        ["daduster"] = 40,
        ["sandero08"] = 25, 
        ["sanderos2"] = 25,
        ["festivac"] = 15,
        ["ap2"] = 15,
        ["civic"] = 20,
        ["na6"] = 20,
        ["benzc32"] = 20,
        ["w210amg"] = 20,
        ["MBW124"] = 20,
        ["2dopelr3"] = 15,
        ["206c"] = 15,
        ["R50"] = 45,
        ["golf1"] = 25,
        ["golf2"] = 25,
        ["golfgti"] =25, 
        ["celisupra"] = 30, 
        ["tico"] = 15,
        ["v242"] = 20,
        ["volvo850r"] = 25,
        ["audquattros"] = 25,
        ["69charger"] = 25,
        ["tiburon"] = 20,
        ["honcrx91"] = 20,
        ["tornado2"] = 20,
        ["deltaintegrale"] = 20,
        ["rx811"] = 20,
        ["fd"] = 20,
        ["eclipsegt09"] = 20,
        ["eclipsegt06"] = 20,
        ["cp9a"] = 20,
        ["mitsugto"] = 20,
        ["skyline"] = 20, 
        ["bnr34"] = 25,
        ["bnr32"] = 25,
        ["silvias15"] = 20,
        ["nis13"] = 25,
        ["gtr"] = 30,
        ["a80"] = 28,
        ["tsgr20"] = 28,
        ["mr2sw20"] = 20,
        ["subisti08"] = 25,
        ["brztuning"] = 20,
        ["rsv4"] = 10,
        ["blazer6"] = 10,
        ["monsteratv"] = 10,
        ["bmws"] = 10,
        ["diavel"] = 10,
        ["cb500x"] = 10,
        ["bros60"] = 10,
        ["goldwing"] = 10,
        ["africat"] = 10,
        ["hvrod"] = 10,
        ["foxharley1"] = 12,
        ["foxharley2"] = 12,
        ["h2carb"] = 12,
        ["ktmsm"] = 10,
        ["stryder"] = 14,
        ["tmsm"] = 10,
        ["r1"] = 10,
        ["20r1"] = 10,
        ["r6"] = 10,
        ["tmaxDX"] = 12,
        ["r25"] = 10,
        ["primo2"] = 20,
        ["voodoo"] = 20,
        ["sabregt2"] = 25,
        ["slamvan3"] = 25,
        ["minivan2"] = 20,
        ["chino2"] = 22,
        ["tornado5"] = 25
    }
    GetInvItems = function()
        local user_id = vRP.getUserId({source})
        if not user_id then return end
        local data = vRP.getUserDataTable({user_id})
        local indicator = 0
        tempInv = {}
        if data.inventory ~= nil and data.inventory ~= {} then
            for k,v in pairs(data.inventory) do
                local item_name = vRP.getItemName({k})
                local item_weight = vRP.getItemWeight({k}) * v.amount
                local itmImg = "NULL"
                if k:match('wammo|') then
                    itmImg = "wammo"
                elseif k:match('wbody|') then
                    itmImg = "wbody"
                end
                indicator = indicator + 1
                table.insert(tempInv, {
                    slot = indicator,
                    name = k,
                    label = item_name,
                    description = item_desc,
                    amount = v.amount,
                    weight = item_weight,
                })
            end

            return tempInv
        end
    end

    RefreshInv = function(user_id)

        if not user_id then return end
        local data = vRP.getUserDataTable({user_id})
        local player = vRP.getUserSource({user_id})
        local weight = vRP.getInventoryWeight({user_id})
        local maxWeight = vRP.getInventoryMaxWeight({user_id})

        local weightt = 0 
        local itemss = {}
        local mw = 0
        vRPclient.getNearestOwnedVehicle(player,{7},function(ok,vtype,name,vehicleId)
            if ok then
                local mere = vRPclient.isPlayerInAnyVehicle(player)
                if not mere then
                    local chestname = "u"..user_id.."veh_"..string.lower(name)
                    local max_weight = cfg_inventory.vehicle_chest_weights[string.lower(name)] or cfg_inventory.default_vehicle_chest_weight
                    local chest = {}
                    vRP.getSData({"chest:"..chestname, function(cdata)
                        chest.items = json.decode(cdata) or {}
                        mw = cfg_inventory.vehicle_chest_weights[string.lower(name)] or cfg_inventory.default_vehicle_chest_weight
                        weightt = vRP.computeItemsWeight{chest.items}
                        for k, v in pairs(chest.items) do
                            table.insert(itemss, {
                                name = vRP.getItemName{k},
                                amount = v.amount,
                                weight = vRP.getItemWeight{k},
                                img = "NULL",
                                item = k
                            })
                        end

                        TriggerClientEvent('fp-inventory:refreshInventory', player, GetInvItems(), weight, maxWeight, itemss)
                    end})
                end
            elseif not ok then
                TriggerClientEvent('fp-inventory:refreshInventory', player, GetInvItems(), weight, maxWeight)
            end
        end)
    end

    RegisterServerEvent('fp-inventory:openInventory', function()
        local user_id = vRP.getUserId({source})
        local tempInv = {}
        local player = vRP.getUserSource({user_id})
        if player then
            local data = vRP.getUserDataTable({user_id})
            local weight = vRP.getInventoryWeight({user_id})
            local maxWeight = vRP.getInventoryMaxWeight({user_id})

            local weightt = 0 
            local itemss = {}
            local mw = 0
            vRPclient.getNearestOwnedVehicle(player,{7},function(ok,vtype,name,vehicleId)
                if ok then
                    local mere = vRPclient.isPlayerInAnyVehicle(player)
                    if not mere then
                        local chestname = "u"..user_id.."veh_"..string.lower(name)
                        local max_weight = cfg_inventory.vehicle_chest_weights[string.lower(name)] or cfg_inventory.default_vehicle_chest_weight
                        local chest = {}
                        vRP.getSData({"chest:"..chestname, function(cdata)
                            chest.items = json.decode(cdata) or {}
                            mw = cfg_inventory.vehicle_chest_weights[string.lower(name)] or cfg_inventory.default_vehicle_chest_weight
                            weightt = vRP.computeItemsWeight{chest.items}
                            for k, v in pairs(chest.items) do
                                table.insert(itemss, {
                                    name = vRP.getItemName{k},
                                    amount = v.amount,
                                    weight = vRP.getItemWeight{k},
                                    img = "NULL",
                                    item = k
                                })
                            end

                            TriggerClientEvent('fp-inventory:openInventory', player, GetInvItems(), weight, maxWeight, itemss)
                        end})
                    end
                elseif not ok then
                    TriggerClientEvent('fp-inventory:openInventory', player, GetInvItems(), weight, maxWeight)
                end
            end)

        
        end
	end)


    RegisterNetEvent("fp-inventory:giveItem", function(idnamee, ammm)
        local user_id = vRP["getUserId"]{source}
        local player = vRP["getUserSource"]{user_id}
        local idname = tostring(idnamee)
        local amount = tonumber(ammm)
        if idname == 'pachetglovo' then return  vRPclient["notify"](player, {"Eroare: Nu poti oferi pachetul glovo!"}) end
        vRPclient["selectNearestPlayer"](player,{8, false},function(sourcetogive)
            local nplayer = tonumber(sourcetogive)
            local nuser_id = vRP["getUserId"]{nplayer}
            local itemweight = vRP["getItemWeight"]{idname}*amount
            local new_weight = vRP["getInventoryWeight"]{nuser_id}+itemweight
            if new_weight <= vRP["getInventoryMaxWeight"]{nuser_id} then
                if vRP["tryGetInventoryItem"]{user_id, idname, amount, false} then
                    vRP["giveInventoryItem"]{nuser_id, idname, amount, false}
                    RefreshInv(user_id)
                    RefreshInv(nuser_id)
                    vRPclient["notify"](player, {"Ai oferit x"..amount.." "..idname.." lui "..GetPlayerName(nplayer).."("..nuser_id..")!"})
                    vRPclient["notify"](nplayer, {"Ai primit x"..amount.." "..idname.." de la "..GetPlayerName(player).."("..user_id..")!"})
                    return
                else
                    vRPclient["notify"](player, {"Eroare: Nu ai acest item in inventar!"})
                    return
                end
            else
                vRPclient["notify"](player, {"Eroare: Aceasta persoana nu are destul spatiu in inventar!"})
                return
            end
        end)
    end)

    RegisterServerEvent('fp-inventory:useItem', function(idname)
        local player = source
        local user_id = vRP.getUserId({player})
        if user_id ~= nil then
            local idname = tostring(idname)
    
            local choice = vRP.getItemChoices({idname})
            local descriere = vRP.getItemDescription({idname})
            if json.encode(choice) ~= '[]' then
                for key,value in pairs(choice) do 
                    local cb = value[1]
                    if cb ~= nil then
                        cb(player,k,1)
                        RefreshInv(user_id)
                    end
                end
            else
                vRPclient.notify(player,{'~r~Acest item nu poate fi folosit!'})
            end
        end
    end)

    RegisterNetEvent("fp-inventory:fromChestToPlayer", function(itemm, amm, isPl)
        local user_id = vRP.getUserId{source}
        local player = vRP.getUserSource{user_id}

        if not user_id then return end 
        if not player then return end 

        vRPclient.getNearestOwnedVehicle(source,{7},function(ok,vtype,name,vehicleId)
            if ok then
                local chest = { max_weight = 40; }
                local chestname = "u"..user_id.."veh_"..string.lower(name)
                exports.oxmysql:execute("SELECT dvalue FROM vrp_srv_data WHERE dkey = @key", {key = "chest:"..chestname}, function(rows)
                    if rows[1] == nil then
                        chest.items = {}
                    else
                        chest.items = json.decode(rows[1].dvalue) or {}
                    end
                    local amount = amm
                    local idname = itemm
                    local citem = chest.items[idname]
                    local new_weight = vRP.getInventoryWeight{user_id}+vRP.getItemWeight{idname}*amount
                    if new_weight <= vRP.getInventoryMaxWeight{user_id} then
                        vRP.giveInventoryItem{user_id, idname, amount, true}
                        RefreshInv(user_id)
                        citem.amount = citem.amount-amount
                        if citem.amount <= 0 then
                            chest.items[idname] = nil
                        end
                        if cb_out then cb_out(idname,amount) end
                        vRP.setSData({"chest:"..chestname, json.encode(chest.items)})
                    else
                        vRPclient.notify(source,{lang.inventory.full()})
                    end
                end)
            end
        end)

    end)

    RegisterNetEvent("fp-inventory:fromPlayerToChest", function(itemm, amm, isPl)
        local user_id = vRP.getUserId{source}
        local player = vRP.getUserSource{user_id}

        if not user_id then return end 
        if not player then return end 

        local chest = { max_weight = 40; }
        vRPclient.getNearestOwnedVehicle(source,{7},function(ok,vtype,name,vehicleId)
            if ok then
                local chestname = "u"..user_id.."veh_"..string.lower(name)
                exports.oxmysql:execute("SELECT dvalue FROM vrp_srv_data WHERE dkey = @key", {key = "chest:"..chestname}, function(rows)
                    if rows[1] == nil then
                        chest.items = {}
                    else
                        chest.items = json.decode(rows[1].dvalue) or {}
                    end
                    local idname = itemm
                    local max_weight = cfg_inventory.default_vehicle_chest_weight
                    local amount = amm
                    local new_weight = 0
                    if not (chest.items == nil) then
                        new_weight = vRP.computeItemsWeight({chest.items})+vRP.getItemWeight({idname})*amount
                    else
                        new_weight = 0+vRP.getItemWeight({idname})*amount
                    end
                    if new_weight <= max_weight then
                        if amount >= 0 and vRP.tryGetInventoryItem({user_id, idname, amount, true}) then
                            local citem = chest.items[idname]
                            RefreshInv(user_id)
                            if citem ~= nil then
                                citem.amount = citem.amount+amount
                            else
                                chest.items[idname] = {amount=amount}
                            end
                            if cb_in then cb_in(idname,amount) end
                            vRP.setSData({"chest:"..chestname, json.encode(chest.items)})
                        end
                    else
                        vRPclient.notify(source,{"Eroare: Nu ai spatiu destul in portbagaj"})
                    end
                end)
            end
        end)


    end)

    --Drops: 

    Drops = {}
    IDs = {}
    
    GenerateDropID = function()
        local id = 'Drop-'..math.random(10000,60000)
        while IDs[id] do 
            Wait(0)
            id = 'Drop-'..math.random(10000,60000)
        end
        IDs[id] = true
        return id
    end

    GetNumberOfTbls = function(tbl)
        local number = 0 

        for i,v in pairs(tbl) do
            number = number + 1
        end

        return number
    end
    
    -- Citizen.CreateThread(function()
    --     while GetNumberOfTbls(Drops) > 0 do
    --         Wait(1000) 
    --         TriggerClientEvent('fp-inventory:refreshDrops', source, Drops)
    --     end
    -- end)

    RegisterNetEvent('fp-inventory:trashItem',function(idname, label, amm)
        local player = source
        local user_id = vRP.getUserId({player})
        if user_id ~= nil then
            local idname = tostring(idname)
            local maxAmount = vRP.getInventoryItemAmount({user_id,idname})
            local itemName = vRP.getItemName({idname})
    
            local amount = amm

            if idname == 'pachetglovo' then return  vRPclient["notify"](player, {"Eroare: Nu poti arunca pachetul glovo!"}) end

            if vRP.tryGetInventoryItem({user_id,idname,amount,false}) then
                local id = GenerateDropID()
                Drops[id] = {
                    position = GetEntityCoords(GetPlayerPed(player)),
                    item = idname,
                    label = label,
                    amount = amount,
                }
    
                TriggerClientEvent('fp-inventory:refreshDrops', player, Drops)
                RefreshInv(user_id)
                vRPclient.notify(player,{'Ai aruncat x'..amount..' '..itemName})
                vRPclient.playAnim(player,{true,{{"pickup_object","pickup_low",1}},false})
                SetTimeout(600000,function()
                    Drops[id] = nil
                    TriggerClientEvent('fp-inventory:refreshDrops', player, Drops)
                end)
            else
                vRPclient.notify(player,{'~r~Valoare invalida!'})
            end
        end
    end)
    
    
    RegisterServerEvent('fp-inventory:collectDrop',function(_)
        local player = source
        local user_id = vRP.getUserId({player})
        if not user_id then return end
        if not Drops[_] then return TriggerEvent('Fire_:3', 'Event Injection ( fire-inventory:collectDrop )') end 
            
        vRPclient.playAnim(player,{true,{{"pickup_object","pickup_low",1}},false})
        vRP["giveInventoryItem"]{user_id, Drops[_].item, Drops[_].amount, false}
    
        Drops[_] = nil

        TriggerClientEvent('fp-inventory:refreshDrops', player, Drops)
    end)
end)() end
