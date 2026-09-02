tellraw @s ["",{"text":"\u24d8 ","bold":true,"color":"#77E999"},{"text":"\u2022 ","bold":true,"color":"dark_gray"},{"text":"Loading...","bold":true,"color":"#77E999"}]

function lobby:disable_packs
datapack enable "file/FortPractice"
clear @p
execute in minecraft:the_nether run spawnpoint @p 0 67 -28 

gamerule commandBlockOutput false
execute in minecraft:the_nether run tp @p 0 67 -28 0 0
function lobby:refresh_tags

scoreboard players set timer timer 0
scoreboard players set timer settings 0
title @a actionbar ""

title @a times 10 25 10
tellraw @a ["",{"text":"\u24d8 ","bold":true,"color":"#77E999"},{"text":"\u2022 ","bold":true,"color":"dark_gray"},{"text":"Use","color":"#F1EC82"},{"text":" /trigger hub","bold":true,"color":"#77E999"},{"text":" or","color":"#F1EC82"},{"text":" the sign\n \u0020 \u0020","bold":true,"color":"#77E999"},{"text":" to return to","color":"#F1EC82"},{"text":" the hub!","bold":true,"color":"#77E999"}]
title @a subtitle ["",{"text":"\u2505","bold":true,"color":"dark_gray"},{"text":" Fortress Practice","bold":true,"color":"#FD501A"},{"text":" \u2505","bold":true,"color":"dark_gray"}]
title @a title {"text":""}

