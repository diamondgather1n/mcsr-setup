
tellraw @s ["",{"text":"\u24d8 ","bold":true,"color":"#77E999"},{"text":"\u2507","bold":true,"color":"dark_gray"},{"text":" Loading...","bold":true,"color":"#77E999"}]

function lobby:disable_packs
datapack enable "file/OWPractice"
tp @p -117 77 419 -90 0
clear @p

title @a times 10 25 10
tellraw @p ["",{"text":"\u24d8","bold":true,"color":"#77E999"},{"text":" Type \"","color":"#F1EC82"},{"text":"/trigger hub","bold":true,"color":"#77E999"},{"text":"\" or ","color":"#F1EC82"},{"text":"use the signs","bold":true,"color":"#77E999"},{"text":"\n"},{"text":" \u0020 \u0020to return to the hub!","color":"#F1EC82"}]
title @a subtitle ["",{"text":"\u2505","bold":true,"color":"dark_gray"},{"text":" OW Practice","bold":true,"color":"#73F528"},{"text":" \u2505","bold":true,"color":"dark_gray"}]
title @a title {"text":""}

