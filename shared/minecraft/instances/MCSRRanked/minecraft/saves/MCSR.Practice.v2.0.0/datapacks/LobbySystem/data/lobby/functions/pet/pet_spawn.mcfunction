execute positioned -150 2 81 run kill @e[tag=display,distance=..5]

execute positioned -150 92 81 as @e[tag=display,distance=..2] run tp @s ~ ~-90 ~
execute positioned -150 92 81 run kill @e[type=minecraft:item,distance=..5]

execute if score @p petType matches 1 run summon cow -150 92 81 {Invulnerable:1b,NoAI:1b,PersistenceRequired:1b,Rotation:[0.0f,0.0f],Tags:["display"],Age:-2147483648}
execute if score @p petType matches 2 run summon pig -150 92 81 {Invulnerable:1b,NoAI:1b,PersistenceRequired:1b,Rotation:[0.0f,0.0f],Tags:["display"],Age:-2147483648}
execute if score @p petType matches 3 run summon rabbit -150 92 81 {Invulnerable:1b,NoAI:1b,PersistenceRequired:1b,Rotation:[0.0f,0.0f],Tags:["display"],Age:-2147483648}
execute if score @p petType matches 4 run summon llama -150 92 81 {Invulnerable:1b,NoAI:1b,PersistenceRequired:1b,Rotation:[0.0f,0.0f],Tags:["display"],Age:-2147483648}
execute if score @p petType matches 5 run summon parrot -150 92.5 81 {Variant:3,Invulnerable:1b,NoAI:1b,PersistenceRequired:1b,Rotation:[0.0f,0.0f],Tags:["display"],Age:1}
execute if score @p petType matches 6 run summon bee -150 92.5 81 {Invulnerable:1b,NoAI:1b,PersistenceRequired:1b,Rotation:[0.0f,0.0f],Tags:["display"],Age:-2147483648}
execute if score @p petType matches 7 run summon turtle -150 92 81 {Invulnerable:1b,NoAI:1b,PersistenceRequired:1b,Rotation:[0.0f,0.0f],Tags:["display"],Age:-2147483648}
execute if score @p petType matches 8 run summon panda -150 92 81 {Invulnerable:1b,NoAI:1b,PersistenceRequired:1b,Rotation:[0.0f,0.0f],Tags:["display"],Age:-2147483648}
execute if score @p petType matches 9 run summon polar_bear -150 92 81 {Invulnerable:1b,NoAI:1b,PersistenceRequired:1b,Rotation:[0.0f,0.0f],Tags:["display"],Age:-2147483648}
execute if score @p petType matches 10 run summon fox -150 92 81 {Trusted:[{UUIDMost:1L,UUIDLeast:1L}],Type:"snow",Invulnerable:1b,NoAI:1b,PersistenceRequired:1b,Rotation:[0.0f,0.0f],Tags:["display"],Age:-2147483648}
execute if score @p petType matches 11 run summon sheep -150 92 81 {Color:6,Invulnerable:1b,NoAI:1b,PersistenceRequired:1b,Rotation:[0.0f,0.0f],Tags:["display"],Age:-2147483648}
execute if score @p petType matches 12 run summon wolf -150 92 81 {Owner:[I;1,1,1,1],CollarColor:6,Sitting:1,Invulnerable:1b,NoAI:1b,PersistenceRequired:1b,Rotation:[0.0f,0.0f],Tags:["display"],Age:1}
execute if score @p petType matches 13 run summon cat -150 92 81 {CatType:2,Invulnerable:1b,NoAI:1b,PersistenceRequired:1b,Rotation:[0.0f,0.0f],Tags:["display"],Age:-2147483648}

execute positioned -150 2 81 run kill @e[tag=display,distance=..5]