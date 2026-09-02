execute as @p at @p run fill ~-2 ~-2 ~-2 ~2 ~2 ~2 air replace minecraft:nether_portal

stopsound @a * minecraft:block.glass.break
stopsound @a * minecraft:block.grass.break

schedule function practice:stop_sound 2t

clear @p

schedule function practice:crafting/new_boat_cleanup 2t

