setblock -152 72 397 air
setblock -152 72 397 shulker_box[facing=south]{Items:[{Slot:0b,id:"minecraft:structure_void",Count:1b},{Slot:1b,id:"minecraft:structure_void",Count:1b},{Slot:2b,id:"minecraft:structure_void",Count:1b},{Slot:3b,id:"minecraft:structure_void",Count:1b},{Slot:4b,id:"minecraft:structure_void",Count:1b},{Slot:5b,id:"minecraft:structure_void",Count:1b},{Slot:6b,id:"minecraft:structure_void",Count:1b},{Slot:7b,id:"minecraft:structure_void",Count:1b},{Slot:8b,id:"minecraft:structure_void",Count:1b},{Slot:9b,id:"minecraft:structure_void",Count:1b}]}

scoreboard players reset $value randominteger
execute if data storage minecraft:randomhotbar integers[0] store result score $value randominteger run data get storage minecraft:randomhotbar integers[0]
execute if data storage minecraft:randomhotbar integers[0] run scoreboard players remove $value randominteger 1
execute if data storage minecraft:randomhotbar items[0].[0] if score $value randominteger matches 0 run data modify block -152 72 397 Items[{Slot:1b}].id set from storage minecraft:randomhotbar items[0].[0].id
execute if data storage minecraft:randomhotbar items[0].[0] if score $value randominteger matches 0 run data modify block -152 72 397 Items[{Slot:1b}].Count set from storage minecraft:randomhotbar items[0].[0].Count
execute if data storage minecraft:randomhotbar items[0].[0] if score $value randominteger matches 1 run data modify block -152 72 397 Items[{Slot:2b}].id set from storage minecraft:randomhotbar items[0].[0].id
execute if data storage minecraft:randomhotbar items[0].[0] if score $value randominteger matches 1 run data modify block -152 72 397 Items[{Slot:2b}].Count set from storage minecraft:randomhotbar items[0].[0].Count
execute if data storage minecraft:randomhotbar items[0].[0] if score $value randominteger matches 2 run data modify block -152 72 397 Items[{Slot:3b}].id set from storage minecraft:randomhotbar items[0].[0].id
execute if data storage minecraft:randomhotbar items[0].[0] if score $value randominteger matches 2 run data modify block -152 72 397 Items[{Slot:3b}].Count set from storage minecraft:randomhotbar items[0].[0].Count
execute if data storage minecraft:randomhotbar items[0].[0] if score $value randominteger matches 3 run data modify block -152 72 397 Items[{Slot:4b}].id set from storage minecraft:randomhotbar items[0].[0].id
execute if data storage minecraft:randomhotbar items[0].[0] if score $value randominteger matches 3 run data modify block -152 72 397 Items[{Slot:4b}].Count set from storage minecraft:randomhotbar items[0].[0].Count
execute if data storage minecraft:randomhotbar items[0].[0] if score $value randominteger matches 4 run data modify block -152 72 397 Items[{Slot:5b}].id set from storage minecraft:randomhotbar items[0].[0].id
execute if data storage minecraft:randomhotbar items[0].[0] if score $value randominteger matches 4 run data modify block -152 72 397 Items[{Slot:5b}].Count set from storage minecraft:randomhotbar items[0].[0].Count
execute if data storage minecraft:randomhotbar items[0].[0] if score $value randominteger matches 5 run data modify block -152 72 397 Items[{Slot:6b}].id set from storage minecraft:randomhotbar items[0].[0].id
execute if data storage minecraft:randomhotbar items[0].[0] if score $value randominteger matches 5 run data modify block -152 72 397 Items[{Slot:6b}].Count set from storage minecraft:randomhotbar items[0].[0].Count
execute if data storage minecraft:randomhotbar items[0].[0] if score $value randominteger matches 6 run data modify block -152 72 397 Items[{Slot:7b}].id set from storage minecraft:randomhotbar items[0].[0].id
execute if data storage minecraft:randomhotbar items[0].[0] if score $value randominteger matches 6 run data modify block -152 72 397 Items[{Slot:7b}].Count set from storage minecraft:randomhotbar items[0].[0].Count
execute if data storage minecraft:randomhotbar items[0].[0] if score $value randominteger matches 7 run data modify block -152 72 397 Items[{Slot:8b}].id set from storage minecraft:randomhotbar items[0].[0].id
execute if data storage minecraft:randomhotbar items[0].[0] if score $value randominteger matches 7 run data modify block -152 72 397 Items[{Slot:8b}].Count set from storage minecraft:randomhotbar items[0].[0].Count
execute if data storage minecraft:randomhotbar items[0].[0] if score $value randominteger matches 8 run data modify block -152 72 397 Items[{Slot:9b}].id set from storage minecraft:randomhotbar items[0].[0].id
execute if data storage minecraft:randomhotbar items[0].[0] if score $value randominteger matches 8 run data modify block -152 72 397 Items[{Slot:9b}].Count set from storage minecraft:randomhotbar items[0].[0].Count



