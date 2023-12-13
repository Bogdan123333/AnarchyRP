Citizen.CreateThread(function()
	nuiMessage(false)
end)

RegisterCommand("salut", function(source, args)
    nuiMessage(true)
end)


function nuiMessage(val)
	SetNuiFocus(val, false)
	SendNUIMessage({action = "toggleWindow", value = val})
end

RegisterNUICallback('forceClose', function()
	nuiMessage(false)
end)