fx_version 'cerulean'
game 'gta5'
lua54 'yes'
ui_page 'ui/index.html'

server_scripts {
	"@vrp/lib/utils.lua",
	"s_inventory.lua",
}

client_scripts {
	"@vrp/client/Proxy.lua",
	"client/*.lua",
	"clothing_vars.lua",
	
}

files {
	"ui/**/*",
	"client/html/assets/*.png",
	"client/html/assets/**/*.png"
}