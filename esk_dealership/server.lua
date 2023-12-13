local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","esk_dealership")
vRPCds = Tunnel.getInterface("esk_dealership","esk_dealership")
vRPds = {}
Tunnel.bindInterface("esk_dealership",vRPds)
Proxy.addInterface("esk_dealership",vRPds)

RegisterServerEvent('enterCx', function()
    local player = source; 
    
    SetPlayerRoutingBucket(player, tonumber('6'..source))
end)

RegisterServerEvent('leaveCx', function()
    local player = source;
    SetPlayerRoutingBucket(player, 0)
end)

local vehiclesTable = {}
CreateThread(function()
    for k,v in pairs(config.dealerships[1].vehicles) do
        for x,y in next,v do
            vehiclesTable[y.spawncode] = y.price
        end
    end
end)

AddEventHandler('vRP:onPaydayCalled', function(id)
    local ahah = 0;
    exports.ghmattimysql:execute('SELECT * FROM vrp_user_vehicles WHERE user_id = ?', {id}, function(rows)
        for k, v in pairs(rows) do
            ahah = ahah+(math.floor((vehiclesTable[v.vehicle] or 0)*0.01)+0.5);
        end;
        vRPclient.notify(vRP.getUserSource({id}),{'Ti-au fost luati '..ahah..'$ impozit pe masiniile detinute.'})
        if vRP.tryBankPayment({id, ahah}) then
            return
        else
            vRP.setBankMoney({id,0})
        end
    end)
end)

local vehicleStocks = {}
AddEventHandler('onResourceStart', function(resourceName)
    if resourceName == "esk_dealership" then 
       
        defaultStock = 0
        for key,value in pairs (config.dealerships) do
            for i,p in pairs (value.vehicles) do
                for mata,tactumare in pairs(p) do
                    Wait(100)
                    exports.ghmattimysql:execute("SELECT vehicleSpawnCode FROM showroom_stock WHERE vehicleSpawnCode = @vehicleSpawnCode", {['@vehicleSpawnCode'] = tactumare.spawncode}, function (exist)
                        if #exist == 0 then
                            exports.ghmattimysql:execute("INSERT IGNORE INTO showroom_stock(vehicleName,vehicleSpawnCode,stock,type) VALUES(@vehicleName,@vehicleSpawnCode,@stock,@type)", {
                                ['@vehicleName'] = mata,
                                ['@vehicleSpawnCode'] = tactumare.spawncode,
                                ['@stock'] = defaultStock,
                                ['@type'] = value.type
                            }) 
                            
                            print("NEW VEHICLE INSERTED IN DATABASE - "..tactumare.spawncode.." TYPE - "..value.type)
                        end
                        exports.ghmattimysql:execute("SELECT * FROM showroom_stock", {}, function (table)
                            for k,v in pairs (table) do
                                insertInTable(v.vehicleName,v.vehicleSpawnCode,v.stock or 0)
                            end
                        end)
                    end)
                end
            end
        end        
        print('^2VEHICLE STOCKS LOADED^7')
    end
end)



insertInTable = function(vehicleName,vehicleSpawnCode, stock)
    vehicleStocks[vehicleName] = {vehicleSpawnCode = vehicleSpawnCode,stock = stock}
end

vRPds.getAllVehicleStocks = function()
    return vehicleStocks
end

checkVehicleStock = function(vehicle)
    for k,v in pairs (vehicleStocks) do
        if v.vehicleSpawnCode == vehicle then
            return v.stock
        end
    end
end

updateVehicleStock = function(vehicle) 
    for k,v in pairs (vehicleStocks) do
        if v.vehicleSpawnCode == vehicle then
            v.stock = v.stock - 1
            exports.ghmattimysql:execute("UPDATE showroom_stock SET stock = @stock WHERE vehicleSpawnCode = @vehicleSpawnCode  ", {['@vehicleSpawnCode'] = vehicle, ['@stock'] = v.stock})
        end
    end
end

