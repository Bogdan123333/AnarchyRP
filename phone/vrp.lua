local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
local vRP = Proxy.getInterface("vRP")
local vRPclient = Tunnel.getInterface("vRP", "fptPhone")
local fptPhone = {}
Tunnel.bindInterface("fptPhone", fptPhone)

local cfg = module("vrp","cfg/garages")
local vehicle_groups = cfg.garage_types
function getVName(v)
    for _,vehicles in pairs(vehicle_groups) do
        if vehicles[v] then
            return vehicles[v][1]
        end
    end
    return "Unknown"
end

local Tweets = {}
local Deeps = {}
local AppAlerts = {}
local MentionedTweets = {}
local Hashtags = {}
local Calls = {}
local Adverts = {}

RegisterCommand("rezolvare", function(player)
    local uid = vRP.getUserId{player}
    getOrGeneratePhoneNumber(uid)
    getOrGenerateIBAN(uid)
    TriggerClientEvent('fptPhone:playerSpawn', player)
    local data = exports.ghmattimysql:execute("SELECT * FROM twitter_tweets", {})[1]
    TriggerClientEvent('fptPhone:client:SetTweetsSpawn', player, data or {})
end)


fPhone={}
fPhone.ServerCallbacks={}


RegisterServerEvent('fPhone:triggerServerCallback')
AddEventHandler('fPhone:triggerServerCallback',function(a,b,...)
    local c=source

    fPhone.TriggerServerCallback(a,requestID,c,function(...)
        TriggerClientEvent('fPhone:serverCallback',c,b,...)
    end,...)
end)
        

function fptPhone.getBankMoney()
    local player = source;
    local user_id = vRP.getUserId{player};
    if not user_id then return 0 end;
    return vRP.formatMoney{vRP.getBankMoney{user_id}};
end;

    
fPhone.RegisterServerCallback = function(a,t)
    fPhone.ServerCallbacks[a]=t 
end
                    
fPhone.TriggerServerCallback = function(a,b,source,t,...)
    if fPhone.ServerCallbacks[a]~=nil then 
        fPhone.ServerCallbacks[a](source,t,...)
    else 
        print('TriggerServerCallback => ['..a..'] does not exist')
    end 
end

AddEventHandler("vRP:playerSpawn", function (user_id, player, fs)
    if fs then
        getOrGeneratePhoneNumber(user_id)
        getOrGenerateIBAN(user_id)
        TriggerClientEvent('fptPhone:playerSpawn', player)
        local data = exports.ghmattimysql:execute("SELECT * FROM twitter_tweets", {})[1]
        TriggerClientEvent('fptPhone:client:SetTweetsSpawn', player, data or {})
    end
end)
RegisterNetEvent('fptPhone:server:addImageToGallery', function(image)
    local src = source
    local user_id = vRP.getUserId{source}
    exports.oxmysql:execute('INSERT INTO phone_gallery (`user_id`, `image`) VALUES (@user_id, @image)',{user_id = user_id,image = image})
end)

RegisterNetEvent('fptPhone:server:getImageFromGallery', function()
    local src = source
    local uid = vRP.getUserId{source}
    local images = exports.ghmattimysql:execute('SELECT * FROM phone_gallery WHERE user_id = @user_id',{user_id = user_id})
    TriggerClientEvent('fptPhone:refreshImages', src, images)
end)

RegisterNetEvent('fptPhone:server:RemoveImageFromGallery', function(data)
    local src = source
    local user_id = vRP.getUserId{source}
    local image = data.image
    exports.oxmysql:execute('DELETE FROM phone_gallery WHERE user_id = @user_id AND image = @image',{user_id = user_id,image = image})
    TriggerClientEvent("rezolvacoae", source)
end)

function fptPhone.hasPhone()
    local player = source
    local user_id = vRP.getUserId{player}
    if user_id then
        if vRP.getInventoryItemAmount{user_id, "iphone"} >= 1 then
            return true
        end
    end
    vRPclient.notify(player, {"Nu ai un ~y~telefon~w~! Du-te la ~y~Digital Den~w~ si ~y~cumpara-ti~w~ unul, ti-am pus pe ~y~GPS~w~!"})
    --vRPclient.setGPS(player, {-657.15765380859,-857.33227539063,24.503076553345})
    return false
end

RegisterServerEvent('fptPhone:server:AddAdvert')
AddEventHandler('fptPhone:server:AddAdvert', function(msg)
    local src = source
    local userid = vRP.getUserId{src}

    if Adverts[userid] ~= nil then
        Adverts[userid].message = msg
        Adverts[userid].name = "@" .. userid .. ""
        Adverts[userid].number = getNumberPhone(userid)
    else
        Adverts[userid] = {
            message = msg,
            name = "@" .. userid .. "",
            number = getNumberPhone(userid),
        }
    end

    TriggerClientEvent('fptPhone:client:UpdateAdverts', -1, Adverts, "@" .. userid .. "")
end)

