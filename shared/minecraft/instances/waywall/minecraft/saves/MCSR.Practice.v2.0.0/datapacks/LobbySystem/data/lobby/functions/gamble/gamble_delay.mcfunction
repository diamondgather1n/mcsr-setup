execute as @p at @s run fill ~-2 ~-2 ~-2 ~2 ~2 ~2 air replace minecraft:nether_portal

stopsound @a * minecraft:block.glass.break
stopsound @a * minecraft:block.grass.break

schedule function lobby:gamble/gamble_stopsound 2t
