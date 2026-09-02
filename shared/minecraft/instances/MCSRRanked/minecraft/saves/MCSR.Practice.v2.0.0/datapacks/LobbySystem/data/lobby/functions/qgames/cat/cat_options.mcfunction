playsound minecraft:block.comparator.click player @a[tag=sound] ~ ~ ~ 0.8

scoreboard players add @p catType 1

execute if score @p catType matches 11 run scoreboard players set @p catType 1

execute if score @p catType matches 1 run data merge block 160 74 254 {Text1:'{"text":"","clickEvent":{"action":"run_command","value":"function lobby:qgames/cat/cat_options"}}',Text2:'{"text":"Difficulty","bold":true,"color":"#FFD525"}',Text3:'{"text":"Eepy","bold":true,"color":"#2fb553"}',Text4:'{"text":"1","bold":true,"color":"#2fb553"}'}
execute if score @p catType matches 2 run data merge block 160 74 254 {Text1:'{"text":"","clickEvent":{"action":"run_command","value":"function lobby:qgames/cat/cat_options"}}',Text2:'{"text":"Difficulty","bold":true,"color":"#FFD525"}',Text3:'{"text":"Chill","bold":true,"color":"#17993a"}',Text4:'{"text":"2","bold":true,"color":"#17993a"}'}
execute if score @p catType matches 3 run data merge block 160 74 254 {Text1:'{"text":"","clickEvent":{"action":"run_command","value":"function lobby:qgames/cat/cat_options"}}',Text2:'{"text":"Difficulty","bold":true,"color":"#FFD525"}',Text3:'{"text":"Easy","bold":true,"color":"#0d822c"}',Text4:'{"text":"3","bold":true,"color":"#0d822c"}'}
execute if score @p catType matches 4 run data merge block 160 74 254 {Text1:'{"text":"","clickEvent":{"action":"run_command","value":"function lobby:qgames/cat/cat_options"}}',Text2:'{"text":"Difficulty","bold":true,"color":"#FFD525"}',Text3:'{"text":"Moderate","bold":true,"color":"#d69c1e"}',Text4:'{"text":"4","bold":true,"color":"#d69c1e"}'}
execute if score @p catType matches 5 run data merge block 160 74 254 {Text1:'{"text":"","clickEvent":{"action":"run_command","value":"function lobby:qgames/cat/cat_options"}}',Text2:'{"text":"Difficulty","bold":true,"color":"#FFD525"}',Text3:'{"text":"Intermediate","bold":true,"color":"#d6461e"}',Text4:'{"text":"5","bold":true,"color":"#d6461e"}'}
execute if score @p catType matches 6 run data merge block 160 74 254 {Text1:'{"text":"","clickEvent":{"action":"run_command","value":"function lobby:qgames/cat/cat_options"}}',Text2:'{"text":"Difficulty","bold":true,"color":"#FFD525"}',Text3:'{"text":"Tough","bold":true,"color":"#b5220e"}',Text4:'{"text":"6","bold":true,"color":"#b5220e"}'}
execute if score @p catType matches 7 run data merge block 160 74 254 {Text1:'{"text":"","clickEvent":{"action":"run_command","value":"function lobby:qgames/cat/cat_options"}}',Text2:'{"text":"Difficulty","bold":true,"color":"#FFD525"}',Text3:'{"text":"Hard","bold":true,"color":"#2ea4cf"}',Text4:'{"text":"7","bold":true,"color":"#2ea4cf"}'}
execute if score @p catType matches 8 run data merge block 160 74 254 {Text1:'{"text":"","clickEvent":{"action":"run_command","value":"function lobby:qgames/cat/cat_options"}}',Text2:'{"text":"Difficulty","bold":true,"color":"#FFD525"}',Text3:'{"text":"Extreme","bold":true,"color":"#a357e6"}',Text4:'{"text":"8","bold":true,"color":"#a357e6"}'}
execute if score @p catType matches 9 run data merge block 160 74 254 {Text1:'{"text":"","clickEvent":{"action":"run_command","value":"function lobby:qgames/cat/cat_options"}}',Text2:'{"text":"Difficulty","bold":true,"color":"#FFD525"}',Text3:'{"text":"Insane","bold":true,"color":"#a0a0a0"}',Text4:'{"text":"9","bold":true,"color":"#a0a0a0"}'}
execute if score @p catType matches 10 run data merge block 160 74 254 {Text1:'{"text":"","clickEvent":{"action":"run_command","value":"function lobby:qgames/cat/cat_options"}}',Text2:'{"text":"Difficulty","bold":true,"color":"#FFD525"}',Text3:'{"text":"Walter","bold":true,"color":"#e297d5"}',Text4:'{"text":"10","bold":true,"color":"#e297d5"}'}

clear @p
setblock 166 73 258 water[level=7]
fill 164 73 254 156 80 262 air replace minecraft:crafting_table
fill 166 80 256 166 73 260 air replace lava
fill 166 80 256 166 73 260 air replace barrier