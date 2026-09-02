scoreboard players enable @a[tag=!options] options
scoreboard players enable @a[tag=!portals] portals
scoreboard players enable @a[tag=!hub] hub
scoreboard players enable @a[tag=!general] general
scoreboard players enable @a[tag=!zero] zero
scoreboard players enable @a[tag=!bastions] bastions
scoreboard players enable @a[tag=!fortress] fortress
scoreboard players enable @a[tag=!games] games
scoreboard players enable @a[tag=!searchcraft] searchcraft
scoreboard players enable @a[tag=!repairhub] repairhub

execute positioned -150.55 90.13 50.5 if entity @a[tag=inPrep, distance=..2] run tag @a remove inPrep
execute positioned -150.55 90.13 50.5 if entity @a[tag=inSetup, distance=..2] run tag @a remove inSetup
execute positioned -150.55 90.13 50.5 if entity @a[tag=inVillage, distance=..2] run tag @a remove inVillage
execute positioned -150.55 90.13 50.5 if entity @a[tag=inTemple, distance=..2] run tag @a remove inTemple
execute positioned -150.55 90.13 50.5 if entity @a[tag=inRp, distance=..2] run tag @a remove inRp
execute positioned -150.55 90.13 50.5 if entity @a[tag=inShip, distance=..2] run tag @a remove inShip

execute positioned -150.55 90.13 50.5 if entity @a[distance=..2] run scoreboard players set timer timer 0
execute positioned -150.55 90.13 50.5 if entity @a[distance=..2] run scoreboard players set timer settings 0
execute positioned -150.55 90.13 50.5 if entity @a[distance=..2] run title @a actionbar ""

execute positioned -150.55 90.13 50.5 if entity @a[distance=..2] run effect clear @p
execute positioned -150.55 90.13 50.5 if entity @a[distance=..2] run clear @p 
execute positioned -150.55 90.13 50.5 if entity @a[distance=..2] run scoreboard players set active timer 1
execute positioned -150.55 90.13 50.5 if entity @a[distance=..2] run difficulty easy
execute positioned -150.55 90.13 50.5 if entity @a[distance=..2] run gamemode adventure @p
execute positioned -150.55 90.13 50.5 if entity @a[distance=..2] run effect give @p minecraft:instant_health 10 1 true
execute positioned -150.55 90.13 50.5 if entity @a[distance=..2] run effect give @p minecraft:saturation 2 1 true


execute if score @p VillagerClick matches 2.. run function lobby:qgames/warp
execute positioned -134 76 419 if entity @a[distance=..2] run clear @a
execute positioned -134 76 419 if entity @a[distance=..2] run scoreboard players set timer timer 0
execute positioned -134 76 419 if entity @a[distance=..2] run scoreboard players set timer settings 0
execute positioned -134 76 419 if entity @a[distance=..2] run title @a actionbar ""

execute as @a[scores={sound=0},tag=sound] run tag @a remove sound
data modify entity @e[tag=dog,limit=1] Owner set from entity @p UUID
data modify entity @e[tag=parrot,limit=1] Owner set from entity @p UUID