RegisterNetEvent("teducsilaparis", function()
    local user_id = vRP.getUserId{source}
    local mysource = vRP.getUserSource{user_id}

    local mytables = exports.ghmattimysql:execute('SELECT * FROM vrp_users WHERE id = @user_id',{user_id = user_id})
    local data = {
        name = {mytables[1].firstName, mytables[1].secondName},
        number = getNumberPhone(user_id)
    }
    vRPclient.getNearestPlayers(mysource,{tonumber(5)}, function(nplayers)
        for k,v in pairs(nplayers) do 
            TriggerClientEvent("fptPhone:client:AddNewSuggestion", k, data) 
        end
    end)
end)

function fptPhone.shareContact()
    local player = source
    local user_id = vRP.getUserId{player}
    if user_id then
        vRPclient.getNearestPlayers{5, function (players)
            if players then
                for k,v in pairs(players) do
                    local nearestId = vRP.getUserId{k}
                    if nearestId then
                        --local identity = vRP.getUserIdentity{nearestId}
                        vRP.getUserIdentity{nearestId,function(identity)
                            if identity ~= nil then
                                local data = {
                                    name = {identity.firstname or "Unknown", identity.name or "Unknown"},
                                    number = getNumberPhone(nearestId)
                                }
                                TriggerClientEvent("fptPhone:client:AddNewSuggestion", player, data)
                            end
                        end}
                    end
                end
            else
                TriggerClientEvent("fptPhone-new:client:BankNotify", player, "Nimeni in jurul tau.")
            end
        end}
    else
        return
    end
end

function fptPhone.getUserData()
    local player = source
    local user_id = vRP.getUserId{player}
    if user_id then
        --local identity = vRP.getUserIdentity{user_id}
        vRP.getUserIdentity{user_id,function(identity)
            if identity ~= nil then
                local data = {
                    id = user_id,
                    firstname = identity.firstname or "Unknown",
                    name = identity.name or "Unknown",
                    phone = getNumberPhone(user_id),
                    bank = vRP.getBankMoney{user_id},
                    iban = getIBAN(user_id),
                    profilepicture = getBackgroundOrProfilePicture(user_id, "profilepicture"),
                    background = getBackgroundOrProfilePicture(user_id, "background"),
                }
                TriggerClientEvent('fptPhone:client:SetUserData', player, data)
            end
        end}
    else
        return
    end
end

function getPhoneRandomNumber()
    local format = "07DDDDDDDD"
    local abyte = string.byte("A")
    local zbyte = string.byte("0")

    local number = ""
    for i=1,#format do
      local char = string.sub(format, i,i)
      if char == "D" then number = number..string.char(zbyte+math.random(0,9))
      elseif char == "L" then number = number..string.char(abyte+math.random(0,25))
      else number = number..char end
    end

    return number
end

math.randomseed(os.time(), math.random())

function generateIBAN(user_id)
    local str = "RO"
    local id = user_id
    local numBase0 = math.random(100, 999)
    local num = string.format(str.." "..id..numBase0)
	return num
end

function getNumberPhone(user_id)
    local data = exports.ghmattimysql:execute("SELECT phoneNumber FROM vrp_users WHERE id = @user_id", {user_id = user_id})[1]
    return data.phoneNumber or nil
end

function getIBAN(user_id)
    local data = exports.ghmattimysql:execute("SELECT iban FROM vrp_users WHERE id = @user_id", {user_id = user_id})[1]
    return data.iban or nil
end

function getOrGenerateIBAN(user_id)
    local pIBAN = getIBAN(user_id)
    if not pIBAN then
        pIBAN = generateIBAN(user_id)
        exports.oxmysql:execute("UPDATE vrp_users SET iban = @iban WHERE id = @user_id", {iban = pIBAN, user_id = user_id})
        return pIBAN
    end
    return pIBAN
end

function getUserIdFromIban(iban)
    local data = exports.ghmattimysql:execute("SELECT id FROM vrp_users WHERE iban = @iban", {iban = iban})[1]
    return data.id or nil
end

function getBackgroundOrProfilePicture(user_id, type)
    if type == "background" then
        local data = exports.ghmattimysql:execute("SELECT background FROM vrp_users WHERE id = @user_id", {user_id = user_id})[1]
        return data.background or nil
    elseif type == "profilepicture" then
        local data = exports.ghmattimysql:execute("SELECT profilepicture FROM vrp_users WHERE id = @user_id", {user_id = user_id})[1]
        return data.profilepicture or nil
    end
    return nil
