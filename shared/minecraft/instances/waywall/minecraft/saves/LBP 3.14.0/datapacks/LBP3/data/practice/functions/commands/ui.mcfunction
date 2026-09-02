scoreboard players add ui practice 1
execute if score ui practice matches 2.. run scoreboard players set ui practice 0

execute if score ui practice matches 0 if score running bastion.temp matches 1 run function timer:display/hide
execute if score ui practice matches 0 if score running bastion.temp matches 1 run scoreboard objectives setdisplay sidebar

execute if score ui practice matches 1 if score running bastion.temp matches 1 run scoreboard objectives setdisplay sidebar practice.info
execute if score ui practice matches 1 if score running bastion.temp matches 1 run function timer:display/show

schedule function practice:commands/messages/ui 1t