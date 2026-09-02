execute if score editing_loadout practice matches 1 run function practice:signs/loadout_sign/save
scoreboard players add selected loadout.settings 1
execute if score selected loadout.settings matches 5.. run scoreboard players set selected loadout.settings 1
execute if score selected loadout.settings matches 1..3 run data merge block 103 114 7 {Text1:'{"text":"","clickEvent":{"action":"run_command","value":"function practice:signs/loadout_sign/edit"}}',Text2:'[{"text":"Loadout ","color":"#FFFFFF"},{"score":{"name":"selected","objective":"loadout.settings"},"color":"#FFFFFF"}]',Text3:'{"color":"#F8EE16","text":"Edit"}'}
execute if score selected loadout.settings matches 4 run data merge block 103 114 7 {Text1:'{"text":"","clickEvent":{"action":"run_command","value":"playsound ui.button.click block @s ~ ~ ~ 0.35 1"}}',Text2:'{"text":"Loadout","color":"#FFFFFF"}',Text3:'{"text":"Random","color":"#FFFFFF"}'}
playsound block.bamboo.break block @s ~ ~ ~ 1 1.5