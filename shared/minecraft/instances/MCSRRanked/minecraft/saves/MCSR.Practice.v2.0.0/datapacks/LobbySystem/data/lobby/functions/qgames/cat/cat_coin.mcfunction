playsound minecraft:block.note_block.harp ambient @a[tag=sound] ~ ~ ~ 1 1
scoreboard players add @p catCoin 1
execute if score @p catCoin matches 1 run tellraw @a ["",{"text":"Save the cat ","color":"#FFC937"},{"text":"1","bold":true,"underlined":true,"color":"#FFC937"},{"text":" more time to get a ","color":"#FFC937"},{"text":"coin","bold":true,"color":"#FFC937"},{"text":"!","color":"#FFC937"}]
execute if score @p catCoin matches 2 run scoreboard players add @p coins 1
execute if score @p catCoin matches 2 run tellraw @a {"text":"+1 coin","bold":true,"color":"#FFCB29"}
execute if score @p catCoin matches 2 run scoreboard players set @p catCoin 0