RegisterCommand('setstock',function(source, args)
    local player = source;
    local user_id = vRP.getUserId{player};
    if vRP.isUserOwner{user_id} then
        if not (args[1] or args[2]) then return vRPclient.notify(player, {"/restock [spawncode] [+stock]"}) end; 
        local masina = tostring(args[1])
        local stock = parseInt(args[2]);
        if masina and stock then
            for k,v in pairs(vehicleStocks) do
                if v.vehicleSpawnCode == masina then
                    v.stock = stock;
                    exports.ghmattimysql:execute("UPDATE showroom_stock SET stock = @stock WHERE vehicleSpawnCode = @vehicleSpawnCode", {['@vehicleSpawnCode'] = masina, ['@stock'] = v.stock});
                    vRPclient.notify(player, {"Ai editat "..stock.." masini ("..masina..") cu succes!"});
                    break;
                end
            end
        end
    end
end)

RegisterCommand('restock',function(source, args)
    local player = source
    local user_id = vRP.getUserId{player}
    if vRP.isUserOwner{user_id} then
        if not (args[1] or args[2]) then return vRPclient.notify(player, {"/restock [spawncode] [+stock]"}) end; 
        local masina = tostring(args[1])
        local stock = parseInt(args[2]);
        if masina and stock then
            for k,v in pairs(vehicleStocks) do
                if v.vehicleSpawnCode == masina then
                    v.stock = v.stock + stock;
                    exports.ghmattimysql:execute("UPDATE showroom_stock SET stock = @stock WHERE vehicleSpawnCode = @vehicleSpawnCode", {['@vehicleSpawnCode'] = masina, ['@stock'] = v.stock});
                    vRPclient.notify(player, {"Ai adaugat +"..stock.." masini in stock ("..masina..") cu succes!"});
                    break;
                end
            end
        end
    end
end)

vRPds.checkMoneyForTesting = function()
    local user_id = vRP.getUserId({source})
    if user_id ~= nil then
        testPrice = 50
            return vRP.tryPayment({user_id,testPrice}) 
    end
end

vRPds.checkMoneyForBuyingVehicle = function(showroomID,selectedVehicle)
    local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})
    if user_id ~= nil then
        for k,v in pairs (config.dealerships[showroomID].vehicles) do
            --print(json.encode(v))
            for mata,tactumare in pairs(v) do
                if tactumare.vehID == selectedVehicle then
                    model = tactumare.spawncode
                    stock = checkVehicleStock(model)
                    if stock > 0 then
                        --vRP.getUserIdentity({user_id, function(identity)
                            exports.ghmattimysql:execute("SELECT vehicle FROM vrp_user_vehicles WHERE user_id = @user_id AND vehicle = @vehicle", {['@user_id'] = user_id, ['@vehicle'] = model}, function (haveCar)
                                if #haveCar > 0 then
                                    vRPclient.notify(player,{"Ai deja aceasta masina."})
                                else
                                    if vRP.tryPayment({user_id,tactumare.price}) then
                                        local myPlate = math.random(00000,99999)
                                        exports.ghmattimysql:execute("INSERT IGNORE INTO vrp_user_vehicles(user_id,vehicle,upgrades,vehicle_plate) VALUES(@user_id,@vehicle,@upgrades,@vehicle_plate)", {
                                            ['@user_id'] = user_id,
                                            ['@vehicle'] = model,
                                            ['@upgrades'] = json.encode(tuning),
                                            ['@vehicle_plate'] = "P "..myPlate,
                                        })
                                        updateVehicleStock(model)
                                        vRPclient.notify(player, {"Ai platit ~g~$"..tactumare.price.."~w~ pentru acest vehicul!\nDu-te la un garaj pentru a-l scoate!"})
                                        vRPCds.closeShowroom(player,{})
                                        return true
                                    else
                                        vRPclient.notify(player,{"Nu ai suficienti bani sa cumperi aceasta masina."})
                                        return false
                                    end
                                end
                            end)
                    -- end})
                    else
                        vRPclient.notify(player,{"Stock insuficient la aceasta masina !"})
                        return false 
                    end
                    return false 
                end
            end
        end
    end
end

