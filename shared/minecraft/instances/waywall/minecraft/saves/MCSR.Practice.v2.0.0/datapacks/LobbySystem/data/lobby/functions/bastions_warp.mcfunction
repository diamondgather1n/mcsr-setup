tellraw @s ["",{"text":"\u24d8 ","bold":true,"color":"#77E999"},{"text":"\u2022 ","bold":true,"color":"dark_gray"},{"text":"Loading...","bold":true,"color":"#77E999"}]
title @a actionbar ["",{"text":"\u24d8","bold":true,"color":"#FF804C"},{"text":" This might take a while...","color":"#FF804C"}]

function lobby:disable_packs
datapack enable "file/LBP3"
clear @p
execute in minecraft:the_nether run tp @p 105 114 5 0 0
execute in minecraft:the_nether run spawnpoint @p 105 114 5

scoreboard players set timer timer 0
scoreboard players set timer settings 0
title @a actionbar ""

title @a times 10 25 10
tellraw @a ["",{"text":"\u24d8 ","bold":true,"color":"#77E999"},{"text":"\u2022 ","bold":true,"color":"dark_gray"},{"text":"Use","color":"#F1EC82"},{"text":" /trigger hub","bold":true,"color":"#77E999"},{"text":" or","color":"#F1EC82"},{"text":" the sign\n \u0020 \u0020","bold":true,"color":"#77E999"},{"text":" to return to","color":"#F1EC82"},{"text":" the hub!","bold":true,"color":"#77E999"}]
title @a subtitle ["",{"text":"\u2505","bold":true,"color":"dark_gray"},{"text":" Bastion Practice","bold":true,"color":"#FD501A"},{"text":" \u2505","bold":true,"color":"dark_gray"}]
title @a title {"text":""}

