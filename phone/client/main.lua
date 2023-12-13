fptPhone = Tunnel.getInterface("fptPhone","fptPhone")
vRP = Proxy.getInterface("vRP")

fPhone = {}
fPhone.CurrentRequestId          = 0
fPhone.ServerCallbacks           = {}

fPhone.TriggerServerCallback = function(name, cb, ...)
	fPhone.ServerCallbacks[fPhone.CurrentRequestId] = cb

	TriggerServerEvent('fPhone:triggerServerCallback', name, fPhone.CurrentRequestId, ...)

	if fPhone.CurrentRequestId < 65535 then
		fPhone.CurrentRequestId = fPhone.CurrentRequestId + 1
	else
		fPhone.CurrentRequestId = 0
	end
end
RegisterKeyMapping('openphone', 'Deschide Telefon', 'keyboard', 'l')
RegisterCommand("openphone", function()
    OpenPhone()
end)

RegisterNetEvent("fptPhone:openphone", function()

    OpenPhone()
end)
RegisterNetEvent("fptPhone:closephone", function()
    SetNuiFocus(false, false)
    SendNUIMessage({
        action = "opresteinrasatateleu"
    })
    SetNuiFocus(false, false)
end)

RegisterNetEvent("refatelefon", function()
TriggerServerEvent("refatelefon")
end)

RegisterNetEvent('fPhone:serverCallback')
AddEventHandler('fPhone:serverCallback', function(requestId, ...)
	fPhone.ServerCallbacks[requestId](...)
	fPhone.ServerCallbacks[requestId] = nil
end)

local UserData = {}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(60000)
        fptPhone.getUserData{}
		fptPhone.GetPhoneData({}, function(pData)
            if pData then
                if pData.PlayerContacts ~= nil and next(pData.PlayerContacts) ~= nil then 
                    PhoneData.Contacts = pData.PlayerContacts
                end
            end
        end)
		SendNUIMessage({
			action = "RefreshContacts",
			Contacts = PhoneData.Contacts
		})

    end
end)

function LoadPhone()
    Citizen.Wait(100)

    fptPhone.GetPhoneData({}, function(pData)
        if pData then
            if pData.Applications ~= nil and next(pData.Applications) ~= nil then
                for k, v in pairs(pData.Applications) do 
                    Config.PhoneApplications[k].Alerts = v 
                end
            end

            if pData.MentionedTweets ~= nil and next(pData.MentionedTweets) ~= nil then 
                PhoneData.MentionedTweets = pData.MentionedTweets 
            end

            if pData.PlayerContacts ~= nil and next(pData.PlayerContacts) ~= nil then 
                PhoneData.Contacts = pData.PlayerContacts
            end

            if pData.Chats ~= nil and next(pData.Chats) ~= nil then
                local Chats = {}
                for k, v in pairs(pData.Chats) do
                    Chats[v.number] = {
                        name = IsNumberInContacts(v.number),
                        number = v.number,
                        messages = json.decode(v.messages)
                    }
                end

                PhoneData.Chats = Chats
            end

            if pData.Invoices ~= nil and next(pData.Invoices) ~= nil then
                for _, invoice in pairs(pData.Invoices) do
                    invoice.name = IsNumberInContacts(invoice.number)
                end
                PhoneData.Invoices = pData.Invoices
            end

            if pData.Hashtags ~= nil and next(pData.Hashtags) ~= nil then
                PhoneData.Hashtags = pData.Hashtags
            end

            if pData.MentionedTweets ~= nil and next(pData.MentionedTweets) ~= nil then 
                PhoneData.MentionedTweets = pData.MentionedTweets 
            end

            if pData.CryptoTransactions ~= nil and next(pData.CryptoTransactions) ~= nil then
                PhoneData.CryptoTransactions = pData.CryptoTransactions
            end

            if pData.Adverts ~= nil and next(pData.Adverts) ~= nil then
                PhoneData.Adverts = pData.Adverts
            end
            if pData.Images ~= nil and next(pData.Images) ~= nil then
                PhoneData.Images = pData.Images
            end
            PhoneData.Garage = pData.Garage

            Citizen.Wait(300)

            SendNUIMessage({ 
                action = "LoadPhoneData", 
                PhoneData = PhoneData, 
                PlayerData = UserData,
                PlayerJob = 'job',
                applications = Config.PhoneApplications 
            })
            Citizen.Wait(2000)
        end
    end)
end

phoneProp = 0

PhoneData = {
    MetaData = {},
    isOpen = false,
    PlayerData = UserData,
    Contacts = {},
    Tweets = {},
    MentionedTweets = {},
    Hashtags = {},
    Chats = {},
    Invoices = {},
    CallData = {},
	SelfTweets = {},
    RecentCalls = {},
    Garage = {},
    Adverts = {},
    Images = {},
    Mails = {},
    AnunturiComerciale = {},
    AnunturiVehicule = {},
    AnunturiImobiliare = {},
    Darkwebs = {},
    AnimationData = {
        lib = nil,
        anim = nil,
    },
    SuggestedContacts = {},
    CryptoTransactions = {},
    WaitTime = 0,
}

local function escape_str(s)
    local in_char  = {'&', '<', '>', '"', "'", "/"}
    local out_char = {'', '', '<', '', '', ''}
    for i, c in ipairs(in_char) do
       s = s:gsub(c, '' .. out_char[i])
    end
    return s
end

RegisterNUICallback("TakePhoto", function(data,cb)
    SetNuiFocus(false, false)
    CreateMobilePhone(1)
    CellCamActivate(true, true)
    takePhoto = true
    while takePhoto do
        if IsControlJustPressed(1, 27) then -- Toogle Mode
            frontCam = not frontCam
            CellFrontCamActivate(frontCam)
        elseif IsControlJustPressed(1, 176) then -- TAKE.. PIC    
            exports['screenshot-basic']:requestScreenshotUpload(tostring("https://ptb.discord.com/api/webhooks/968676253995528243/3cfeAT_qCQgknRF0L6A6HTOtNLDzpdrlhdMhcvjEFvDryfgKV_ALMprf05dE05v_CeeH"), "files[]", function(data)        print("poza facut")
                print("poza facut")
                local image = json.decode(data)
                DestroyMobilePhone()
                CellCamActivate(false, false)
                TriggerServerEvent('fptPhone:server:addImageToGallery', image.attachments[1].proxy_url)
                Wait(400)
                TriggerServerEvent('fptPhone:server:getImageFromGallery')
                cb(json.encode(image.attachments[1].proxy_url))
                SetNuiFocus(true, true)
                ExecuteCommand("rezolvare")
            end)
            takePhoto = false
        end
        HideHudComponentThisFrame(7)
        HideHudComponentThisFrame(8)
        HideHudComponentThisFrame(9)
        HideHudComponentThisFrame(6)
        HideHudComponentThisFrame(19)
        HideHudAndRadarThisFrame()
        EnableAllControlActions(0)
        Wait(0)
    end
    Wait(1000)
    --OpenPhone()
end)


RegisterNUICallback('DeleteImage', function(image,cb)
    TriggerServerEvent('fptPhone:server:RemoveImageFromGallery',image)
    DestroyMobilePhone()
    Wait(400)
    TriggerServerEvent('fptPhone:server:getImageFromGallery')
    cb(true)
end)
RegisterNUICallback('GetGalleryData', function(data, cb)
    local data = PhoneData.Images
    cb(data)
end)
RegisterNetEvent('fptPhone:refreshImages', function(images)
    PhoneData.Images = images
end)
RegisterNetEvent("fptPhone:client:setWaypoint")
AddEventHandler("fptPhone:client:setWaypoint", function (x,y)
    SetNewWaypoint(x,y)
end)

RegisterNetEvent('fptPhone:client:RaceNotify')
AddEventHandler('fptPhone:client:RaceNotify', function(message)
    if PhoneData.isOpen then
        SendNUIMessage({
            action = "PhoneNotification",
            PhoneNotify = {
                title = "Curse",
                text = message,
                icon = "fas fa-flag-checkered",
                color = "#353b48",
                timeout = 1500,
            },
        })
    else
        SendNUIMessage({
            action = "Notification",
            NotifyData = {
                title = "Curse", 
                content = message, 
                icon = "fas fa-flag-checkered", 
                timeout = 3500, 
                color = "#353b48",
            },
        })
    end
end)



RegisterNetEvent('fptPhone:client:AddRecentCall')
AddEventHandler('fptPhone:client:AddRecentCall', function(data, time, type)
    PhoneData.RecentCalls[#PhoneData.RecentCalls+1] = {
        name = IsNumberInContacts(data.number),
        time = time,
        type = type,
        number = data.number,
        anonymous = data.anonymous
    }
    fptPhone.setPhoneAlerts{"phone"}
    Config.PhoneApplications["phone"].Alerts = Config.PhoneApplications["phone"].Alerts + 1
    SendNUIMessage({ 
        action = "RefreshAppAlerts",
        AppData = Config.PhoneApplications
    })
end)

RegisterNUICallback('ClearRecentAlerts', function(data, cb)
    fptPhone.setPhoneAlerts{"phone", 0}
    Config.PhoneApplications["phone"].Alerts = 0
    SendNUIMessage({ action = "RefreshAppAlerts", AppData = Config.PhoneApplications })
end)

RegisterNUICallback('SetBackground', function(data)
    local background = data.background

    PhoneData.PlayerData.background = background
    fptPhone.saveBackground{background}
end)

RegisterNUICallback('GetMissedCalls', function(data, cb)
    cb(PhoneData.RecentCalls)
end)

