fill -154 81 422 -146 77 414 air replace minecraft:crafting_table
fill -145 72 415 -148 72 424 air

setblock -145 72 421 minecraft:redstone_block
gamemode survival @p
kill @e[type=minecraft:item]

schedule function practice:crafting/new_iron_tools_delay 2t
