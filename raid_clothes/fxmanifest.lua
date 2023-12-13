fx_version 'adamant'
game 'gta5'

dependency 'vrp'

server_scripts {
    '@vrp/lib/utils.lua',
    'server.lua'
}

client_scripts {
    '@vrp/client/Proxy.lua',
    'client/config.lua',
    'client/tatoos.lua',
    'client/skins.lua',
    'client/client.lua'
}

ui_page 'client/html/index.html'

files {
    'client/html/**/*'
}
