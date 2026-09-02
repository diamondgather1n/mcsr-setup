playsound minecraft:block.comparator.click player @a[tag=sound] ~ ~ ~ 0.8

scoreboard players add @p boatCrouchType 1

execute if score @p boatCrouchType matches 3 run scoreboard players set @p boatCrouchType 1

execute if score @p boatCrouchType matches 1 run data merge block -156 90 27 {Text1:'{"text":"","clickEvent":{"action":"run_command","value":"function practice:movement/boat_crouch_options"}}',Text2:'{"text":"Terrain","bold":true,"underlined":true,"color":"#814dfa"}',Text3:'{"text":"Wall","bold":true,"color":"#558ce6"}'}
execute if score @p boatCrouchType matches 2 run data merge block -156 90 27 {Text1:'{"text":"","clickEvent":{"action":"run_command","value":"function practice:movement/boat_crouch_options"}}',Text2:'{"text":"Terrain","bold":true,"underlined":true,"color":"#814dfa"}',Text3:'{"text":"Hallway","bold":true,"color":"#5555e6"}'}