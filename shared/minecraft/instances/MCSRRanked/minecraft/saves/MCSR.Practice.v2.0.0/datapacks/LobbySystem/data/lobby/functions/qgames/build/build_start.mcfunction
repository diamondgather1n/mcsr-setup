execute if score @p buildRunning matches 0 run scoreboard players set timer timer 0
execute if score @p buildRunning matches 0 run scoreboard players set timer settings 1
execute if score @p buildRunning matches 0 run scoreboard players set minutes timer 0 
execute if score @p buildRunning matches 0 run scoreboard players set @p buildRunning 1

clear @p

fill 151 75 291 159 75 283 air
fill 136 75 291 144 75 283 air

setblock 146 76 294 minecraft:structure_block

execute if score r randomTemp matches 1 run data merge block 146 76 294 {mode:"LOAD",name:"build_1",posX:0,posY:1,posZ:-11,ignoreEntities:1b}
execute if score r randomTemp matches 1 run data merge block 145 76 295 {mode:"LOAD",name:"build_1f",posX:-9,posY:-1,posZ:-12,ignoreEntities:1b}
execute if score r randomTemp matches 1 run function lobby:qgames/build/inv/inv_1

execute if score r randomTemp matches 2 run data merge block 146 76 294 {mode:"LOAD",name:"build_2",posX:0,posY:1,posZ:-11,ignoreEntities:1b}
execute if score r randomTemp matches 2 run data merge block 145 76 295 {mode:"LOAD",name:"build_2f",posX:-9,posY:-1,posZ:-12,ignoreEntities:1b}
execute if score r randomTemp matches 2 run function lobby:qgames/build/inv/inv_2

execute if score r randomTemp matches 3 run data merge block 146 76 294 {mode:"LOAD",name:"build_3",posX:0,posY:1,posZ:-11,ignoreEntities:1b}
execute if score r randomTemp matches 3 run data merge block 145 76 295 {mode:"LOAD",name:"build_3f",posX:-9,posY:-1,posZ:-12,ignoreEntities:1b}
execute if score r randomTemp matches 3 run function lobby:qgames/build/inv/inv_3

execute if score r randomTemp matches 4 run data merge block 146 76 294 {mode:"LOAD",name:"build_4",posX:0,posY:1,posZ:-11,ignoreEntities:1b}
execute if score r randomTemp matches 4 run data merge block 145 76 295 {mode:"LOAD",name:"build_4f",posX:-9,posY:-1,posZ:-12,ignoreEntities:1b}
execute if score r randomTemp matches 4 run function lobby:qgames/build/inv/inv_4

execute if score r randomTemp matches 5 run data merge block 146 76 294 {mode:"LOAD",name:"build_5",posX:0,posY:1,posZ:-11,ignoreEntities:1b}
execute if score r randomTemp matches 5 run data merge block 145 76 295 {mode:"LOAD",name:"build_5f",posX:-9,posY:-1,posZ:-12,ignoreEntities:1b}
execute if score r randomTemp matches 5 run function lobby:qgames/build/inv/inv_5

execute if score r randomTemp matches 6 run data merge block 146 76 294 {mode:"LOAD",name:"build_6",posX:0,posY:1,posZ:-11,ignoreEntities:1b}
execute if score r randomTemp matches 6 run data merge block 145 76 295 {mode:"LOAD",name:"build_6f",posX:-9,posY:-1,posZ:-12,ignoreEntities:1b}
execute if score r randomTemp matches 6 run function lobby:qgames/build/inv/inv_6

execute if score r randomTemp matches 7 run data merge block 146 76 294 {mode:"LOAD",name:"build_7",posX:0,posY:1,posZ:-11,ignoreEntities:1b}
execute if score r randomTemp matches 7 run data merge block 145 76 295 {mode:"LOAD",name:"build_7f",posX:-9,posY:-1,posZ:-12,ignoreEntities:1b}
execute if score r randomTemp matches 7 run function lobby:qgames/build/inv/inv_7

execute if score r randomTemp matches 8 run data merge block 146 76 294 {mode:"LOAD",name:"build_8",posX:0,posY:1,posZ:-11,ignoreEntities:1b}
execute if score r randomTemp matches 8 run data merge block 145 76 295 {mode:"LOAD",name:"build_8f",posX:-9,posY:-1,posZ:-12,ignoreEntities:1b}
execute if score r randomTemp matches 8 run function lobby:qgames/build/inv/inv_8

