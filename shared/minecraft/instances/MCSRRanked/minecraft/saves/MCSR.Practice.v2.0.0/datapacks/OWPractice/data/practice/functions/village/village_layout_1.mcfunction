scoreboard players set @p inVillage 1
kill @e[type=item]
kill @e[type=iron_golem]
execute positioned -140 77 443 run tag @e[type=minecraft:armor_stand, distance=..2] remove isPlaced

data merge block -137 78 443 {mode:"LOAD", name:"village_layout_2", posX:1, posY:-5, posZ:1, rotation:"NONE", mirror:"NONE", integrity:1.0f, seed:0L}
setblock -138 78 443 minecraft:redstone_block

# Medium House at -131 78 476 (RNG for medium houses: plains_medium_house_2, plains_tannery_1, plains_library_2, plains_armorer_house_1)
function practice:village/village_rng
execute if score @p randomTemp matches 1 run data merge block -131 77 476 {mode:"LOAD", name:"village/plains/houses/plains_medium_house_2", posX:3, posY:1, posZ:6, rotation:"CLOCKWISE_180", mirror:"NONE", integrity:1.0f, seed:0L}
execute if score @p randomTemp matches 2 run data merge block -131 77 476 {mode:"LOAD", name:"village/plains/houses/plains_tannery_1", posX:3, posY:1, posZ:6, rotation:"CLOCKWISE_180", mirror:"NONE", integrity:1.0f, seed:0L}
execute if score @p randomTemp matches 3 run execute if entity @e[type=armor_stand,tag=!isPlaced,x=-140,y=77,z=443,distance=..2] run data merge block -95 82 467 {mode:"LOAD", name:"village/plains/houses/plains_weaponsmith_1", posX:-3, posY:1, posZ:-6, rotation:"NONE", mirror:"NONE", integrity:1.0f, seed:0L}
execute if score @p randomTemp matches 3 run execute if entity @e[type=armor_stand,tag=!isPlaced,x=-140,y=77,z=443,distance=..2] run execute positioned -140 77 443 run tag @e[type=minecraft:armor_stand, distance=..2] add isPlaced
execute if score @p randomTemp matches 4 run data merge block -131 77 476 {mode:"LOAD", name:"village/plains/houses/plains_armorer_house_1", posX:3, posY:1, posZ:6, rotation:"CLOCKWISE_180", mirror:"NONE", integrity:1.0f, seed:0L}
execute if score @p randomTemp matches 5 run data merge block -131 77 476 {mode:"LOAD", name:"village/plains/houses/plains_library_2", posX:3, posY:0, posZ:6, rotation:"CLOCKWISE_180", mirror:"NONE", integrity:1.0f, seed:0L}

# Medium House at -95 83 467 (RNG for medium houses: plains_medium_house_2, plains_tannery_1, plains_library_2, plains_armorer_house_1)
function practice:village/village_rng
execute if score @p randomTemp matches 1 run data merge block -95 82 467 {mode:"LOAD", name:"village/plains/houses/plains_medium_house_2", posX:-3, posY:1, posZ:-6, rotation:"NONE", mirror:"NONE", integrity:1.0f, seed:0L}
execute if score @p randomTemp matches 2 run data merge block -95 82 467 {mode:"LOAD", name:"village/plains/houses/plains_tannery_1", posX:-3, posY:1, posZ:-6, rotation:"NONE", mirror:"NONE", integrity:1.0f, seed:0L}
execute if score @p randomTemp matches 3 run execute if entity @e[type=armor_stand,tag=!isPlaced,x=-140,y=77,z=443,distance=..2] run data merge block -95 82 467 {mode:"LOAD", name:"village/plains/houses/plains_weaponsmith_1", posX:-3, posY:1, posZ:-6, rotation:"NONE", mirror:"NONE", integrity:1.0f, seed:0L}
execute if score @p randomTemp matches 3 run execute if entity @e[type=armor_stand,tag=!isPlaced,x=-140,y=77,z=443,distance=..2] run execute positioned -140 77 443 run tag @e[type=minecraft:armor_stand, distance=..2] add isPlaced
execute if score @p randomTemp matches 4 run data merge block -95 82 467 {mode:"LOAD", name:"village/plains/houses/plains_armorer_house_1", posX:-3, posY:1, posZ:-6, rotation:"NONE", mirror:"NONE", integrity:1.0f, seed:0L}
execute if score @p randomTemp matches 5 run data merge block -95 82 467 {mode:"LOAD", name:"village/plains/houses/plains_library_2", posX:-3, posY:0, posZ:-6, rotation:"NONE", mirror:"NONE", integrity:1.0f, seed:0L}

