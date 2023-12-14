function Open(message, color, position)
	SendNUIMessage({
		action = 'open',
		message = message,
		color = color,
		position = position,
	})
end

function Close()
	SendNUIMessage({
		action = 'close'
	})
end