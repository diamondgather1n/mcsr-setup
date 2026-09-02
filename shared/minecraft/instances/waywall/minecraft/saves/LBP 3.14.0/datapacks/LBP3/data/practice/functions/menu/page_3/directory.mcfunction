scoreboard players set bool chest_menu 1

execute if score bastion settings matches 0 run function practice:menu/page_3/_directory/random
execute if score bastion settings matches 1 run function practice:menu/page_3/_directory/bridge
execute if score bastion settings matches 2 run function practice:menu/page_3/_directory/stables
execute if score bastion settings matches 3 run function practice:menu/page_3/_directory/treasure
execute if score bastion settings matches 4 run function practice:menu/page_3/_directory/units

execute if score selection chest_menu matches 6 run scoreboard players set page chest_menu 1