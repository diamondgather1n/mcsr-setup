playsound minecraft:block.comparator.click player @a[tag=sound] ~ ~ ~ 0.8

scoreboard players add @p catMode 1

execute if score @p catMode matches 3 run scoreboard players set @p catMode 1

execute if score @p catMode matches 1 run data merge block 162 74 254 {Text1:'{"text":"","clickEvent":{"action":"run_command","value":"function lobby:qgames/cat/cat_mode_options"}}',Text2:'{"text":"Objectives","bold":true,"color":"#FFD525"}',Text3:'{"text":"Tools + Bucket","bold":true,"color":"#E3E3E3"}',Text4:'{"text":"","bold":true,"color":"#14DDAD"}'}
execute if score @p catMode matches 2 run data merge block 162 74 254 {Text1:'{"text":"","clickEvent":{"action":"run_command","value":"function lobby:qgames/cat/cat_mode_options"}}',Text2:'{"text":"Objectives","bold":true,"color":"#FFD525"}',Text3:'{"text":"Tools + Bucket","bold":true,"color":"#14DDAD"}',Text4:'{"text":"Boat + Door","bold":true,"color":"#14DDAD"}'}

clear @p
fill 164 73 254 156 80 262 air replace minecraft:crafting_table
fill 166 80 256 166 73 260 air replace lava
fill 166 80 256 166 73 260 air replace barrier