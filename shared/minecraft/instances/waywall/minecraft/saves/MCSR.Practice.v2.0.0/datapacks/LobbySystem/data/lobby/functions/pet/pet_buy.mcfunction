# Already owned notifications
execute if score @p petType matches 1 if score cow petOwned matches 1 run title @a actionbar {"text":"You already own this pet!","bold":true,"color":"#E82E30"}
execute if score @p petType matches 2 if score pig petOwned matches 1 run title @a actionbar {"text":"You already own this pet!","bold":true,"color":"#E82E30"}
execute if score @p petType matches 3 if score rabbit petOwned matches 1 run title @a actionbar {"text":"You already own this pet!","bold":true,"color":"#E82E30"}
execute if score @p petType matches 4 if score llama petOwned matches 1 run title @a actionbar {"text":"You already own this pet!","bold":true,"color":"#E82E30"}
execute if score @p petType matches 5 if score parrot petOwned matches 1 run title @a actionbar {"text":"You already own this pet!","bold":true,"color":"#E82E30"}
execute if score @p petType matches 6 if score bee petOwned matches 1 run title @a actionbar {"text":"You already own this pet!","bold":true,"color":"#E82E30"}
execute if score @p petType matches 7 if score turtle petOwned matches 1 run title @a actionbar {"text":"You already own this pet!","bold":true,"color":"#E82E30"}
execute if score @p petType matches 8 if score panda petOwned matches 1 run title @a actionbar {"text":"You already own this pet!","bold":true,"color":"#E82E30"}
execute if score @p petType matches 9 if score polar_bear petOwned matches 1 run title @a actionbar {"text":"You already own this pet!","bold":true,"color":"#E82E30"}
execute if score @p petType matches 10 if score fox petOwned matches 1 run title @a actionbar {"text":"You already own this pet!","bold":true,"color":"#E82E30"}
execute if score @p petType matches 11 if score sheep petOwned matches 1 run title @a actionbar {"text":"You already own this pet!","bold":true,"color":"#E82E30"}
execute if score @p petType matches 12 if score walter petOwned matches 1 run title @a actionbar {"text":"You already own this pet!","bold":true,"color":"#E82E30"}
execute if score @p petType matches 13 if score spoingus petOwned matches 1 run title @a actionbar {"text":"You already own this pet!","bold":true,"color":"#E82E30"}

# Cow
execute if score @p petType matches 1 if score cow petOwned matches 0 if score @p coins matches ..149 run title @a actionbar {"text":"Not enough coins :(","bold":true,"color":"#E82E30"}
execute if score @p petType matches 1 if score cow petOwned matches 0 if score @p coins matches ..149 run playsound minecraft:block.note_block.bass ambient @a[tag=sound] ~ ~ ~ 0.9 0.8
execute if score @p petType matches 1 if score cow petOwned matches 0 if score @p coins matches 150.. run function lobby:pet/pets/cow

# Pig
execute if score @p petType matches 2 if score pig petOwned matches 0 if score @p coins matches ..149 run title @a actionbar {"text":"Not enough coins :(","bold":true,"color":"#E82E30"}
execute if score @p petType matches 2 if score pig petOwned matches 0 if score @p coins matches ..149 run playsound minecraft:block.note_block.bass ambient @a[tag=sound] ~ ~ ~ 0.9 0.8
execute if score @p petType matches 2 if score pig petOwned matches 0 if score @p coins matches 150.. run function lobby:pet/pets/pig

# Rabbit
execute if score @p petType matches 3 if score rabbit petOwned matches 0 if score @p coins matches ..199 run title @a actionbar {"text":"Not enough coins :(","bold":true,"color":"#E82E30"}
execute if score @p petType matches 3 if score rabbit petOwned matches 0 if score @p coins matches ..199 run playsound minecraft:block.note_block.bass ambient @a[tag=sound] ~ ~ ~ 0.9 0.8
execute if score @p petType matches 3 if score rabbit petOwned matches 0 if score @p coins matches 200.. run function lobby:pet/pets/rabbit

# Llama
execute if score @p petType matches 4 if score llama petOwned matches 0 if score @p coins matches ..224 run title @a actionbar {"text":"Not enough coins :(","bold":true,"color":"#E82E30"}
execute if score @p petType matches 4 if score llama petOwned matches 0 if score @p coins matches ..224 run playsound minecraft:block.note_block.bass ambient @a[tag=sound] ~ ~ ~ 0.9 0.8
execute if score @p petType matches 4 if score llama petOwned matches 0 if score @p coins matches 225.. run function lobby:pet/pets/llama