scoreboard players reset $value randominteger
execute if data storage minecraft:randomhotbar integers[1] store result score $value randominteger run data get storage minecraft:randomhotbar integers[1]
execute if data storage minecraft:randomhotbar integers[1] run scoreboard players remove $value randominteger 1
execute if data storage minecraft:randomhotbar items[0].[1] if score $value randominteger matches 0 run data modify block -152 72 397 Items[{Slot:1b}].id set from storage minecraft:randomhotbar items[0].[1].id
execute if data storage minecraft:randomhotbar items[0].[1] if score $value randominteger matches 0 run data modify block -152 72 397 Items[{Slot:1b}].Count set from storage minecraft:randomhotbar items[0].[1].Count
execute if data storage minecraft:randomhotbar items[0].[1] if score $value randominteger matches 1 run data modify block -152 72 397 Items[{Slot:2b}].id set from storage minecraft:randomhotbar items[0].[1].id
execute if data storage minecraft:randomhotbar items[0].[1] if score $value randominteger matches 1 run data modify block -152 72 397 Items[{Slot:2b}].Count set from storage minecraft:randomhotbar items[0].[1].Count
execute if data storage minecraft:randomhotbar items[0].[1] if score $value randominteger matches 2 run data modify block -152 72 397 Items[{Slot:3b}].id set from storage minecraft:randomhotbar items[0].[1].id
execute if data storage minecraft:randomhotbar items[0].[1] if score $value randominteger matches 2 run data modify block -152 72 397 Items[{Slot:3b}].Count set from storage minecraft:randomhotbar items[0].[1].Count
execute if data storage minecraft:randomhotbar items[0].[1] if score $value randominteger matches 3 run data modify block -152 72 397 Items[{Slot:4b}].id set from storage minecraft:randomhotbar items[0].[1].id
execute if data storage minecraft:randomhotbar items[0].[1] if score $value randominteger matches 3 run data modify block -152 72 397 Items[{Slot:4b}].Count set from storage minecraft:randomhotbar items[0].[1].Count
execute if data storage minecraft:randomhotbar items[0].[1] if score $value randominteger matches 4 run data modify block -152 72 397 Items[{Slot:5b}].id set from storage minecraft:randomhotbar items[0].[1].id
execute if data storage minecraft:randomhotbar items[0].[1] if score $value randominteger matches 4 run data modify block -152 72 397 Items[{Slot:5b}].Count set from storage minecraft:randomhotbar items[0].[1].Count
execute if data storage minecraft:randomhotbar items[0].[1] if score $value randominteger matches 5 run data modify block -152 72 397 Items[{Slot:6b}].id set from storage minecraft:randomhotbar items[0].[1].id
execute if data storage minecraft:randomhotbar items[0].[1] if score $value randominteger matches 5 run data modify block -152 72 397 Items[{Slot:6b}].Count set from storage minecraft:randomhotbar items[0].[1].Count
execute if data storage minecraft:randomhotbar items[0].[1] if score $value randominteger matches 6 run data modify block -152 72 397 Items[{Slot:7b}].id set from storage minecraft:randomhotbar items[0].[1].id
execute if data storage minecraft:randomhotbar items[0].[1] if score $value randominteger matches 6 run data modify block -152 72 397 Items[{Slot:7b}].Count set from storage minecraft:randomhotbar items[0].[1].Count
execute if data storage minecraft:randomhotbar items[0].[1] if score $value randominteger matches 7 run data modify block -152 72 397 Items[{Slot:8b}].id set from storage minecraft:randomhotbar items[0].[1].id
execute if data storage minecraft:randomhotbar items[0].[1] if score $value randominteger matches 7 run data modify block -152 72 397 Items[{Slot:8b}].Count set from storage minecraft:randomhotbar items[0].[1].Count
execute if data storage minecraft:randomhotbar items[0].[1] if score $value randominteger matches 8 run data modify block -152 72 397 Items[{Slot:9b}].id set from storage minecraft:randomhotbar items[0].[1].id
execute if data storage minecraft:randomhotbar items[0].[1] if score $value randominteger matches 8 run data modify block -152 72 397 Items[{Slot:9b}].Count set from storage minecraft:randomhotbar items[0].[1].Count