execute if score r randomTemp matches 9 run data merge block 146 76 294 {mode:"LOAD",name:"build_9",posX:0,posY:1,posZ:-11,ignoreEntities:1b}
execute if score r randomTemp matches 9 run data merge block 145 76 295 {mode:"LOAD",name:"build_9f",posX:-9,posY:-1,posZ:-12,ignoreEntities:1b}
execute if score r randomTemp matches 9 run function lobby:qgames/build/inv/inv_9

execute if score r randomTemp matches 10 run data merge block 146 76 294 {mode:"LOAD",name:"build_10",posX:0,posY:1,posZ:-11,ignoreEntities:1b}
execute if score r randomTemp matches 10 run data merge block 145 76 295 {mode:"LOAD",name:"build_10f",posX:-9,posY:-1,posZ:-12,ignoreEntities:1b}
execute if score r randomTemp matches 10 run function lobby:qgames/build/inv/inv_10

execute if score r randomTemp matches 11 run data merge block 146 76 294 {mode:"LOAD",name:"build_11",posX:0,posY:1,posZ:-11,ignoreEntities:1b}
execute if score r randomTemp matches 11 run data merge block 145 76 295 {mode:"LOAD",name:"build_11f",posX:-9,posY:-1,posZ:-12,ignoreEntities:1b}
execute if score r randomTemp matches 11 run function lobby:qgames/build/inv/inv_11

execute if score r randomTemp matches 12 run data merge block 146 76 294 {mode:"LOAD",name:"build_12",posX:0,posY:1,posZ:-11,ignoreEntities:1b}
execute if score r randomTemp matches 12 run data merge block 145 76 295 {mode:"LOAD",name:"build_12f",posX:-9,posY:-1,posZ:-12,ignoreEntities:1b}
execute if score r randomTemp matches 12 run function lobby:qgames/build/inv/inv_12

execute if score r randomTemp matches 13 run data merge block 146 76 294 {mode:"LOAD",name:"build_13",posX:0,posY:1,posZ:-11,ignoreEntities:1b}
execute if score r randomTemp matches 13 run data merge block 145 76 295 {mode:"LOAD",name:"build_13f",posX:-9,posY:-1,posZ:-12,ignoreEntities:1b}
execute if score r randomTemp matches 13 run function lobby:qgames/build/inv/inv_13

execute if score r randomTemp matches 14 run data merge block 146 76 294 {mode:"LOAD",name:"build_14",posX:0,posY:1,posZ:-11,ignoreEntities:1b}
execute if score r randomTemp matches 14 run data merge block 145 76 295 {mode:"LOAD",name:"build_14f",posX:-9,posY:-1,posZ:-12,ignoreEntities:1b}
execute if score r randomTemp matches 14 run function lobby:qgames/build/inv/inv_14

execute if score r randomTemp matches 15 run data merge block 146 76 294 {mode:"LOAD",name:"build_15",posX:0,posY:1,posZ:-11,ignoreEntities:1b}
execute if score r randomTemp matches 15 run data merge block 145 76 295 {mode:"LOAD",name:"build_15f",posX:-9,posY:-1,posZ:-12,ignoreEntities:1b}
execute if score r randomTemp matches 15 run function lobby:qgames/build/inv/inv_15

execute if score r randomTemp matches 16 run data merge block 146 76 294 {mode:"LOAD",name:"build_16",posX:0,posY:1,posZ:-11,ignoreEntities:1b}
execute if score r randomTemp matches 16 run data merge block 145 76 295 {mode:"LOAD",name:"build_16f",posX:-9,posY:-1,posZ:-12,ignoreEntities:1b}
execute if score r randomTemp matches 16 run function lobby:qgames/build/inv/inv_16

execute if score r randomTemp matches 17 run data merge block 146 76 294 {mode:"LOAD",name:"build_17",posX:0,posY:1,posZ:-11,ignoreEntities:1b}
execute if score r randomTemp matches 17 run data merge block 145 76 295 {mode:"LOAD",name:"build_17f",posX:-9,posY:-1,posZ:-12,ignoreEntities:1b}
execute if score r randomTemp matches 17 run function lobby:qgames/build/inv/inv_17

