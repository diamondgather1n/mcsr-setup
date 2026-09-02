forceload add 0 0
execute positioned 0 -128 0 run loot spawn ~ ~ ~ loot practice:blocks/random_integer
execute store result score $count randomblocks positioned 0 -128 0 as @e[type=item,distance=..1] at @s run data get entity @s Item.Count

execute as @s if score $count randomblocks matches 0 unless entity @s[nbt={Inventory:[{Slot:9b}]}] run loot replace entity @s inventory.0 loot practice:blocks/random_give
execute as @s if score $count randomblocks matches 1 unless entity @s[nbt={Inventory:[{Slot:10b}]}] run loot replace entity @s inventory.1 loot practice:blocks/random_give
execute as @s if score $count randomblocks matches 2 unless entity @s[nbt={Inventory:[{Slot:11b}]}] run loot replace entity @s inventory.2 loot practice:blocks/random_give
execute as @s if score $count randomblocks matches 3 unless entity @s[nbt={Inventory:[{Slot:12b}]}] run loot replace entity @s inventory.3 loot practice:blocks/random_give
execute as @s if score $count randomblocks matches 4 unless entity @s[nbt={Inventory:[{Slot:13b}]}] run loot replace entity @s inventory.4 loot practice:blocks/random_give
execute as @s if score $count randomblocks matches 5 unless entity @s[nbt={Inventory:[{Slot:14b}]}] run loot replace entity @s inventory.5 loot practice:blocks/random_give
execute as @s if score $count randomblocks matches 6 unless entity @s[nbt={Inventory:[{Slot:15b}]}] run loot replace entity @s inventory.6 loot practice:blocks/random_give
execute as @s if score $count randomblocks matches 7 unless entity @s[nbt={Inventory:[{Slot:16b}]}] run loot replace entity @s inventory.7 loot practice:blocks/random_give
execute as @s if score $count randomblocks matches 8 unless entity @s[nbt={Inventory:[{Slot:17b}]}] run loot replace entity @s inventory.8 loot practice:blocks/random_give
execute as @s if score $count randomblocks matches 9 unless entity @s[nbt={Inventory:[{Slot:18b}]}] run loot replace entity @s inventory.9 loot practice:blocks/random_give
execute as @s if score $count randomblocks matches 10 unless entity @s[nbt={Inventory:[{Slot:19b}]}] run loot replace entity @s inventory.10 loot practice:blocks/random_give
execute as @s if score $count randomblocks matches 11 unless entity @s[nbt={Inventory:[{Slot:20b}]}] run loot replace entity @s inventory.11 loot practice:blocks/random_give
execute as @s if score $count randomblocks matches 12 unless entity @s[nbt={Inventory:[{Slot:21b}]}] run loot replace entity @s inventory.12 loot practice:blocks/random_give
execute as @s if score $count randomblocks matches 13 unless entity @s[nbt={Inventory:[{Slot:22b}]}] run loot replace entity @s inventory.13 loot practice:blocks/random_give
execute as @s if score $count randomblocks matches 14 unless entity @s[nbt={Inventory:[{Slot:23b}]}] run loot replace entity @s inventory.14 loot practice:blocks/random_give
execute as @s if score $count randomblocks matches 15 unless entity @s[nbt={Inventory:[{Slot:24b}]}] run loot replace entity @s inventory.15 loot practice:blocks/random_give
execute as @s if score $count randomblocks matches 16 unless entity @s[nbt={Inventory:[{Slot:25b}]}] run loot replace entity @s inventory.16 loot practice:blocks/random_give
execute as @s if score $count randomblocks matches 17 unless entity @s[nbt={Inventory:[{Slot:26b}]}] run loot replace entity @s inventory.17 loot practice:blocks/random_give
execute as @s if score $count randomblocks matches 18 unless entity @s[nbt={Inventory:[{Slot:27b}]}] run loot replace entity @s inventory.18 loot practice:blocks/random_give
execute as @s if score $count randomblocks matches 19 unless entity @s[nbt={Inventory:[{Slot:28b}]}] run loot replace entity @s inventory.19 loot practice:blocks/random_give
execute as @s if score $count randomblocks matches 20 unless entity @s[nbt={Inventory:[{Slot:29b}]}] run loot replace entity @s inventory.20 loot practice:blocks/random_give
execute as @s if score $count randomblocks matches 21 unless entity @s[nbt={Inventory:[{Slot:30b}]}] run loot replace entity @s inventory.21 loot practice:blocks/random_give
execute as @s if score $count randomblocks matches 22 unless entity @s[nbt={Inventory:[{Slot:31b}]}] run loot replace entity @s inventory.22 loot practice:blocks/random_give
execute as @s if score $count randomblocks matches 23 unless entity @s[nbt={Inventory:[{Slot:32b}]}] run loot replace entity @s inventory.23 loot practice:blocks/random_give
execute as @s if score $count randomblocks matches 24 unless entity @s[nbt={Inventory:[{Slot:33b}]}] run loot replace entity @s inventory.24 loot practice:blocks/random_give
execute as @s if score $count randomblocks matches 25 unless entity @s[nbt={Inventory:[{Slot:34b}]}] run loot replace entity @s inventory.25 loot practice:blocks/random_give
execute as @s if score $count randomblocks matches 26 unless entity @s[nbt={Inventory:[{Slot:35b}]}] run loot replace entity @s inventory.26 loot practice:blocks/random_give