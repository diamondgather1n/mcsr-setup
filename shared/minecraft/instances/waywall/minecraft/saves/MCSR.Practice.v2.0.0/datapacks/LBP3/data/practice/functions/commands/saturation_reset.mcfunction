scoreboard players add sat_reset practice 1
execute if score sat_reset practice matches 2.. run scoreboard players set sat_reset practice 0
execute if score has_carpet practice matches 0 run scoreboard players set sat_reset practice 0

schedule function practice:commands/messages/saturation_reset 1t