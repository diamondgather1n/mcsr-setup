scoreboard players add @p jumpCoin 1
execute if score @p jumpCoin matches 8 run tellraw @a ["",{"text":"Do ","color":"#FFC937"},{"text":"1","bold":true,"underlined":true,"color":"#FFC937"},{"text":" more jump to get a ","color":"#FFC937"},{"text":"coin","bold":true,"color":"#FFC937"},{"text":"!","color":"#FFC937"}]
execute if score @p jumpCoin matches 9 run scoreboard players add @p coins 1
execute if score @p jumpCoin matches 9 run tellraw @a {"text":"+1 coin","bold":true,"color":"#FFCB29"}
execute if score @p jumpCoin matches 9 run scoreboard players set @p jumpCoin 0