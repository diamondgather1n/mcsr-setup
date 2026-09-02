execute if score bastion settings matches 0 run function practice:menu/page_3/_items/random
execute if score bastion settings matches 1 run function practice:menu/page_3/_items/bridge
execute if score bastion settings matches 2 run function practice:menu/page_3/_items/stables
execute if score bastion settings matches 3 run function practice:menu/page_3/_items/treasure
execute if score bastion settings matches 4 run function practice:menu/page_3/_items/units

replaceitem entity @s enderchest.4 piglin_banner_pattern{menu:1,page:3,display:{Name:'[{"text":"Bastion Settings","italic":false,"color":"red"}]',Lore:['[{"text":""}]','[{"text":"Click on an item to cycle through its settings","italic":false,"color":"white"}]']},HideFlags:34}

replaceitem entity @s enderchest.22 nether_star{menu:1,page:3,selection:6,display:{Name:'[{"text":"Standard Settings","italic":false,"color":"gold"}]',Lore:['[{"text":""}]','[{"text":"Click to edit","italic":false,"color":"white"}]']},HideFlags:2}