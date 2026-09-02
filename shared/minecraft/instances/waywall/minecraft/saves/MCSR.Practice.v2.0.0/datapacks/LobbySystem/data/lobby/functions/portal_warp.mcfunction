tellraw @s ["",{"text":"\u24d8 ","bold":true,"color":"#77E999"},{"text":"\u2022 ","bold":true,"color":"dark_gray"},{"text":"Loading...","bold":true,"color":"#77E999"}]

function lobby:disable_packs
datapack enable "file/PortalPractice"
function lobby:refresh_tags

effect give @p minecraft:saturation 100000 255 true
tp @p 0 33 0 0 0
clear @p

scoreboard players set timer timer 0
scoreboard players set timer settings 0
title @a actionbar ""

schedule function chest:load 2t

title @a times 10 25 10
tellraw @a ["",{"text":"\u24d8 ","bold":true,"color":"#77E999"},{"text":"\u2022 ","bold":true,"color":"dark_gray"},{"text":"Use","color":"#F1EC82"},{"text":" /trigger hub","bold":true,"color":"#77E999"},{"text":" or","color":"#F1EC82"},{"text":" the sign\n \u0020 \u0020","bold":true,"color":"#77E999"},{"text":" to return to","color":"#F1EC82"},{"text":" the hub!","bold":true,"color":"#77E999"}]
title @a subtitle ["",{"text":"\u2505","bold":true,"color":"dark_gray"},{"text":" Portal Practice","bold":true,"color":"dark_purple"},{"text":" \u2505","bold":true,"color":"dark_gray"}]
title @a title {"text":""}