# Medium House at -131 78 464 (RNG for medium houses: plains_medium_house_2, plains_tannery_1, plains_library_2, plains_armorer_house_1)
function practice:village/village_rng
execute if score @p randomTemp matches 1 run data merge block -131 77 464 {mode:"LOAD", name:"village/plains/houses/plains_medium_house_2", posX:3, posY:1, posZ:5, rotation:"CLOCKWISE_180", mirror:"NONE", integrity:1.0f, seed:0L}
execute if score @p randomTemp matches 2 run data merge block -131 77 464 {mode:"LOAD", name:"village/plains/houses/plains_tannery_1", posX:3, posY:1, posZ:5, rotation:"CLOCKWISE_180", mirror:"NONE", integrity:1.0f, seed:0L}
execute if score @p randomTemp matches 3 run execute if entity @e[type=armor_stand,tag=!isPlaced,x=-140,y=77,z=443,distance=..2] run data merge block -131 77 464 {mode:"LOAD", name:"village/plains/houses/plains_weaponsmith_1", posX:3, posY:1, posZ:5, rotation:"CLOCKWISE_180", mirror:"NONE", integrity:1.0f, seed:0L}
execute if score @p randomTemp matches 3 run execute if entity @e[type=armor_stand,tag=!isPlaced,x=-140,y=77,z=443,distance=..2] run execute positioned -140 77 443 run tag @e[type=minecraft:armor_stand, distance=..2] add isPlaced
execute if score @p randomTemp matches 4 run data merge block -131 77 464 {mode:"LOAD", name:"village/plains/houses/plains_armorer_house_1", posX:3, posY:1, posZ:5, rotation:"CLOCKWISE_180", mirror:"NONE", integrity:1.0f, seed:0L}

# Small House at -131 78 487 (RNG for small houses: plains_small_house_1, plains_small_house_3, plains_small_house_4, plains_small_house_7)
function practice:rng
execute if score @p randomTemp matches 1 run data merge block -131 77 487 {mode:"LOAD", name:"village/plains/houses/plains_small_house_1", posX:3, posY:1, posZ:3, rotation:"CLOCKWISE_180", mirror:"NONE", integrity:1.0f, seed:0L}
execute if score @p randomTemp matches 2 run data merge block -131 77 487 {mode:"LOAD", name:"village/plains/houses/plains_small_house_3", posX:3, posY:1, posZ:3, rotation:"CLOCKWISE_180", mirror:"NONE", integrity:1.0f, seed:0L}
execute if score @p randomTemp matches 3 run data merge block -131 77 487 {mode:"LOAD", name:"village/plains/houses/plains_small_house_4", posX:3, posY:1, posZ:3, rotation:"CLOCKWISE_180", mirror:"NONE", integrity:1.0f, seed:0L}
execute if score @p randomTemp matches 4 run data merge block -131 77 487 {mode:"LOAD", name:"village/plains/houses/plains_small_house_7", posX:3, posY:1, posZ:3, rotation:"CLOCKWISE_180", mirror:"NONE", integrity:1.0f, seed:0L}

# Small House at -131 79 449 (RNG for small houses: plains_small_house_1, plains_small_house_3, plains_small_house_4, plains_small_house_7)
function practice:rng
execute if score @p randomTemp matches 1 run data merge block -131 78 449 {mode:"LOAD", name:"village/plains/houses/plains_small_house_1", posX:-3, posY:1, posZ:4, rotation:"COUNTERCLOCKWISE_90", mirror:"NONE", integrity:1.0f, seed:0L}
execute if score @p randomTemp matches 2 run data merge block -131 78 449 {mode:"LOAD", name:"village/plains/houses/plains_small_house_3", posX:-3, posY:1, posZ:4, rotation:"COUNTERCLOCKWISE_90", mirror:"NONE", integrity:1.0f, seed:0L}
execute if score @p randomTemp matches 3 run data merge block -131 78 449 {mode:"LOAD", name:"village/plains/houses/plains_small_house_4", posX:-3, posY:1, posZ:4, rotation:"COUNTERCLOCKWISE_90", mirror:"NONE", integrity:1.0f, seed:0L}
execute if score @p randomTemp matches 4 run data merge block -131 78 449 {mode:"LOAD", name:"village/plains/houses/plains_small_house_7", posX:-3, posY:1, posZ:4, rotation:"COUNTERCLOCKWISE_90", mirror:"NONE", integrity:1.0f, seed:0L}

