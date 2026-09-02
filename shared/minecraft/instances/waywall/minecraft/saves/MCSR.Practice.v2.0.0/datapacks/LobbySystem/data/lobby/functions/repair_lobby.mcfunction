execute positioned -155.00 90.72 55.37 run kill @e[type=minecraft:armor_stand,distance=..2]
execute positioned -155.00 90.72 55.37 run kill @e[type=minecraft:villager,distance=..2]
execute positioned -146.00 91.51 45.90 run kill @e[type=minecraft:armor_stand,distance=..2]
execute positioned 166.20 73.00 258.14 as @e[type=cat,distance=..2] run tp @s ~ ~-50 ~
execute positioned -157 91 27 run kill @e[type=minecraft:armor_stand,distance=..2]
execute positioned -118 78 415 run kill @e[type=minecraft:armor_stand,distance=..2]
execute positioned -152 71 393 run kill @e[type=minecraft:armor_stand,distance=..2]
execute positioned -160 71 388 run kill @e[type=minecraft:armor_stand,distance=..2]
execute positioned -149.73 92.00 81.74 run kill @e[tag=display,distance=..3]

execute as @a run function lobby:pet/pet_respawn

setblock -140 106 62 minecraft:redstone_block 
setblock -164 102 58 minecraft:redstone_block
setblock -179 98 42 minecraft:redstone_block
setblock -166 99 41 minecraft:redstone_block
setblock -149 98 33 minecraft:redstone_block
setblock 182 81 277 minecraft:redstone_block
setblock 169 82 262 minecraft:redstone_block
setblock -127 87 429 minecraft:redstone_block
setblock -150 83 396 minecraft:redstone_block
setblock -158 102 65 minecraft:redstone_block

setblock -140 106 62 minecraft:air
setblock -164 102 58 minecraft:air
setblock -179 98 42 minecraft:air
setblock -166 99 41 minecraft:air
setblock -149 98 33 minecraft:air
setblock 182 81 277 minecraft:air
setblock 169 82 262 minecraft:air
setblock -127 87 429 minecraft:air
setblock -150 83 396 minecraft:air
setblock -158 102 65 minecraft:air

playsound minecraft:block.note_block.chime ambient @a[tag=sound] ~ ~ ~ 1 0.8
title @a actionbar ["",{"text":"\u24d8","bold":true,"color":"#77E999"},{"text":" The lobby was repaired!","color":"#2CDD3C"}]