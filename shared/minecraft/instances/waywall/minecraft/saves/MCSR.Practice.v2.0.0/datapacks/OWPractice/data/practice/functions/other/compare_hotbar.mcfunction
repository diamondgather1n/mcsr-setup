data modify block -152 73 397 Items set value {}

execute as @s run data modify block -152 73 397 Items append from entity @s Inventory[{Slot:0b}]
execute as @s run data modify block -152 73 397 Items append from entity @s Inventory[{Slot:1b}]
execute as @s run data modify block -152 73 397 Items append from entity @s Inventory[{Slot:2b}]
execute as @s run data modify block -152 73 397 Items append from entity @s Inventory[{Slot:3b}]
execute as @s run data modify block -152 73 397 Items append from entity @s Inventory[{Slot:4b}]
execute as @s run data modify block -152 73 397 Items append from entity @s Inventory[{Slot:5b}]
execute as @s run data modify block -152 73 397 Items append from entity @s Inventory[{Slot:6b}]
execute as @s run data modify block -152 73 397 Items append from entity @s Inventory[{Slot:7b}]
execute as @s run data modify block -152 73 397 Items append from entity @s Inventory[{Slot:8b}]

execute if blocks -152 73 397 -152 73 397 -152 72 394 masked run scoreboard players set $hotbarmatched randomblocks 1

# END

execute as @s if score $hotbarmatched randomblocks matches 1.. run clear @s
execute as @s if score $hotbarmatched randomblocks matches 1.. run function practice:other/inv_finish
execute as @s if score $hotbarmatched randomblocks matches 1.. run function practice:other/inv_reset