RegisterNUICallback('GetSuggestedContacts', function(data, cb)
    cb(PhoneData.SuggestedContacts)
end)

function IsNumberInContacts(num)
    local retval = num
    for _, v in pairs(PhoneData.Contacts) do
        if num == v.number then
            retval = v.name
        end
    end
    return retval
end


-- Citizen.CreateThread(function()
--     while true do
--         if IsControlJustPressed(0, Config.OpenPhone) then
--             if not PhoneData.isOpen then
--                 OpenPhone()
--             end
--         end
--         if PhoneData.isOpen then
--             SetRadarZoom(950)
--             DisplayRadar(true)
--         end
--         Citizen.Wait(1)
--     end
-- end)

function CalculateTimeToDisplay()
	hour = GetClockHours()
    minute = GetClockMinutes()
    
    local obj = {}
    
	if minute <= 9 then
		minute = "0" .. minute
    end
    
    obj.hour = hour
    obj.minute = minute

    return obj
end

Citizen.CreateThread(function()
    while true do
        if PhoneData.isOpen then
            SendNUIMessage({
                action = "UpdateTime",
                InGameTime = CalculateTimeToDisplay(),
            })
        end
        Citizen.Wait(1000)
    end
end)




Citizen.CreateThread(function()
    while true do
        if PhoneData.isOpen then
            SendNUIMessage({
                action = "updateTweets",
                tweets = PhoneData.Tweets,
                selfTweets = PhoneData.SelfTweets,
            })
        end
        Citizen.Wait(2000)
    end
end)

Citizen.CreateThread(function()
    Wait(500)
    LoadPhone()
end)

RegisterNetEvent('fptPhone:client:sendAnunturi')
AddEventHandler('fptPhone:client:sendAnunturi', function (aC, aV, aI)
    PhoneData.AnunturiComerciale = aC
    PhoneData.AnunturiImobiliare = aI 
    PhoneData.AnunturiVehicule = aV
end)

RegisterNetEvent('fptPhone:client:SetTweetsSpawn')
AddEventHandler('fptPhone:client:SetTweetsSpawn', function(data)
    Citizen.Wait(2000)
    PhoneData.Tweets = data
end)

RegisterNetEvent('fptPhone:playerSpawn')
AddEventHandler('fptPhone:playerSpawn', function()
    fptPhone.getUserData{}
    TriggerServerEvent('uc-weazel:getAnunturi')
    Citizen.Wait(500)
    PhoneData = {
        MetaData = {},
        isOpen = false,
        PlayerData = UserData,
        Contacts = {},
        Tweets = {},
        MentionedTweets = {},
        Hashtags = {},
        Chats = {},
        Invoices = {},
        CallData = {},
        RecentCalls = {},
        Garage = {},
        Mails = {},
        AnunturiComerciale = {},
        AnunturiImobiliare = {},
        AnunturiVehicule = {},
        Darkwebs = {},
        AnimationData = {
            lib = nil,
            anim = nil,
        },
        SuggestedContacts = {},
        CryptoTransactions = {},
    }
    
	LoadPhone()
end)

RegisterNUICallback('HasPhone', function(data, cb)
	fptPhone.hasPhone({}, function(HasPhone)
	    if HasPhone then
            cb(HasPhone)
        end
    end)
end)

function OpenPhone()
    fptPhone.hasPhone({}, function(HasPhone)
	    if HasPhone then
	    	PhoneData.PlayerData = {}
	    	SetNuiFocus(true, true)
            --SetNuiFocusKeepInput(true)
	    	SendNUIMessage({
	    		action = "open",
	    		Tweets = PhoneData.Tweets,
	    		AppData = Config.PhoneApplications,
	    		CallData = PhoneData.CallData,
	    		PlayerData = UserData,
	    	})
	    	PhoneData.isOpen = true

	    	if not PhoneData.CallData.InCall then
	    		DoPhoneAnimation('cellphone_text_in')
	    	else
	    		DoPhoneAnimation('cellphone_call_to_text')
	    	end

	    	SetTimeout(250, function()
	    		newPhoneProp()
	    	end)

	    else
            
	    end
    end)
end

Citizen.CreateThread(function ()
    while true do
        Citizen.Wait(0)
        if PhoneData.isOpen then
            DisableControlAction(0,24,true) -- disable attack
            DisableControlAction(0,25,true) -- disable aim
            DisableControlAction(0,47,true) -- disable weapon
            DisableControlAction(0,58,true) -- disable weapon
            DisableControlAction(0,263,true) -- disable melee
            DisableControlAction(0,264,true) -- disable melee
            DisableControlAction(0,257,true) -- disable melee
            DisableControlAction(0,140,true) -- disable melee
            DisableControlAction(0,141,true) -- disable melee
            DisableControlAction(0,142,true) -- disable melee
            DisableControlAction(0,143,true) -- disable melee
            DisableControlAction(0,32,true) -- disable move up
            DisableControlAction(0,268,true)
            DisableControlAction(0,182,true)
            DisableControlAction(0,217,true)
            DisableControlAction(0,33,true) -- disable move down
            DisableControlAction(0,269,true)
            DisableControlAction(0,34,true) -- disable move left
            DisableControlAction(0,270,true)
            DisableControlAction(0,35,true) -- disable move right
            DisableControlAction(0,1,true)
            DisableControlAction(0,2,true)
            DisableControlAction(0,3,true)
            DisableControlAction(0,4,true)
            DisableControlAction(0,5,true)
            DisableControlAction(0,6,true)
            DisableControlAction(0,7,true)
            DisableControlAction(0,14,true)
            DisableControlAction(0,15,true)
            DisableControlAction(0,16,true)
            DisableControlAction(0,17,true)
            DisableControlAction(0,245,true)
            DisableControlAction(0,246,true)
            DisableControlAction(0,254,true)
            DisableControlAction(0,255,true)
            DisableControlAction(0,236,true)
            DisableControlAction(0,252,true)
            DisableControlAction(0,253,true)
            DisableControlAction(0,73,true)
            DisableControlAction(0,74,true)
            DisableControlAction(0,303,true)
            DisableControlAction(0,305,true)
            DisableControlAction(0,199,true)
            DisableControlAction(0,22,true)
            DisableControlAction(0,202,true)
            DisableControlAction(0,311,true)
            DisableControlAction(0,323,true)
            DisableControlAction(0,29,true)
            DisableControlAction(0,79,true)
            DisableControlAction(0,0,true)
            DisableControlAction(0,322,true)
            DisableControlAction(0,177,true)
            DisableControlAction(0,200,true)
            DisableControlAction(0,75, true)
            DisableControlAction(0,244, true)
            DisableControlAction(0,86, true)
            DisableControlAction(0,85, true)
            DisableControlAction(0,80, true)
            DisableControlAction(0,38, true)
        else
            Citizen.Wait(1000)
        end
    end
end)

RegisterNUICallback('SetupGarageVehicles', function(data, cb)
    fptPhone.getVehicles({}, function(vehicles)
        -- Wait(500)
        -- print(json.encode(vehicles))
        -- PhoneData.GarageVehicles = vehicles
        cb(vehicles)
    end)
end)

RegisterNUICallback('Close', function()
    if not PhoneData.CallData.InCall then
        DoPhoneAnimation('cellphone_text_out')
        SetTimeout(400, function()
            StopAnimTask(PlayerPedId(), PhoneData.AnimationData.lib, PhoneData.AnimationData.anim, 2.5)
            deletePhone()
            PhoneData.AnimationData.lib = nil
            PhoneData.AnimationData.anim = nil
        end)
    else
        PhoneData.AnimationData.lib = nil
        PhoneData.AnimationData.anim = nil
        DoPhoneAnimation('cellphone_text_to_call')
    end
    SetNuiFocus(false, false)
    SetTimeout(1000, function()
        PhoneData.isOpen = false
    end)
end)

RegisterNUICallback('RemoveMail', function(data, cb)
    PhoneData.Mails = {}
    SendNUIMessage({
        action = "UpdateMails",
        Mails = PhoneData.Mails
    })
    cb('ok')
end)