scoreboard players reset $value randominteger
execute if data storage minecraft:randomhotbar integers[2] store result score $value randominteger run data get storage minecraft:randomhotbar integers[2]
execute if data storage minecraft:randomhotbar integers[2] run scoreboard players remove $value randominteger 1
execute if data storage minecraft:randomhotbar items[0].[2] if score $value randominteger matches 0 run data modify block -152 72 397 Items[{Slot:1b}].id set from storage minecraft:randomhotbar items[0].[2].id
execute if data storage minecraft:randomhotbar items[0].[2] if score $value randominteger matches 0 run data modify block -152 72 397 Items[{Slot:1b}].Count set from storage minecraft:randomhotbar items[0].[2].Count
execute if data storage minecraft:randomhotbar items[0].[2] if score $value randominteger matches 1 run data modify block -152 72 397 Items[{Slot:2b}].id set from storage minecraft:randomhotbar items[0].[2].id
execute if data storage minecraft:randomhotbar items[0].[2] if score $value randominteger matches 1 run data modify block -152 72 397 Items[{Slot:2b}].Count set from storage minecraft:randomhotbar items[0].[2].Count
execute if data storage minecraft:randomhotbar items[0].[2] if score $value randominteger matches 2 run data modify block -152 72 397 Items[{Slot:3b}].id set from storage minecraft:randomhotbar items[0].[2].id
execute if data storage minecraft:randomhotbar items[0].[2] if score $value randominteger matches 2 run data modify block -152 72 397 Items[{Slot:3b}].Count set from storage minecraft:randomhotbar items[0].[2].Count
execute if data storage minecraft:randomhotbar items[0].[2] if score $value randominteger matches 3 run data modify block -152 72 397 Items[{Slot:4b}].id set from storage minecraft:randomhotbar items[0].[2].id
execute if data storage minecraft:randomhotbar items[0].[2] if score $value randominteger matches 3 run data modify block -152 72 397 Items[{Slot:4b}].Count set from storage minecraft:randomhotbar items[0].[2].Count
execute if data storage minecraft:randomhotbar items[0].[2] if score $value randominteger matches 4 run data modify block -152 72 397 Items[{Slot:5b}].id set from storage minecraft:randomhotbar items[0].[2].id
execute if data storage minecraft:randomhotbar items[0].[2] if score $value randominteger matches 4 run data modify block -152 72 397 Items[{Slot:5b}].Count set from storage minecraft:randomhotbar items[0].[2].Count
execute if data storage minecraft:randomhotbar items[0].[2] if score $value randominteger matches 5 run data modify block -152 72 397 Items[{Slot:6b}].id set from storage minecraft:randomhotbar items[0].[2].id
execute if data storage minecraft:randomhotbar items[0].[2] if score $value randominteger matches 5 run data modify block -152 72 397 Items[{Slot:6b}].Count set from storage minecraft:randomhotbar items[0].[2].Count
execute if data storage minecraft:randomhotbar items[0].[2] if score $value randominteger matches 6 run data modify block -152 72 397 Items[{Slot:7b}].id set from storage minecraft:randomhotbar items[0].[2].id
execute if data storage minecraft:randomhotbar items[0].[2] if score $value randominteger matches 6 run data modify block -152 72 397 Items[{Slot:7b}].Count set from storage minecraft:randomhotbar items[0].[2].Count
execute if data storage minecraft:randomhotbar items[0].[2] if score $value randominteger matches 7 run data modify block -152 72 397 Items[{Slot:8b}].id set from storage minecraft:randomhotbar items[0].[2].id
execute if data storage minecraft:randomhotbar items[0].[2] if score $value randominteger matches 7 run data modify block -152 72 397 Items[{Slot:8b}].Count set from storage minecraft:randomhotbar items[0].[2].Count
execute if data storage minecraft:randomhotbar items[0].[2] if score $value randominteger matches 8 run data modify block -152 72 397 Items[{Slot:9b}].id set from storage minecraft:randomhotbar items[0].[2].id
execute if data storage minecraft:randomhotbar items[0].[2] if score $value randominteger matches 8 run data modify block -152 72 397 Items[{Slot:9b}].Count set from storage minecraft:randomhotbar items[0].[2].Count



scoreboard players reset $value randominteger
execute if data storage minecraft:randomhotbar integers[3] store result score $value randominteger run data get storage minecraft:randomhotbar integers[3]
execute if data storage minecraft:randomhotbar integers[3] run scoreboard players remove $value randominteger 1
execute if data storage minecraft:randomhotbar items[0].[3] if score $value randominteger matches 0 run data modify block -152 72 397 Items[{Slot:1b}].id set from storage minecraft:randomhotbar items[0].[3].id
execute if data storage minecraft:randomhotbar items[0].[3] if score $value randominteger matches 0 run data modify block -152 72 397 Items[{Slot:1b}].Count set from storage minecraft:randomhotbar items[0].[3].Count
execute if data storage minecraft:randomhotbar items[0].[3] if score $value randominteger matches 1 run data modify block -152 72 397 Items[{Slot:2b}].id set from storage minecraft:randomhotbar items[0].[3].id
execute if data storage minecraft:randomhotbar items[0].[3] if score $value randominteger matches 1 run data modify block -152 72 397 Items[{Slot:2b}].Count set from storage minecraft:randomhotbar items[0].[3].Count
execute if data storage minecraft:randomhotbar items[0].[3] if score $value randominteger matches 2 run data modify block -152 72 397 Items[{Slot:3b}].id set from storage minecraft:randomhotbar items[0].[3].id
execute if data storage minecraft:randomhotbar items[0].[3] if score $value randominteger matches 2 run data modify block -152 72 397 Items[{Slot:3b}].Count set from storage minecraft:randomhotbar items[0].[3].Count
execute if data storage minecraft:randomhotbar items[0].[3] if score $value randominteger matches 3 run data modify block -152 72 397 Items[{Slot:4b}].id set from storage minecraft:randomhotbar items[0].[3].id
execute if data storage minecraft:randomhotbar items[0].[3] if score $value randominteger matches 3 run data modify block -152 72 397 Items[{Slot:4b}].Count set from storage minecraft:randomhotbar items[0].[3].Count
execute if data storage minecraft:randomhotbar items[0].[3] if score $value randominteger matches 4 run data modify block -152 72 397 Items[{Slot:5b}].id set from storage minecraft:randomhotbar items[0].[3].id
execute if data storage minecraft:randomhotbar items[0].[3] if score $value randominteger matches 4 run data modify block -152 72 397 Items[{Slot:5b}].Count set from storage minecraft:randomhotbar items[0].[3].Count
execute if data storage minecraft:randomhotbar items[0].[3] if score $value randominteger matches 5 run data modify block -152 72 397 Items[{Slot:6b}].id set from storage minecraft:randomhotbar items[0].[3].id
execute if data storage minecraft:randomhotbar items[0].[3] if score $value randominteger matches 5 run data modify block -152 72 397 Items[{Slot:6b}].Count set from storage minecraft:randomhotbar items[0].[3].Count
execute if data storage minecraft:randomhotbar items[0].[3] if score $value randominteger matches 6 run data modify block -152 72 397 Items[{Slot:7b}].id set from storage minecraft:randomhotbar items[0].[3].id
execute if data storage minecraft:randomhotbar items[0].[3] if score $value randominteger matches 6 run data modify block -152 72 397 Items[{Slot:7b}].Count set from storage minecraft:randomhotbar items[0].[3].Count
execute if data storage minecraft:randomhotbar items[0].[3] if score $value randominteger matches 7 run data modify block -152 72 397 Items[{Slot:8b}].id set from storage minecraft:randomhotbar items[0].[3].id
execute if data storage minecraft:randomhotbar items[0].[3] if score $value randominteger matches 7 run data modify block -152 72 397 Items[{Slot:8b}].Count set from storage minecraft:randomhotbar items[0].[3].Count
execute if data storage minecraft:randomhotbar items[0].[3] if score $value randominteger matches 8 run data modify block -152 72 397 Items[{Slot:9b}].id set from storage minecraft:randomhotbar items[0].[3].id
execute if data storage minecraft:randomhotbar items[0].[3] if score $value randominteger matches 8 run data modify block -152 72 397 Items[{Slot:9b}].Count set from storage minecraft:randomhotbar items[0].[3].Count



