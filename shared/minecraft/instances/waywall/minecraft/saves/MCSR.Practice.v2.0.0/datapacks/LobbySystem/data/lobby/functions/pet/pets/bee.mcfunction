scoreboard players remove @p coins 300
scoreboard players set bee petOwned 1
function lobby:pet/pet_respawn
title @a actionbar {"text":"Congrats! Visit your pet, in the pet room :)","bold":true,"color":"#24DE30"}
playsound minecraft:block.note_block.chime ambient @a[tag=sound] ~ ~ ~ 0.9 0.8