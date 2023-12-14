fx_version {'adamant'}
game {'gta5'}

lua54 'yes'
ui_page 'nui/ui.html'

client_scripts{ 
  '@vrp/client/Proxy.lua',
  '@vrp/client/Tunnel.lua',
  'binoclu-client.lua',
  'bunvenit-client.lua',
  'cautaingunoi-client.lua',
  'caziere-client.lua',
  'ascundeteingunoi-client.lua',
  'textui-client.lua',
  'luxvehcontrol-client.lua',
  'config_ac.lua',
  'stores-client.lua',
  'accident-client.lua',
  'spawn-client.lua',
  'vehicledamage-client.lua',
  'bariere-client.lua',
  'weazel-client.lua',
}
export 'Alert'
export 'Open'
export 'Close'

server_scripts{ 
  '@vrp/lib/utils.lua',
  'stores-server.lua',
  'server_vrp.lua',
}

files {
	'nui/*.*',
  'nui/sounds/textui.mp3',
  'nui/js/textui.js',
  'nui/css/textui.css',
  'nui/images/*.png',
  'nui/fonts/*.ttf'
}