scoreboard players reset $value randominteger
execute if data storage minecraft:randomhotbar integers[4] store result score $value randominteger run data get storage minecraft:randomhotbar integers[4]
execute if data storage minecraft:randomhotbar integers[4] run scoreboard players remove $value randominteger 1
execute if data storage minecraft:randomhotbar items[0].[4] if score $value randominteger matches 0 run data modify block -152 72 397 Items[{Slot:1b}].id set from storage minecraft:randomhotbar items[0].[4].id
execute if data storage minecraft:randomhotbar items[0].[4] if score $value randominteger matches 0 run data modify block -152 72 397 Items[{Slot:1b}].Count set from storage minecraft:randomhotbar items[0].[4].Count
execute if data storage minecraft:randomhotbar items[0].[4] if score $value randominteger matches 1 run data modify block -152 72 397 Items[{Slot:2b}].id set from storage minecraft:randomhotbar items[0].[4].id
execute if data storage minecraft:randomhotbar items[0].[4] if score $value randominteger matches 1 run data modify block -152 72 397 Items[{Slot:2b}].Count set from storage minecraft:randomhotbar items[0].[4].Count
execute if data storage minecraft:randomhotbar items[0].[4] if score $value randominteger matches 2 run data modify block -152 72 397 Items[{Slot:3b}].id set from storage minecraft:randomhotbar items[0].[4].id
execute if data storage minecraft:randomhotbar items[0].[4] if score $value randominteger matches 2 run data modify block -152 72 397 Items[{Slot:3b}].Count set from storage minecraft:randomhotbar items[0].[4].Count
execute if data storage minecraft:randomhotbar items[0].[4] if score $value randominteger matches 3 run data modify block -152 72 397 Items[{Slot:4b}].id set from storage minecraft:randomhotbar items[0].[4].id
execute if data storage minecraft:randomhotbar items[0].[4] if score $value randominteger matches 3 run data modify block -152 72 397 Items[{Slot:4b}].Count set from storage minecraft:randomhotbar items[0].[4].Count
execute if data storage minecraft:randomhotbar items[0].[4] if score $value randominteger matches 4 run data modify block -152 72 397 Items[{Slot:5b}].id set from storage minecraft:randomhotbar items[0].[4].id
execute if data storage minecraft:randomhotbar items[0].[4] if score $value randominteger matches 4 run data modify block -152 72 397 Items[{Slot:5b}].Count set from storage minecraft:randomhotbar items[0].[4].Count
execute if data storage minecraft:randomhotbar items[0].[4] if score $value randominteger matches 5 run data modify block -152 72 397 Items[{Slot:6b}].id set from storage minecraft:randomhotbar items[0].[4].id
execute if data storage minecraft:randomhotbar items[0].[4] if score $value randominteger matches 5 run data modify block -152 72 397 Items[{Slot:6b}].Count set from storage minecraft:randomhotbar items[0].[4].Count
execute if data storage minecraft:randomhotbar items[0].[4] if score $value randominteger matches 6 run data modify block -152 72 397 Items[{Slot:7b}].id set from storage minecraft:randomhotbar items[0].[4].id
execute if data storage minecraft:randomhotbar items[0].[4] if score $value randominteger matches 6 run data modify block -152 72 397 Items[{Slot:7b}].Count set from storage minecraft:randomhotbar items[0].[4].Count
execute if data storage minecraft:randomhotbar items[0].[4] if score $value randominteger matches 7 run data modify block -152 72 397 Items[{Slot:8b}].id set from storage minecraft:randomhotbar items[0].[4].id
execute if data storage minecraft:randomhotbar items[0].[4] if score $value randominteger matches 7 run data modify block -152 72 397 Items[{Slot:8b}].Count set from storage minecraft:randomhotbar items[0].[4].Count
execute if data storage minecraft:randomhotbar items[0].[4] if score $value randominteger matches 8 run data modify block -152 72 397 Items[{Slot:9b}].id set from storage minecraft:randomhotbar items[0].[4].id
execute if data storage minecraft:randomhotbar items[0].[4] if score $value randominteger matches 8 run data modify block -152 72 397 Items[{Slot:9b}].Count set from storage minecraft:randomhotbar items[0].[4].Count



