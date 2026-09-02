forceload add 100 0

execute store result score #pearls practice.info run clear @a ender_pearl 0
execute store result score #obsidian practice.info run clear @a obsidian 0
execute store result score #string practice.info run clear @a string 0

data merge block 101 120 0 {Text1:'{"text":"Previous Run:","bold":true,"color":"dark_aqua"}'}
data merge block 101 120 0 {Text2:'["Time: ",{"score":{"name":"minutes","objective":"timer.temp"}},":",{"nbt":"seconds","storage":"timer","interpret":true}]'}
data merge block 101 120 0 {Text3:'["Piglins: ",{"score":{"name":"Piglins","objective":"practice.info"}}]'}
data merge block 101 120 0 {Text4:'["Barters: ",{"score":{"name":"Barters","objective":"practice.info"}}]'}
data merge block 100 120 0 {Text1:'["Pearls: ",{"score":{"name":"#pearls","objective":"practice.info"}}]'}
data merge block 100 120 0 {Text2:'["Obsidian: ",{"score":{"name":"#obsidian","objective":"practice.info"}}]'}
data merge block 100 120 0 {Text3:'["String: ",{"score":{"name":"#string","objective":"practice.info"}}]'}

function practice:previous_run_info/update