# Parrot
execute if score @p petType matches 5 if score parrot petOwned matches 0 if score @p coins matches ..249 run title @a actionbar {"text":"Not enough coins :(","bold":true,"color":"#E82E30"}
execute if score @p petType matches 5 if score parrot petOwned matches 0 if score @p coins matches ..249 run playsound minecraft:block.note_block.bass ambient @a[tag=sound] ~ ~ ~ 0.9 0.8
execute if score @p petType matches 5 if score parrot petOwned matches 0 if score @p coins matches 250.. run function lobby:pet/pets/parrot

# Bee
execute if score @p petType matches 6 if score bee petOwned matches 0 if score @p coins matches ..299 run title @a actionbar {"text":"Not enough coins :(","bold":true,"color":"#E82E30"}
execute if score @p petType matches 6 if score bee petOwned matches 0 if score @p coins matches ..299 run playsound minecraft:block.note_block.bass ambient @a[tag=sound] ~ ~ ~ 0.9 0.8
execute if score @p petType matches 6 if score bee petOwned matches 0 if score @p coins matches 300.. run function lobby:pet/pets/bee

# Turtle
execute if score @p petType matches 7 if score turtle petOwned matches 0 if score @p coins matches ..324 run title @a actionbar {"text":"Not enough coins :(","bold":true,"color":"#E82E30"}
execute if score @p petType matches 7 if score turtle petOwned matches 0 if score @p coins matches ..324 run playsound minecraft:block.note_block.bass ambient @a[tag=sound] ~ ~ ~ 0.9 0.8
execute if score @p petType matches 7 if score turtle petOwned matches 0 if score @p coins matches 325.. run function lobby:pet/pets/turtle

# Panda
execute if score @p petType matches 8 if score panda petOwned matches 0 if score @p coins matches ..349 run title @a actionbar {"text":"Not enough coins :(","bold":true,"color":"#E82E30"}
execute if score @p petType matches 8 if score panda petOwned matches 0 if score @p coins matches ..349 run playsound minecraft:block.note_block.bass ambient @a[tag=sound] ~ ~ ~ 0.9 0.8
execute if score @p petType matches 8 if score panda petOwned matches 0 if score @p coins matches 350.. run function lobby:pet/pets/panda

# Polar Bear
execute if score @p petType matches 9 if score polar_bear petOwned matches 0 if score @p coins matches ..374 run title @a actionbar {"text":"Not enough coins :(","bold":true,"color":"#E82E30"}
execute if score @p petType matches 9 if score polar_bear petOwned matches 0 if score @p coins matches ..374 run playsound minecraft:block.note_block.bass ambient @a[tag=sound] ~ ~ ~ 0.9 0.8
execute if score @p petType matches 9 if score polar_bear petOwned matches 0 if score @p coins matches 375.. run function lobby:pet/pets/polar_bear

# Fox
execute if score @p petType matches 10 if score fox petOwned matches 0 if score @p coins matches ..399 run title @a actionbar {"text":"Not enough coins :(","bold":true,"color":"#E82E30"}
execute if score @p petType matches 10 if score fox petOwned matches 0 if score @p coins matches ..399 run playsound minecraft:block.note_block.bass ambient @a[tag=sound] ~ ~ ~ 0.9 0.8
execute if score @p petType matches 10 if score fox petOwned matches 0 if score @p coins matches 400.. run function lobby:pet/pets/fox

# Sheep
execute if score @p petType matches 11 if score sheep petOwned matches 0 if score @p coins matches ..424 run title @a actionbar {"text":"Not enough coins :(","bold":true,"color":"#E82E30"}
execute if score @p petType matches 11 if score sheep petOwned matches 0 if score @p coins matches ..424 run playsound minecraft:block.note_block.bass ambient @a[tag=sound] ~ ~ ~ 0.9 0.8
execute if score @p petType matches 11 if score sheep petOwned matches 0 if score @p coins matches 425.. run function lobby:pet/pets/sheep

# Walter
execute if score @p petType matches 12 if score walter petOwned matches 0 if score @p coins matches ..449 run title @a actionbar {"text":"Not enough coins :(","bold":true,"color":"#E82E30"}
execute if score @p petType matches 12 if score walter petOwned matches 0 if score @p coins matches ..449 run playsound minecraft:block.note_block.bass ambient @a[tag=sound] ~ ~ ~ 0.9 0.8
execute if score @p petType matches 12 if score walter petOwned matches 0 if score @p coins matches 450.. run function lobby:pet/pets/walter

# Spoingus
execute if score @p petType matches 13 if score spoingus petOwned matches 0 if score @p coins matches ..499 run title @a actionbar {"text":"Not enough coins :(","bold":true,"color":"#E82E30"}
execute if score @p petType matches 13 if score spoingus petOwned matches 0 if score @p coins matches ..499 run playsound minecraft:block.note_block.bass ambient @a[tag=sound] ~ ~ ~ 0.9 0.8
execute if score @p petType matches 13 if score spoingus petOwned matches 0 if score @p coins matches 500.. run function lobby:pet/pets/spoingus
