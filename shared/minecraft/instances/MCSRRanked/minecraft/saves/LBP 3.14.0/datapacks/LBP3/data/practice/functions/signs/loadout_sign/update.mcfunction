forceload add 100 0
execute in the_nether if score editing_loadout practice matches 1 run data merge block 103 114 7 {Text1:'{"text":"","clickEvent":{"action":"run_command","value":"function practice:signs/loadout_sign/save"}}',Text2:'[{"text":"Loadout ","color":"#FFFFFF"},{"score":{"name":"selected","objective":"loadout.settings"},"color":"#FFFFFF"}]',Text3:'{"text":"Save","color":"#35FF21"}'}
execute in the_nether if score editing_loadout practice matches 0 run data merge block 103 114 7 {Text1:'{"text":"","clickEvent":{"action":"run_command","value":"function practice:signs/loadout_sign/edit"}}',Text2:'[{"text":"Loadout ","color":"#FFFFFF"},{"score":{"name":"selected","objective":"loadout.settings"},"color":"#FFFFFF"}]',Text3:'{"text":"Edit","color":"#F8EE16"}'}

execute in the_nether unless block 100 110 0 white_concrete run schedule function practice:signs/loadout_sign/update 1t
execute in the_nether if block 100 110 0 white_concrete run forceload remove 100 0