# Small House at -115 78 462 (RNG for small houses: plains_small_house_1, plains_small_house_3, plains_small_house_4, plains_small_house_7)
function practice:rng
execute if score @p randomTemp matches 1 run data merge block -115 77 462 {mode:"LOAD", name:"village/plains/houses/plains_small_house_1", posX:3, posY:1, posZ:-3, rotation:"CLOCKWISE_90", mirror:"NONE", integrity:1.0f, seed:0L}
execute if score @p randomTemp matches 2 run data merge block -115 77 462 {mode:"LOAD", name:"village/plains/houses/plains_small_house_3", posX:3, posY:1, posZ:-3, rotation:"CLOCKWISE_90", mirror:"NONE", integrity:1.0f, seed:0L}
execute if score @p randomTemp matches 3 run data merge block -115 77 462 {mode:"LOAD", name:"village/plains/houses/plains_small_house_4", posX:3, posY:1, posZ:-3, rotation:"CLOCKWISE_90", mirror:"NONE", integrity:1.0f, seed:0L}
execute if score @p randomTemp matches 4 run data merge block -115 77 462 {mode:"LOAD", name:"village/plains/houses/plains_small_house_7", posX:3, posY:1, posZ:-3, rotation:"CLOCKWISE_90", mirror:"NONE", integrity:1.0f, seed:0L}

# Small House at -99 80 478 (RNG for small houses: plains_small_house_1, plains_small_house_3, plains_small_house_4, plains_small_house_7)
function practice:rng
execute if score @p randomTemp matches 1 run data merge block -99 80 478 {mode:"LOAD", name:"village/plains/houses/plains_small_house_1", posX:-3, posY:1, posZ:-3, rotation:"NONE", mirror:"NONE", integrity:1.0f, seed:0L}
execute if score @p randomTemp matches 2 run data merge block -99 80 478 {mode:"LOAD", name:"village/plains/houses/plains_small_house_3", posX:-3, posY:1, posZ:-3, rotation:"NONE", mirror:"NONE", integrity:1.0f, seed:0L}
execute if score @p randomTemp matches 3 run data merge block -99 80 478 {mode:"LOAD", name:"village/plains/houses/plains_small_house_4", posX:-3, posY:1, posZ:-3, rotation:"NONE", mirror:"NONE", integrity:1.0f, seed:0L}
execute if score @p randomTemp matches 4 run data merge block -99 80 478 {mode:"LOAD", name:"village/plains/houses/plains_small_house_7", posX:-3, posY:1, posZ:-3, rotation:"NONE", mirror:"NONE", integrity:1.0f, seed:0L}

function practice:village/village_rng
execute if score @p randomTemp matches 1 run data merge block -109 78 485 {mode:"LOAD", name:"village/plains/houses/plains_medium_house_2", posX:3, posY:1, posZ:5, rotation:"CLOCKWISE_180", mirror:"NONE", integrity:1.0f, seed:0L}
execute if score @p randomTemp matches 2 run data merge block -109 78 485 {mode:"LOAD", name:"village/plains/houses/plains_tannery_1", posX:3, posY:1, posZ:5, rotation:"CLOCKWISE_180", mirror:"NONE", integrity:1.0f, seed:0L}
execute if score @p randomTemp matches 3 run data merge block -109 78 485 {mode:"LOAD", name:"village/plains/houses/plains_weaponsmith_1", posX:3, posY:1, posZ:5, rotation:"CLOCKWISE_180", mirror:"NONE", integrity:1.0f, seed:0L}
execute if score @p randomTemp matches 3 run data merge block -109 78 485 {mode:"LOAD", name:"village/plains/houses/plains_library_2", posX:3, posY:0, posZ:5, rotation:"CLOCKWISE_180", mirror:"NONE", integrity:1.0f, seed:0L}
execute if score @p randomTemp matches 4 run data merge block -109 78 485 {mode:"LOAD", name:"village/plains/houses/plains_armorer_house_1", posX:3, posY:1, posZ:5, rotation:"CLOCKWISE_180", mirror:"NONE", integrity:1.0f, seed:0L}

execute if entity @e[type=armor_stand,tag=!isPlaced,x=-140,y=77,z=443,distance=..2] run data merge block -109 78 485 {mode:"LOAD", name:"village/plains/houses/plains_weaponsmith_1", posX:3, posY:1, posZ:5, rotation:"CLOCKWISE_180", mirror:"NONE", integrity:1.0f, seed:0L}
execute if entity @e[type=armor_stand,tag=!isPlaced,x=-140,y=77,z=443,distance=..2] run data merge block -112 80 486 {LootTable:"practice:blacksmith"}

