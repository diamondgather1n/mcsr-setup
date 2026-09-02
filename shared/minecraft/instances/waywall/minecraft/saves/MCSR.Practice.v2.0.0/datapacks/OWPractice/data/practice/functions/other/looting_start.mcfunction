data merge block -150 71 390 {LootTable:"minecraft:chests/bastion_other"}
data merge block -150 71 389 {LootTable:"minecraft:chests/bastion_other"}
data merge block -150 71 387 {LootTable:"minecraft:chests/bastion_other"}

playsound minecraft:block.note_block.harp player @a[tag=sound] ~ ~ ~ 100 0.7

clear @p
kill @e[type=item]
gamemode adventure @p
