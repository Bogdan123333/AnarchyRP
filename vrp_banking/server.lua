local Proxy, Tunnel = module("vrp", "lib/Proxy"), module("vrp", "lib/Tunnel")
local vRP, vRPclient = Proxy.getInterface("vRP"), Tunnel.getInterface("vRP", "illusion_banking")

local vRPBank = {}
Tunnel.bindInterface("illusion_banking", vRPBank)
Proxy.addInterface("illusion_banking", vRPBank)

function vRPBank.getInfo()
    local user_id = vRP.getUserId{source}
    if not user_id then return end
    local balance = vRP.formatMoney{vRP.getBankMoney{user_id}}
    return {
        iban = user_id,
        balance = balance
    }
end

RegisterServerEvent("banking:Action", function(data)
    local user_id = vRP.getUserId{source}
    if not user_id or not type(data) == "table" then return end
    if data.type == "depunere" then
        if not data.amount then return end
        local suma = tonumber(data.amount)
        if vRP.tryPayment{user_id, suma} then
            vRP.giveBankMoney{user_id, suma}
            vRPclient.notify(source, {"Succes: Ai depozitat suma de $"..vRP.formatMoney{suma}})
        else
            vRPclient.notify(source, {"Eroare: Nu ai destui bani la tine!"})
        end
    elseif data.type == "retragere" then
        if not data.amount then return end
        local suma = tonumber(data.amount)
        if vRP.tryBankPayment{user_id, suma} then
            vRP.giveMoney{user_id, suma}
            vRPclient.notify(source, {"Succes: Ai depozitat suma de $"..vRP.formatMoney{suma}})
        else
            vRPclient.notify(source, {"Eroare: Nu ai destui bani in cont!"})
        end
    elseif data.type == "transfer" then
        if not data.id then return end
        local target_id = tonumber(data.id)
        local target_src = vRP.getUserSource{target_id}
        if not target_src then
            vRPclient.notify(source, {"Eroare: Jucatorul nu este online!"})
            return
        end
        if target_id == user_id then
            vRPclient.notify(source, {"Eroare: Nu iti poti transfera bani singur!"})
            return
        end
        if not data.amount then return end
        local suma = tonumber(data.amount)
        if vRP.tryBankPayment{user_id, suma} then
            vRP.giveBankMoney{target_id, suma}
            vRPclient.notify(source, {"Succes: I-ai transferat lui "..vRP.getPlayerName{target_src}.." suma de $"..vRP.formatMoney{suma}})
            vRPclient.notify(target_src, {"Info: "..vRP.getPlayerName{source}.." ti-a transferat suma de $"..vRP.formatMoney{suma}})
        else
            vRPclient.notify(source, {"Eroare: Nu ai destui bani in cont!"})
        end
    end
end)