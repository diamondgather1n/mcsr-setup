data merge block -146 78 418 {LootTable:"practice:bt"}
fill -154 81 422 -146 77 414 air replace minecraft:crafting_table
fill -148 72 416 -145 72 423 air replace minecraft:redstone_block

setblock -148 72 421 minecraft:redstone_block
gamemode survival @p
kill @e[type=minecraft:item]
schedule function practice:crafting/new_treasure9_gen_delay 2t