function practice:menu/get_page
function practice:menu/get_selection

scoreboard players set bool chest_menu 0
execute if score bool chest_menu matches 0 if score page chest_menu matches 1 run function practice:menu/page_1/directory
execute if score bool chest_menu matches 0 if score page chest_menu matches 2 run function practice:menu/page_2/directory
execute if score bool chest_menu matches 0 if score page chest_menu matches 3 run function practice:menu/page_3/directory
execute if score bool chest_menu matches 0 if score page chest_menu matches 4 run function practice:menu/page_4/directory

# Play button press sound
execute if score selection chest_menu matches 1.. at @s run playsound ui.button.click master @s ~ ~ ~ 0.3 1

function practice:menu/update
clear @s #practice:chest_menu{menu:1}
scoreboard players set selection chest_menu 0

