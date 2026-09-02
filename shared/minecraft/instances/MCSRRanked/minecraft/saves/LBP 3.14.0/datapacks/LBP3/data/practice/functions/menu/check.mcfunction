execute store result score items chest_menu run clear @s #practice:chest_menu{menu:1} 0
execute if score items chest_menu matches 1.. run function practice:menu/directory

# Check for item entities
execute at @a as @e[type=item, distance=..1.4, nbt={Item:{tag:{menu:1}}}] run data modify entity @s PickupDelay set value 0