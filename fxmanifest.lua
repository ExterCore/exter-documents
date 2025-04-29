fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'CLTRALTDELETE'
description 'Advanced and customizable document system for QBCore support.'
version '1.0.0'

-- Shared resources
shared_scripts {
    'shared/cores.lua',
    'shared/locale.lua',
    'locales/en.lua',
    'locales/*.lua',
    'shared/config.lua'
}

-- Client-side logic
client_scripts {
    'client/*.lua'
}

-- Server-side logic
server_scripts {
    'server/*.lua'
}

-- UI setup
ui_page 'html/index.html'

files {
    'html/**'
}