execute if score r randomTemp matches 18 run data merge block 146 76 294 {mode:"LOAD",name:"build_18",posX:0,posY:1,posZ:-11,ignoreEntities:1b}
execute if score r randomTemp matches 18 run data merge block 145 76 295 {mode:"LOAD",name:"build_18f",posX:-9,posY:-1,posZ:-12,ignoreEntities:1b}
execute if score r randomTemp matches 18 run function lobby:qgames/build/inv/inv_18

execute if score r randomTemp matches 19 run data merge block 146 76 294 {mode:"LOAD",name:"build_19",posX:0,posY:1,posZ:-11,ignoreEntities:1b}
execute if score r randomTemp matches 19 run data merge block 145 76 295 {mode:"LOAD",name:"build_19f",posX:-9,posY:-1,posZ:-12,ignoreEntities:1b}
execute if score r randomTemp matches 19 run function lobby:qgames/build/inv/inv_19

execute if score r randomTemp matches 20 run data merge block 146 76 294 {mode:"LOAD",name:"build_20",posX:0,posY:1,posZ:-11,ignoreEntities:1b}
execute if score r randomTemp matches 20 run data merge block 145 76 295 {mode:"LOAD",name:"build_20f",posX:-9,posY:-1,posZ:-12,ignoreEntities:1b}
execute if score r randomTemp matches 20 run function lobby:qgames/build/inv/inv_20

execute if score r randomTemp matches 21 run data merge block 146 76 294 {mode:"LOAD",name:"build_21",posX:0,posY:1,posZ:-11,ignoreEntities:1b}
execute if score r randomTemp matches 21 run data merge block 145 76 295 {mode:"LOAD",name:"build_21f",posX:-9,posY:-1,posZ:-12,ignoreEntities:1b}
execute if score r randomTemp matches 21 run function lobby:qgames/build/inv/inv_21

execute if score r randomTemp matches 22 run data merge block 146 76 294 {mode:"LOAD",name:"build_22",posX:0,posY:1,posZ:-11,ignoreEntities:1b}
execute if score r randomTemp matches 22 run data merge block 145 76 295 {mode:"LOAD",name:"build_22f",posX:-9,posY:-1,posZ:-12,ignoreEntities:1b}
execute if score r randomTemp matches 22 run function lobby:qgames/build/inv/inv_22

execute if score r randomTemp matches 23 run data merge block 146 76 294 {mode:"LOAD",name:"build_23",posX:0,posY:1,posZ:-11,ignoreEntities:1b}
execute if score r randomTemp matches 23 run data merge block 145 76 295 {mode:"LOAD",name:"build_23f",posX:-9,posY:-1,posZ:-12,ignoreEntities:1b}
execute if score r randomTemp matches 23 run function lobby:qgames/build/inv/inv_23

execute if score r randomTemp matches 24 run data merge block 146 76 294 {mode:"LOAD",name:"build_24",posX:0,posY:1,posZ:-11,ignoreEntities:1b}
execute if score r randomTemp matches 24 run data merge block 145 76 295 {mode:"LOAD",name:"build_24f",posX:-9,posY:-1,posZ:-12,ignoreEntities:1b}
execute if score r randomTemp matches 24 run function lobby:qgames/build/inv/inv_24

execute if score r randomTemp matches 25 run data merge block 146 76 294 {mode:"LOAD",name:"build_25",posX:0,posY:1,posZ:-11,ignoreEntities:1b}
execute if score r randomTemp matches 25 run data merge block 145 76 295 {mode:"LOAD",name:"build_25f",posX:-9,posY:-1,posZ:-12,ignoreEntities:1b}
execute if score r randomTemp matches 25 run function lobby:qgames/build/inv/inv_25

execute if score r randomTemp matches 26 run data merge block 146 76 294 {mode:"LOAD",name:"build_26",posX:0,posY:1,posZ:-11,ignoreEntities:1b}
execute if score r randomTemp matches 26 run data merge block 145 76 295 {mode:"LOAD",name:"build_26f",posX:-9,posY:-1,posZ:-12,ignoreEntities:1b}
execute if score r randomTemp matches 26 run function lobby:qgames/build/inv/inv_26