end

function getOrGeneratePhoneNumber(user_id)
    local pPhoneNumber = getNumberPhone(user_id)
    if not pPhoneNumber then
        pPhoneNumber = getPhoneRandomNumber()
        exports.oxmysql:execute("UPDATE vrp_users SET phoneNumber = @phoneNumber WHERE id = @user_id", {phoneNumber = pPhoneNumber, user_id = user_id})
        return pPhoneNumber
    end
    return pPhoneNumber
end

function fptPhone.saveBackground(picture)
    local user_id = vRP.getUserId{source}
    if user_id then
        exports.oxmysql:execute("UPDATE vrp_users SET background = @background WHERE id = @user_id", {background = picture, user_id = user_id})
    else
        return
    end
end

function fptPhone.saveProfilePicture(ProfilePicture)
    local user_id = vRP.getUserId{source}
    if user_id then
        exports.oxmysql:execute("UPDATE vrp_users SET profilepicture = @profilepicture WHERE id = @user_id", {profilepicture = ProfilePicture, user_id = user_id})
    else
        return
    end
end

function fptPhone.UpdateTweets(TweetsData, TweetMessage)
    Tweets = TweetsData
    CheckMention(TweetMessage)
    TriggerClientEvent('fptPhone:client:UpdateTweets', -1, Tweets)
end

function fptPhone.UpdateDeep(mesaj)
    Tweets = DeepData
    TriggerClientEvent('fptPhone:client:UpdateDarkwebs', -1, mesaj)
end

function CheckMention(TweetMessage)
    
end


function fptPhone.callOnline()
    local player = source
    local user_id = vRP.getUserId{player}
    if user_id and player ~= user_id and player then
        return true
    end
    return false
end

function fptPhone.isOnline(iban)
    local player = source
    local user_id = vRP.getUserId{player}
    if user_id and iban then
        local data = exports.ghmattimysql:execute("SELECT id FROM vrp_users WHERE iban = @iban", {iban = iban})[1]
        local oSource = vRP.getUserSource{data.id}
        if oSource and oSource ~= player then
            return true
        end
    end
    return false
end

function GetOnlineStatus(number)
    if number then
        vRP.getUserByPhone{number, function (targetId)
            local targetSource = vRP.getUserSource{targetId}
            if targetSource then
                return true
            end
        end}
    end
    return false
end

function fptPhone.GetPhoneData()
    local player = source
    local user_id = vRP.getUserId{player}
    if user_id then
        local PhoneData = {
            Applications = {},
            PlayerContacts = {},
            MentionedTweets = {},
            Chats = {},
            Invoices = {},
            Hashtags = {},
            Tweets = {},
            Adverts = {},
            Deeps = {},
            Garage = {},
            Images = {},
            CryptoTransactions = {}
        }
        local contacts = exports.ghmattimysql:execute("SELECT * FROM player_contacts WHERE user_id = @user_id ORDER BY `name` ASC", {user_id = user_id})
        PhoneData.Adverts = Adverts
        if contacts[1] then
            for k,v in pairs(contacts) do
                v.status = GetOnlineStatus(v.number)
            end
            PhoneData.PlayerContacts = contacts
        end
        local chats = exports.ghmattimysql:execute("SELECT * FROM phone_messages WHERE user_id = @user_id", {user_id = user_id})
        if chats then
            PhoneData.Chats = chats
        end

        if AppAlerts[user_id] then 
            PhoneData.Applications = AppAlerts[user_id]
        end
        local images = exports.ghmattimysql:execute("SELECT * FROM phone_gallery WHERE user_id = @user_id", {user_id = user_id})
        if images ~= nil and next(images) ~= nil then
            PhoneData.Images = images
        end
        if MentionedTweets[user_id] then 
            PhoneData.MentionedTweets = MentionedTweets[user_id]
        end
        if Tweets ~= nil and next(Tweets) ~= nil then
            PhoneData.Tweets = Tweets
        end
        if Deeps ~= nil and next(Deeps) ~= nil then
            PhoneData.Deeps = Deeps
        end
        if Hashtags then
            PhoneData.Hashtags = Hashtags
        end
        return PhoneData
    end
    return {}
end

function fptPhone.deleteWapp(ChatNumber);end



fPhone.RegisterServerCallback('fptPhone_new:server:GetCallState', function(source, cb, ContactData)
    local Target = vRP.getUserId({source})
    if Target ~= nil then
        if Calls[Target] ~= nil then
            print(Target)
            if Calls[Target].inCall then
                cb(false, true)
            else
                cb(true, true)
            end
        else
            cb(true, true)
        end
    else
        cb(false, false)
    end
end)
function fptPhone.SetCallState(bool)
    local player = source
    local user_id = vRP.getUserId{player}
    if user_id then
        if Calls[user_id] then
            Calls[user_id].inCall = bool
        else
            Calls[user_id] = {}
            Calls[user_id].inCall = bool
        end
    end
