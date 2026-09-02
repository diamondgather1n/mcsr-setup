playsound minecraft:block.comparator.click player @a[tag=sound] ~ ~ ~

scoreboard players add @p shipType 1

execute if score @p shipType matches 5 run scoreboard players set @p shipType 1

execute if score @p shipType matches 1 run data merge block -118 78 415 {Text1:'{"text":"","clickEvent":{"action":"run_command","value":"function practice:ship/cycle_ship"}}',Text2:'["",{"text":"Normal ","bold":true,"color":"#FF7200"}]'}
execute if score @p shipType matches 2 run data merge block -118 78 415 {Text1:'{"text":"","clickEvent":{"action":"run_command","value":"function practice:ship/cycle_ship"}}',Text2:'["",{"text":"Upside Down ","bold":true,"color":"#FF7200"}]'}
execute if score @p shipType matches 3 run data merge block -118 78 415 {Text1:'{"text":"","clickEvent":{"action":"run_command","value":"function practice:ship/cycle_ship"}}',Text2:'["",{"text":"Sideways ","bold":true,"color":"#FF7200"}]'}
execute if score @p shipType matches 4 run data merge block -118 78 415 {Text1:'{"text":"","clickEvent":{"action":"run_command","value":"function practice:ship/cycle_ship"}}',Text2:'["",{"text":"Random ","bold":true,"color":"#FF7200"}]'}