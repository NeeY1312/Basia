resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'Scrypt na basie/esx'

server_scripts {
	'@es_extended/locale.lua',
	'locales/pl.lua',
	'Config.lua',
	'server/main.lua'
}

client_scripts {
	'@es_extended/locale.lua',
	'locales/pl.lua',
	'Config.lua',
	'client/main.lua'
}
