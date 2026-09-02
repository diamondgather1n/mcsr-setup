schedule function practice:_start/run_tick 1t

# Count gold ingots on the ground
scoreboard players set total_gold practice.gold 0
execute as @e[type=item, nbt={Item:{id:"minecraft:gold_ingot"}}] run function practice:_start/_run_tick/count_gold

# Count bartering piglins
execute as @e[type=piglin, tag=bastion_mob, nbt={HandItems:[{id:"minecraft:gold_ingot"}]}] run function practice:_start/_run_tick/count_barters

# Count piglins in hole
scoreboard players set total_piglins practice.piglins 0
execute as @e[type=piglin, tag=bastion_mob] run function practice:_start/_run_tick/count_piglins

# Move damage taken, barters and piglins count to the info scoreboard
scoreboard players operation @a damage_taken /= #10 practice.info
scoreboard players operation Damage practice.info += @a damage_taken
execute if score logger practice matches 1.. as @a[scores={damage_taken=1..}] run function practice:logger/damage_taken
scoreboard players reset @a damage_taken
scoreboard players operation Barters practice.info = total_barters practice.barters
scoreboard players operation Piglins practice.info = total_piglins practice.piglins

# Log tick events
execute if score logger practice matches 1.. run function practice:logger/log_tick

# Check whether the player has reset
execute as @a[predicate=practice:dropped_pick] at @s run function practice:on_dropped_pick