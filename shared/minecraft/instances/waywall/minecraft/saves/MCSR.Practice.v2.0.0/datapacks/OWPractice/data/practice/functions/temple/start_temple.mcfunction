tag @p add inTemple

execute positioned -90 77 419 run kill @e[type=tnt, distance=..25]

setblock -103 77 405 minecraft:redstone_block
setblock -103 77 405 minecraft:air

data merge block -90 65 417 {LootTable:"practice:temple"}
data merge block -88 65 419 {LootTable:"practice:temple"}
data merge block -90 65 421 {LootTable:"practice:temple"}
data merge block -92 65 419 {LootTable:"practice:temple"}

execute positioned -90 77 419 run kill @e[type=item, distance=..25]


setblock -106 77 405 minecraft:redstone_block

gamemode survival @a[tag=inTemple]
clear @a[tag=inTemple]

replaceitem entity @a container.9 barrier{display:{Name:'["",{"text":"χ Reset χ","italic":false,"bold":true,"color":"#ff0000"}]'}}
replaceitem entity @a container.13 barrier{display:{Name:'["",{"text":"χ Reset χ","italic":false,"bold":true,"color":"#ff0000"}]'}}

tp @a[tag=inTemple] -86 77 419 90 0
playsound minecraft:block.note_block.harp player @a[tag=sound] ~ ~ ~ 100 0.7

effect give @a minecraft:instant_health 10 10 true
effect give @a minecraft:saturation 1 1

scoreboard players set timer timer 0
scoreboard players set timer settings 1

execute at @p run fill ~ ~ ~ ~ ~1 ~ nether_portal replace air
schedule function practice:delay 2t