RegisterNetEvent('fptPhone:client:UpdateMails')
AddEventHandler('fptPhone:client:UpdateMails', function(NewMails)
    NewMails.mailid = #PhoneData.Mails + 1
    PhoneData.Mails[#PhoneData.Mails + 1] = NewMails
    SendNUIMessage({
        action = "UpdateMails",
        Mails = PhoneData.Mails
    })
end)

RegisterNUICallback('AddNewContact', function(data, cb)
    PhoneData.Contacts[#PhoneData.Contacts+1] = {
        name = data.ContactName,
        number = data.ContactNumber,
        iban = data.ContactIban
    }
    Citizen.Wait(100)
    cb(PhoneData.Contacts)
    if PhoneData.Chats[data.ContactNumber] ~= nil and next(PhoneData.Chats[data.ContactNumber]) ~= nil then
        PhoneData.Chats[data.ContactNumber].name = data.ContactName
    end
    fptPhone.addNewContact{data.ContactName, data.ContactNumber}
end)

RegisterNUICallback('GetMails', function(data, cb)
    cb(PhoneData.Mails)
end)

RegisterNUICallback('GetWhatsappChat', function(data, cb)
    if PhoneData.Chats[data.phone] ~= nil then
        cb(PhoneData.Chats[data.phone])
    else
        cb(false)
    end
end)

RegisterNUICallback('GetProfilePicture', function(data, cb)
    local number = data.number

    fptPhone.GetPicture({number}, function (picture)
        cb(picture)
    end)
end)

RegisterNUICallback('GetBankContacts', function(data, cb)
    cb(PhoneData.Contacts)
end)

RegisterNUICallback('GetInvoices', function(data, cb)
    if PhoneData.Invoices ~= nil and next(PhoneData.Invoices) ~= nil then
        cb(PhoneData.Invoices)
    else
        cb(nil)
    end
end)

function GetKeyByDate(Number, Date)
    local retval = nil
    if PhoneData.Chats[Number] ~= nil then
        if PhoneData.Chats[Number].messages ~= nil then
            for key, chat in pairs(PhoneData.Chats[Number].messages) do
                if chat.date == Date then
                    retval = key
                    break
                end
            end
        end
    end
    return retval
end

function GetKeyByNumber(Number)
    local retval = nil
    if PhoneData.Chats then
        for k, v in pairs(PhoneData.Chats) do
            if v.number == Number then
                retval = k
            end
        end
    end
    return retval
end

function ReorganizeChats(key)
    local ReorganizedChats = {}
    ReorganizedChats[1] = PhoneData.Chats[key]
    for k, chat in pairs(PhoneData.Chats) do
        if k ~= key then
            ReorganizedChats[#ReorganizedChats+1] = chat
        end
    end
    PhoneData.Chats = ReorganizedChats
end

takePhoto = false

function CellFrontCamActivate(activate)
	return Citizen.InvokeNative(0x2491A93618B7D838, activate)
end

RegisterNUICallback('DeleteWapp', function(data, cb)
    local ChatNumber = data.ChatNumber
    fptPhone.deleteWapp{ChatNumber}
    NumberKey = GetKeyByNumber(ChatNumber)
    PhoneData.Chats[NumberKey] = nil
    ReorganizeChats(NumberKey)
end)

RegisterNetEvent('fptPhone:client:deletedWapp')
AddEventHandler('fptPhone:client:deletedWapp', function(newWapps)
    PhoneData.Chats = newWapps
    SendNUIMessage({
        action = 'UpdateWapps',
        Chats = newWapps
    })
end)

RegisterNUICallback('benzinarie1', function()
    SetNewWaypoint(822.12664794922,-1029.0632324219)
    SendNUIMessage({
        action = "PhoneNotification",
        PhoneNotify = {
            title = "Whatsapp",
            text = "Locatie setata!",
            icon = "fab fa-whatsapp",
            color = "#25D366",
            timeout = 1500,
        },
    })
end)

RegisterNUICallback('SharedLocation', function(data)
    local x = data.coords.x
    local y = data.coords.y

    SetNewWaypoint(x, y)
    SendNUIMessage({
        action = "PhoneNotification",
        PhoneNotify = {
            title = "Whatsapp",
            text = "Locatie setata!",
            icon = "fab fa-whatsapp",
            color = "#25D366",
            timeout = 1500,
        },
    })
end)

RegisterNUICallback('shareContact', function()
    fptPhone.shareContact{}
end)



RegisterNetEvent('fptPhone:client:UpdateMessages')
AddEventHandler('fptPhone:client:UpdateMessages', function(ChatMessages, SenderNumber, New)
    local Sender = IsNumberInContacts(SenderNumber)
    print(SenderNumber)
    local NumberKey = GetKeyByNumber(SenderNumber)

    if New then
        PhoneData.Chats[#PhoneData.Chats+1] = {
            name = IsNumberInContacts(SenderNumber),
            number = SenderNumber,
            messages = {},
        }

        NumberKey = GetKeyByNumber(SenderNumber)

        PhoneData.Chats[NumberKey] = {
            name = IsNumberInContacts(SenderNumber),
            number = SenderNumber,
            messages = ChatMessages
        }

        if PhoneData.Chats[NumberKey].Unread ~= nil then
            PhoneData.Chats[NumberKey].Unread = PhoneData.Chats[NumberKey].Unread + 1
        else
            PhoneData.Chats[NumberKey].Unread = 1
        end

        if PhoneData.isOpen then
            if SenderNumber ~= UserData.phone then
                print(json.decode(UserData.phone))
                SendNUIMessage({
                    action = "PhoneNotification",
                    PhoneNotify = {
                        title = "Whatsapp",
                        text = "Mesaj nou de la "..IsNumberInContacts(SenderNumber).."!",
                        icon = "fab fa-whatsapp",
                        color = "#25D366",
                        timeout = 1500,
                    },
                })
            else
                SendNUIMessage({
                    action = "PhoneNotification",
                    PhoneNotify = {
                        title = "Whatsapp",
                        text = "Nu iti poti trimite mesaj singur!",
                        icon = "fab fa-whatsapp",
                        color = "#25D366",
                        timeout = 4000,
                    },
                })
            end

            NumberKey = GetKeyByNumber(SenderNumber)
            ReorganizeChats(NumberKey)

            Wait(100)
            fptPhone.GetContactPictures({PhoneData.Chats}, function(Chats)
                SendNUIMessage({
                    action = "UpdateChat",
                    chatData = Chats[GetKeyByNumber(SenderNumber)],
                    chatNumber = SenderNumber,
                    Chats = Chats,
                })
            end)
        else
            SendNUIMessage({
                action = "Notification",
                NotifyData = {
                    title = "Whatsapp", 
                    content = "Mesaj nou de la "..IsNumberInContacts(SenderNumber).."!", 
                    icon = "fab fa-whatsapp", 
                    timeout = 3500, 
                    color = "#25D366",
                },
            })
            Config.PhoneApplications['whatsapp'].Alerts = Config.PhoneApplications['whatsapp'].Alerts + 1
            fptPhone.setPhoneAlerts{"whatsapp"}
        end
    else
        PhoneData.Chats[NumberKey].messages = ChatMessages

        if PhoneData.Chats[NumberKey].Unread ~= nil then
            PhoneData.Chats[NumberKey].Unread = PhoneData.Chats[NumberKey].Unread + 1
        else
            PhoneData.Chats[NumberKey].Unread = 1
        end

        if PhoneData.isOpen then
            if SenderNumber ~= UserData.phone then
                SendNUIMessage({
                    action = "PhoneNotification",
                    PhoneNotify = {
                        title = "Whatsapp",
                        text = "Mesaj nou de la "..IsNumberInContacts(SenderNumber).."!",
                        icon = "fab fa-whatsapp",
                        color = "#25D366",
                        timeout = 1500,
                    },
                })
            else
                SendNUIMessage({
                    action = "PhoneNotification",
                    PhoneNotify = {
                        title = "Whatsapp",
                        text = "Nu iti poti trimite mesaje singur!",
                        icon = "fab fa-whatsapp",
                        color = "#25D366",
                        timeout = 4000,
                    },
                })
            end

            NumberKey = GetKeyByNumber(SenderNumber)
            ReorganizeChats(NumberKey)

            Wait(100)
            fptPhone.GetContactPictures({PhoneData.Chats}, function(Chats)
                SendNUIMessage({
                    action = "UpdateChat",
                    chatData = Chats[GetKeyByNumber(SenderNumber)],
                    chatNumber = SenderNumber,
                    Chats = Chats,
                })
            end)
        else
            SendNUIMessage({
                action = "Notification",
                NotifyData = {
                    title = "Whatsapp", 
                    content = "Ai primit un mesaj de la "..IsNumberInContacts(SenderNumber).."!", 
                    icon = "fab fa-whatsapp", 
                    timeout = 3500, 
                    color = "#25D366",
                },
            })

            NumberKey = GetKeyByNumber(SenderNumber)
            ReorganizeChats(NumberKey)

            Config.PhoneApplications['whatsapp'].Alerts = Config.PhoneApplications['whatsapp'].Alerts + 1
            fptPhone.setPhoneAlerts{"whatsapp"}
        end
    end
end)

RegisterNUICallback('SendMessage', function(data, cb)
    local ChatMessage = data.ChatMessage
    local ChatDate = data.ChatDate
    local ChatNumber = data.ChatNumber
    local ChatTime = data.ChatTime
    local ChatType = data.ChatType
    local Ped = PlayerPedId()
    local Pos = GetEntityCoords(Ped)
    local NumberKey = GetKeyByNumber(ChatNumber)
    local ChatKey = GetKeyByDate(NumberKey, ChatDate)

    local photoUrl = ''
    local waiting = false

    if ChatType == "image" then
        
        SetNuiFocus(false, false)
        CreateMobilePhone(1)
        CellCamActivate(true, true)
        takePhoto = true
        PhoneData.isOpen = false
        while takePhoto do
            Citizen.Wait(0)
            SetMobilePhoneScale(2000)
            
            if IsControlJustPressed(1, 27) then -- Toogle Mode
                frontCam = not frontCam
                CellFrontCamActivate(frontCam)
            end
            
            if IsControlJustPressed(1, 176) then
                exports['screenshot-basic']:requestScreenshotUpload(tostring("https://ptb.discord.com/api/webhooks/968676253995528243/3cfeAT_qCQgknRF0L6A6HTOtNLDzpdrlhdMhcvjEFvDryfgKV_ALMprf05dE05v_CeeH"), "files[]", function(data2)
                    DestroyMobilePhone()
                    CellCamActivate(false, false)
                    local resp = json.decode(data2)
                    photoUrl = resp.attachments[1].proxy_url
                    waiting = true
                    PhoneData.isOpen = true
                end)

                Citizen.Wait(200)
                
                DestroyMobilePhone()
                takePhoto = false
            end
        end
        
        OpenPhone()
    else
        waiting = true
    end

    while not waiting do Citizen.Wait(50) end

    if PhoneData.Chats[NumberKey] ~= nil then
        if(PhoneData.Chats[NumberKey].messages == nil) then
            PhoneData.Chats[NumberKey].messages = {}
        end
        if PhoneData.Chats[NumberKey].messages[ChatKey] ~= nil then
            if ChatType == "message" then
                PhoneData.Chats[NumberKey].messages[ChatKey].messages[#PhoneData.Chats[NumberKey].messages[ChatKey].messages+1] = {
                    message = ChatMessage,
                    time = ChatTime,
                    sender = UserData.id,
                    type = ChatType,
                    data = {},
                }
            elseif ChatType == "location" then
                PhoneData.Chats[NumberKey].messages[ChatKey].messages[#PhoneData.Chats[NumberKey].messages[ChatKey].messages+1] = {
                    message = "Locatie",
                    time = ChatTime,
                    sender = UserData.id,
                    type = ChatType,
                    data = {
                        x = Pos.x,
                        y = Pos.y,
                    },
                }
            elseif ChatType == "image" then
                PhoneData.Chats[NumberKey].messages[ChatKey].messages[#PhoneData.Chats[NumberKey].messages[ChatKey].messages+1] = {
                    message = photoUrl,
                    time = ChatTime,
                    sender = UserData.id,
                    type = ChatType,
                    data = {},
                }
            end
            fptPhone.updateMessages{PhoneData.Chats[NumberKey].messages, ChatNumber, false}
            NumberKey = GetKeyByNumber(ChatNumber)
            ReorganizeChats(NumberKey)
        else
            PhoneData.Chats[NumberKey].messages[#PhoneData.Chats[NumberKey].messages+1] = {
                date = ChatDate,
                messages = {},
            }
            ChatKey = GetKeyByDate(NumberKey, ChatDate)
            if ChatType == "message" then
                PhoneData.Chats[NumberKey].messages[ChatKey].messages[#PhoneData.Chats[NumberKey].messages[ChatKey].messages+1] {
                    message = ChatMessage,
                    time = ChatTime,
                    sender = UserData.id,
                    type = ChatType,
                    data = {},
                }
            elseif ChatType == "location" then
                PhoneData.Chats[NumberKey].messages[ChatDate].messages[#PhoneData.Chats[NumberKey].messages[ChatDate].messages+1] = {
                    message = "Locatie",
                    time = ChatTime,
                    sender = UserData.id,
                    type = ChatType,
                    data = {
                        x = Pos.x,
                        y = Pos.y,
                    },
                }
            elseif ChatType == "image" then
                PhoneData.Chats[NumberKey].messages[ChatKey].messages[#PhoneData.Chats[NumberKey].messages[ChatKey].messages+1] {
                    message = photoUrl,
                    time = ChatTime,
                    sender = UserData.id,
                    type = ChatType,
                    data = {},
                }
            end
            fptPhone.updateMessages{PhoneData.Chats[NumberKey].messages, ChatNumber, true}
            NumberKey = GetKeyByNumber(ChatNumber)
            ReorganizeChats(NumberKey)
        end
    else
        PhoneData.Chats[#PhoneData.Chats+1] = {
            name = IsNumberInContacts(ChatNumber),
            number = ChatNumber,
            messages = {},
        }
        NumberKey = GetKeyByNumber(ChatNumber)
        PhoneData.Chats[NumberKey].messages[#PhoneData.Chats[NumberKey].messages+1] = {
            date = ChatDate,
            messages = {},
        }
        ChatKey = GetKeyByDate(NumberKey, ChatDate)
        if ChatType == "message" then
            PhoneData.Chats[NumberKey].messages[ChatKey].messages[#PhoneData.Chats[NumberKey].messages[ChatKey].messages+1] = {
                message = ChatMessage,
                time = ChatTime,
                sender = UserData.id,
                type = ChatType,
                data = {},
            }
        elseif ChatType == "location" then
            PhoneData.Chats[NumberKey].messages[ChatKey].messages[#PhoneData.Chats[NumberKey].messages[ChatKey].messages+1] = {
                message = "Locatie",
                time = ChatTime,
                sender = UserData.id,
                type = ChatType,
                data = {
                    x = Pos.x,
                    y = Pos.y,
                },
            }
        elseif ChatType == "image" then
            PhoneData.Chats[NumberKey].messages[ChatKey].messages[#PhoneData.Chats[NumberKey].messages[ChatKey].messages+1] = {
                message = photoUrl,
                time = ChatTime,
                sender = UserData.id,
                type = ChatType,
                data = {},
            }
        end
        fptPhone.updateMessages{PhoneData.Chats[NumberKey].messages, ChatNumber, true}
        NumberKey = GetKeyByNumber(ChatNumber)
        ReorganizeChats(NumberKey)
    end
	fptPhone.GetContactPicture({PhoneData.Chats[GetKeyByNumber(ChatNumber)]}, function(Chat)
        SendNUIMessage({
            action = "UpdateChat",
            chatData = Chat,
            chatNumber = ChatNumber,
        })
    end)
end)

RegisterNetEvent("fptPhone-new:client:BankNotify")
AddEventHandler("fptPhone-new:client:BankNotify", function(text)
    SendNUIMessage({
        action = "Notification",
        NotifyData = {
            title = "Bank", 
            content = text, 
            icon = "fas fa-university", 
            timeout = 3500, 
            color = "#ff002f",
        },
    })
end)

RegisterNetEvent('fptPhone:client:NewMailNotify')
AddEventHandler('fptPhone:client:NewMailNotify', function(MailData)
    if PhoneData.isOpen then
        SendNUIMessage({
            action = "PhoneNotification",
            PhoneNotify = {
                title = "Mail",
                text = "Ai primit un mail nou de la Primarie",
                icon = "fas fa-envelope",
                color = "#ff002f",
                timeout = 1500,
            },
        })
    else
        SendNUIMessage({
            action = "Notification",
            NotifyData = {
                title = "Mail", 
                content = "Ai primit un mail nou de la Primarie", 
                icon = "fas fa-envelope", 
                timeout = 3500, 
                color = "#ff002f",
            },
        })
    end
    Config.PhoneApplications['mail'].Alerts = Config.PhoneApplications['mail'].Alerts + 1
    fptPhone.setPhoneAlerts{"mail"}
end)


RegisterNetEvent('fptPhone:client:NewMailNotifyPostas')
AddEventHandler('fptPhone:client:NewMailNotifyPostas', function(MailData)
    if PhoneData.isOpen then
        SendNUIMessage({
            action = "PhoneNotification",
            PhoneNotify = {
                title = "Mail",
                text = "Ai primit un mail nou",
                icon = "fas fa-envelope",
                color = "#ff002f",
                timeout = 1500,
            },
        })
    else
        SendNUIMessage({
            action = "Notification",
            NotifyData = {
                title = "Mail", 
                content = "Ai primit un mail nou de la posta", 
                icon = "fas fa-envelope", 
                timeout = 3500, 
                color = "#ff002f",
            },
        })
    end
    Config.PhoneApplications['mail'].Alerts = Config.PhoneApplications['mail'].Alerts + 1
    fptPhone.setPhoneAlerts{"mail"}
end)



RegisterNetEvent('fptPhone:client:NewMailNotifyGunoier')
AddEventHandler('fptPhone:client:NewMailNotifyGunoier', function(MailData)
    if PhoneData.isOpen then
        SendNUIMessage({
            action = "PhoneNotification",
            PhoneNotify = {
                title = "Mail",
                text = "Ai primit un mail nou",
                icon = "fas fa-envelope",
                color = "#ff002f",
                timeout = 1500,
            },
        })
    else
        SendNUIMessage({
            action = "Notification",
            NotifyData = {
                title = "Mail", 
                content = "Ai primit un mail nou de la gunoieri", 
                icon = "fas fa-envelope", 
                timeout = 3500, 
                color = "#ff002f",
            },
        })
    end
    Config.PhoneApplications['mail'].Alerts = Config.PhoneApplications['mail'].Alerts + 1
    fptPhone.setPhoneAlerts{"mail"}
end)


RegisterNetEvent('fptPhone:client:NewMailNotifyBuild')
AddEventHandler('fptPhone:client:NewMailNotifyBuild', function(MailData)
    if PhoneData.isOpen then
        SendNUIMessage({
            action = "PhoneNotification",
            PhoneNotify = {
                title = "Mail",
                text = "Ai primit un mail nou constructori",
                icon = "fas fa-envelope",
                color = "#ff002f",
                timeout = 1500,
            },
        })
    else
        SendNUIMessage({
            action = "Notification",
            NotifyData = {
                title = "Mail", 
                content = "Ai primit un mail nou de la constructori", 
                icon = "fas fa-envelope", 
                timeout = 3500, 
                color = "#ff002f",
            },
        })
    end
    Config.PhoneApplications['mail'].Alerts = Config.PhoneApplications['mail'].Alerts + 1
    fptPhone.setPhoneAlerts{"mail"}
end)

RegisterNetEvent('fptPhone:client:NewMailNotifySoferi')
AddEventHandler('fptPhone:client:NewMailNotifySoferi', function(MailData)
    if PhoneData.isOpen then
        SendNUIMessage({
            action = "PhoneNotification",
            PhoneNotify = {
                title = "Mail",
                text = "Ai primit un mail nou soferi",
                icon = "fas fa-envelope",
                color = "#ff002f",
                timeout = 1500,
            },
        })
    else
        SendNUIMessage({
            action = "Notification",
            NotifyData = {
                title = "Mail", 
                content = "Ai primit un mail nou de la soferi", 
                icon = "fas fa-envelope", 
                timeout = 3500, 
                color = "#ff002f",
            },
        })
    end
    Config.PhoneApplications['mail'].Alerts = Config.PhoneApplications['mail'].Alerts + 1
    fptPhone.setPhoneAlerts{"mail"}
end)


RegisterNetEvent('fptPhone:client:NewMailNotifyCiresar')
AddEventHandler('fptPhone:client:NewMailNotifyCiresar', function(MailData)
    if PhoneData.isOpen then
        SendNUIMessage({
            action = "PhoneNotification",
            PhoneNotify = {
                title = "Mail",
                text = "Ai primit un mail nou de la seful livedei",
                icon = "fas fa-envelope",
                color = "#ff002f",
                timeout = 1500,
            },
        })
    else
        SendNUIMessage({
            action = "Notification",
            NotifyData = {
                title = "Mail", 
                content = "Ai primit un mail nou de la seful livedei", 
                icon = "fas fa-envelope", 
                timeout = 3500, 
                color = "#ff002f",
            },
        })
    end
    Config.PhoneApplications['mail'].Alerts = Config.PhoneApplications['mail'].Alerts + 1
    fptPhone.setPhoneAlerts{"mail"}
end)


RegisterNetEvent('fptPhone:client:NewMailNotifyCiuperca')
AddEventHandler('fptPhone:client:NewMailNotifyCiuperca', function(MailData)
    if PhoneData.isOpen then
        SendNUIMessage({
            action = "PhoneNotification",
            PhoneNotify = {
                title = "Mail",
                text = "Ai primit un mail nou de la seful livedei",
                icon = "fas fa-envelope",
                color = "#ff002f",
                timeout = 1500,
            },
        })
    else
        SendNUIMessage({
            action = "Notification",
            NotifyData = {
                title = "Mail", 
                content = "Ai primit un mail nou de la seful livedei", 
                icon = "fas fa-envelope", 
                timeout = 3500, 
                color = "#ff002f",
            },
        })
    end
    Config.PhoneApplications['mail'].Alerts = Config.PhoneApplications['mail'].Alerts + 1
    fptPhone.setPhoneAlerts{"mail"}
end)


RegisterNetEvent('fptPhone:client:NewMailNotifyElec')
AddEventHandler('fptPhone:client:NewMailNotifyElec', function(MailData)
    if PhoneData.isOpen then
        SendNUIMessage({
            action = "PhoneNotification",
            PhoneNotify = {
                title = "Mail",
                text = "Ai primit un mail nou de la electrician",
                icon = "fas fa-envelope",
                color = "#ff002f",
                timeout = 1500,
            },
        })
    else
        SendNUIMessage({
            action = "Notification",
            NotifyData = {
                title = "Mail", 
                content = "Ai primit un mail nou de la electriciani", 
                icon = "fas fa-envelope", 
                timeout = 3500, 
                color = "#ff002f",
            },
        })
    end
    Config.PhoneApplications['mail'].Alerts = Config.PhoneApplications['mail'].Alerts + 1
    fptPhone.setPhoneAlerts{"mail"}
end)



RegisterNUICallback('PostAdvert', function(data)
    TriggerServerEvent('fptPhone:server:AddAdvert', data.message)
   -- TriggerServerEvent('fptPhone:server:payadvert', source)
end)

RegisterNetEvent('fptPhone:client:UpdateAdverts')
AddEventHandler('fptPhone:client:UpdateAdverts', function(Adverts, LastAd)
    PhoneData.Adverts = Adverts

    if PhoneData.isOpen then
        SendNUIMessage({
            action = "PhoneNotification",
            PhoneNotify = {
                title = "DarkWeb",
                text = "Un nou anunt a fost postat.",
                icon = "fas fa-user-ninja",
                color = "#000000",
                timeout = 2500,
            },
        })
    else
        SendNUIMessage({
            action = "Notification",
            NotifyData = {
                title = "DarkWeb",
                content = "Un nou anunt a fost postat.",
                icon = "fas fa-user-ninja",
                timeout = 2500,
                color = "#000000",
            },
        })
    end

    SendNUIMessage({
        action = "RefreshAdverts",
        Adverts = PhoneData.Adverts
    })
end)

RegisterNUICallback('LoadAdverts', function()
    SendNUIMessage({
        action = "RefreshAdverts",
        Adverts = PhoneData.Adverts
    })
end)

RegisterNUICallback('ClearAlerts', function(data, cb)
    local chat = data.number
    local ChatKey = GetKeyByNumber(chat)

    if PhoneData.Chats[ChatKey].Unread ~= nil then
        local newAlerts = (Config.PhoneApplications['whatsapp'].Alerts - PhoneData.Chats[ChatKey].Unread)
        Config.PhoneApplications['whatsapp'].Alerts = newAlerts
        fptPhone.setPhoneAlerts{"whatsapp", newAlerts}

        PhoneData.Chats[ChatKey].Unread = 0

        SendNUIMessage({
            action = "RefreshWhatsappAlerts",
            Chats = PhoneData.Chats,
        })
        SendNUIMessage({ action = "RefreshAppAlerts", AppData = Config.PhoneApplications })
    end
end)

RegisterNUICallback('EditContact', function(data, cb)
    local NewName = data.CurrentContactName
    local NewNumber = data.CurrentContactNumber
    local NewIban = data.CurrentContactIban
    local OldName = data.OldContactName
    local OldNumber = data.OldContactNumber
    local OldIban = data.OldContactIban

    for k, v in pairs(PhoneData.Contacts) do
        if v.name == OldName and v.number == OldNumber then
            v.name = NewName
            v.number = NewNumber
            v.iban = NewIban
        end
    end
    if PhoneData.Chats[NewNumber] ~= nil and next(PhoneData.Chats[NewNumber]) ~= nil then
        PhoneData.Chats[NewNumber].name = NewName
    end
    Citizen.Wait(100)
    fptPhone.editContact{NewName, NewNumber, NewIban, OldName, OldNumber, OldIban}
    cb(PhoneData.Contacts)
    
end)

function GenerateTweetId()
    local tweetId = "TWEET-"..math.random(11111111, 99999999)
    return tweetId
end


RegisterNUICallback('GetHashtagMessages', function(data, cb)
    if PhoneData.Hashtags[data.hashtag] ~= nil and next(PhoneData.Hashtags[data.hashtag]) ~= nil then
        cb(PhoneData.Hashtags[data.hashtag])
    else
        cb(nil)
    end
end)

function getIndex(theTable, theID)
	local index={}

	for k,v in pairs(theTable) do
	   index[v.id]=k
	end

	return index[theID]
end

RegisterNUICallback('GetTweets', function(data, cb)
    print(json.encode(data))
    fptPhone.getTweeturi({}, function(Tweeturi)
        cb(Tweeturi)
        print(json.decode(getTweeturi))
    end)
end)

RegisterNUICallback('GetSelfTweets', function(data, cb)
    cb(PhoneData.SelfTweets)
    print(json.decode(PhoneData.selfTweets))
end)

RegisterNUICallback('UpdateProfilePicture', function(data)
    local pf = data.profilepicture

    PhoneData.PlayerData.profilepicture = pf
    fptPhone.saveProfilePicture{pf}
end)

RegisterNUICallback('PostNewTweet', function(data, cb)
    local TweetMessage = {
        firstName = UserData.firstname,
        lastName = UserData.name,
        message = escape_str(data.Message),
        url = data.url,
        time = data.Date,
        tweetId = GenerateTweetId(),
        picture = data.Picture
    }
    
    table.insert(PhoneData.Tweets, TweetMessage)
    fptPhone.updateTweets{PhoneData.Tweets, TweetMessage}
    Citizen.Wait(100)
    cb(PhoneData.Tweets)
    TriggerServerEvent('MI-phone:server:UpdateTweets', PhoneData.Tweets, TweetMessage)
    
end)

RegisterNetEvent('fpt-phone:client:UpdateDarkwebs')
AddEventHandler('fpt-phone:client:UpdateDarkwebs', function(Darkwebs, LastAd)
    PhoneData.Darkwebs = Darkwebs

    if PhoneData.isOpen then
        SendNUIMessage({
            action = "PhoneNotification",
            PhoneNotify = {
                title = "Deep Web",
                text = "Mesaj nou pe Deep Web",
                icon = "fas fa-skull-crossbones",
                color = "#ff0000",
                timeout = 2500,
            },
        })
    else
        SendNUIMessage({
            action = "Notification",
            NotifyData = {
                title = "Deep Web", 
                content = "Mesaj nou pe Deep Web",
                icon = "fas fa-skull-crossbones", 
                timeout = 2500, 
                color = "#ff0000",
            },
        })
    end

    SendNUIMessage({
        action = "RefreshDarkwebs",
        Darkwebs = PhoneData.Darkwebs
    })
end)


RegisterNetEvent('MI-phone:client:UpdateTweets')
AddEventHandler('MI-phone:client:UpdateTweets', function(src, Tweets, NewTweetData)
    PhoneData.Tweets = Tweets
    local MyPlayerId = PhoneData.PlayerData.source

    if src ~= MyPlayerId then
        if not PhoneData.isOpen then
            SendNUIMessage({
                action = "Notification",
                NotifyData = {
                    title = " A fost postat un nou tweet!", 
                    content = NewTweetData.message, 
                    icon = "fab fa-twitter", 
                    timeout = 3500, 
                    color = nil,
                },
            })
        else
            SendNUIMessage({
                action = "PhoneNotification",
                PhoneNotify = {
                    title = " A fost postat un nou tweet!", 
                    text = NewTweetData.message, 
                    icon = "fab fa-twitter",
                    color = "#1DA1F2",
                },
            })
        end
    else
        SendNUIMessage({
            action = "PhoneNotification",
            PhoneNotify = {
                title = "A fost postat un nou tweet!", 
                text = "A fost postat un nou tweet!", 
                icon = "fab fa-twitter",
                color = "#1DA1F2",
                timeout = 1000,
            },
        })
    end
end)

RegisterNUICallback('PostNewImage', function(data, cb)
    SetNuiFocus(false, false)
	CreateMobilePhone(1)
    CellCamActivate(true, true)
    takePhoto = true

	while takePhoto do
		Citizen.Wait(0)
		SetMobilePhoneScale(2000)
		
		if IsControlJustPressed(1, 27) then -- Toogle Mode
			frontCam = not frontCam
			CellFrontCamActivate(frontCam)
		end
		
		if IsControlJustPressed(1, 176) then
			exports['screenshot-basic']:requestScreenshotUpload('https://discord.com/api/webhooks/957652800614056107/KHCOkpuYnxxVnKatpqFO6IcnhX_tPFg-K96ECBAC4cuscyeKjEm3wsJP60gVkYsKV1n7', 'files[]', function(data2)
				DestroyMobilePhone()
				CellCamActivate(false, false)
				local resp = json.decode(data2)
				photoUrl = resp.attachments[1].proxy_url
				cb(resp.attachments[1].proxy_url)
			end)

            Citizen.Wait(200)
			
			DestroyMobilePhone()
			takePhoto = false
		end
    end
	
    OpenPhone()
end)

RegisterNetEvent("rezolvacoae", function()
    ExecuteCommand("rezolvare")
end)

RegisterNUICallback('openCamera', function(data, cb)
    SetNuiFocus(false, false)
    CreateMobilePhone(1)
    CellCamActivate(true, true)
    takePhoto = true
    while takePhoto do
        if IsControlJustPressed(1, 46) then -- Toogle Mode
            frontCam = not frontCam
            CellFrontCamActivate(frontCam)
        elseif IsControlJustPressed(1, 176) then -- TAKE.. PIC
            exports['screenshot-basic']:requestScreenshotUpload(tostring("https://ptb.discord.com/api/webhooks/968676253995528243/3cfeAT_qCQgknRF0L6A6HTOtNLDzpdrlhdMhcvjEFvDryfgKV_ALMprf05dE05v_CeeH"), "files[]", function(data)
                        print("poza facuta")
                        local image = json.decode(data)
                        DestroyMobilePhone()
                        CellCamActivate(false, false)
                        TriggerServerEvent('fptPhone:server:addImageToGallery', image.attachments[1].proxy_url)
                        ExecuteCommand("rezolvare")
                        Wait(400)
                        TriggerServerEvent('fptPhone:server:getImageFromGallery')
                        cb(json.encode(image.attachments[1].proxy_url))
                    end)
            takePhoto = false
        end
        HideHudComponentThisFrame(7)
        HideHudComponentThisFrame(8)
        HideHudComponentThisFrame(9)
        HideHudComponentThisFrame(6)
        HideHudComponentThisFrame(19)
        HideHudAndRadarThisFrame()
        EnableAllControlActions(0)
        Wait(0)
    end
    Wait(1000)

end)

RegisterNetEvent('fptPhone:client:SetUserData', function(data)
    UserData = data
end)

RegisterNetEvent('fptPhone:client:UpdateTweets')
AddEventHandler('fptPhone:client:UpdateTweets', function(src, Tweets, NewTweetData)
    PhoneData.Tweets = Tweets
end)

RegisterNUICallback('PostDarkweb', function(data)
    fptPhone.UpdateDeep{data.message}
end)

RegisterNetEvent('fptPhone:client:UpdateDarkwebs')
AddEventHandler('fptPhone:client:UpdateDarkwebs', function(Darkwebs, LastAd)
    PhoneData.Darkwebs = Darkwebs

    if PhoneData.isOpen then
        SendNUIMessage({
            action = "PhoneNotification",
            PhoneNotify = {
                title = "Deep Web",
                text = "Mesaj nou pe Deep Web",
                icon = "fas fa-skull-crossbones",
                color = "#ff0000",
                timeout = 2500,
            },
        })
    else
        SendNUIMessage({
            action = "Notification",
            NotifyData = {
                title = "Deep Web", 
                content = "Mesaj nou pe Deep Web",
                icon = "fas fa-skull-crossbones", 
                timeout = 2500, 
                color = "#ff0000",
            },
        })
    end

    SendNUIMessage({
        action = "RefreshDarkwebs",
        Darkwebs = PhoneData.Darkwebs
    })
end)

RegisterNUICallback('LoadDarkwebs', function()
    print("DarkWebs Loaded succesfull")
    SendNUIMessage({
        action = "RefreshDarkwebs",
        Darkwebs = PhoneData.Darkwebs
    })
end)

RegisterNUICallback('GetMentionedTweets', function(data, cb)
    cb(PhoneData.MentionedTweets)
end)

RegisterNUICallback('GetHashtags', function(data, cb)
    if PhoneData.Hashtags ~= nil and next(PhoneData.Hashtags) ~= nil then
        cb(PhoneData.Hashtags)
    else
        cb(nil)
    end
end)

RegisterNetEvent('fptPhone:client:GetMentioned')
AddEventHandler('fptPhone:client:GetMentioned', function(TweetMessage, AppAlerts)
    Config.PhoneApplications["twitter"].Alerts = AppAlerts
    if not PhoneData.isOpen then
        SendNUIMessage({ action = "Notification", NotifyData = { title = "Twitter", content = TweetMessage.message, icon = "fab fa-twitter", timeout = 3500, color = nil, }, })
    else
        SendNUIMessage({ action = "PhoneNotification", PhoneNotify = { title = "Twitter", text = TweetMessage.message, icon = "fab fa-twitter", color = "#1DA1F2", }, })
    end
    local TweetMessage = {firstName = TweetMessage.firstName, lastName = TweetMessage.lastName, message = TweetMessage.message, time = TweetMessage.time, picture = TweetMessage.picture}
    table.insert(PhoneData.MentionedTweets, TweetMessage)
    SendNUIMessage({ action = "RefreshAppAlerts", AppData = Config.PhoneApplications })
    SendNUIMessage({ action = "UpdateMentionedTweets", Tweets = PhoneData.MentionedTweets })
end)

RegisterNUICallback('ClearMentions', function()
    Config.PhoneApplications["twitter"].Alerts = 0
    SendNUIMessage({
        action = "RefreshAppAlerts",
        AppData = Config.PhoneApplications
    })
    fptPhone.setPhoneAlerts{"twitter", 0}
    SendNUIMessage({ action = "RefreshAppAlerts", AppData = Config.PhoneApplications })
end)

RegisterNUICallback('ClearGeneralAlerts', function(data)
    SetTimeout(400, function()
        Config.PhoneApplications[data.app].Alerts = 0
        SendNUIMessage({
            action = "RefreshAppAlerts",
            AppData = Config.PhoneApplications
        })
        fptPhone.setPhoneAlerts{data.app, 0}
        SendNUIMessage({ action = "RefreshAppAlerts", AppData = Config.PhoneApplications })
    end)
end)

RegisterNetEvent("fptPhone:notify", function(notificationData)
	if notificationData and type(notificationData) == "table" then
		SendNUIMessage({
			action = "PhoneNotification",
			PhoneNotify = notificationData
		})
	end
end)

RegisterNUICallback('GetWhatsappChats', function(data, cb)
    if next (PhoneData.Chats) then
        fptPhone.GetContactPictures({PhoneData.Chats}, function(Chats)
            cb(Chats)
        end)
    end
end)

RegisterNUICallback("transferMoney", function(data)
    fptPhone.transferMoney{data};
end);


RegisterNUICallback("GetBankMoney", function(data, cb)
	fptPhone.getBankMoney({}, function(amount)
		cb(amount)
	end)
end)

RegisterNetEvent("fptPhone:client:CallContact")
AddEventHandler("fptPhone:client:CallContact", function (data)
    local callData
    local gPN
    fptPhone.GetCallState({data}, function(cData) callData = cData end)
    fptPhone.getPhoneNumber({}, function(PN) gPN = PN end)
    local canCall = callData.call
    local isOnline = callData.online
    local status = { 
        CanCall = canCall, 
        IsOnline = isOnline,
        InCall = PhoneData.CallData.InCall,
    }
    if canCall and not status.InCall and (data.number ~= gPN) then
        if data.service then
            CallContact(data, true)
        else
             CallContact(data, false)
        end
       
    end
    SendNUIMessage({
        action = 'callService'
    })
    OpenPhone()
end)


RegisterNUICallback('CallContact', function(data, cb)
    local gPN
    fptPhone.getPhoneNumber({}, function(PN) gPN = PN end)
    fPhone.TriggerServerCallback('fptPhone_new:server:GetCallState', function(CanCall, IsOnline)
        local status = { 
            CanCall = CanCall, 
            IsOnline = IsOnline,
            InCall = PhoneData.CallData.InCall,
        }
        cb(status)
        if CanCall and not status.InCall and (data.ContactData.number ~= gPN) then
            CallContact(data.ContactData, data.Anonymous)
        end
    end, data.ContactData)
end)

CallContact = function(CallData, AnonymousCall)
    local RepeatCount = 0
    fptPhone.getUserData{}
    Citizen.Wait(200)
    PhoneData.CallData.CallType = "outgoing"
    PhoneData.CallData.InCall = true
    PhoneData.CallData.TargetData = CallData
    PhoneData.CallData.AnsweredCall = false
    PhoneData.CallData.CallId = UserData.id
    fptPhone.callContact{PhoneData.CallData.TargetData, PhoneData.CallData.CallId, AnonymousCall}
    fptPhone.setCallState{true}

    if PhoneData.isOpen then
        DoPhoneAnimation('cellphone_call_listen_base')
    else
        DoPhoneAnimation('cellphone_call_listen_base')
    end
    
    --exports["pma-voice"]:SetCallChannel(UserData.id,'Phone')
    exports["pma-voice"]:SetCallChannel(UserData.id)
    
    for i = 1, Config.CallRepeats + 1, 1 do
        if not PhoneData.CallData.AnsweredCall then
            if RepeatCount + 1 ~= Config.CallRepeats + 1 then
                if PhoneData.CallData.InCall then
                    RepeatCount = RepeatCount + 1
                else
                    break
                end
                Citizen.Wait(Config.RepeatTimeout)
            else
                CancelCall()
                exports["pma-voice"]:SetCallChannel(0)
                break
            end
        else
            break
        end
    end
end

CancelCall = function()
    --fptPhone.cancelCall{PhoneData.CallData}
    TriggerServerEvent("CancelCall:Legend",PhoneData.CallData)
    print(PhoneData.callData)
    if PhoneData.CallData.CallType == "ongoing" then
        exports["pma-voice"]:SetCallChannel(0)
    end
    PhoneData.CallData.CallType = nil
    PhoneData.CallData.InCall = false
    PhoneData.CallData.AnsweredCall = false
    PhoneData.CallData.TargetData = {}
    PhoneData.CallData.CallId = nil

    if not PhoneData.isOpen then
        StopAnimTask(PlayerPedId(), PhoneData.AnimationData.lib, PhoneData.AnimationData.anim, 2.5)
        deletePhone()
        PhoneData.AnimationData.lib = nil
        PhoneData.AnimationData.anim = nil
    else
        PhoneData.AnimationData.lib = nil
        PhoneData.AnimationData.anim = nil
    end

    fptPhone.setCallState(false)

    if not PhoneData.isOpen then
        SendNUIMessage({ 
            action = "Notification", 
            NotifyData = { 
                title = "Telefon",
                content = "Apelul s-a terminat!", 
                icon = "fas fa-phone", 
                timeout = 3500, 
                color = "#e84118",
            }, 
        })            
    else
        SendNUIMessage({ 
            action = "PhoneNotification", 
            PhoneNotify = { 
                title = "Telefon", 
                text = "Apelul s-a terminat!", 
                icon = "fas fa-phone", 
                color = "#e84118", 
            }, 
        })

        SendNUIMessage({
            action = "SetupHomeCall",
            CallData = PhoneData.CallData,
        })

        SendNUIMessage({
            action = "CancelOutgoingCall",
        })
    end
end

RegisterNetEvent('fptPhone:client:CancelCall')
AddEventHandler('fptPhone:client:CancelCall', function()
    if PhoneData.CallData.CallType == "ongoing" then
        SendNUIMessage({
            action = "CancelOngoingCall"
        })
    end
    exports["pma-voice"]:SetCallChannel(0)
    PhoneData.CallData.CallType = nil
    PhoneData.CallData.InCall = false
    PhoneData.CallData.AnsweredCall = false
    PhoneData.CallData.TargetData = {}

    if not PhoneData.isOpen then
        StopAnimTask(PlayerPedId(), PhoneData.AnimationData.lib, PhoneData.AnimationData.anim, 2.5)
        deletePhone()
        PhoneData.AnimationData.lib = nil
        PhoneData.AnimationData.anim = nil
    else
        PhoneData.AnimationData.lib = nil
        PhoneData.AnimationData.anim = nil
    end

    fptPhone.setCallState(false)

    if not PhoneData.isOpen then
        SendNUIMessage({ 
            action = "Notification", 
            NotifyData = { 
                title = "Telefon",
                content = "Apelul s-a incheiat!", 
                icon = "fas fa-phone", 
                timeout = 3500, 
                color = "#e84118",
            }, 
        })            
    else
        SendNUIMessage({ 
            action = "PhoneNotification", 
            PhoneNotify = { 
                title = "Telefon", 
                text = "Apelul s-a incheiat!", 
                icon = "fas fa-phone", 
                color = "#e84118", 
            }, 
        })

        SendNUIMessage({
            action = "SetupHomeCall",
            CallData = PhoneData.CallData,
        })

        SendNUIMessage({
            action = "CancelOutgoingCall",
        })
    end
end)

RegisterNetEvent('fptPhone:client:GetCalled')
AddEventHandler('fptPhone:client:GetCalled', function(CallerNumber, CallId, AnonymousCall)
    local RepeatCount = 0
    local CallData = {
        number = CallerNumber,
        name = IsNumberInContacts(CallerNumber),
        anonymous = AnonymousCall
    }

    if AnonymousCall then
        CallData.name = "Numar Necunoscut"
    end

    PhoneData.CallData.CallType = "incoming"
    PhoneData.CallData.InCall = true
    PhoneData.CallData.AnsweredCall = false
    PhoneData.CallData.TargetData = CallData
    PhoneData.CallData.CallId = CallId

    fptPhone.setCallState{true}

    SendNUIMessage({
        action = "SetupHomeCall",
        CallData = PhoneData.CallData,
    })

    for i = 1, Config.CallRepeats + 1, 1 do
        if not PhoneData.CallData.AnsweredCall then
            if RepeatCount + 1 ~= Config.CallRepeats + 1 then
                if PhoneData.CallData.InCall then
                    RepeatCount = RepeatCount + 1
                    TriggerServerEvent("InteractSound_SV:PlayOnSource", "ringing", 0.2)
                    
                    if not PhoneData.isOpen then
                        SendNUIMessage({
                            action = "IncomingCallAlert",
                            CallData = PhoneData.CallData.TargetData,
                            Canceled = false,
                            AnonymousCall = AnonymousCall,
                        })
                    end
                else
                    SendNUIMessage({
                        action = "IncomingCallAlert",
                        CallData = PhoneData.CallData.TargetData,
                        Canceled = true,
                        AnonymousCall = AnonymousCall,
                    })
                    --fptPhone.addRecentCall{"missed", CallData}
                    TriggerServerEvent("fptPhone:recente", "missed", CallData)
                    break
                end
                Citizen.Wait(Config.RepeatTimeout)
            else
                SendNUIMessage({
                    action = "IncomingCallAlert",
                    CallData = PhoneData.CallData.TargetData,
                    Canceled = true,
                    AnonymousCall = AnonymousCall,
                })
                fptPhone.addRecentCall{"missed", CallData}
                TriggerServerEvent("fptPhone:recente", "missed", CallData)
                break
            end
        else
            fptPhone.addRecentCall{"missed", CallData}
            TriggerServerEvent("fptPhone:recente", "outgoing", CallData)
            break
        end
    end
end)



RegisterNUICallback('CancelOutgoingCall', function()
    CancelCall()
end)

RegisterNUICallback('DenyIncomingCall', function()
    CancelCall()
end)

RegisterNUICallback('CancelOngoingCall', function()
    CancelCall()
end)

RegisterNUICallback('AnswerCall', function()
    AnswerCall()
end)

function AnswerCall()
    if (PhoneData.CallData.CallType == "incoming" or PhoneData.CallData.CallType == "outgoing") and PhoneData.CallData.InCall and not PhoneData.CallData.AnsweredCall then
        PhoneData.CallData.CallType = "ongoing"
        PhoneData.CallData.AnsweredCall = true
        PhoneData.CallData.CallTime = 0

        SendNUIMessage({ action = "AnswerCall", CallData = PhoneData.CallData})
        SendNUIMessage({ action = "SetupHomeCall", CallData = PhoneData.CallData})

        fptPhone.setCallState{true}

        if PhoneData.isOpen then
            DoPhoneAnimation('cellphone_text_to_call')
        else
            DoPhoneAnimation('cellphone_call_listen_base')
        end

        Citizen.CreateThread(function()
            while true do
                if PhoneData.CallData.AnsweredCall then
                    PhoneData.CallData.CallTime = PhoneData.CallData.CallTime + 1
                    SendNUIMessage({
                        action = "UpdateCallTime",
                        Time = PhoneData.CallData.CallTime,
                        Name = PhoneData.CallData.TargetData.name,
                    })
                else
                    break
                end

                Citizen.Wait(1000)
            end
        end)
        fptPhone.answerCall{PhoneData.CallData}

        exports["pma-voice"]:SetCallChannel(PhoneData.CallData.CallId)

    else
        PhoneData.CallData.InCall = false
        PhoneData.CallData.CallType = nil
        PhoneData.CallData.AnsweredCall = false

        SendNUIMessage({ 
            action = "PhoneNotification", 
            PhoneNotify = { 
                title = "Telefon", 
                text = "Nu te suna nimeni...", 
                icon = "fas fa-phone", 
                color = "#e84118", 
            }, 
        })
    end
end

RegisterNetEvent('fptPhone:client:AnswerCall')
AddEventHandler('fptPhone:client:AnswerCall', function()
    if (PhoneData.CallData.CallType == "incoming" or PhoneData.CallData.CallType == "outgoing") and PhoneData.CallData.InCall and not PhoneData.CallData.AnsweredCall then
        PhoneData.CallData.CallType = "ongoing"
        PhoneData.CallData.AnsweredCall = true
        PhoneData.CallData.CallTime = 0

        SendNUIMessage({ action = "AnswerCall", CallData = PhoneData.CallData})
        SendNUIMessage({ action = "SetupHomeCall", CallData = PhoneData.CallData})

        fptPhone.setCallState{true}

        if PhoneData.isOpen then
            DoPhoneAnimation('cellphone_call_listen_base')
        else
            DoPhoneAnimation('cellphone_call_listen_base')
        end

        Citizen.CreateThread(function()
            while true do
                if PhoneData.CallData.AnsweredCall then
                    PhoneData.CallData.CallTime = PhoneData.CallData.CallTime + 1
                    SendNUIMessage({
                        action = "UpdateCallTime",
                        Time = PhoneData.CallData.CallTime,
                        Name = PhoneData.CallData.TargetData.name,
                    })
                else
                    break
                end

                Citizen.Wait(1000)
            end
        end)    

        exports["pma-voice"]:SetCallChannel(PhoneData.CallData.CallId)
    else
        PhoneData.CallData.InCall = false
        PhoneData.CallData.CallType = nil
        PhoneData.CallData.AnsweredCall = false

        SendNUIMessage({ 
            action = "PhoneNotification", 
            PhoneNotify = { 
                title = "Telefon", 
                text = "Nu te suna nimeni...", 
                icon = "fas fa-phone", 
                color = "#e84118", 
            }, 
        })
    end
end)

RegisterNUICallback('shareContact', function(data, cb)
    TriggerServerEvent("teducsilaparis")
end)

RegisterNUICallback('RemoveSuggestion', function(data, cb)
    local data = data.data

    if PhoneData.SuggestedContacts ~= nil and next(PhoneData.SuggestedContacts) ~= nil then
        for k, v in pairs(PhoneData.SuggestedContacts) do
            if (data.name[1] == v.name[1] and data.name[2] == v.name[2]) and data.number == v.number and data.bank == v.bank then
                table.remove(PhoneData.SuggestedContacts, k)
            end
        end
    end
end)

function GetClosestPlayer()
    return nil
end

RegisterNUICallback('DeleteContact', function(data, cb)
    local Name = data.CurrentContactName
    local Number = data.CurrentContactNumber
    local Account = data.CurrentContactIban

    for k, v in pairs(PhoneData.Contacts) do
        if v.name == Name and v.number == Number then
            table.remove(PhoneData.Contacts, k)
            if PhoneData.isOpen then
                SendNUIMessage({
                    action = "PhoneNotification",
                    PhoneNotify = {
                        title = "Telefon",
                        text = "Ai scos un contact!", 
                        icon = "fa fa-phone-alt",
                        color = "#04b543",
                        timeout = 1500,
                    },
                })
            else
                SendNUIMessage({
                    action = "Notification",
                    NotifyData = {
                        title = "Telefon", 
                        content = "Ai scos un contact!", 
                        icon = "fa fa-phone-alt", 
                        timeout = 3500, 
                        color = "#04b543",
                    },
                })
            end
            break
        end
    end
    Citizen.Wait(100)
    cb(PhoneData.Contacts)
    if PhoneData.Chats[Number] ~= nil and next(PhoneData.Chats[Number]) ~= nil then
        PhoneData.Chats[Number].name = Number
    end
    fptPhone.removeContact{Name, Number}
end)

RegisterNetEvent('fptPhone:client:AddNewSuggestion')
AddEventHandler('fptPhone:client:AddNewSuggestion', function(SuggestionData)
    table.insert(PhoneData.SuggestedContacts, SuggestionData)

    if PhoneData.isOpen then
        SendNUIMessage({
            action = "PhoneNotification",
            PhoneNotify = {
                title = "Telefon",
                text = "Ai o sugestie noua de contact!", 
                icon = "fa fa-phone-alt",
                color = "#04b543",
                timeout = 1500,
            },
        })
    else
        SendNUIMessage({
            action = "Notification",
            NotifyData = {
                title = "Telefon", 
                content = "Ai o sugestie noua de contact!", 
                icon = "fa fa-phone-alt", 
                timeout = 3500, 
                color = "#04b543",
            },
        })
    end

    Config.PhoneApplications["phone"].Alerts = Config.PhoneApplications["phone"].Alerts + 1
    fptPhone.setPhoneAlerts{"phone", Config.PhoneApplications["phone"].Alerts}
end)

RegisterNetEvent('fptPhone:client:RemoveBankMoney')
AddEventHandler('fptPhone:client:RemoveBankMoney', function(amount)
    if PhoneData.isOpen then
        SendNUIMessage({
            action = "PhoneNotification",
            PhoneNotify = {
                title = "TimeToPlay Bank",
                text = "$"..amount..",- au fost retrasi din contul tau bancar!", 
                icon = "fas fa-university", 
                color = "#ff002f",
                timeout = 3500,
            },
        })
    else
        SendNUIMessage({
            action = "Notification",
            NotifyData = {
                title = "TimeToPlay Bank",
                content = "$"..amount..",- au fost retrasi din contul tau bancar!", 
                icon = "fas fa-university",
                timeout = 3500, 
                color = "#ff002f",
            },
        })
    end
end)

RegisterNUICallback('JoinRace', function(data)
    TriggerServerEvent('uc-lapraces:server:JoinRace', data.RaceData)
end)

RegisterNUICallback('LeaveRace', function(data)
    TriggerServerEvent('uc-lapraces:server:LeaveRace', data.RaceData)
end)

RegisterNUICallback('StartRace', function(data)
    TriggerServerEvent('uc-lapraces:server:StartRace', data.RaceData.RaceId)
end)

RegisterNetEvent('fptPhone:client:UpdateLapraces')
AddEventHandler('fptPhone:client:UpdateLapraces', function()
    SendNUIMessage({
        action = "UpdateRacingApp",
    })
end)

RegisterNUICallback('Reziliaza', function (data,cb)
    local nuserCID = data.id
    fptPhone.reziliereContract{nuserCID}

    SendNUIMessage({
        action = "PhoneNotification",
        PhoneNotify = {
            title = "Casa",
            text = 'Ai incheiat contractul cu ' .. data.name,
            icon = "fas fa-house-user",
            color = "#FFFFFF",
            timeout = 1500,
        },
    })
    
end)

RegisterNUICallback('GetPlayerHouses', function(data, cb)
    local Houses = fptPhone.getPlayerHouses{}
    cb(Houses)
end)

RegisterNUICallback('SetGPSLocation', function(data, cb)
    local ped = PlayerPedId()

    SetNewWaypoint(data.coords.x, data.coords.y)
    TriggerEvent("fplaytbank:notifications", 'success', 'GPS Setat!', 'success')
end)

RegisterNUICallback('SetApartmentLocation', function(data, cb)
    local ApartmentData = data.data.appartmentdata
    local TypeData = Apartments.Locations[ApartmentData.type]

    SetNewWaypoint(TypeData.coords.enter.x, TypeData.coords.enter.y)
    TriggerEvent("fplaytbank:notifications", 'success', 'GPS Setat!', 'success')
end)


RegisterNUICallback('GetCurrentLawyers', function(data, cb)
	local weazel = fptPhone.getWeazel{}
    cb(weazel)
end)


local WaitTime = 0

function resetWaitTime()
    Wait(10000)
    WaitTime = 0 
end

RegisterNUICallback('calledTaxi', function(data, cb)
    if WaitTime == 0 then
        WaitTime = 10
        local accept = fptPhone.answerTaxi{data.numar}
        resetWaitTime()
        cb(accept)
    else
        cb('asteapta')
    end
    
end)

RegisterNUICallback('calledMecanic', function(data, cb)
    if WaitTime == 0 then
        WaitTime = 10
        local accept = fptPhone.answerMecanic{data.numar}
        resetWaitTime()
        cb(accept)
    else
        cb('asteapta')
    end
end)

RegisterNUICallback('calledWeazel', function(data, cb)
    if WaitTime == 0 then
        WaitTime = 10
        local accept = fptPhone.answerWeazel{data.numar}
        resetWaitTime()
        cb(accept)
    else
        cb('asteapta')
    end
end)
RegisterNUICallback('GetCurrentDrivers', function(data, cb)
    fPhone.TriggerServerCallback('fptPhone:getCurrentTaxi', function(taxi)
        cb(taxi)
    end)
end)
RegisterNUICallback('GetCurrentMechanic', function(data, cb)
    fPhone.TriggerServerCallback('fptPhone:getCurrentMechanic', function(mechanic)
        cb(mechanic)
    end)
end)
RegisterNUICallback('GetCurrentDoctor', function(data, cb)
    fPhone.TriggerServerCallback('fptPhone:getCurrentSmurd', function(smurd)
        cb(smurd)
    end)
end)
RegisterNUICallback('GetCurrentpolices', function(data, cb)
    fPhone.TriggerServerCallback('fptPhone:getCurrentPolices', function(lawyers)
        cb(lawyers)
    end)
end)
RegisterNUICallback('GetCurrentTraficant', function(data, cb)
    fPhone.TriggerServerCallback('fptPhone:getCurrentTraficant', function(hitman)
        cb(hitman)
    end)
end)

RegisterNUICallback('olxAdd', function(data, cb)
    fptPhone.addAnnounceOlx{data}
end)
RegisterNUICallback('olxFetchMyAnnounces', function(data, cb)
    fPhone.TriggerServerCallback('fptPhone:olxFetchMyAnnounces', function(result)

        cb(result)
    end)
end)

local anunturi = ""


RegisterNetEvent("updateanunt", function()
    TriggerServerEvent("inserttableann")
end)

RegisterNUICallback("olxSearch", function(data, cb)
    fPhone.TriggerServerCallback('fptPhone:olxSearch', function(result)
      cb(result)
    end,data)
    print(json.encode(data))
  end)

  RegisterNUICallback("olxDeleteAnn", function(data)
    fptPhone.removeAnn{data}
  end)
  RegisterNUICallback("olxEditAnn", function(data)
    fptPhone.editAnn{data}
  end)