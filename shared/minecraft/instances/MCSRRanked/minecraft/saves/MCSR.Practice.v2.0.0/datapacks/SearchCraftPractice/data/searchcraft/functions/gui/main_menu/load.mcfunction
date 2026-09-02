data modify storage searchcraft:recipes chest_top set value []
data modify storage searchcraft:recipes chest_bottom set value []
scoreboard players set column gui 1
#data modify storage searchcraft:recipes R set from storage searchcraft:recipes recipes
#data modify storage searchcraft:recipes L set value []

scoreboard players set index gui 0
function searchcraft:gui/main_menu/set_recipe_selected
scoreboard players reset index gui

execute if data storage searchcraft:recipes R[0] run function searchcraft:gui/main_menu/load_recipes

data modify block -65 63 377 Items set from storage searchcraft:recipes chest_top
data modify block -65 63 377 Items prepend from storage searchcraft:gui background_recipes_top[]

data modify block -65 63 376 Items set from storage searchcraft:recipes chest_bottom
data modify block -65 63 376 Items prepend from storage searchcraft:gui background_recipes_bottom[]

scoreboard players add page gui 1
data merge block -100 2 400 {Text1:'[{"text":"Previous Page (","italic":"false","color":"gold"},{"score":{"name":"page","objective":"gui"}},{"text":"/10)"}]',Text2:'[{"text":"Next Page (","italic":"false","color":"gold"},{"score":{"name":"page","objective":"gui"}},{"text":"/10)"}]'}
data modify block -65 63 376 Items[{Slot:0b}].tag.display.Name set from block -100 2 400 Text1
data modify block -65 63 376 Items[{Slot:8b}].tag.display.Name set from block -100 2 400 Text2
scoreboard players remove page gui 1

data modify block -65 63 377 CustomName set value '{"text":"Recipes"}'

scoreboard players set menu gui 0