scoreboard players reset $value randominteger
execute if data storage minecraft:randomhotbar integers[5] store result score $value randominteger run data get storage minecraft:randomhotbar integers[5]
execute if data storage minecraft:randomhotbar integers[5] run scoreboard players remove $value randominteger 1
execute if data storage minecraft:randomhotbar items[0].[5] if score $value randominteger matches 0 run data modify block -152 72 397 Items[{Slot:1b}].id set from storage minecraft:randomhotbar items[0].[5].id
execute if data storage minecraft:randomhotbar items[0].[5] if score $value randominteger matches 0 run data modify block -152 72 397 Items[{Slot:1b}].Count set from storage minecraft:randomhotbar items[0].[5].Count
execute if data storage minecraft:randomhotbar items[0].[5] if score $value randominteger matches 1 run data modify block -152 72 397 Items[{Slot:2b}].id set from storage minecraft:randomhotbar items[0].[5].id
execute if data storage minecraft:randomhotbar items[0].[5] if score $value randominteger matches 1 run data modify block -152 72 397 Items[{Slot:2b}].Count set from storage minecraft:randomhotbar items[0].[5].Count
execute if data storage minecraft:randomhotbar items[0].[5] if score $value randominteger matches 2 run data modify block -152 72 397 Items[{Slot:3b}].id set from storage minecraft:randomhotbar items[0].[5].id
execute if data storage minecraft:randomhotbar items[0].[5] if score $value randominteger matches 2 run data modify block -152 72 397 Items[{Slot:3b}].Count set from storage minecraft:randomhotbar items[0].[5].Count
execute if data storage minecraft:randomhotbar items[0].[5] if score $value randominteger matches 3 run data modify block -152 72 397 Items[{Slot:4b}].id set from storage minecraft:randomhotbar items[0].[5].id
execute if data storage minecraft:randomhotbar items[0].[5] if score $value randominteger matches 3 run data modify block -152 72 397 Items[{Slot:4b}].Count set from storage minecraft:randomhotbar items[0].[5].Count
execute if data storage minecraft:randomhotbar items[0].[5] if score $value randominteger matches 4 run data modify block -152 72 397 Items[{Slot:5b}].id set from storage minecraft:randomhotbar items[0].[5].id
execute if data storage minecraft:randomhotbar items[0].[5] if score $value randominteger matches 4 run data modify block -152 72 397 Items[{Slot:5b}].Count set from storage minecraft:randomhotbar items[0].[5].Count
execute if data storage minecraft:randomhotbar items[0].[5] if score $value randominteger matches 5 run data modify block -152 72 397 Items[{Slot:6b}].id set from storage minecraft:randomhotbar items[0].[5].id
execute if data storage minecraft:randomhotbar items[0].[5] if score $value randominteger matches 5 run data modify block -152 72 397 Items[{Slot:6b}].Count set from storage minecraft:randomhotbar items[0].[5].Count
execute if data storage minecraft:randomhotbar items[0].[5] if score $value randominteger matches 6 run data modify block -152 72 397 Items[{Slot:7b}].id set from storage minecraft:randomhotbar items[0].[5].id
execute if data storage minecraft:randomhotbar items[0].[5] if score $value randominteger matches 6 run data modify block -152 72 397 Items[{Slot:7b}].Count set from storage minecraft:randomhotbar items[0].[5].Count
execute if data storage minecraft:randomhotbar items[0].[5] if score $value randominteger matches 7 run data modify block -152 72 397 Items[{Slot:8b}].id set from storage minecraft:randomhotbar items[0].[5].id
execute if data storage minecraft:randomhotbar items[0].[5] if score $value randominteger matches 7 run data modify block -152 72 397 Items[{Slot:8b}].Count set from storage minecraft:randomhotbar items[0].[5].Count
execute if data storage minecraft:randomhotbar items[0].[5] if score $value randominteger matches 8 run data modify block -152 72 397 Items[{Slot:9b}].id set from storage minecraft:randomhotbar items[0].[5].id
execute if data storage minecraft:randomhotbar items[0].[5] if score $value randominteger matches 8 run data modify block -152 72 397 Items[{Slot:9b}].Count set from storage minecraft:randomhotbar items[0].[5].Count



