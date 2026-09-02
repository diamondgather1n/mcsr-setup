playsound minecraft:block.comparator.click player @a ~ ~ ~ 0.8

scoreboard players add @p sound 1

execute if score @p sound matches 2 run scoreboard players set @p sound 0

execute if score @p sound matches 1 run tag @p add sound
execute if score @p sound matches 0 run tag @p remove sound

execute if score @p sound matches 1 run data merge block -155 108 50 {Text1:'{"text":"","clickEvent":{"action":"run_command","value":"function lobby:sound_options"}}',Text2:'{"text":"Sounds","bold":true,"underlined":true,"color":"#94E8FF"}',Text3:'{"text":"\\u226b ON \\u226a","bold":true,"color":"#30DA59"}'}
execute if score @p sound matches 0 run data merge block -155 108 50 {Text1:'{"text":"","clickEvent":{"action":"run_command","value":"function lobby:sound_options"}}',Text2:'{"text":"Sounds","bold":true,"underlined":true,"color":"#94E8FF"}',Text3:'{"text":"\\u226b OFF \\u226a","bold":true,"color":"#DD2224"}'}