end

function fptPhone.getPhoneNumber()
    local player = source
    local user_id = vRP.getUserId{player}
    if user_id then
        return getNumberPhone(user_id)
    end
    return nil
end

function GenerateMailId()
    return math.random(111111, 999999)
end

-- RegisterCommand("testmail", function(source)
--     vRP.getUserIdentity{user_id,function(identity)
--         if identity ~= nil then
--             local mail = {
--                 sender = "Primaria Orasului",
--                 subject = "Salariul pe aceasta ORA",
--                 message = [==[
--                     Buna ziua, ]==].. identity.firstname ..[==[ ]==].. identity.name ..[==[!<br>
--                     Va anuntam ca ati primit salariu.<br>
--                     <br>
--                     Cu resprect,<br>
--                     Primaria Orasului<br>
--                 ]==]
--             }
--             TriggerClientEvent('fptPhone:client:UpdateMails', -1, mail)
--             TriggerClientEvent("fptPhone:client:NewMailNotify", -1)
--         end
--     end}
-- end)


function fptPhone.sendNewMail(source, scrisori, strada)
    local player = source
    local user_id = vRP.getUserId{player}
    if user_id then
        vRP.getUserIdentity{user_id,function(identity)
            if identity ~= nil then
                local mail = {
                    sender = "Posta Romana",
                    subjet = "Livrare",
                    message = [==[
                        Buna ziua, ]==].. identity.firstname or "Unknown" ..[==[.
                        Va anuntam ca aveti de livrat ]==].. scrisori or 0 ..[==[
                        scrisori
                        Locatie: ]==]..strada..[==[

                        Cu resprect,
                        Posta Romana
                    ]==]
                }
                TriggerClientEvent('fptPhone:client:UpdateMails', player, mail)
            end
        end}
    else
        return
    end
end

function fptPhone.callContact(TargetData, CallId, AnonymousCall)
    local player = source
    local user_id = vRP.getUserId{player}
    if user_id then
        --vRP.getUserByPhone{TargetData.number, function (targetId)
        local result = exports.ghmattimysql:execute('SELECT * FROM vrp_users WHERE phoneNumber = @phoneNumber', {
            ['@phoneNumber'] = TargetData.number
        })
            if result[1] then
                if result[1].id then

                    local targetSource = vRP.getUserSource{result[1].id}
                    if targetSource then
                      TriggerClientEvent('fptPhone:client:GetCalled', targetSource, getNumberPhone(user_id), CallId, AnonymousCall)
                    end

                end
            end
       -- end}
    else
        return
    end
end

function fptPhone.setPhoneAlerts(app, alerts)
    local player = source
    local user_id = vRP.getUserId{player}
    if user_id and app then
        if AppAlerts[user_id] == nil then
            AppAlerts[user_id] = {}
            if AppAlerts[user_id][app] == nil then
                if alerts == nil then
                    AppAlerts[user_id][app] = 1
                else
                    AppAlerts[user_id][app] = alerts
                end
            end
        else
            if AppAlerts[user_id][app] == nil then
                if alerts == nil then
                    AppAlerts[user_id][app] = 1
                else
                    AppAlerts[user_id][app] = 0
                end
            else
                if alerts == nil then
                    AppAlerts[user_id][app] = AppAlerts[user_id][app] + 1
                else
                    AppAlerts[user_id][app] = AppAlerts[user_id][app] + 0
                end
            end
        end
    else
        return
    end
end

function fptPhone.GetContactPictures(chats)
    local player = source
    local user_id = vRP.getUserId{player}
    if user_id then
        for k, v in pairs(chats) do
            local data = exports.ghmattimysql:execute("SELECT profilepicture FROM vrp_users WHERE phoneNumber = @phoneNumber", {phoneNumber = v.number})[1]
            v.picture = data.profilepicture or "default"
        end
    else
        return false
    end
    return chats
end

function fptPhone.GetPicture(number)
    local player = source
    local user_id = vRP.getUserId{player}
    if user_id then
        local data = exports.ghmattimysql:execute("SELECT profilepicture FROM vrp_users WHERE phoneNumber = '"..number.."'", {})[1]
        return data.profilepicture or "default"
    else 
        return false
    end
    return "default"
end

function fptPhone.getDeepuri()
    return Deeps
end

function fptPhone.getTweeturi()
    return Tweets
end

