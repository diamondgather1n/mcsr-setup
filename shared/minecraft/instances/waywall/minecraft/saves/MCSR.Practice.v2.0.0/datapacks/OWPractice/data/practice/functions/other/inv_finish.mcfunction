replaceitem block -152 72 394 container.9 red_stained_glass_pane 1
replaceitem block -152 72 394 container.10 red_stained_glass_pane 1
replaceitem block -152 72 394 container.11 red_stained_glass_pane 1
replaceitem block -152 72 394 container.12 red_stained_glass_pane 1
replaceitem block -152 72 394 container.13 red_stained_glass_pane 1
replaceitem block -152 72 394 container.14 red_stained_glass_pane 1
replaceitem block -152 72 394 container.15 red_stained_glass_pane 1
replaceitem block -152 72 394 container.16 red_stained_glass_pane 1
replaceitem block -152 72 394 container.17 red_stained_glass_pane 1
replaceitem block -152 72 394 container.18 red_stained_glass_pane 1
replaceitem block -152 72 394 container.19 red_stained_glass_pane 1
replaceitem block -152 72 394 container.20 red_stained_glass_pane 1
replaceitem block -152 72 394 container.21 red_stained_glass_pane 1
replaceitem block -152 72 394 container.22 red_stained_glass_pane 1
replaceitem block -152 72 394 container.23 red_stained_glass_pane 1
replaceitem block -152 72 394 container.24 red_stained_glass_pane 1
replaceitem block -152 72 394 container.25 red_stained_glass_pane 1
replaceitem block -152 72 394 container.26 red_stained_glass_pane 1

gamemode adventure @p

scoreboard players set timer timer 0
scoreboard players set timer settings 0
title @a actionbar ""

tellraw @a [{"text":"  Time: ","color":"gray"},{"nbt":"time_string","storage":"lobby:timeparser","interpret":true,"color":"gold"}]

execute at @p run fill ~ ~ ~ ~ ~1 ~ nether_portal replace red_stained_glass_pane
schedule function practice:delay 2t