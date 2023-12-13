fx_version 'adamant'
games { 'gta5' }

description "hud"

ui_page "nui/index.html"

files {
	'nui/index.html',
	'nui/style.css',
  'nui/*.woff',
  'nui/*.*',
  'nui/scripts.js',
}

client_scripts{ 
  "@vrp/core_client/Tunnel.lua",
  "@vrp/core_client/Proxy.lua",
  "client.lua"
}

server_scripts{ 
  "@vrp/lib/utils.lua",
  "server.lua"
}