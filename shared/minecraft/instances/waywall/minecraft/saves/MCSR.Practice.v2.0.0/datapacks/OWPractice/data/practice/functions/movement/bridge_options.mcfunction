playsound minecraft:block.comparator.click player @a[tag=sound] ~ ~ ~ 0.8

scoreboard players add @p bridgeType 1

execute if score @p bridgeType matches 6 run scoreboard players set @p bridgeType 1

execute if score @p bridgeType matches 1 run data merge block -170 91 34 {Text1:'{"text":"","clickEvent":{"action":"run_command","value":"function practice:movement/bridge_options"}}',Text2:'{"text":"Bridge Type","bold":true,"underlined":true,"color":"#E4BE00"}',Text3:'{"text":"Dirt","bold":true,"color":"#BE7030"}'}
execute if score @p bridgeType matches 2 run data merge block -170 91 34 {Text1:'{"text":"","clickEvent":{"action":"run_command","value":"function practice:movement/bridge_options"}}',Text2:'{"text":"Bridge Type","bold":true,"underlined":true,"color":"#E4BE00"}',Text3:'{"text":"Soul Sand","bold":true,"color":"#42D2AE"}'}
execute if score @p bridgeType matches 3 run data merge block -170 91 34 {Text1:'{"text":"","clickEvent":{"action":"run_command","value":"function practice:movement/bridge_options"}}',Text2:'{"text":"Bridge Type","bold":true,"underlined":true,"color":"#E4BE00"}',Text3:'{"text":"Soul Speed 1","bold":true,"color":"#4B96DB"}'}
execute if score @p bridgeType matches 4 run data merge block -170 91 34 {Text1:'{"text":"","clickEvent":{"action":"run_command","value":"function practice:movement/bridge_options"}}',Text2:'{"text":"Bridge Type","bold":true,"underlined":true,"color":"#E4BE00"}',Text3:'{"text":"Soul Speed 2","bold":true,"color":"#4B96DB"}'}
execute if score @p bridgeType matches 5 run data merge block -170 91 34 {Text1:'{"text":"","clickEvent":{"action":"run_command","value":"function practice:movement/bridge_options"}}',Text2:'{"text":"Bridge Type","bold":true,"underlined":true,"color":"#E4BE00"}',Text3:'{"text":"Soul Speed 3","bold":true,"color":"#4B96DB"}'}
