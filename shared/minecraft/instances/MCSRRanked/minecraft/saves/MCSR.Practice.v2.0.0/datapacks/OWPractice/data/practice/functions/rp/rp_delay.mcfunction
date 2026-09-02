execute if score r randomTemp matches 1 run tp @a -158.95 94 448 90 83
execute if score r randomTemp matches 2 run tp @a -180.1 95.00 457.50 -90 83
execute if score r randomTemp matches 3 run tp @a -158.96 94.00 447.50 90 83
execute if score r randomTemp matches 4 run tp @a -173.5 91.00 470.05 180 83
execute if score r randomTemp matches 5 run tp @a -180.05 94.00 447.5 -90 83
execute if score r randomTemp matches 6 run tp @a -174.5 93.00 470.1 -180 83
execute if score r randomTemp matches 7 run tp @a -157.95 94.00 446.5 90 83
execute if score r randomTemp matches 8 run tp @a -159.05 94.00 447.5 -90 83
execute if score r randomTemp matches 9 run tp @a -156.5 94.00 449.05 -180 83
execute if score r randomTemp matches 10 run tp @a -158.95 93.00 446.5 90 83

setblock -151 93 442 minecraft:redstone_block

execute at @p run fill ~ ~ ~ ~ ~1 ~ nether_portal replace air
schedule function practice:delay 2t

scoreboard players set @a resetCheck 1