function fptPhone.removeAnn(data)
    if not data.id then return end;
    local user_id = vRP.getUserId{source}
    exports.oxmysql:execute("DELETE FROM olx_myannounce WHERE user_id = @user_id AND id = @id", {user_id = user_id, id = json.encode(data.id)}, function()end)
    TriggerClientEvent("fptPhone:notify", source, {title = "OLX", text = "Ai sters anunt-ul!", color = "#c40000", timeout = 2500})
end

function fptPhone.transferMoney(data)
    data.amount = (tonumber(data.amount) or nil);
    if not data.number or not data.amount then return end;
    local player = source;
    local user_id = vRP.getUserId{player};
    if not user_id then return end;
    local target_id = exports.ghmattimysql:execute("SELECT id FROM vrp_users WHERE phoneNumber = @pN", {pN = data.number})[1].id;
    if not target_id or target_id == user_id then return end;
    local target_source = vRP.getUserSource{target_id};
    if not target_source then return TriggerClientEvent("fptPhone:notify", player, {title = "Banking", text = "Persoana nu este online.", color = "#c40000", timeout = 2500}); end;
    if(tonumber(data.amount) and tonumber(data.amount) > 0 and data.amount ~= "" and data.amount ~= nil)then
        bankMoney = vRP.getBankMoney({user_id})
            if(bankMoney >= data.amount)then
                newBankMoney = tonumber(bankMoney - data.amount)
				vRP.setBankMoney({user_id, newBankMoney})
                vRP.giveBankMoney({target_id, data.amount})
                return TriggerClientEvent("fptPhone:notify", player, {title = "Banking", text = "Transfer realizat cu succes.", color = "#c40000", timeout = 2500});
            else
                TriggerClientEvent("fptPhone:notify", player, {title = "Banking", text = "Esti sarac"..vRP.formatMoney{data.amount}.."$ lui "..GetPlayerName(target_source)..".", color = "#00ff1a", timeout = 2500});
            end
            TriggerClientEvent("fptPhone:notify", player, {title = "Banking", text = "Esti sarac"..vRP.formatMoney{data.amount}.."$ lui "..GetPlayerName(target_source)..".", color = "#00ff1a", timeout = 2500});
    end        
end;

function fptPhone.EditContact(NewName, NewNumber, NewIban, OldName, OldNumber, OldIban)
    local player = source
    local user_id = vRP.getUserId{player}
    if user_id then
        exports.oxmysql:execute("UPDATE `player_contacts` SET `name` = '"..NewName.."', `number` = '"..NewNumber.."', `iban` = '"..NewIban.."' WHERE `user_id` = '"..user_id.."' AND `name` = '"..OldName.."' AND `number` = '"..OldNumber.."' AND `iban` = '"..OldIban.."'", {})
    else
        return
    end
end

function fptPhone.removeContact(Name, Number)
    local player = source
    local user_id = vRP.getUserId{player}
    if user_id then
        exports.oxmysql:execute("DELETE FROM `player_contacts` WHERE `name` = '"..Name.."' AND `number` = '"..Number.."' AND `user_id` = '"..user_id.."'", {})
    else
        return
    end
end

function fptPhone.addNewContact(name, number)
    local player = source
    local user_id = vRP.getUserId{player}
    if user_id then
        exports.oxmysql:execute("INSERT INTO `player_contacts` (`user_id`, `name`, `number`, `iban`) VALUES ('"..user_id.."', '"..tostring(name).."', '"..tostring(number).."', '"..tostring(0).."')", {})
    else
        return
    end
end