scoreboard players reset $value randominteger
execute if data storage minecraft:randomhotbar integers[6] store result score $value randominteger run data get storage minecraft:randomhotbar integers[6]
execute if data storage minecraft:randomhotbar integers[6] run scoreboard players remove $value randominteger 1
execute if data storage minecraft:randomhotbar items[0].[6] if score $value randominteger matches 0 run data modify block -152 72 397 Items[{Slot:1b}].id set from storage minecraft:randomhotbar items[0].[6].id
execute if data storage minecraft:randomhotbar items[0].[6] if score $value randominteger matches 0 run data modify block -152 72 397 Items[{Slot:1b}].Count set from storage minecraft:randomhotbar items[0].[6].Count
execute if data storage minecraft:randomhotbar items[0].[6] if score $value randominteger matches 1 run data modify block -152 72 397 Items[{Slot:2b}].id set from storage minecraft:randomhotbar items[0].[6].id
execute if data storage minecraft:randomhotbar items[0].[6] if score $value randominteger matches 1 run data modify block -152 72 397 Items[{Slot:2b}].Count set from storage minecraft:randomhotbar items[0].[6].Count
execute if data storage minecraft:randomhotbar items[0].[6] if score $value randominteger matches 2 run data modify block -152 72 397 Items[{Slot:3b}].id set from storage minecraft:randomhotbar items[0].[6].id
execute if data storage minecraft:randomhotbar items[0].[6] if score $value randominteger matches 2 run data modify block -152 72 397 Items[{Slot:3b}].Count set from storage minecraft:randomhotbar items[0].[6].Count
execute if data storage minecraft:randomhotbar items[0].[6] if score $value randominteger matches 3 run data modify block -152 72 397 Items[{Slot:4b}].id set from storage minecraft:randomhotbar items[0].[6].id
execute if data storage minecraft:randomhotbar items[0].[6] if score $value randominteger matches 3 run data modify block -152 72 397 Items[{Slot:4b}].Count set from storage minecraft:randomhotbar items[0].[6].Count
execute if data storage minecraft:randomhotbar items[0].[6] if score $value randominteger matches 4 run data modify block -152 72 397 Items[{Slot:5b}].id set from storage minecraft:randomhotbar items[0].[6].id
execute if data storage minecraft:randomhotbar items[0].[6] if score $value randominteger matches 4 run data modify block -152 72 397 Items[{Slot:5b}].Count set from storage minecraft:randomhotbar items[0].[6].Count
execute if data storage minecraft:randomhotbar items[0].[6] if score $value randominteger matches 5 run data modify block -152 72 397 Items[{Slot:6b}].id set from storage minecraft:randomhotbar items[0].[6].id
execute if data storage minecraft:randomhotbar items[0].[6] if score $value randominteger matches 5 run data modify block -152 72 397 Items[{Slot:6b}].Count set from storage minecraft:randomhotbar items[0].[6].Count
execute if data storage minecraft:randomhotbar items[0].[6] if score $value randominteger matches 6 run data modify block -152 72 397 Items[{Slot:7b}].id set from storage minecraft:randomhotbar items[0].[6].id
execute if data storage minecraft:randomhotbar items[0].[6] if score $value randominteger matches 6 run data modify block -152 72 397 Items[{Slot:7b}].Count set from storage minecraft:randomhotbar items[0].[6].Count
execute if data storage minecraft:randomhotbar items[0].[6] if score $value randominteger matches 7 run data modify block -152 72 397 Items[{Slot:8b}].id set from storage minecraft:randomhotbar items[0].[6].id
execute if data storage minecraft:randomhotbar items[0].[6] if score $value randominteger matches 7 run data modify block -152 72 397 Items[{Slot:8b}].Count set from storage minecraft:randomhotbar items[0].[6].Count
execute if data storage minecraft:randomhotbar items[0].[6] if score $value randominteger matches 8 run data modify block -152 72 397 Items[{Slot:9b}].id set from storage minecraft:randomhotbar items[0].[6].id
execute if data storage minecraft:randomhotbar items[0].[6] if score $value randominteger matches 8 run data modify block -152 72 397 Items[{Slot:9b}].Count set from storage minecraft:randomhotbar items[0].[6].Count



