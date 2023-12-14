local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")



vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "vsGarages")

vRPSgarage = {}
Tunnel.bindInterface("vsGarages", vRPSgarage)
Proxy.addInterface("vsGarages", vRPSgarage)
vRPSgarage = Tunnel.getInterface("vsGarages", "vsGarages")

--vRPclient = Tunnel.getInterface("vRP","core_vehicle")

---# Call backs
ServerCallbacks = {}

RegisterServerEvent(GetCurrentResourceName() .. ':triggerServerCallback')
AddEventHandler(GetCurrentResourceName() .. ':triggerServerCallback', function(name, requestId, ...)
    local playerId = source

    TriggerServerCallback(name, requestId, playerId, function(...)
        TriggerClientEvent(GetCurrentResourceName() .. ':serverCallback', playerId, requestId, ...)
    end, ...)
end)

function RegisterServerCallback(name, cb)
    ServerCallbacks[name] = cb
end

function TriggerServerCallback(name, requestId, source, cb, ...)
    if ServerCallbacks[name] then
        ServerCallbacks[name](source, cb, ...)
    end
end

RegisterServerCallback('getuvehs', function(source, cb)
    exports.ghmattimysql:execute("SELECT * FROM vrp_user_vehicles WHERE user_id=@user_id",
        { user_id = vRP.getUserId({ source }) }
        , function(pvehicles)
        cb(pvehicles)
    end)
end)