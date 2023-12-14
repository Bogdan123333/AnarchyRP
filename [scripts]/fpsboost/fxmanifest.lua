fx_version 'adamant'
game 'gta5'

author ''
description ''
version '1.0.0'

resource_type 'gametype' { name = '' }

client_scripts {
	"lib/Proxy.lua",
	"lib/Tunnel.lua",
    "client.lua"
} 

server_scripts {
	"@vrp/lib/utils.lua",
	'server.lua'
}
