execute in the_nether run data modify entity @e[type=area_effect_cloud, tag=line1, limit=1] CustomName set from block 101 120 0 Text1
execute in the_nether run data modify entity @e[type=area_effect_cloud, tag=line2, limit=1] CustomName set from block 101 120 0 Text2
execute in the_nether run data modify entity @e[type=area_effect_cloud, tag=line3, limit=1] CustomName set from block 101 120 0 Text3
execute in the_nether run data modify entity @e[type=area_effect_cloud, tag=line4, limit=1] CustomName set from block 101 120 0 Text4
execute in the_nether run data modify entity @e[type=area_effect_cloud, tag=line5, limit=1] CustomName set from block 100 120 0 Text1
execute in the_nether run data modify entity @e[type=area_effect_cloud, tag=line6, limit=1] CustomName set from block 100 120 0 Text2
execute in the_nether run data modify entity @e[type=area_effect_cloud, tag=line7, limit=1] CustomName set from block 100 120 0 Text3

execute if entity @e[type=area_effect_cloud, tag=info] in the_nether run forceload remove 100 0

execute unless entity @e[type=area_effect_cloud, tag=info] run schedule function practice:previous_run_info/update 1t