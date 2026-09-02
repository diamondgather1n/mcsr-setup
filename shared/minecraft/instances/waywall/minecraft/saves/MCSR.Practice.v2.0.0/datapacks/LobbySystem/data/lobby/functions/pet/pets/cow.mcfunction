scoreboard players remove @p coins 150
scoreboard players set cow petOwned 1
function lobby:pet/pet_respawn
title @a actionbar {"text":"Congrats! Visit your pet, in the pet room :)","bold":true,"color":"#24DE30"}
playsound minecraft:block.note_block.chime ambient @a[tag=sound] ~ ~ ~ 0.9 0.8