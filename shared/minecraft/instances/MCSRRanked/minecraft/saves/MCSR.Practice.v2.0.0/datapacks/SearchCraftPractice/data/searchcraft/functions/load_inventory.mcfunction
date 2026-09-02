clear @a
setblock -100 1 400 minecraft:white_shulker_box
data modify block -100 1 400 Items set from storage searchcraft:gui background_hotbar
data modify block -100 1 400 Items append from storage searchcraft:recipes recipes_enabled[{selected:1b}].goals[]
data modify block -100 1 400 Items[].tag.dnd set value 1b
loot replace entity @a hotbar.0 mine -100 1 400 minecraft:air{drop_contents:1b}

data modify block -100 1 400 Items set from storage searchcraft:recipes recipes_enabled[{selected:1b}].resources
loot replace entity @a inventory.0 mine -100 1 400 minecraft:air{drop_contents:1b}
