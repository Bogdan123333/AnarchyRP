local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","cc_hud")

function betterMoney(amount)
  local left,num,right = string.match(tostring(amount),'^([^%d]*%d)(%d*)(.-)$')
  return left..(num:reverse():gsub('(%d%d%d)','%1.'):reverse())..right
end
AddEventHandler("vRP:playerLeave", function(user_id, source)
local player = vRP.getUserSource({user_id})
local user_id = vRP.getUserId({source})

end)

local playersOnline

RegisterServerEvent("GetAlexxInfo")
AddEventHandler("GetAlexxInfo",function()
   local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})
    if user_id ~= nil and user_id ~= 0 then
        TriggerClientEvent("Lsv1:updateMoney",player,betterMoney(vRP.getMoney({user_id})))
        TriggerClientEvent("Lsv1:updateMoneyBank",player,betterMoney(vRP.getBankMoney({user_id})))
        TriggerClientEvent("Lsv1:updateMoneyCoins",player,betterMoney(vRP.getKRCoins({user_id})))
        TriggerClientEvent("Lsv1:updateID",player,user_id)
   end
end)

timer = function ()
  SetTimeout(1500, function ()
      TriggerClientEvent("Lsv1:updateConnectedPlayers",-1, GetNumPlayerIndices())
      timer()
  end)
end

timer()