scoreboard players reset $value randominteger
execute if data storage minecraft:randomhotbar integers[7] store result score $value randominteger run data get storage minecraft:randomhotbar integers[7]
execute if data storage minecraft:randomhotbar integers[7] run scoreboard players remove $value randominteger 1
execute if data storage minecraft:randomhotbar items[0].[7] if score $value randominteger matches 0 run data modify block -152 72 397 Items[{Slot:1b}].id set from storage minecraft:randomhotbar items[0].[7].id
execute if data storage minecraft:randomhotbar items[0].[7] if score $value randominteger matches 0 run data modify block -152 72 397 Items[{Slot:1b}].Count set from storage minecraft:randomhotbar items[0].[7].Count
execute if data storage minecraft:randomhotbar items[0].[7] if score $value randominteger matches 1 run data modify block -152 72 397 Items[{Slot:2b}].id set from storage minecraft:randomhotbar items[0].[7].id
execute if data storage minecraft:randomhotbar items[0].[7] if score $value randominteger matches 1 run data modify block -152 72 397 Items[{Slot:2b}].Count set from storage minecraft:randomhotbar items[0].[7].Count
execute if data storage minecraft:randomhotbar items[0].[7] if score $value randominteger matches 2 run data modify block -152 72 397 Items[{Slot:3b}].id set from storage minecraft:randomhotbar items[0].[7].id
execute if data storage minecraft:randomhotbar items[0].[7] if score $value randominteger matches 2 run data modify block -152 72 397 Items[{Slot:3b}].Count set from storage minecraft:randomhotbar items[0].[7].Count
execute if data storage minecraft:randomhotbar items[0].[7] if score $value randominteger matches 3 run data modify block -152 72 397 Items[{Slot:4b}].id set from storage minecraft:randomhotbar items[0].[7].id
execute if data storage minecraft:randomhotbar items[0].[7] if score $value randominteger matches 3 run data modify block -152 72 397 Items[{Slot:4b}].Count set from storage minecraft:randomhotbar items[0].[7].Count
execute if data storage minecraft:randomhotbar items[0].[7] if score $value randominteger matches 4 run data modify block -152 72 397 Items[{Slot:5b}].id set from storage minecraft:randomhotbar items[0].[7].id
execute if data storage minecraft:randomhotbar items[0].[7] if score $value randominteger matches 4 run data modify block -152 72 397 Items[{Slot:5b}].Count set from storage minecraft:randomhotbar items[0].[7].Count
execute if data storage minecraft:randomhotbar items[0].[7] if score $value randominteger matches 5 run data modify block -152 72 397 Items[{Slot:6b}].id set from storage minecraft:randomhotbar items[0].[7].id
execute if data storage minecraft:randomhotbar items[0].[7] if score $value randominteger matches 5 run data modify block -152 72 397 Items[{Slot:6b}].Count set from storage minecraft:randomhotbar items[0].[7].Count
execute if data storage minecraft:randomhotbar items[0].[7] if score $value randominteger matches 6 run data modify block -152 72 397 Items[{Slot:7b}].id set from storage minecraft:randomhotbar items[0].[7].id
execute if data storage minecraft:randomhotbar items[0].[7] if score $value randominteger matches 6 run data modify block -152 72 397 Items[{Slot:7b}].Count set from storage minecraft:randomhotbar items[0].[7].Count
execute if data storage minecraft:randomhotbar items[0].[7] if score $value randominteger matches 7 run data modify block -152 72 397 Items[{Slot:8b}].id set from storage minecraft:randomhotbar items[0].[7].id
execute if data storage minecraft:randomhotbar items[0].[7] if score $value randominteger matches 7 run data modify block -152 72 397 Items[{Slot:8b}].Count set from storage minecraft:randomhotbar items[0].[7].Count
execute if data storage minecraft:randomhotbar items[0].[7] if score $value randominteger matches 8 run data modify block -152 72 397 Items[{Slot:9b}].id set from storage minecraft:randomhotbar items[0].[7].id
execute if data storage minecraft:randomhotbar items[0].[7] if score $value randominteger matches 8 run data modify block -152 72 397 Items[{Slot:9b}].Count set from storage minecraft:randomhotbar items[0].[7].Count



scoreboard players reset $value randominteger
execute if data storage minecraft:randomhotbar integers[8] store result score $value randominteger run data get storage minecraft:randomhotbar integers[8]
execute if data storage minecraft:randomhotbar integers[8] run scoreboard players remove $value randominteger 1
execute if data storage minecraft:randomhotbar items[0].[8] if score $value randominteger matches 0 run data modify block -152 72 397 Items[{Slot:1b}].id set from storage minecraft:randomhotbar items[0].[8].id
execute if data storage minecraft:randomhotbar items[0].[8] if score $value randominteger matches 0 run data modify block -152 72 397 Items[{Slot:1b}].Count set from storage minecraft:randomhotbar items[0].[8].Count
execute if data storage minecraft:randomhotbar items[0].[8] if score $value randominteger matches 1 run data modify block -152 72 397 Items[{Slot:2b}].id set from storage minecraft:randomhotbar items[0].[8].id
execute if data storage minecraft:randomhotbar items[0].[8] if score $value randominteger matches 1 run data modify block -152 72 397 Items[{Slot:2b}].Count set from storage minecraft:randomhotbar items[0].[8].Count
execute if data storage minecraft:randomhotbar items[0].[8] if score $value randominteger matches 2 run data modify block -152 72 397 Items[{Slot:3b}].id set from storage minecraft:randomhotbar items[0].[8].id
execute if data storage minecraft:randomhotbar items[0].[8] if score $value randominteger matches 2 run data modify block -152 72 397 Items[{Slot:3b}].Count set from storage minecraft:randomhotbar items[0].[8].Count
execute if data storage minecraft:randomhotbar items[0].[8] if score $value randominteger matches 3 run data modify block -152 72 397 Items[{Slot:4b}].id set from storage minecraft:randomhotbar items[0].[8].id
execute if data storage minecraft:randomhotbar items[0].[8] if score $value randominteger matches 3 run data modify block -152 72 397 Items[{Slot:4b}].Count set from storage minecraft:randomhotbar items[0].[8].Count
execute if data storage minecraft:randomhotbar items[0].[8] if score $value randominteger matches 4 run data modify block -152 72 397 Items[{Slot:5b}].id set from storage minecraft:randomhotbar items[0].[8].id
execute if data storage minecraft:randomhotbar items[0].[8] if score $value randominteger matches 4 run data modify block -152 72 397 Items[{Slot:5b}].Count set from storage minecraft:randomhotbar items[0].[8].Count
execute if data storage minecraft:randomhotbar items[0].[8] if score $value randominteger matches 5 run data modify block -152 72 397 Items[{Slot:6b}].id set from storage minecraft:randomhotbar items[0].[8].id
execute if data storage minecraft:randomhotbar items[0].[8] if score $value randominteger matches 5 run data modify block -152 72 397 Items[{Slot:6b}].Count set from storage minecraft:randomhotbar items[0].[8].Count
execute if data storage minecraft:randomhotbar items[0].[8] if score $value randominteger matches 6 run data modify block -152 72 397 Items[{Slot:7b}].id set from storage minecraft:randomhotbar items[0].[8].id
execute if data storage minecraft:randomhotbar items[0].[8] if score $value randominteger matches 6 run data modify block -152 72 397 Items[{Slot:7b}].Count set from storage minecraft:randomhotbar items[0].[8].Count
execute if data storage minecraft:randomhotbar items[0].[8] if score $value randominteger matches 7 run data modify block -152 72 397 Items[{Slot:8b}].id set from storage minecraft:randomhotbar items[0].[8].id
execute if data storage minecraft:randomhotbar items[0].[8] if score $value randominteger matches 7 run data modify block -152 72 397 Items[{Slot:8b}].Count set from storage minecraft:randomhotbar items[0].[8].Count
execute if data storage minecraft:randomhotbar items[0].[8] if score $value randominteger matches 8 run data modify block -152 72 397 Items[{Slot:9b}].id set from storage minecraft:randomhotbar items[0].[8].id
execute if data storage minecraft:randomhotbar items[0].[8] if score $value randominteger matches 8 run data modify block -152 72 397 Items[{Slot:9b}].Count set from storage minecraft:randomhotbar items[0].[8].Count

