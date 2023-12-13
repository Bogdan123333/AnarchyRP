local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","esk_tuning")
vRPCtuning = Tunnel.getInterface("esk_tuning","esk_tuning")
vRPtuning = {}
Tunnel.bindInterface("esk_tuning",vRPtuning)
Proxy.addInterface("esk_tuning",vRPtuning)


vRPtuning.getMyMoney = function()
    local user_id = vRP.getUserId({source})
    if user_id ~= nil then
        local player = vRP.getUserSource({user_id})
        local handmoney = vRP.getMoney({user_id})
        local bankmoney = vRP.getBankMoney({user_id})
        local money = handmoney + bankmoney
        vRPCtuning.updateMyMoney(player,{money})
    end
end


vRPtuning.saveTuning = function(tuning)
	local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})
	
	vRPclient.getNearestOwnedVehicle(player,{7},function(ok,vtype,name)
		if ok then
			exports.fpt_db:query("UPDATE vrp_user_vehicles  SET upgrades = @upgrades WHERE user_id = @id and vehicle = @model ", {
				['@id'] = user_id,
				['@upgrades'] = json.encode(tuning),
				['@model'] = name
			})
		end
	end)
end

RegisterServerEvent('esk:getTuning')
AddEventHandler('esk:getTuning',function(vehicle)
	local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})
    exports.fpt_db:query("SELECT * FROM vrp_user_vehicles  WHERE user_id = @user_id AND vehicle = @vehicle AND upgrades IS NOT NULL", {['@user_id'] = user_id, ['@vehicle'] = vehicle}, function (rows)
		if #rows > 0 then 
			tuning = json.decode(rows[1].upgrades)
			vRPCtuning.setTuningOnVehicle(player,{tuning})
		end
	end)
end)


RegisterServerEvent('mechanic:sv:removeCash')
AddEventHandler('mechanic:sv:removeCash', function(amount)
	local src = source

    amount = tonumber(amount)
    if (not amount or amount <= 0) then return end
    
    local user_id = vRP.getUserId({src})
    if (user_id) then
        if vRP.tryFullPayment({user_id,amount}) then 
            TriggerClientEvent("fpt:notify", src, 'success', 'Ai platit $'..amount..'  cu succes!')
        else
            return 
        end
    end
end)