execute if score r randomTemp matches 27 run data merge block 146 76 294 {mode:"LOAD",name:"build_27",posX:0,posY:1,posZ:-11,ignoreEntities:1b}
execute if score r randomTemp matches 27 run data merge block 145 76 295 {mode:"LOAD",name:"build_27f",posX:-9,posY:-1,posZ:-12,ignoreEntities:1b}
execute if score r randomTemp matches 27 run function lobby:qgames/build/inv/inv_27

execute if score r randomTemp matches 28 run data merge block 146 76 294 {mode:"LOAD",name:"build_28",posX:0,posY:1,posZ:-11,ignoreEntities:1b}
execute if score r randomTemp matches 28 run data merge block 145 76 295 {mode:"LOAD",name:"build_28f",posX:-9,posY:-1,posZ:-12,ignoreEntities:1b}
execute if score r randomTemp matches 28 run function lobby:qgames/build/inv/inv_28

execute if score r randomTemp matches 29 run data merge block 146 76 294 {mode:"LOAD",name:"build_29",posX:0,posY:1,posZ:-11,ignoreEntities:1b}
execute if score r randomTemp matches 29 run data merge block 145 76 295 {mode:"LOAD",name:"build_29f",posX:-9,posY:-1,posZ:-12,ignoreEntities:1b}
execute if score r randomTemp matches 29 run function lobby:qgames/build/inv/inv_29

execute if score r randomTemp matches 30 run data merge block 146 76 294 {mode:"LOAD",name:"build_30",posX:0,posY:1,posZ:-11,ignoreEntities:1b}
execute if score r randomTemp matches 30 run data merge block 145 76 295 {mode:"LOAD",name:"build_30f",posX:-9,posY:-1,posZ:-12,ignoreEntities:1b}
execute if score r randomTemp matches 30 run function lobby:qgames/build/inv/inv_30

execute if score r randomTemp matches 31 run data merge block 146 76 294 {mode:"LOAD",name:"build_31",posX:0,posY:1,posZ:-11,ignoreEntities:1b}
execute if score r randomTemp matches 31 run data merge block 145 76 295 {mode:"LOAD",name:"build_31f",posX:-9,posY:-1,posZ:-12,ignoreEntities:1b}
execute if score r randomTemp matches 31 run function lobby:qgames/build/inv/inv_31

execute if score r randomTemp matches 32 run data merge block 146 76 294 {mode:"LOAD",name:"build_32",posX:0,posY:1,posZ:-11,ignoreEntities:1b}
execute if score r randomTemp matches 32 run data merge block 145 76 295 {mode:"LOAD",name:"build_32f",posX:-9,posY:-1,posZ:-12,ignoreEntities:1b}
execute if score r randomTemp matches 32 run function lobby:qgames/build/inv/inv_32

execute if score r randomTemp matches 33 run data merge block 146 76 294 {mode:"LOAD",name:"build_33",posX:0,posY:1,posZ:-11,ignoreEntities:1b}
execute if score r randomTemp matches 33 run data merge block 145 76 295 {mode:"LOAD",name:"build_33f",posX:-9,posY:-1,posZ:-12,ignoreEntities:1b}
execute if score r randomTemp matches 33 run function lobby:qgames/build/inv/inv_33

execute if score r randomTemp matches 34 run data merge block 146 76 294 {mode:"LOAD",name:"build_34",posX:0,posY:1,posZ:-11,ignoreEntities:1b}
execute if score r randomTemp matches 34 run data merge block 145 76 295 {mode:"LOAD",name:"build_34f",posX:-9,posY:-1,posZ:-12,ignoreEntities:1b}
execute if score r randomTemp matches 34 run function lobby:qgames/build/inv/inv_34

execute if score r randomTemp matches 35 run data merge block 146 76 294 {mode:"LOAD",name:"build_35",posX:0,posY:1,posZ:-11,ignoreEntities:1b}
execute if score r randomTemp matches 35 run data merge block 145 76 295 {mode:"LOAD",name:"build_35f",posX:-9,posY:-1,posZ:-12,ignoreEntities:1b}
execute if score r randomTemp matches 35 run function lobby:qgames/build/inv/inv_35



setblock 145 76 294 minecraft:redstone_block
setblock 145 76 294 minecraft:air
setblock 148 76 297 minecraft:redstone_block

setblock 145 76 297 minecraft:redstone_block

setblock 146 76 294 minecraft:air

execute at @a[tag=sound] run playsound minecraft:block.note_block.pling ambient @p[tag=sound] ~ ~ ~ 1 1
