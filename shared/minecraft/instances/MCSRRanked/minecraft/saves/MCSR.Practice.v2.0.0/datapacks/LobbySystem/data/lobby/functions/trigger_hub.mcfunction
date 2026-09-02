execute as @a[scores={hub=1..}] run function lobby:hub

execute as @a[scores={hub=1..}] run scoreboard players set @s hub 0

execute as @a[scores={zero=1..}] run function lobby:zero_warp

execute as @a[scores={zero=1..}] run scoreboard players set @s zero 0

execute as @a[scores={portals=1..}] run function lobby:portal_warp

execute as @a[scores={portals=1..}] run scoreboard players set @s portals 0

execute as @a[scores={options=1..}] run function lobby:options_warp

execute as @a[scores={options=1..}] run scoreboard players set @s options 0

execute as @a[scores={general=1..}] run function lobby:overworld_warp

execute as @a[scores={general=1..}] run scoreboard players set @s general 0

execute as @a[scores={bastions=1..}] run function lobby:bastions_warp

execute as @a[scores={bastions=1..}] run scoreboard players set @s bastions 0

execute as @a[scores={fortress=1..}] run function lobby:fortress_warp

execute as @a[scores={fortress=1..}] run scoreboard players set @s fortress 0

execute as @a[scores={games=1..}] run function lobby:qgames/warp

execute as @a[scores={games=1..}] run scoreboard players set @s games 0

execute as @a[scores={searchcraft=1..}] run function lobby:craft_warp

execute as @a[scores={searchcraft=1..}] run scoreboard players set @s searchcraft 0

execute as @a[scores={repairhub=1..}] run function lobby:repair_lobby

execute as @a[scores={repairhub=1..}] run scoreboard players set @s repairhub 0