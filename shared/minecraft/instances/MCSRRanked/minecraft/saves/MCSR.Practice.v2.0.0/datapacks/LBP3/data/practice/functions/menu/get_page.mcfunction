scoreboard players set bool chest_menu 0
execute store success score bool chest_menu run clear @s #practice:chest_menu{page:1} 0
execute if score bool chest_menu matches 1 run scoreboard players set page chest_menu 1
execute store success score bool chest_menu run clear @s #practice:chest_menu{page:2} 0
execute if score bool chest_menu matches 1 run scoreboard players set page chest_menu 2
execute store success score bool chest_menu run clear @s #practice:chest_menu{page:3} 0
execute if score bool chest_menu matches 1 run scoreboard players set page chest_menu 3
execute store success score bool chest_menu run clear @s #practice:chest_menu{page:4} 0
execute if score bool chest_menu matches 1 run scoreboard players set page chest_menu 4
