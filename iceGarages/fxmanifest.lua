fx_version 'adamant'

game 'gta5'

server_scripts {
    "@vrp/lib/utils.lua",
    'server.lua',
    "config.lua"
}

client_scripts {
    "config.lua",
    "@vrp/client/Tunnel.lua",
    "@vrp/client/Proxy.lua",
    "@vrp/lib/utils.lua",
    'client.lua',
}



escrow_ignore {
    "config.lua"
}

ui_page "ui/index.html"
files {
    'ui/*',
    'ui/images/*'
}
