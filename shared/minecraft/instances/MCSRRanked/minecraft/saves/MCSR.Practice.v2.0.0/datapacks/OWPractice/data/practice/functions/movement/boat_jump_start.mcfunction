# Reset random for boatJumpType 5 (Random)
execute if score @p boatJumpType matches 5 run function practice:rng

# Boat type-specific commands
execute if score @p boatJumpType matches 1 run data merge block -130 89 24 {mode:"LOAD", name:"boat_5", posX:-8, posY:-5, posZ:2}
execute if score @p boatJumpType matches 2 run data merge block -130 89 24 {mode:"LOAD", name:"boat_6", posX:-8, posY:-5, posZ:2}
execute if score @p boatJumpType matches 3 run data merge block -130 89 24 {mode:"LOAD", name:"boat_7", posX:-8, posY:-5, posZ:2}
execute if score @p boatJumpType matches 4 run data merge block -130 89 24 {mode:"LOAD", name:"boat_8", posX:-8, posY:-5, posZ:2}

# Corrected random selection for randomTemp
execute if score @p boatJumpType matches 5 if score @p randomTemp matches 1 run data merge block -130 89 24 {mode:"LOAD", name:"boat_5", posX:-8, posY:-5, posZ:2}
execute if score @p boatJumpType matches 5 if score @p randomTemp matches 2 run data merge block -130 89 24 {mode:"LOAD", name:"boat_6", posX:-8, posY:-5, posZ:2}
execute if score @p boatJumpType matches 5 if score @p randomTemp matches 3 run data merge block -130 89 24 {mode:"LOAD", name:"boat_7", posX:-8, posY:-5, posZ:2}
execute if score @p boatJumpType matches 5 if score @p randomTemp matches 4 run data merge block -130 89 24 {mode:"LOAD", name:"boat_8", posX:-8, posY:-5, posZ:2}

# Rest of your code
setblock -130 89 23 minecraft:redstone_block
setblock -130 89 23 minecraft:air
setblock -130 89 23 minecraft:redstone_block


kill @e[type=boat]
clear @p
gamemode survival @p
give @p oak_boat

tp @p -144 89 29 -90 0

playsound minecraft:block.note_block.harp player @a[tag=sound] ~ ~ ~ 100 0.7

effect give @a minecraft:instant_health 10 10 true
effect give @a minecraft:saturation 1 1
