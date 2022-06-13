fx_version "bodacious"
game "gta5"

author "Raavy"
discord "https://discord.gg/"

client_scripts{
    "@vrp/lib/utils.lua",
    "config/config.lua",
    "client.lua"
}

server_scripts{
    "@vrp/lib/utils.lua",
    --"config/config.lua",
    "server.lua"
}

files {
    "web/index.html",
    "web/estilo.css",
    "web/back.js"
}

ui_page "web/index.html"