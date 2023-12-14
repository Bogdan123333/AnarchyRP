local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

local vRP = Proxy.getInterface("vRP")
local vRPclient = Tunnel.getInterface("vRP", "vrp_dealership")

local cfg = module("vrp_dealership", "config")

RegisterNetEvent("ples-dealership:requestCategory", function ()
    local player = source
    local user_id = vRP.getUserId({player})
    local categoryMenu =  {name="Category",css = {top="75px",header_color="rgba(255, 255,0,0.8)"}}
    SetPlayerRoutingBucket(player, player)
    if user_id then
        for k, v in pairs(cfg.vehicles) do
            categoryMenu[k] = {function(player,choice)
                TriggerClientEvent("ples-dealership:getMenuVeh", player, 1, #v, {category = k, title = v[1][1], model = v[1][2], formPrice = v[1][3], stock = v[1][4]})
                vRP.closeMenu({player,categoryMenu})
            end}
        end
        vRP.openMenu({player,categoryMenu})
    end
end)

RegisterNetEvent("ples-dealership:getVeh", function (index, category)
    local player = source
    TriggerClientEvent("ples-dealership:getMenuVeh", player, index, #cfg.vehicles[category], {category = category, title = cfg.vehicles[category][index][1], model = cfg.vehicles[category][index][2], formPrice = cfg.vehicles[category][index][3], stock = cfg.vehicles[category][index][4]})
end)

RegisterNetEvent("ples-dealership:tryBuyCar", function (category, index)
    local player = source
    local user_id = vRP.getUserId({player})
    if user_id then
        if cfg.vehicles[category][index][4] > 0 then
            local hasVeh = exports.ghmattimysql:executeSync("SELECT id FROM vrp_user_vehicles WHERE user_id = @user_id AND vehicle = @vehicle", {["@user_id"] = user_id, ["@vehicle"] = cfg.vehicles[category][index][2]})
            if #hasVeh == 0 then
                if vRP.tryPayment({user_id, cfg.vehicles[category][index][3]}) then
                    math.randomseed(os.time())
                    local tempPlate = "B "..math.random(10000,99999)
                    cfg.vehicles[category][index][4] = cfg.vehicles[category][index][4] - 1
                    exports.ghmattimysql:execute("UPDATE stocks SET stock = @stock WHERE model = @model", {["@stock"] = cfg.vehicles[category][index][4], ["@model"] = cfg.vehicles[category][index][2]})
                    exports.ghmattimysql:execute("INSERT IGNORE INTO vrp_user_vehicles(user_id,vehicle,vehicle_plate) VALUES(@user_id,@model,@plate)", {["user_id"] = user_id, ["@model"] = cfg.vehicles[category][index][2], ["@plate"] = tempPlate})
                    vRPclient.notify(player, {"Succes: Ai plait suma de "..vRP.formatMoney({cfg.vehicles[category][index][3]}).."$ pentru acest vehicul!\nDu-te la un garaj pentru a-l scoate!"})
                else
                    vRPclient.notify(player, {"Eroare: Nu ai suficienti bani"})
                end
            else
                vRPclient.notify(player, {"Eroare: Ai deja aceasta masina"})
            end
        else
            vRPclient.notify(player, {"Eroare: Nu sunt destule masini in stock"})
        end
    end
end)

RegisterNetEvent("ples-dealership:exitDealership", function ()
    local player = source
    if GetPlayerRoutingBucket(player) == player then
        SetPlayerRoutingBucket(player, 0)
    end
end)

function initCars()
    for k, v in pairs(cfg.vehicles) do
        for i = 1, #v do
            Wait(100)
            exports.ghmattimysql:execute("SELECT stock FROM stocks WHERE model = @model", {['@model'] = v[i][2]}, function (rows)
                if #rows <= 0 then
                    v[i][4] = 0
                    Wait(100)
                    exports.ghmattimysql:execute("INSERT INTO stocks(model, stock) VALUES(@model, @stock)", {['@model'] = v[i][2], ['@stock'] = v[i][4]})
                end
                v[i][4] = rows[1].stock
            end)
        end
    end
end
CreateThread(initCars)

function getValAndR(R, val, curT,T)
    if not R then
        if val == "+" then
            curT = curT + T
            return curT
        end
        curT = curT - T
        return curT
    end
    if val == "+" then
        return {"adaugat", "pe"}
    end
    return {"scos", "din"}
end

RegisterCommand("stock", function(player)
    local user_id = vRP.getUserId{player}
    local isAdmin = vRP.isUserFondator{user_id}
    if isAdmin then
        local CStockMenu =  {name="CStock Menu",css = {top="75px",header_color="rgba(255, 255,0,0.8)"}}
        for k, v in pairs(cfg.vehicles) do
            CStockMenu[k] = {function (player, choice)
                local VStockMenu = {name="VStock Menu",css = {top="75px",header_color="rgba(255, 255,0,0.8)"}}
                for i = 1, #v do
                    VStockMenu[v[i][1]] = {function(player, choice)
                        vRP.prompt({player,"Adauga/Scade : ","+/-", function(player, val)
                            local val = tostring(val)
                            if val ~= nil and val ~= "" then
                                vRP.prompt({player,"Stock -> "..v[i][1].." : ","",function(player,stock)
                                    local stock = parseInt(stock)
                                    if stock ~= nil and type(stock) == 'number' and stock >= 0 then
                                        v[i][4] = getValAndR(false, val, v[i][4], stock)
                                        exports.ghmattimysql:execute("UPDATE stocks SET stock = @stock WHERE model = @model", {["@stock"] = v[i][4], ["@model"] = v[i][2]})
                                        vRPclient.notify(player, {"Succes: Ai "..getValAndR(true,val)[1].." "..stock.." "..v[i][1].." "..getValAndR(true,val)[2].." stock"})
                                    else
                                        vRPclient.notify(player, {"Eroare: Numarul de stock-uri este invalid"})
                                    end
                                    vRP.closeMenu({player,VStockMenu})
                                end})
                            else
                                vRPclient.notify(player, {"Eroare: Valoare invalida"})
                            end
                        end})
                    end}
                end
                vRP.openMenu({player,VStockMenu})
            end}
        end
        vRP.openMenu({player,CStockMenu})
    else
        vRPclient.notify(player, {"Eroare: Nu ai acces la comanda /stock"})
    end
end)