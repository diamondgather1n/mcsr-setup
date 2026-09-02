replaceitem entity @p weapon.offhand oak_button
replaceitem entity @p weapon.offhand air

clear @p
execute positioned 166 73 258 run kill @e[type=item,distance=..15]

setblock 162 73 257 dark_oak_wall_sign[facing=west]
data merge block 162 73 257 {Text1:'{"text":"","clickEvent":{"action":"run_command","value":"function lobby:qgames/cat/cat_start"}}',Text2:'{"text":"Start","bold":true,"color":"#36EF34"}'}