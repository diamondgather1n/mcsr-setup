execute if score @p boatCrouchType matches 1 run data merge block -149 96 19 {mode:"LOAD", name:"crouch_1", posX:-9, posY:-8, posZ:-12}
execute if score @p boatCrouchType matches 2 run data merge block -149 96 19 {mode:"LOAD", name:"crouch_2", posX:-9, posY:-8, posZ:-12}

setblock -149 97 19 minecraft:redstone_block
setblock -149 97 19 minecraft:air

setblock -154 97 8 redstone_block

clear @p
gamemode survival @p
give @p oak_boat

function practice:movement/boat_c_clear

loot replace entity @p hotbar.0 9 mine -158 92 27 minecraft:air{drop_contents:1b}

function practice:movement/boat_c_reset

tp @p -154 90 17 180 0

playsound minecraft:block.note_block.harp player @a[tag=sound] ~ ~ ~ 100 0.7


effect give @a minecraft:instant_health 10 10 true
effect give @a minecraft:saturation 1 1
