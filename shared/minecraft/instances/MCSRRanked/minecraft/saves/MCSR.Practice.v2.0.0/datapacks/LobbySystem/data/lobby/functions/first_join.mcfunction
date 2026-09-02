execute as @a if block ~ ~-1 ~ gold_block run scoreboard players set @a spawnCheck 1
execute as @a if block ~ ~-1 ~ yellow_stained_glass run scoreboard players set @a spawnCheck 1

scoreboard players set @a[tag=!firstJoin] coins 1
scoreboard players set @a[tag=!firstJoin] boatJumpType 1
scoreboard players set @a[tag=!firstJoin] boatCrouchType 1
scoreboard players set @a[tag=!firstJoin] bridgeType 1
scoreboard players set @a[tag=!firstJoin] shipType 1
scoreboard players set @a[tag=!firstJoin] bridgeType 1
scoreboard players set @a[tag=!firstJoin] spawnerType 1
scoreboard players set @a[tag=!firstJoin] explType 1
scoreboard players set @a[tag=!firstJoin] catMode 1
scoreboard players set @a[tag=!firstJoin] catType 1
scoreboard players set @a[tag=!firstJoin] buildScore 0
scoreboard players set @a[tag=!firstJoin] buildSound 0
scoreboard players set @a[tag=!firstJoin] buildRunning 0
scoreboard players set @a[tag=!firstJoin] buildRunning 0
scoreboard players set @a[tag=!firstJoin] buildPb 0
scoreboard players set @a[tag=!firstJoin] buildCount 0
scoreboard players set @a[tag=!firstJoin] jumpCount 0
scoreboard players set @a[tag=!firstJoin] jumpPb 0
scoreboard players set @a[tag=!firstJoin] jumpCurrent 0
scoreboard players set @a[tag=!firstJoin] coins 0
scoreboard players set @a[tag=!firstJoin] inRp 0
scoreboard players set @a[tag=!firstJoin] VillagerClick 1
scoreboard players set @a[tag=!firstJoin] sound 1
scoreboard players set @a[tag=!firstJoin] catType 1
scoreboard players set @a[tag=!firstJoin] catMode 1
scoreboard players set @a[tag=!firstJoin] catCoin 0
scoreboard players set @a[tag=!firstJoin] petType 1

xp set @a[tag=!firstJoin] 0 levels
xp set @a[tag=!firstJoin] 0 points

execute as @a[tag=!firstJoin] run function lobby:pets/reset_pets

scoreboard players set @a[tag=!firstJoin] bastionJoin 0
scoreboard players set active timer 1
playsound minecraft:ui.toast.challenge_complete ambient @a[tag=!firstJoin] ~ ~ ~ 0.6 1
tellraw @a[tag=!firstJoin] ["",{"text":"\u24d8 ","bold":true,"color":"#C97EEA"},{"text":"\u2022 ","bold":true,"color":"dark_gray"},{"text":"WELCOME","bold":true,"color":"#C97EEA"},{"text":" to ","color":"#F3F3F3"},{"text":"THE","bold":true,"underlined":true,"color":"#C97EEA"},{"text":" MCSR Practice Map","bold":true,"color":"#C97EEA"},{"text":"\n\n     ","bold":true},{"text":"Use","color":"#F3F3F3"},{"text":" /trigger [Section-Name]","bold":true,"color":"#C97EEA"},{"text":" or","color":"#F3F3F3"},{"text":"\n"},{"text":"     the signs","bold":true,"color":"#C97EEA"},{"text":" to ","color":"#F3F3F3"},{"text":"navigate ","bold":true,"color":"#C97EEA"},{"text":"around the\n      map!\n      "},{"text":"Use","bold":true,"color":"#C97EEA"},{"text":" the "},{"text":"options","bold":true,"color":"#C97EEA"},{"text":" for"},{"text":" customization!\n     ","bold":true,"color":"#C97EEA"},{"text":"Avoid a render distance higher than 16!","bold":true,"color":"#FFB12E"}]
tag @a add firstJoin
tag @a add sound
tag @a add layout
execute as @a if score @s spawnCheck matches 0 run schedule function lobby:first_join 2t