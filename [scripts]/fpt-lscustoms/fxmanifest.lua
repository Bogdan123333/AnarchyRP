fx_version 'bodacious'
game 'gta5'


ui_page 'client/ui/index.html'
files {
	'client/ui/index.html',
	'client/ui/js/**/*.js',
	'client/ui/css/**/*.css',
	'client/ui/img/**/*.png',
	'client/ui/sounds/**/*.ogg'
}

client_scripts {	
	"@vrp/client/Tunnel.lua",
	"@vrp/client/Proxy.lua",
	'client/core.lua',
	'client/helper.lua',
	'config/config.lua',
	'config/menus.lua',
	'config/labels.lua',
	'config/vehicles.lua',
}

server_scripts {
	"@vrp/lib/utils.lua",	
	'server/core.lua',
	'config/config.lua',
	'config/menus.lua',
	'config/labels.lua',
	'config/vehicles.lua',
}