data modify block -65 63 376 Items set value []
data modify block -65 63 377 Items set value []
data modify block -100 1 400 Items set value []
data modify block -100 1 400 Items set from storage searchcraft:recipes recipes[{selected:1b}].goals
loot replace block -65 63 377 container.9 mine -100 1 400 air{drop_contents:1b}
data modify block -65 63 377 Items prepend from storage searchcraft:gui background_config[]
data modify block -65 63 376 Items set from storage searchcraft:recipes recipes[{selected:1b}].resources

data modify block -65 63 377 CustomName set value '{"text":"Configuration"}'

gamemode creative @a

scoreboard players set menu gui 1