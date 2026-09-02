playsound minecraft:block.comparator.click player @a[tag=sound] ~ ~ ~ 0.8

scoreboard players add @p boatJumpType 1

execute if score @p boatJumpType matches 6 run scoreboard players set @p boatJumpType 1

execute if score @p boatJumpType matches 1 run data merge block -156 90 31 {Text1:'{"text":"","clickEvent":{"action":"run_command","value":"function practice:movement/boat_jump_options"}}',Text2:'{"text":"Jump Length","bold":true,"underlined":true,"color":"#E4BE00"}',Text3:'{"text":"5 Blocks","bold":true,"color":"#6cf542"}'}
execute if score @p boatJumpType matches 2 run data merge block -156 90 31 {Text1:'{"text":"","clickEvent":{"action":"run_command","value":"function practice:movement/boat_jump_options"}}',Text2:'{"text":"Jump Length","bold":true,"underlined":true,"color":"#E4BE00"}',Text3:'{"text":"6 Blocks","bold":true,"color":"#d4f542"}'}
execute if score @p boatJumpType matches 3 run data merge block -156 90 31 {Text1:'{"text":"","clickEvent":{"action":"run_command","value":"function practice:movement/boat_jump_options"}}',Text2:'{"text":"Jump Length","bold":true,"underlined":true,"color":"#E4BE00"}',Text3:'{"text":"7 Blocks","bold":true,"color":"#f5b342"}'}
execute if score @p boatJumpType matches 4 run data merge block -156 90 31 {Text1:'{"text":"","clickEvent":{"action":"run_command","value":"function practice:movement/boat_jump_options"}}',Text2:'{"text":"Jump Length","bold":true,"underlined":true,"color":"#E4BE00"}',Text3:'{"text":"8 Blocks","bold":true,"color":"#bf2121"}'}
execute if score @p boatJumpType matches 5 run data merge block -156 90 31 {Text1:'{"text":"","clickEvent":{"action":"run_command","value":"function practice:movement/boat_jump_options"}}',Text2:'{"text":"Jump Length","bold":true,"underlined":true,"color":"#E4BE00"}',Text3:'{"text":"Random","bold":true,"color":"#ffbb3c"}'}
