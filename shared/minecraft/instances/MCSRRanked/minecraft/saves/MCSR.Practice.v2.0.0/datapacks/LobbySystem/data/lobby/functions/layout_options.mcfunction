setblock -147 95 48 minecraft:structure_block

playsound minecraft:block.comparator.click player @a[tag=sound] ~ ~ ~ 0.8

scoreboard players add @p layout 1

execute if score @p layout matches 2 run scoreboard players set @p layout 0

execute if score @p layout matches 0 run execute positioned -155.5 90.00 55.5 run kill @e[type=minecraft:villager,distance=..2]
execute if score @p layout matches 0 run execute positioned -155.5 90.00 55.5 run kill @e[type=minecraft:armor_stand,distance=..2]
execute if score @p layout matches 0 run execute positioned -146 91 45 run kill @e[type=minecraft:armor_stand,distance=..5] 
execute if score @p layout matches 0 run data merge block -151 108 54 {Text1:'{"text":"","clickEvent":{"action":"run_command","value":"function lobby:layout_options"}}',Text2:'{"text":"Layout","bold":true,"underlined":true,"color":"#FFA935"}',Text3:'{"text":"\\u226b STANDARD \\u226a","bold":true,"color":"#34E45E"}'}
execute if score @p layout matches 0 run data merge block -140 106 61 {mode:"LOAD",name:"lobby_standard",posX:-21,posY:-25,posZ:-21}

execute if score @p layout matches 1 run execute positioned -146 91 45 run kill @e[type=minecraft:armor_stand,distance=..3] 
execute if score @p layout matches 1 run execute positioned -155.17 90.00 55.68 run kill @e[type=!player,distance=..2]
execute if score @p layout matches 1 run data merge block -151 108 54 {Text1:'{"text":"","clickEvent":{"action":"run_command","value":"function lobby:layout_options"}}',Text2:'{"text":"Layout","bold":true,"underlined":true,"color":"#FFA935"}',Text3:'{"text":"\\u226b SIMPLE \\u226a","bold":true,"color":"#F0F0F0"}'}
execute if score @p layout matches 1 run data merge block -140 106 61 {mode:"LOAD",name:"lobby_simple",posX:-21,posY:-25,posZ:-21}

setblock -140 106 62 minecraft:redstone_block
setblock -140 106 62 minecraft:air

kill @e[type=item]