setblock -189 91 56 minecraft:redstone_block

kill @e[type=item]
kill @e[type=ender_pearl]
clear @p
give @p ender_pearl 1
tp @p -197 95 56 90 0

scoreboard players set timer timer 0
scoreboard players set timer settings 1