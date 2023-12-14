fx_version 'adamant'

game 'gta5'

ui_page "html/index.html"

client_scripts {
    '@vrp/client/Tunnel.lua',
    '@vrp/client/Proxy.lua',
    'client/main.lua',
    'client/animation.lua',
    'config.lua',
}

server_scripts {
    '@vrp/lib/utils.lua',
    'config.lua',
    "vrp.lua"
}

files {
    'html/*.html',
    'html/js/*.js',
    'html/img/*.png',
    'html/img/*.gif',
    'html/css/*.css',
    'html/fonts/*.ttf',
    'html/fonts/*.otf',
    'html/fonts/*.woff',
    'html/img/backgrounds/*.png',
    'html/img/apps/*.png',
}
