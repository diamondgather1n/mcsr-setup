scoreboard players add timer_printout settings 1
scoreboard players operation timer_printout settings %= 3 c

execute if score timer_printout settings matches 0 run data modify block -64 64 377 Text3 set value '{"text":"Time + Items","color":"yellow","clickEvent":{"action":"run_command","value":"function searchcraft:settings/timer_printout"}}'
execute if score timer_printout settings matches 1 run data modify block -64 64 377 Text3 set value '{"text":"Time Only","color":"yellow","clickEvent":{"action":"run_command","value":"function searchcraft:settings/timer_printout"}}'
execute if score timer_printout settings matches 2 run data modify block -64 64 377 Text3 set value '{"text":"Disabled","color":"yellow","clickEvent":{"action":"run_command","value":"function searchcraft:settings/timer_printout"}}'