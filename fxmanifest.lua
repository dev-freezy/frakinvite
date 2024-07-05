

fx_version 'cerulean'
game 'gta5'

author 'Freezy'
description 'Apfelsosenmus'
version '4.2.0'

client_scripts {
    'client.lua'
}

shared_scripts {
 '@es_extended/imports.lua',
} 

server_scripts {
    'server.lua',
    'config.lua',
}

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/style.css',
    'html/script.js',
    'html/config.js',
    'html/logo.png'
}
