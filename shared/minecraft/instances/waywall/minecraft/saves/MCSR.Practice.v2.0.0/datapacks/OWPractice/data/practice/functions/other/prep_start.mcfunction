gamemode creative @p
setblock -167 72 388 redstone_block
setblock -167 72 388 air
clear @p
kill @e[type=item]
kill @e[type=silverfish]

effect give @a minecraft:instant_health 10 10 true
effect give @a minecraft:saturation 1 1

tag @p add inPrep
execute in minecraft:the_end run setblock 97 41 -1 minecraft:redstone_block
setblock -165 71 388 minecraft:redstone_block

kill @e[type=item,nbt={Item:{id:"minecraft:red_stained_glass_pane"}}]

function practice:other/prep_c_clear

loot replace entity @p hotbar.0 9 mine -161 72 388 minecraft:air{drop_contents:1b}

function practice:other/prep_c_reset

loot give @p loot practice:blocks/random_give_zero1
loot give @p loot practice:blocks/random_give_zero2

tp @p -171 71 388 90 0
spawnpoint @p -155 70 388

scoreboard players set timer timer 0
scoreboard players set timer settings 1

playsound minecraft:block.note_block.harp player @a[tag=sound] ~ ~ ~ 100 0.7

schedule function practice:other/prep_delay 2t