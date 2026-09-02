# Add tag and start the owtimer
tag @p add inShip

# Prepare ship section
fill -131 46 379 -103 69 370 water

# Clear everything
setblock -134 74 369 minecraft:redstone_block
setblock -134 74 369 minecraft:air

# Main script
function practice:rng

# Random structure block selection
execute if score @p randomTemp matches 1 run data merge block -134 73 369 {mode:"LOAD", name:"minecraft:ship_env_1", posX:1, posY:-28, posZ:0, rotation:"NONE", mirror:"NONE", integrity:1.0f, seed:0L}
execute if score @p randomTemp matches 2 run data merge block -134 73 369 {mode:"LOAD", name:"minecraft:ship_env_2", posX:1, posY:-28, posZ:0, rotation:"NONE", mirror:"NONE", integrity:1.0f, seed:0L}
execute if score @p randomTemp matches 3 run data merge block -134 73 369 {mode:"LOAD", name:"minecraft:ship_env_3", posX:1, posY:-28, posZ:0, rotation:"NONE", mirror:"NONE", integrity:1.0f, seed:0L}
execute if score @p randomTemp matches 4 run data merge block -134 73 369 {mode:"LOAD", name:"minecraft:ship_env_4", posX:1, posY:-28, posZ:0, rotation:"NONE", mirror:"NONE", integrity:1.0f, seed:0L}

execute as @a[tag=inShip] if score @s shipType matches 1 run data merge block -134 71 369 {mode:"LOAD", name:"shipwreck/with_mast", posX:3, posY:-24, posZ:10, rotation:"COUNTERCLOCKWISE_90", mirror:"NONE", integrity:1.0f, seed:0L}
execute as @a[tag=inShip] if score @s shipType matches 2 run data merge block -134 71 369 {mode:"LOAD", name:"shipwreck/upsidedown_full", posX:3, posY:-24, posZ:10, rotation:"COUNTERCLOCKWISE_90", mirror:"NONE", integrity:1.0f, seed:0L}
execute as @a[tag=inShip] if score @s shipType matches 3 run data merge block -134 71 369 {mode:"LOAD", name:"shipwreck/sideways_full", posX:3, posY:-24, posZ:10, rotation:"COUNTERCLOCKWISE_90", mirror:"NONE", integrity:1.0f, seed:0L}

function practice:ship/ship_rng
execute if score @p shipType matches 4 if score @p randomTemp matches 1 run data merge block -134 71 369 {mode:"LOAD", name:"shipwreck/with_mast", posX:3, posY:-24, posZ:10, rotation:"COUNTERCLOCKWISE_90", mirror:"NONE", integrity:1.0f, seed:0L}
execute if score @p shipType matches 4 if score @p randomTemp matches 2 run data merge block -134 71 369 {mode:"LOAD", name:"shipwreck/upsidedown_full", posX:3, posY:-24, posZ:10, rotation:"COUNTERCLOCKWISE_90", mirror:"NONE", integrity:1.0f, seed:0L}
execute if score @p shipType matches 4 if score @p randomTemp matches 3 run data merge block -134 71 369 {mode:"LOAD", name:"shipwreck/sideways_full", posX:3, posY:-24, posZ:10, rotation:"COUNTERCLOCKWISE_90", mirror:"NONE", integrity:1.0f, seed:0L}

# Structure block activation
setblock -134 70 369 minecraft:redstone_block
setblock -134 70 369 minecraft:air

execute if score @p shipType matches 4 if score @p randomTemp matches 1 run data merge block -107 51 373 {LootTable:"practice:ship"}
execute if score @p shipType matches 4 if score @p randomTemp matches 1 run data merge block -122 49 375 {LootTable:"practice:ship_food"}
execute if score @p shipType matches 4 if score @p randomTemp matches 2 run data merge block -107 49 377 {LootTable:"practice:ship"}
execute if score @p shipType matches 4 if score @p randomTemp matches 2 run data merge block -123 52 375 {LootTable:"practice:ship_food"}
execute if score @p shipType matches 4 if score @p randomTemp matches 3 run data merge block -107 49 376 {LootTable:"practice:ship"}
execute if score @p shipType matches 4 if score @p randomTemp matches 3 run data merge block -123 50 374 {LootTable:"practice:ship_food"}

# Set loot in ship
execute as @a[tag=inShip] if score @s shipType matches 1 run data merge block -107 51 373 {LootTable:"practice:ship"}
execute as @a[tag=inShip] if score @s shipType matches 1 run data merge block -122 49 375 {LootTable:"practice:ship_food"}
execute as @a[tag=inShip] if score @s shipType matches 2 run data merge block -107 49 377 {LootTable:"practice:ship"}
execute as @a[tag=inShip] if score @s shipType matches 2 run data merge block -123 52 375 {LootTable:"practice:ship_food"}
execute as @a[tag=inShip] if score @s shipType matches 3 run data merge block -107 49 376 {LootTable:"practice:ship"}
execute as @a[tag=inShip] if score @s shipType matches 3 run data merge block -123 50 374 {LootTable:"practice:ship_food"}

# Delete structure blocks
fill -132 46 380 -104 63 371 water replace structure_block

# Kill items in the specified area
execute positioned -119 65 381 run kill @e[type=item, distance=..25]
execute positioned -119 65 381 run kill @e[type=boat, distance=..25]

########################################################################################################

# Final setup and teleport
setblock -134 70 367 minecraft:redstone_block

gamemode survival @a[tag=inShip]
clear @a[tag=inShip]

replaceitem entity @a container.9 barrier{display:{Name:'["",{"text":"χ Reset χ","italic":false,"bold":true,"color":"#ff0000"}]'}}
replaceitem entity @a container.13 barrier{display:{Name:'["",{"text":"χ Reset χ","italic":false,"bold":true,"color":"#ff0000"}]'}}

tp @a[tag=inShip] -117 70 392 180 0
playsound minecraft:block.note_block.harp player @a[tag=sound] ~ ~ ~ 100 0.7

effect give @a minecraft:instant_health 10 10 true
effect give @a minecraft:saturation 1 1

scoreboard players set timer timer 0
scoreboard players set timer settings 1

execute at @p run fill ~ ~ ~ ~ ~1 ~ nether_portal replace air
schedule function practice:delay 2t