data modify block -152 72 397 Items[{id:"minecraft:structure_void"}] set value {}

data remove storage minecraft:randomhotbar tempitems
execute positioned -152 72 397 if data block ~ ~ ~ Items[{Slot:1b}] run data modify storage minecraft:randomhotbar tempitems append from block ~ ~ ~ Items[{Slot:1b}]
execute positioned -152 72 397 if data block ~ ~ ~ Items[{Slot:2b}] run data modify storage minecraft:randomhotbar tempitems append from block ~ ~ ~ Items[{Slot:2b}]
execute positioned -152 72 397 if data block ~ ~ ~ Items[{Slot:3b}] run data modify storage minecraft:randomhotbar tempitems append from block ~ ~ ~ Items[{Slot:3b}]
execute positioned -152 72 397 if data block ~ ~ ~ Items[{Slot:4b}] run data modify storage minecraft:randomhotbar tempitems append from block ~ ~ ~ Items[{Slot:4b}]
execute positioned -152 72 397 if data block ~ ~ ~ Items[{Slot:5b}] run data modify storage minecraft:randomhotbar tempitems append from block ~ ~ ~ Items[{Slot:5b}]
execute positioned -152 72 397 if data block ~ ~ ~ Items[{Slot:6b}] run data modify storage minecraft:randomhotbar tempitems append from block ~ ~ ~ Items[{Slot:6b}]
execute positioned -152 72 397 if data block ~ ~ ~ Items[{Slot:7b}] run data modify storage minecraft:randomhotbar tempitems append from block ~ ~ ~ Items[{Slot:7b}]
execute positioned -152 72 397 if data block ~ ~ ~ Items[{Slot:8b}] run data modify storage minecraft:randomhotbar tempitems append from block ~ ~ ~ Items[{Slot:8b}]
execute positioned -152 72 397 if data block ~ ~ ~ Items[{Slot:9b}] run data modify storage minecraft:randomhotbar tempitems append from block ~ ~ ~ Items[{Slot:9b}]

execute if data storage minecraft:randomhotbar tempitems[0] run data modify storage minecraft:randomhotbar tempitems[0].Slot set value 0b
execute if data storage minecraft:randomhotbar tempitems[1] run data modify storage minecraft:randomhotbar tempitems[1].Slot set value 1b
execute if data storage minecraft:randomhotbar tempitems[2] run data modify storage minecraft:randomhotbar tempitems[2].Slot set value 2b
execute if data storage minecraft:randomhotbar tempitems[3] run data modify storage minecraft:randomhotbar tempitems[3].Slot set value 3b
execute if data storage minecraft:randomhotbar tempitems[4] run data modify storage minecraft:randomhotbar tempitems[4].Slot set value 4b
execute if data storage minecraft:randomhotbar tempitems[5] run data modify storage minecraft:randomhotbar tempitems[5].Slot set value 5b
execute if data storage minecraft:randomhotbar tempitems[6] run data modify storage minecraft:randomhotbar tempitems[6].Slot set value 6b
execute if data storage minecraft:randomhotbar tempitems[7] run data modify storage minecraft:randomhotbar tempitems[7].Slot set value 7b
execute if data storage minecraft:randomhotbar tempitems[8] run data modify storage minecraft:randomhotbar tempitems[8].Slot set value 8b

data modify block -152 72 397 Items set from storage minecraft:randomhotbar tempitems