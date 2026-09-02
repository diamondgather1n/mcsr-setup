clear @a
setblock 0 0 0 minecraft:white_shulker_box
data modify block 0 0 0 Items set from storage searchcraft:gui background_hotbar
data modify block 0 0 0 Items append from storage searchcraft:recipes recipes_enabled[{selected:1b}].goals[]
data modify block 0 0 0 Items[].tag.dnd set value 1b
loot replace entity @a hotbar.0 mine 0 0 0 minecraft:air{drop_contents:1b}

data modify block 0 0 0 Items set from storage searchcraft:recipes recipes_enabled[{selected:1b}].resources
loot replace entity @a inventory.0 mine 0 0 0 minecraft:air{drop_contents:1b}
