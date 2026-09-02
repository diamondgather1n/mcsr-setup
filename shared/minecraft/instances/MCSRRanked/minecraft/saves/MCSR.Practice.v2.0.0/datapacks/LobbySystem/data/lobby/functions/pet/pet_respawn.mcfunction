playsound minecraft:block.note_block.chime ambient @a[tag=sound] ~ ~ ~ 0.9 0.8

tp @e[tag=pet] ~ ~-100 ~
kill @e[tag=pet]

execute if score cow petOwned matches 1 run summon cow -150 92 70 {Invulnerable:1b,PersistenceRequired:1b,Rotation:[0.0f,0.0f],Tags:["pet"],Age:-2147483648}
execute if score pig petOwned matches 1 run summon pig -150 92 70 {Invulnerable:1b,PersistenceRequired:1b,Rotation:[0.0f,0.0f],Tags:["pet"],Age:-2147483648}
execute if score rabbit petOwned matches 1 run summon rabbit -150 92 70 {Invulnerable:1b,PersistenceRequired:1b,Rotation:[0.0f,0.0f],Tags:["pet"],Age:-2147483648}
execute if score llama petOwned matches 1 run summon llama -150 92 70 {Invulnerable:1b,PersistenceRequired:1b,Rotation:[0.0f,0.0f],Tags:["pet"],Age:-2147483648}
execute if score parrot petOwned matches 1 run summon parrot -150 92.5 70 {Variant:3,Invulnerable:1b,PersistenceRequired:1b,Rotation:[0.0f,0.0f],Tags:["pet","parrot"],Age:1}
execute if score bee petOwned matches 1 run summon bee -150 92.5 70 {Invulnerable:1b,PersistenceRequired:1b,Rotation:[0.0f,0.0f],Tags:["pet"],Age:-2147483648}
execute if score turtle petOwned matches 1 run summon turtle -150 92 70 {Invulnerable:1b,PersistenceRequired:1b,Rotation:[0.0f,0.0f],Tags:["pet"],Age:-2147483648}
execute if score panda petOwned matches 1 run summon panda -150 92 70 {Invulnerable:1b,PersistenceRequired:1b,Rotation:[0.0f,0.0f],Tags:["pet"],Age:-2147483648}
execute if score polar_bear petOwned matches 1 run summon polar_bear -150 92 70 {Invulnerable:1b,PersistenceRequired:1b,Rotation:[0.0f,0.0f],Tags:["pet"],Age:-2147483648}
execute if score fox petOwned matches 1 run summon fox -150 92 70 {Trusted:[{UUIDMost:1L,UUIDLeast:1L}],Type:"snow",Invulnerable:1b,PersistenceRequired:1b,Rotation:[0.0f,0.0f],Tags:["pet"],Age:-2147483648}
execute if score sheep petOwned matches 1 run summon sheep -150 92 70 {Color:6,Invulnerable:1b,PersistenceRequired:1b,Rotation:[0.0f,0.0f],Tags:["pet"],Age:-2147483648}
execute if score walter petOwned matches 1 run summon wolf -147 93 74 {CollarColor:6,Sitting:1,Invulnerable:1b,PersistenceRequired:1b,Rotation:[0.0f,0.0f],Tags:["pet","dog"],Age:1}
execute if score spoingus petOwned matches 1 run summon cat -147 93 74 {CatType:2,Invulnerable:1b,PersistenceRequired:1b,Rotation:[0.0f,0.0f],Tags:["pet"],Age:-2147483648}