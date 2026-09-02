tag @p add inSetup
effect give @p resistance 1 4 true

advancement revoke @p[tag=inSetup] only practice:bed_use
setblock 136 106 0 minecraft:obsidian
setblock 136 107 0 minecraft:cobblestone

kill @e[type=item]

setblock 136 107 3 minecraft:oak_wall_sign[facing=south]
setblock 136 107 2 minecraft:oak_wall_sign[facing=north]
data merge block 136 107 2 {Text1:'{"text":"","clickEvent":{"action":"run_command","value":"function practice:setup/setup_reset"}}',Text2:'{"text":"Back","bold":true,"color":"#E12123"}'}
tp @s 136.3 108 0.3 -45 84

clear @s

function practice:inventory/loadinv