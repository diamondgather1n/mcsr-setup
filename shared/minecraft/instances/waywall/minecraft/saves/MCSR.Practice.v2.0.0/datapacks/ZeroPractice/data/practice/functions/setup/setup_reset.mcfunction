fill 129 103 8 143 130 -6 air

tag @p remove inSetup

advancement revoke @p[tag=inSetup] only practice:bed_use

setblock 136 107 2 minecraft:dark_oak_wall_sign[facing=north]
data merge block 136 107 2 {Text1:'{"text":"","clickEvent":{"action":"run_command","value":"function practice:setup/setup_reset"}}',Text2:'{"text":"Back","bold":true,"color":"#E12123"}'}
setblock 136 106 0 minecraft:obsidian
setblock 136 107 0 minecraft:cobblestone

kill @e[type=item]
gamemode survival @s
tp @a 136 65 0 90 0
clear @a
