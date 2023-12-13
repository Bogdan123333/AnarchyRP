fx_version "adamant"

game "gta5"

client_scripts{
	"@vrp/client/Proxy.lua",
	"@vrp/client/Tunnel.lua",	
	"c_coordonate.lua",
	"c_npc.lua",
}

server_scripts{
	"@vrp/lib/utils.lua",
	"s_npc.lua",
}


ui_page 'web/ui.html'

files {
	'web/*.*'
}