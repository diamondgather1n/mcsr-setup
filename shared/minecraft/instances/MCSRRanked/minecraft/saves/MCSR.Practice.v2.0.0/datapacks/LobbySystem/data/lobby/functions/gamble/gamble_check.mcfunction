gamemode adventure @p

title @a times 10 25 10

execute if score @p coins matches ..9 run title @p actionbar ["",{"text":"You need at least ","color":"#E54644"},{"text":"10 coins","bold":true,"color":"#FFD235"},{"text":" to gamble!","color":"#E54644"}]
execute if score @p coins matches 10.. run function lobby:gamble/gamble_loop

execute if score @p gambleRunning matches 1 if score @p coins matches 10.. run title @a actionbar {"text":"The gamble is already running!","color":"#E54644"}
execute if score @p gambleRunning matches 0 if score @p coins matches 10.. run scoreboard players set @p gambleRunning 1

execute at @p run fill ~ ~ ~ ~ ~1 ~ nether_portal replace air
schedule function lobby:gamble/gamble_delay 2t
 