fptPhone.updateMessages = function(ChatMessages, ChatNumber, New)
    local player = source
    local user_id = vRP.getUserId{player}
    local sursamea = vRP.getUserSource{user_id}
    if user_id then
        --vRP.getUserByPhone{ChatNumber, function (targetId)
        local result = exports.ghmattimysql:execute('SELECT * FROM vrp_users WHERE phoneNumber = @phoneNumber', {
            ['@phoneNumber'] = ChatNumber
        })
        if result[1].id then
            local targetSource = vRP.getUserSource{result[1].id}
            local chat = exports.ghmattimysql:execute("SELECT * FROM phone_messages WHERE user_id = '"..user_id.."' and number = '"..ChatNumber.."'", {})[1]
            if not chat then 
                exports.oxmysql:execute("INSERT INTO `phone_messages` (`user_id`, `number`, `messages`) VALUES ('"..result[1].id.."', '"..getNumberPhone(user_id).."', '"..json.encode(ChatMessages).."')", {})
                exports.oxmysql:execute("INSERT INTO `phone_messages` (`user_id`, `number`, `messages`) VALUES ('"..user_id.."', '"..getNumberPhone(result[1].id).."', '"..json.encode(ChatMessages).."')", {})
                if targetSource then
                    TriggerClientEvent("fptPhone:client:UpdateMessages", targetSource, ChatMessages, getNumberPhone(user_id), true)
                end
            else
                exports.oxmysql:execute("UPDATE phone_messages SET messages = '"..json.encode(ChatMessages).."' WHERE user_id = '"..result[1].id.."' AND number = '"..getNumberPhone(user_id).."'",{})
                exports.oxmysql:execute("UPDATE phone_messages SET messages = '"..json.encode(ChatMessages).."' WHERE user_id = '"..user_id.."' AND number = '"..getNumberPhone(result[1].id).."'",{})
                if targetSource then
                    TriggerClientEvent("fptPhone:client:UpdateMessages", targetSource, ChatMessages, getNumberPhone(user_id), false)
                end
            end
        end
    else
        return
    end
end

RegisterNetEvent("fptPhone:recente", function(type, data)
    local player = source
    local user_id = vRP.getUserId{player}
    if user_id then
        local label = os.date("%H:%M")
        TriggerClientEvent('fptPhone:client:AddRecentCall', player, data, label, type)
        local result = exports.ghmattimysql:execute('SELECT * FROM vrp_users WHERE phoneNumber = @phoneNumber', {
            ['@phoneNumber'] = data.number
        })
        if result[1].id then
            local targetSource = vRP.getUserSource{result[1].id}
            if targetSource then
                if identity ~= nil then
                    local data = {
                        name = (result[1].firstName or "Unknown") .. " " ..(result[1].secondName or "Unknown"),
                        number = getNumberPhone(result[1].id),
                        anonymous = data.anonymous
                    }
                    TriggerClientEvent('fptPhone:client:AddRecentCall', targetSource, data, label, "outgoing")
                end
            end
        end
    else
        return
    end
end)


function fptPhone.AddRecentCall(type, data)
    local player = source
    local user_id = vRP.getUserId{player}
    if user_id then
        local label = os.date("%H:%M")
        TriggerClientEvent('fptPhone:client:AddRecentCall', player, data, label, type)
        vRP.getUserByPhone{data.number, function (targetId)
            if targetId then
                local targetSource = vRP.getUserSource{targetId}
                if targetSource then
                    vRP.getUserIdentity{targetId,function(identity)
                        if identity ~= nil then
                            local data = {
                                name = (identity.firstname or "Unknown") .. " " ..(identity.name or "Unknown"),
                                number = getNumberPhone(targetId),
                                anonymous = data.anonymous
                            }
                            TriggerClientEvent('fptPhone:client:AddRecentCall', targetSource, data, label, "outgoing")
                        end
                    end}
                end
            end
        end}
    else
        return
    end
end

RegisterNetEvent("CancelCall:Legend")
AddEventHandler("CancelCall:Legend",function(CallData)
    local player = source
    local user_id = vRP.getUserId{player}
    if user_id then
        local result = exports.ghmattimysql:execute('SELECT * FROM vrp_users WHERE phoneNumber = @phone', {
            ['@phone'] = CallData.TargetData.number
        })
        if result[1] and result[1].id then
            local targetSource = vRP.getUserSource{result[1].id}
            if targetSource then
                TriggerClientEvent('fptPhone:client:CancelCall',targetSource)
            end
        end
    else
        return
    end
end)

function fptPhone.answerCall(CallData)
    local player = source
    local user_id = vRP.getUserId{player}
    if user_id then
        local result = exports.ghmattimysql:execute('SELECT * FROM vrp_users WHERE phoneNumber = @phone', {
            ['@phone'] = CallData.TargetData.number
        })
        if result[1].id then
            local targetSource = vRP.getUserSource{result[1].id}
            if targetSource then
                TriggerClientEvent('fptPhone:client:AnswerCall', targetSource)
            end
        end
    else
        return
    end
end

-- function fptPhone.spawnGarageVehicle()
--     local player = source
--     local user_id = vRP.getUserId{}
--     local vehicle = {}
--     exports.oxmysql:execute("SELECT * FROM vrp_user_vehicles WHERE user_id = @user_id AND vehicle = @vehicle", {user_id = user_id, vehicle = vname},function(result)
--         if #result > 0 then
--             local vehid = result[1].id
--             local veh_type = result[1].veh_type
--             local plate = result[1].vehicle_plate
--             local vname = result[1].vehicle
--             --print(tuning,damage,xenon,veh_type,plate)
--             vRPclient.spawnGarageVehicle(player,{veh_type,vname,vehid,plate})
--         end
--     end)
-- end

-- RegisterCommand('cacat2', function()
--     fptPhone.spawnGarageVehicle("t20")
-- end)

function fptPhone.getVehicles()
    local player = source
    local user_id = vRP.getUserId{player}
    if user_id then
        local vehicles = {}
        local uvehicles = exports.ghmattimysql:execute("SELECT id,vehicle,vehicle_plate FROM vrp_user_vehicles WHERE user_id = @user_id", {user_id = user_id})
        for k, v in pairs(uvehicles) do
            local vdata = {
                model = v.vehicle,
                plate = v.vehicle_plate,
                fullname = getVName(v.vehicle),
                garage = vRPclient.isPersonalVehicleSpawned(player, {v.id}),
                engine = v.engine or 1000,
                body = v.body or 1000
            }
            table.insert(vehicles, vdata)
        end
        return vehicles
    end
    return {}
end

-- function fptPhone.GetGarageVehicles()
--     local player = source
--     local user_id = vRP.getUserId{player}
--     if user_id then
--         local vehicles = {}
--         local playerVehs = exports.ghmattimysql:execute("SELECT id,vehicle,vehicle_plate FROM vrp_user_vehicles WHERE user_id = @user_id", {user_id = user_id})
--         for k, v in pairs(playerVehs) do
--             local vdata = {
--                 model = v.vehicle,
--                 fullname = getVName(v.vehicle),
--                 plate = v.vehicle_plate,
--                 garage = false,
--                 engine = v.engine or 1000,
--                 body = v.body or 1000
--             }

--             vRPclient.isPersonalVehicleSpawned(player, {v.id}, function(is)
--                 vdata.garage = is
--             end)

--             Wait(100)

--             table.insert(vehicles, vdata)
--         end
--         return vehicles
--     end
--     return {}
-- end

fPhone.RegisterServerCallback("fptPhone:olxSearch", function(source, cb, data)
    if type(data) ~= "table" then return end;
    local user_id = vRP.getUserId{source}
    if user_id == nil then return end;
    exports.oxmysql:execute("SELECT * FROM olx_myannounce WHERE category = @category", {category = data.value}, function (result)
        cb(result)
    end)
end)

fPhone.RegisterServerCallback("fptPhone:olxFetchMyAnnounces", function(source, cb)
    local Anunturi = {}
    local user_id = vRP.getUserId{source}
    if not user_id then return end;
    local result = exports.ghmattimysql:execute('SELECT * FROM olx_myannounce WHERE user_id = @user_id', {
        ['@user_id'] = user_id
    })
    for k, v in pairs(result) do 
            table.insert(Anunturi, {
                id = v.id,
                category = v.category,
                price = v.price,
                desc = v.desca,
                photos = v.photos,
                title = v.title,
                promoted = v.promoted,
                expireDate = v.expireDate,
            })
        end

cb(Anunturi)

end)

function fptPhone.editAnn(data)
    local user_id = vRP.getUserId{source}
    local user_source = vRP.getUserSource{user_id}

    exports.oxmysql:execute("UPDATE olx_myannounce SET title = @title WHERE id = @id", {title = data.title, id = data.id})
    exports.oxmysql:execute("UPDATE olx_myannounce SET price = @price WHERE id = @id", {price = data.price, id = data.id})
    exports.oxmysql:execute("UPDATE olx_myannounce SET desca = @desc WHERE id = @id", {desc = data.desc, id = data.id})
    TriggerClientEvent("fptPhone:notify", user_source, {title = "OLX", text = "Ai editat cu succes anunt-ul!", color = "#c40000", timeout = 2500})
end



function fptPhone.addAnnounceOlx(data)
    local user_id = vRP.getUserId{source}
    local user_source = vRP.getUserSource{user_id}
    local result = exports.ghmattimysql:execute('SELECT * FROM vrp_users WHERE id = @user_id', {
        ['@user_id'] = user_id
    })
    local poze = table.unpack(data.photos)
    local pozec = "nil"
    if poze then 
        pozec = poze 
    end

    if vRP.tryBankPayment{user_id, 5000} then 
        TriggerClientEvent("fptPhone:notify", user_source, {title = "OLX", text = "Ai postat cu succes anunt-ul!", color = "#c40000", timeout = 2500})
        exports.oxmysql:execute("INSERT INTO `olx_myannounce` (`user_id`, `category`, `price`, `desca`, `photos`, `title`, `phone`, `expireDate`) VALUES ('"..user_id.."', '"..data.category.."', '"..data.price.."', '"..data.desc.."', '"..pozec.."', '"..data.title.."', '"..result[1].phoneNumber.."', '"..os.time().."')", {})
    else
        vRPclient.notify(user_source, {"Nu ai destui bani saracule. :)"})
    end
end

function fptPhone.updateTweets(data,data2)
    --print(json.encode(data))
    --print("DATA 2 : "..json.encode(data2))
end

RegisterServerEvent('lucid_phone:saveTwitterToDatabase')
AddEventHandler('lucid_phone:saveTwitterToDatabase', function(data)
    local user_id = vRP.getUserId(source)
    --print(json.decode(data))
    print(json.decode(data[1]))
	exports['oxmysql']:execute('INSERT INTO twitter_tweets (firstname, lastname, message, url, time, picture, owner) VALUES (@firstname, @lastname, @message, @url, @time, @picture, @owner)',
	{
		['@firstname']   	= firstName,
		['@lastname']   	= lastname,
		['@message'] 	= message,
        ['@url']       = url,
		['@time']  = time,
        ['@picture'] 		= picture,
        ['@owner'] 		= user_id,

	})
end)

RegisterServerEvent('MI-phone:server:UpdateTweets')
AddEventHandler('MI-phone:server:UpdateTweets', function(NewTweets, TweetData)
    Tweets = NewTweets
    local TwtData = TweetData
    local src = source
    TriggerClientEvent('MI-phone:client:UpdateTweets', -1, src, Tweets, TwtData)
end)






fPhone.RegisterServerCallback('fptPhone:getmyAdd', function(source, cb)
    local MyAdd = {}

    table.insert(MyAdd, {
        id = 1,
        title = "adwdaw",
        phone = result[1].phoneNumber,
    })

    cb(MyAdd)
end)





fPhone.RegisterServerCallback('fptPhone:getCurrentPolices', function(source, cb)
    local Polices = {}
    for k, v in pairs(vRP.getUsers()) do
        local user_id = vRP.getUserId{v}
        local result = exports.ghmattimysql:execute('SELECT * FROM vrp_users WHERE id = @phoneNumber', {
            ['@phoneNumber'] = user_id
        })
            if vRP.isUserInFaction{user_id, "Politie"} then
                table.insert(Polices, {
                    name = result[1].firstName .. " " .. result[1].secondName,
                    phone = result[1].phoneNumber,
                })
            end
    end
    cb(Polices)
end)

fPhone.RegisterServerCallback('fptPhone:getCurrentTraficant', function(source, cb)
    local Traficant = {}
    for k, v in pairs(vRP.getUsers()) do
        local user_id = vRP.getUserId{v}
        local result = exports.ghmattimysql:execute('SELECT * FROM vrp_users WHERE id = @phoneNumber', {
            ['@phoneNumber'] = user_id
        })
            if vRP.hasGroup{user_id, "Specialist Arme"} then
                table.insert(Traficant, {
                    name = result[1].firstName .. " " .. result[1].secondName,
                    phone = result[1].phoneNumber,
                })
            end
    end
    cb(Traficant)
end)

fPhone.RegisterServerCallback('fptPhone:getCurrentTaxi', function(source, cb)
    local Taxi = {}
    for k, v in pairs(vRP.getUsers()) do
        local user_id = vRP.getUserId{v}
        local result = exports.ghmattimysql:execute('SELECT * FROM vrp_users WHERE id = @phoneNumber', {
            ['@phoneNumber'] = user_id
        })
        if vRP.isUserInFaction{user_id, "Taxi"} then
            table.insert(Taxi, {
                name = result[1].firstName .. " " .. result[1].secondName,
                phone = result[1].phoneNumber,
            })
        end
    end
    cb(Taxi)
end)

fPhone.RegisterServerCallback('fptPhone:getCurrentSmurd', function(source, cb)
    local Smurds = {}
    for k, v in pairs(vRP.getUsers()) do
        local user_id = vRP.getUserId{v}
        local result = exports.ghmattimysql:execute('SELECT * FROM vrp_users WHERE id = @phoneNumber', {
            ['@phoneNumber'] = user_id
        })
        if vRP.isUserInFaction{user_id, "Smurd"} then
            table.insert(Smurds, {
                name = result[1].firstName .. " " .. result[1].secondName,
                phone = result[1].phoneNumber,
            })
        end
    end
    cb(Smurds)
end)


fPhone.RegisterServerCallback('fptPhone:getCurrentMechanic', function(source, cb)
    local nshcoae = {}
    for k, v in pairs(vRP.getUsers()) do
        local user_id = vRP.getUserId{v}
        local result = exports.ghmattimysql:execute('SELECT * FROM vrp_users WHERE id = @phoneNumber', {
            ['@phoneNumber'] = user_id
        })
        if vRP.isUserInFaction{user_id, "Mecanic"} then
            table.insert(nshcoae, {
                name = result[1].firstName .. " " .. result[1].secondName,
                phone = result[1].phoneNumber,
            })
        end
    end
    cb(nshcoae)
end)