function practice:rng
execute if score @p randomTemp matches 1 run data merge block -108 80 475 {mode:"LOAD", name:"haybales_1", posX:-1, posY:1, posZ:-1, rotation:"NONE", mirror:"NONE", integrity:1.0f, seed:0L}
execute if score @p randomTemp matches 2 run data merge block -108 80 475 {mode:"LOAD", name:"haybales_2", posX:-1, posY:1, posZ:-1, rotation:"NONE", mirror:"NONE", integrity:1.0f, seed:0L}
execute if score @p randomTemp matches 3 run data merge block -108 80 475 {mode:"LOAD", name:"haybales_3", posX:-1, posY:1, posZ:-1, rotation:"NONE", mirror:"NONE", integrity:1.0f, seed:0L}
execute if score @p randomTemp matches 4 run data merge block -108 80 475 {mode:"LOAD", name:"haybales_4", posX:-1, posY:1, posZ:-1, rotation:"NONE", mirror:"NONE", integrity:1.0f, seed:0L}

function practice:rng
execute if score @p randomTemp matches 1 run data merge block -98 77 447 {mode:"LOAD", name:"haybales_1", posX:-1, posY:1, posZ:-1, rotation:"NONE", mirror:"NONE", integrity:1.0f, seed:0L}
execute if score @p randomTemp matches 2 run data merge block -98 77 447 {mode:"LOAD", name:"haybales_2", posX:-1, posY:1, posZ:-1, rotation:"NONE", mirror:"NONE", integrity:1.0f, seed:0L}
execute if score @p randomTemp matches 3 run data merge block -98 77 447 {mode:"LOAD", name:"haybales_3", posX:-1, posY:1, posZ:-1, rotation:"NONE", mirror:"NONE", integrity:1.0f, seed:0L}
execute if score @p randomTemp matches 4 run data merge block -98 77 447 {mode:"LOAD", name:"haybales_4", posX:-1, posY:1, posZ:-1, rotation:"NONE", mirror:"NONE", integrity:1.0f, seed:0L}

function practice:rng
execute if score @p randomTemp matches 1 run setblock -91 82 446 minecraft:redstone_block
execute if score @p randomTemp matches 2 run setblock -91 82 489 minecraft:redstone_block
execute if score @p randomTemp matches 3 run setblock -91 82 446 minecraft:redstone_block
execute if score @p randomTemp matches 4 run setblock -91 82 489 minecraft:redstone_block

# Activate the structure blocks with redstone blocks
setblock -131 76 487 redstone_block
setblock -131 76 476 redstone_block
setblock -131 76 464 redstone_block
setblock -131 77 449 redstone_block
setblock -115 76 462 redstone_block
setblock -95 81 467 redstone_block
setblock -99 79 478 redstone_block
setblock -109 77 485 redstone_block
setblock -108 79 475 redstone_block
setblock -98 76 447 redstone_block
setblock -119 76 476 redstone_block
setblock -138 78 443 minecraft:air

summon minecraft:iron_golem -114 80 453

execute positioned -140 77 443 run tag @e[type=minecraft:armor_stand, distance=..2] remove isPlaced

# Schedule cleanup for structure blocks
schedule function practice:village/cleanup 5t

####################################################################################################################################################

tag @p add inVillage
clear @a
gamemode survival @a

replaceitem entity @a container.9 barrier{display:{Name:'["",{"text":"χ Reset χ","italic":false,"bold":true,"color":"#ff0000"}]'}}
replaceitem entity @a container.13 barrier{display:{Name:'["",{"text":"χ Reset χ","italic":false,"bold":true,"color":"#ff0000"}]'}}

function practice:rng
execute if score @p randomTemp matches 1 run tp @a[tag=inVillage] -90 83 455 90 0
execute if score @p randomTemp matches 2 run tp @a[tag=inVillage] -90 83 472 90 0
execute if score @p randomTemp matches 3 run tp @a[tag=inVillage] -125 78 490 180 0
execute if score @p randomTemp matches 4 run tp @a[tag=inVillage] -122 80 445 0 0

playsound minecraft:block.note_block.harp player @a[tag=sound] ~ ~ ~ 100 0.7

scoreboard players set timer timer 0
scoreboard players set timer settings 1

effect give @a minecraft:instant_health 10 10 true
effect give @a minecraft:saturation 1 1

schedule function practice:delay 2t
schedule function practice:village/village_delay 5t

execute at @p run fill ~ ~ ~ ~ ~1 ~ nether_portal replace air
